/*
 * jsCalendarYearMonth v0.1.4-beta.1
 * 
 * 
 * MIT License
 * 
 * Copyright (c) 2017-2024 Grammatopoulos Athanasios-Vasileios
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 * 
 */

var jsCalendarYearMonth = (function(){

    // Constructor
    function JsCalendarYearMonth(){
        // No parameters
        if (arguments.length === 0) {
            // Do nothing
            return;
        }
        else {
            // Construct calendar
            this._construct(arguments);
        }
    }

    // Version
    JsCalendarYearMonth.version = 'v0.1.4-beta.1';

    // Sub-Constructor
    JsCalendarYearMonth.prototype._construct = function(args) {
        // Parsear argumentos
        args = this._parseArguments(args);
        // Configurar el contenedor
        this._setTarget(args.target);
        // Init calendar
        this._init(args.options);
        // Init target
        this._initTarget();
        // Set date
        args.year = this._parseYear(args.year);
        this._setYear(
            (args.year !== null && args.year !== 0) ? args.year :
            (this._target.dataset.hasOwnProperty('year')) ? this._target.dataset.year :
            new Date().getFullYear());
        // If invalid year
        if (!this._now) throw new Error('jsCalendarYearMonth: Year is outside range.');
        // Create
        this._create();
        // Update
        this._update();
        // set not frozen
        this._isFrozen = false;
    }

    // Método _applyExtensions
    JsCalendarYearMonth.prototype._applyExtensions = function(calendar) {
        if (this._options.extensions && this._options.extensions.length > 0) {
            this._options.extensions.forEach(function(ext) {
                if (typeof jsCalendar.ext === 'function') {
                    var originalUpdate = calendar._events.update;
                    calendar._events.update = function(month) {
                        originalUpdate.call(calendar, month);
                        jsCalendar.ext(ext).update(calendar, month);
                    };
                }
            });
        }
    };

    // Init calendar
    JsCalendarYearMonth.prototype._init = function(options) {
        // Init elements object
        this._elements = {};
        // Almacenar las instancias de los calendarios
        this._calendars = [];
        // Events init
        this._events = {};
/*         this._events.date = [];
        this._events.month = []; */
        this._events.header_render = [];
        this._events.title_render = [];
        /* this._events.date_render = [];
        this._events.month_render = [];
        this._events.month_render = []; */
        // Dates variables
        this._now = null;
        this._year = null;
        this._selectedDates = [];

        // Parse options
        this._parseOptions(options);
        this._selectedDates = this._options.selectedDates;
    };

    JsCalendarYearMonth.prototype._parseArguments = function(args) {
        // Arguments object
        var obj = {
            target : null,
            year : null,
            options : {}
        };

        // If no arguments
        if (args.length === 0) {
            // Throw an error
            throw new Error('JsCalendarYearMonth: No parameters were given.');
        }

        // Only 1 argument
        else if (args.length === 1) {

            // If target element
            if (
                (
                    // If html element
                    ((typeof HTMLElement === 'object') ? (args[0] instanceof HTMLElement) : args[0]) &&
                    (typeof args[0] === 'object') && (args[0] !== null) && (args[0].nodeType === 1) &&
                    (typeof args[0].nodeName === 'string')
                ) || (
                    // Or string
                    typeof args[0] === 'string'
                )
            ) {
                obj.target = args[0];
            }

            // Options argument
            else {
                // Init arguments
                obj.options = args[0];
                // Get target
                if (typeof args[0].target !== 'undefined') {
                    obj.target = args[0].target;
                }
                else {
                    // Throw an error
                    throw new Error('jsCalendar: Not target was given.');
                }
                // Get year
                if (typeof args[0].year !== 'undefined') {
                    obj.year = args[0].year;
                }
            }
        }

        // Many arguments
        else {

            // First is target
            obj.target = args[0];

            // If year
            if (args.length >= 2) {
                obj.year = args[1];
            }

            // If options
            if (args.length >= 3) {
                obj.options = args[2];
            }

        }

        // Return object
        return obj;
    };
    
    // Default options
    JsCalendarYearMonth.options = {
        /* language: 'en',
        zeroFill: false,
        monthFormat: 'month',
        dayFormat: 'D',
        firstDayOfTheWeek: false,
        navigator: false,
        navigatorPosition: 'both',
        min : false,
        max : false,
        onMonthRender: false,
        onDayRender: false,
        onDateRender: false,
 */
        year: 0,
        minYear: 0,
        maxYear: 0,
        themeClasses: [], // Array de clases de temas
        responsiveLayout: true, // true: inline, false: hace caso a monthsPerRow
        monthsPerRow: 4, // Número de meses por fila
        yearNavigator: true,
        yearNavigatorPosition : 'both', //'both', 'left', 'right'
        navIcons: false, //'fontawesome', 'material'
        fontawesomePrefix: 'fa', //'fa' v.4.7, 'fas' v.5-6
        selectedDates: [], // Array de fechas seleccionadas
        extensions: [],
        renderHeader: null, // Función personalizada para renderizar la cabecera
        customYearTitle:null,   // Función personalizada que devolverá el texto a incluir como título.
        
        onPrevYear: null,   // Función personalizada para navegar al año anterior
        onNextYear: null,    // Función personalizada para navegar al año siguiente
        onYearChanged: null,  // Nueva opción para onYearChanged
        onDateClick: null,     // Nueva opción para onDateClick
    };

    // Método _parseOptions
    JsCalendarYearMonth.prototype._parseOptions = function(doptions) {
        // Options Object
        this._options = {};
        // Input options object (dirty)
        var options = {};
        // Get calendar options
        this._options.jsCalendarOptions = {};
        
        var item;
        // Load default and input options from jsCalendar
        for (item in jsCalendar.options) {
            // Dynamic options
            if (doptions.hasOwnProperty(item)) {
                // options[item] = doptions[item];
                this._options.jsCalendarOptions[item] = doptions[item];
            }
            // Dataset options
            else if (this._target.dataset.hasOwnProperty(item)) {
                // options[item] = this._target.dataset[item];
                this._options.jsCalendarOptions[item] = this._target.dataset[item];
            }
        }
        // Also load alias
        item = 'fdotw'
        if (doptions.hasOwnProperty(item)) {
            // options[item] = doptions[item];
            this._options.jsCalendarOptions = doptions[item];
        }
        else if (this._target.dataset.hasOwnProperty(item)) {
            // options[item] = this._target.dataset[item];
            this._options.jsCalendarOptions = this._target.dataset[item];
        }
        
        this._options.jsCalendarOptions.navigator = false;
        this._options.jsCalendarOptions.min = false;
        this._options.jsCalendarOptions.max = false;
        if(this._options.jsCalendarOptions.language === 'undefined'){
            this._options.jsCalendarOptions.language = 'en';
        }

        // Load default and input local options
        for (item in JsCalendarYearMonth.options) {
            // Default options
            if (JsCalendarYearMonth.options.hasOwnProperty(item)) {
                this._options[item] = JsCalendarYearMonth.options[item];
            }
            // Dynamic options
            if (doptions.hasOwnProperty(item)) {
                options[item] = doptions[item];
            }
            // Dataset options
            else if (this._target.dataset.hasOwnProperty(item)) {
                options[item] = this._target.dataset[item];
            }
        }
        
        options.year = this._parseYear(options.year,0);
        if(options.year === 0){
            options.year = new Date().getFullYear();
        }
        this._options.year = options.year;
                
        // Set min annuary year
        options.minYear = this._parseYear(options.minYear, 0);
        if (options.minYear > 0 && this._options.year < options.minYear ){
            this._options.year = options.minYear;
        }
        this._options.minYear = options.minYear;

        // Set max annuary year
        options.maxYear = this._parseYear(options.maxYear, 0);
        if (options.maxYear > 0 && this._options.year > options.maxYear ){
            this._options.year = options.maxYear;
        }
        this._options.maxYear = options.maxYear;

        // Por defecto responsiveLayout = true
        options.responsiveLayout = this._parseBoolean(options.responsiveLayout,null);
        if(options.responsiveLayout !== null){
            this._options.responsiveLayout = options.responsiveLayout;
        }
        // Validar que monthsPerRow sea un número entero en el rango de 1 a 12
        if(true === this._options.responsiveLayout){
            options.monthsPerRow = this._parseNumber(options.monthsPerRow, null);
            if (options.monthsPerRow !== null && options.monthsPerRow > 0 && options.monthsPerRow < 13) {
                this._options.monthsPerRow = options.monthsPerRow;
            }
        }

        if(typeof options.themeClasses !== 'undefined'){
            if(typeof options.themeClasses  === 'string'){
                options.themeClasses = [options.themeClasses];
            }
            this._options.themeClasses = options.themeClasses;
            
        }

        options.yearNavigator = this._parseBoolean(options.yearNavigator,null);
        if(options.yearNavigator !== null){
            this._options.yearNavigator = options.yearNavigator;
        }            
        if(true === this._options.yearNavigator){
            if(typeof options.yearNavigatorPosition !== 'undefined' &&
                typeof options.yearNavigatorPosition === 'string' &&
                (options.yearNavigatorPosition === 'left' || options.yearNavigatorPosition === 'right' || options.yearNavigatorPosition === 'both')
            ){
                this._options.yearNavigatorPosition = options.yearNavigatorPosition;
            }
        
            if(typeof options.navIcons !== 'undefined' && this._parseBoolean(options.navIcons,null) !== null && options.navIcons !== false){
                if(typeof options.navIcons === 'string' &&
                    (options.navIcons === 'fontawesome' || options.navIcons === 'material')
                ){
                    this._options.navIcons = options.navIcons;

                    if (this._options.navIcons === 'fontawesome'){                    
                        if(typeof options.fontawesomePrefix !== 'undefined' && typeof options.fontawesomePrefix === 'string'
                            // && (options.fontawesomePrefix === 'fa' || options.yearNavigatorPosition === 'right')
                        ){
                            this._options.fontawesomePrefix = options.fontawesomePrefix;
                        }
                    } 
                }
            } 

        } 
                
        if(typeof options.selectedDates !== 'undefined') {
            if(!(options.selectedDates instanceof Array)) {
                options.selectedDates = [options.selectedDates];
            }

            if (options.selectedDates.length > 0) {
                options.selectedDates = options.selectedDates.map(function(date) {
                    var dt = new Date(date).setHours(0, 0, 0, 0);
                    return jsCalendar.tools.parseDate(dt);
                });
            }            
            this._options.selectedDates = options.selectedDates;
        }
        //this._selectedDates = this._options.selectedDates;
                
        if(typeof options.extensions !== 'undefined') {
            if(!(options.extensions instanceof Array)) {
                options.extensions = [options.extensions];
            }
            this._options.extensions = options.extensions;
        }
        
        // Set render handlers
        options.renderHeader = this._parseFunction(options.renderHeader,null);
        if (typeof options.renderHeader !== null) {
            // this._on('header_render', options.renderHeader);
            this._options.renderHeader = options.renderHeader;
        }

        options.customYearTitle = this._parseFunction(options.customYearTitle,null);
        if (typeof options.customYearTitle !== null) {
            // this._on('title_render', options.customYearTitle);
            this._options.customYearTitle = options.customYearTitle;
        }

        options.onPrevYear = this._parseFunction(options.onPrevYear,null);
        if (typeof options.onPrevYear !== null) {
            this._options.onPrevYear = options.onPrevYear;
        }

        options.onNextYear = this._parseFunction(options.onNextYear,null);
        if (typeof options.onNextYear !== null) {
            this._options.onNextYear = options.onNextYear;
        }

        options.onYearChanged = this._parseFunction(options.onYearChanged,null);
        if (typeof options.onYearChanged !== null) {
            this._options.onYearChanged = options.onYearChanged;
        }

        options.onDateClick = this._parseFunction(options.onDateClick,null);
        if (typeof options.onDateClick !== null) {
            this._options.onDateClick = options.onDateClick;
        }

    };

    // Configurar el contenedor y añadir la clase automáticamente
    JsCalendarYearMonth.prototype._setTarget = function(element) {
        // Parse target
        var target = jsCalendar.tools.getElement(element);
        // If target not found
        if (!target) {
            // Throw an error
            throw new Error('JsCalendarYearMonth: Target was not found.');
        }
        else {
            // Save element
            this._target = target;

            // Link object to list
            var id = this._target.id;
            if (id && id.length > 0) {
                jsCalendarYearObjects['#' + id] = this;
            }
        }
    };

    // Init target
    JsCalendarYearMonth.prototype._initTarget = function() {
        // Add class
        if (this._target.className.length > 0){
            this._target.className += ' ';
        }
        this._target.className += 'jsCalendar-yearmonth';

    };

    JsCalendarYearMonth.prototype._parseFunction = function(value,valuedefault) {
        if (typeof valuedefault === 'undefined') {
            valuedefault = null;
        }
        
        if (typeof value !== 'undefined') {
            if (
                typeof value === 'string' &&
                typeof window[value] === 'function'
            ) {
                return window[value];
            }
            // Passed as function
            else if (typeof value === 'function') {
                return value;
            }
        }
        return valuedefault;
    }

    JsCalendarYearMonth.prototype._parseBoolean = function(bool, valuedefault) {
        if (typeof valuedefault === 'undefined') {
            valuedefault = null;
        }
        if (typeof bool !== 'undefined') {
            if (typeof bool !== 'boolean') {
                if(typeof bool === 'numer'){
                    if(bool === 0){
                        return false;
                    } else if (bool === 1 || bool === -1){
                        return true;
                    }					
                } else if( typeof bool === 'string'){
                    bool = bool.toLowerCase();
                    if(bool === 'false' || bool === 'true'){
                        return Boolean(bool);
                    }
                }
                return valuedefault;
            }
        } else {
            return valuedefault;
        }
    
        return bool;
    }

    JsCalendarYearMonth.prototype._parseNumber = function(value,valuedefault) {
        if (typeof valuedefault === 'undefined') {
            valuedefault = null;
        }
        // Verifica que no sea un booleano, ni null o undefined
        if (typeof value === 'boolean' || value == null) {
            return valuedefault;
        }    
        // Verifica que no sea una cadena vacía o una cadena que solo contiene espacios
        if (typeof value === 'string' && value.trim() === '') {
            return valuedefault;
        }
        return isNaN(value)?valuedefault:Number(value);
    }

    JsCalendarYearMonth.prototype._parseYear = function(value,valuedefault) {
        if (typeof valuedefault === 'undefined') {
            valuedefault = null;
        }

        value = this._parseNumber(value,null);
        if( value === null){
            return valuedefault;
        } else if(value < 0) {
            return valuedefault;
        }
        return value;
    }

    // Check if date in range
    JsCalendarYearMonth.prototype._isYearInRange = function(year) {
        // If no range
        if (this._options.minYear === 0 && this._options.maxYear === 0) {
            return true;
        }

        year = this._parseYear(year,null);
        
        if(year === null){
            return false;
        } else if (year === 0){
            return false;
        }        
        // Check min
        if (this._options.minYear !== 0 && year < this._options.minYear) {
            return false;
        }
        // Check max
        if (this._options.maxYear !== 0 && year > this._options.maxYear) {
            return false;
        }

        // In range
        return true;
    };

    // Set a Date
    JsCalendarYearMonth.prototype._setYear = function(newyear) {
        // Parse year
        newyear = this._parseYear(newyear);
        // Check date not in range
        if (!this._isYearInRange(newyear)) {
            return;
        }
        // Set data
        this._now = newyear;
        this._year = newyear;
    };

    // Método _renderHeader
    JsCalendarYearMonth.prototype._renderHeader = function() {

        var onPrevYear = this._options.onPrevYear ? this._options.onPrevYear.bind(this) : this.previousYear.bind(this)
        var onNextYear = this._options.onNextYear ? this._options.onNextYear.bind(this) : this.nextYear.bind(this);

        if (typeof this._options.renderHeader === 'function') {
            this._elements.head = this._options.renderHeader(this._year);

            // TODO
            if (this._options.yearNavigator) {
                this._elements.navLeft = this._elements.head.getElementsByClassName('prev')[0];
                /* if(this._elements.navLeft !== undefined){
                    this._elements.navLeft.onclick = onPrevYear;
                } */
                this._elements.navRight = this._elements.head.getElementsByClassName('next')[0];
                /* if(this._elements.navRight !== undefined){
                    this._elements.navRight.onclick = onNextYear;
                } */
            }

            this._elements.title = this._elements.head.getElementsByClassName('year-title')[0];
                
        } else {
            this._elements.head = document.createElement("div");
            this._elements.head.className = "year-header";
    
            // Texto del año
            this._elements.title = document.createElement('span');
            this._elements.title.className = "year-title";
    
            if (this._options.yearNavigator) {
                if (typeof this._options.navIcons === 'string' && (this._options.navIcons === 'fontawesome' || this._options.navIcons === 'material')) {
                    this._elements.navLeft = document.createElement('i');
                    this._elements.navLeft.className = "year-nav iconbutton prev ";
                    if (this._options.navIcons === 'fontawesome'){
                        this._elements.navLeft.className += this._options.fontawesomePrefix +' fa-angle-left'; // Icono de FontAwesome - chevron
                    } else {
                        // Icono de Material Design para navegar al año anterior
                        this._elements.navLeft.className += "material-icons";
                        this._elements.navLeft.textContent = "chevron_left";  // Ícono de "flecha a la izquierda"
                    }
                    this._elements.navLeft.style.cursor = 'pointer';
                } else {
                    this._elements.navLeft = document.createElement("div");
                    this._elements.navLeft.className = "year-nav textbutton prev";
                }
                
                if (typeof this._options.navIcons === 'string' && (this._options.navIcons === 'fontawesome' || this._options.navIcons === 'material')) {
                    this._elements.navRight = document.createElement('i');
                    this._elements.navRight.className = "year-nav iconbutton next ";
                    if (this._options.navIcons === 'fontawesome'){
                        this._elements.navRight.className += this._options.fontawesomePrefix +' fa-angle-right'; // Icono de FontAwesome
                    } else {
                        this._elements.navRight.className += "material-icons";
                        this._elements.navRight.textContent = "chevron_right";  // Ícono de "flecha a la derecha"
                    }
                    this._elements.navRight.style.cursor = 'pointer';
                } else {
                    this._elements.navRight = document.createElement("div");
                    this._elements.navRight.className = "year-nav textbutton next";
                }

                this._elements.navLeft.onclick = onPrevYear; // Usar función pasada
                this._elements.navRight.onclick = onNextYear;

                // Event listeners
                /* this._elements.navLeft.addEventListener('click', function(event){
                    that.previous();
                    var date = new Date(that._date.getTime());
                    date.setDate(1);
                    that._eventFire('month', date, event);
                }, false);
                this._elements.navRight.addEventListener('click', function(event){
                    that.next();
                    var date = new Date(that._date.getTime());
                    date.setDate(1);
                    that._eventFire('month', date, event);
                }, false); */
            }
        
            if (!this._options.yearNavigator) {
                this._elements.head.appendChild(this._elements.title);
            } else {
                if (this._options.yearNavigatorPosition === 'left') {
                    this._elements.head.appendChild(this._elements.navLeft);
                    this._elements.head.appendChild(this._elements.navRight);
                    this._elements.head.appendChild(this._elements.title);
                } else if (this._options.yearNavigatorPosition === 'right') {
                    this._elements.head.appendChild(this._elements.title);
                    this._elements.head.appendChild(this._elements.navLeft);
                    this._elements.head.appendChild(this._elements.navRight);
                } else {
                    this._elements.head.appendChild(this._elements.navLeft);
                    this._elements.head.appendChild(this._elements.title);
                    this._elements.head.appendChild(this._elements.navRight);
                }
            }
        }
    };

    // Método _render no responsive. cols per row.
    JsCalendarYearMonth.prototype._renderBodyColsRow = function() {
        var wrapper = this._target;

        var rowContainer = document.createElement("div");
        rowContainer.className = "year-row-container";
        wrapper.appendChild(rowContainer);    

        this._minwidthmoth = 0;

        for (var i = 0; i < 12; i++) {
            if (i % this._options.monthsPerRow === 0 && i !== 0) {
                rowContainer = document.createElement("div");
                rowContainer.className = "year-row-container";
                wrapper.appendChild(rowContainer);
            }

            var monthContainer = document.createElement("div");
            monthContainer.className = "month-container";
            rowContainer.appendChild(monthContainer);

            var calendar = this._renderMonth(wrapper, monthContainer, i);
            this._calendars.push(calendar);

            if( i === 0){
                this._minwidthmoth = calendar._elements.table.offsetWidth;
            }
        }

        var mpr = this._options.monthsPerRow;
        var mwpr = this._minwidthmoth;
        var rowContainers = wrapper.querySelectorAll('.year-row-container');
        rowContainers.forEach(function(rowContainer) {
            rowContainer.style.setProperty('--months-per-row', mpr);
            rowContainer.style.setProperty('--min-width-month', mwpr);
        });
    };

    // Método _render responsive
    JsCalendarYearMonth.prototype._renderBodyResponsive = function() {
        var wrapper = this._target;
        // Crear calendarios mensuales
        for (var i = 0; i < 12; i++) {
            var monthContainer = document.createElement("div");
            wrapper.appendChild(monthContainer);

            var calendar = this._renderMonth(wrapper, monthContainer, i);
            this._calendars.push(calendar);
        }
    };

    // Método _renderMonth
    JsCalendarYearMonth.prototype._renderMonth = function(wrapper, monthContainer, month) {
        // Aplicar las clases de tema especificadas
        this._options.themeClasses.forEach(function(themeClass) {
            monthContainer.classList.add(themeClass);
        });

        var calendar = jsCalendar.new(monthContainer, 0, this._options.jsCalendarOptions);
        
        // Add target listeners
        var parent = this;
        // Calendar click handler
        calendar.onDateClick(function(event, date) {
            if (typeof parent._options.onDateClick === 'function') {
                parent._options.onDateClick(event, date);
            }
            // Dispatchar el evento onDateClick
            var event = new CustomEvent('onDateClick', {
                detail: { event: event, date: date }
            });
            wrapper.dispatchEvent(event);
        });

        this._applyExtensions(calendar);

        return calendar;
    };

    // Método _render
    JsCalendarYearMonth.prototype._create = function() {
        // Set created flag
        this._elements.created = true;
        this._renderHeader();
        this._target.appendChild(this._elements.head);
        
        // Renderizar el anuario
        if( this._options.responsiveLayout ) {
            this._renderBodyResponsive();
        } else {
            this._renderBodyColsRow();
        }
    };

    // Update calendar
    JsCalendarYearMonth.prototype._update = function() {
        if (true === this._isFrozen) return this;
        
        if(this._elements.title !== undefined){
            if (typeof this._options.customYearTitle === 'function') {
                this._elements.title.textContent = this._options.customYearTitle(this._year);
            } else {
                this._elements.title.textContent = this._year;
            }
        }

        this._updateButtonsNavYear();

        var calendar;
        if (this._calendars.length > 0) {
            for (month = 0; month < 12; month++) {
                calendar = this._calendars[month];
                calendar.goto(new Date(this._year, month, 1));
                this._selectDatesForMonth(calendar, month + 1, this._selectedDates);
            }
        }
    };

    // Unselect all dates on calendar
    JsCalendarYearMonth.prototype._unselectAllDates = function() {
        // While not empty
        while (this._selectedDates.length) {
            this._selectedDates.pop();
        }

        var calendar;
        if (this._calendars.length > 0) {
            for (month = 0; month < 12; month++) {
                calendar = this._calendars[month];
                calendar.clearSelect();
            }
        }
    };

    // Método _updateButtonsNavYear
    JsCalendarYearMonth.prototype._updateButtonsNavYear = function() {
        if(!this._options.yearNavigator || (this._options.minYear === 0 && this._options.maxYear === 0)){
            return;
        }

        // Control de deshabilitación para el botón "Anterior"
        if(this._elements.navLeft !== undefined){
            if(this._year <= this._options.minYear){
                this._elements.navLeft.setAttribute('disabled','');
            } else {
                this._elements.navLeft.removeAttribute('disabled');
            }
        }
        // Control de deshabilitación para el botón "Siguiente"
        if(this._elements.navRight !== undefined){
            if(this._year >= this._options.maxYear){
                this._elements.navRight.setAttribute('disabled','');
            } else {
                this._elements.navRight.removeAttribute('disabled');
            }
        }
    };

    // Select dates on month calendar
    JsCalendarYearMonth.prototype._selectDatesForMonth = function(calendar, month, dates) {

        var datesToSelect = dates.filter(function(date) {
            var selectedDate = new Date(date);
            return selectedDate.getFullYear() === this._year && (selectedDate.getMonth() + 1) === month;
        }, this);

        if (datesToSelect.length > 0) {
            var dateObjects = datesToSelect.map(function(date) {
                var dt = new Date(date).setHours(0, 0, 0, 0);
                return jsCalendar.tools.parseDate(dt);
            });
            calendar.select(dateObjects);
        }
    };

    // Un-select dates on month calendar
    JsCalendarYearMonth.prototype._unselectDatesForMonth = function(calendar, month, dates) {

        dates = dates.filter(function(date) {
            var selectedDate = new Date(date);
            return selectedDate.getFullYear() !== this._year || (selectedDate.getMonth() + 1) !== month;
        }, this);

        calendar.clearselect();
    };

    // Unselect all dates
    // Podriamos personalizarla para que limpiase la selección de un mes en concreto o de un año en concreto.
    JsCalendarYearMonth.prototype.clearSelect = function(){
        // Unselect all dates
        this._unselectAllDates();
        // Refresh
        this.refresh();

        // Return
        return this;
    };

    // Get selected dates
    /**
     * 
     * @param {object} options {sort, type}
     * sort	true	Sort in ascending order
     * sort	"asc" | "desc"	Sort in ascending/descending order
     * type	"timestamp"	Format dates as timestamp integer
     * type	"date"	Format dates as javascript Date
     * type	String with month format or day format	Format dates as custom string
     * @returns Array
     */
    JsCalendarYearMonth.prototype.getSelected = function(options){
        // Check if no options
        if (typeof options !== 'object') {
            options = {};
        }

        // Copy selected array
        var dates = this._selectedDates.slice();

        // Options - Sort array
        if (options.sort) {
            if (options.sort === true) {
                dates.sort();
            }
            else if (typeof options.sort === 'string') {
                if (options.sort.toLowerCase() === 'asc') {
                    dates.sort();
                }
                else if (options.sort.toLowerCase() === 'desc'){
                    dates.sort();
                    dates.reverse();
                }
            }
        }

        // Options - Data type
        if (options.type && typeof options.type === 'string') {
            var i;
            // Convert to date object
            if (options.type.toLowerCase() === 'date'){
                for (i = dates.length - 1; i >= 0; i--) {
                    dates[i] = new Date(dates[i]);
                }
            }
            // If not a timestamp - convert to custom format
            else if (options.type.toLowerCase() !== 'timestamp') {
                for (i = dates.length - 1; i >= 0; i--) {
                    dates[i] = this._parseToDateString(new Date(dates[i]), options.type);
                }
            }
        }

        // Return dates
        return dates;
    };

    // Check if date is selected
    JsCalendarYearMonth.prototype.isSelected = function(date){
        // If no arguments or null
        if (typeof date === 'undefined' || date === null) {
            // Return
            return false;
        }

        // Parse date
        date = jsCalendar.tools.parseDate(date);
        date.setHours(0, 0, 0, 0);
        date = date.getTime();

        // If selected
        if (this._selectedDates.indexOf(date) >= 0) {
            return true;
        }
        // If not selected
        else {
            return false;
        }
    };

    // Check if date is in active month
    JsCalendarYearMonth.prototype.isInYear = function(date){
        // If no arguments or null
        if (typeof date === 'undefined' || date === null) {
            // Return
            return false;
        }

        // Parse date and get month
        var year = jsCalendar.tools.parseDate(date);
        year.setHours(0, 0, 0, 0);
        year = year.setDate(1).getFullYear();
        
        // If same month
        if (year === this._year) {
            return true;
        }
        // Other month
        else {
            return false;
        }
    };

    // Set Year - Hace "activo" el año indicado
    JsCalendarYearMonth.prototype.setYear = function(newYear) {
        const oldYear = this._year;
        const oldnow = this._now;
        this._now = null;
        
        this._setYear(newYear);

        // Si el nuevo año es válido y es distinto al anterior
        // actualizamos y dispachamos evento de cambio.
        if(this._now !== null && this._year !== oldYear){
            // Refresh
            this.refresh();
            // Dispatchar el evento onYearChanged
            var event = new CustomEvent('onYearChanged', {
                detail: { newYear: this._year, oldYear: oldYear }
            });
            this._target.dispatchEvent(event);

            // Ejecutar la función onYearChanged si está definida en las opciones
            if (typeof this._options.onYearChanged === 'function') {
                this._options.onYearChanged(this._year, oldYear);
            }
        } else {
            this._now = oldnow;
        }

        return this;
    };

    // Select dates on calendar
    JsCalendarYearMonth.prototype._selected = function(dates) {
        // Copy array instance
        dates = dates.slice();

        // Parse dates (date object)
        var dates = dates.map(function(date) {
            var dt = new Date(date).setHours(0, 0, 0, 0);
            return jsCalendar.tools.parseDate(dt);
        });

        // Insert dates on array
        var index;
        for (i = dates.length - 1; i >= 0; i--) {
            // If not already selected
            index = this._selectedDates.findIndex(function(date) {
                return date.getTime() === dates[i].getTime();
            });
            if (index < 0) {
                this._selectedDates.push(dates[i]);
                var month = dates[i].getMonth();
                this._calendars[month].select(dates[i]);
            }
        }
    };

    // Un-select dates on calendar
    JsCalendarYearMonth.prototype._unselectDates = function(dates) {
        // Copy array instance
        dates = dates.slice();

        // Parse dates
        var dates = dates.map(function(date) {
            var dt = new Date(date).setHours(0, 0, 0, 0);
            return jsCalendar.tools.parseDate(dt);
        });

        // Remove dates of the array
        var index;
        for (i = dates.length - 1; i >= 0; i--) {
            // If selected
            index = this._selectedDates.findIndex(function(date) {
                return date.getTime() === dates[i].getTime();
            });
            if (index >= 0) {
                this._selectedDates.splice(index, 1);
                var month = dates[i].getMonth();
                this._calendars[month].unselect(dates[i]);
            }
        }
    };

    // Select dates
    JsCalendarYearMonth.prototype.selectDates = function(dates) {
        // If no arguments
        if(typeof dates !== 'undefined') {
            if(!(dates instanceof Array)) {
                dates = [dates];
            }
        } else {
            // Return
            return this;
        }
        // Select dates
        this._selected(dates);
        // Refresh. (No queremos volver a posicionar cada calendario, sólo queremos aplicar la selección)
        this._isFrozen = true;
        this.refresh();
        this._isFrozen = false;

        // Return
        return this;
    };

    // Unselect dates
    JsCalendarYearMonth.prototype.unselectDates = function(dates){
        // If no arguments
        if (typeof dates === 'undefined') {
            // Return
            return this;
        }

        // If dates not array
        if (!(dates instanceof Array)) {
            // Lets make it an array
            dates = [dates];
        }
        // Unselect dates
        this._unselectDates(dates);
        // Refresh. (No queremos volver a posicionar cada calendario, sólo queremos aplicar la selección)
        this._isFrozen = true;
        this.refresh();
        this._isFrozen = false;

        // Return
        return this;
    };

    JsCalendarYearMonth.prototype.freeze = function() {
        this._isFrozen = true;
        return this;
    };

    JsCalendarYearMonth.prototype.unfreeze = function() {
        this._isFrozen = false;
        return this;
    };

    JsCalendarYearMonth.prototype.isFrozen = function() {
        return this._isFrozen;
    };

    // Refresh
    // Safe _update
    JsCalendarYearMonth.prototype.refresh = function(year) {
        // If date provided
        if (typeof year !== 'undefined' && year !== null && this._year !== year) {
            // If date is in range
            if (this._isYearInRange(year)) {
                const oldYear = this._year;
                this._year = year;

                // Dispatchar el evento onYearChanged
                var event = new CustomEvent('onYearChanged', {
                    detail: { newYear: this._year, oldYear: oldYear }
                });
                this._target.dispatchEvent(event);
    
                // Ejecutar la función onYearChanged si está definida en las opciones
                if (typeof this._options.onYearChanged === 'function') {
                    this._options.onYearChanged(this._year, oldYear);
                }
            }
        }

        // If calendar elements ready
        if (this._elements.created === true) {
            this._update();
        }

        // Return
        return this;
    };

    // Reset to the date
    JsCalendarYearMonth.prototype.reset = function(){
        this.refresh(this._now);

        // Return
        return this;
    };

    // Método previousYear
    JsCalendarYearMonth.prototype.previousYear = function() {
        this.setYear(this._year - 1);
    };
    
    // Método nextYear
    JsCalendarYearMonth.prototype.nextYear = function() {
        this.setYear(this._year + 1);
    };

    // Goto a year. "moverse" al año indicado (el año "activo" no varía)
    // En una vista anual, tal vez, no tenga mucho sentido; dependerá.
    JsCalendarYearMonth.prototype.gotoYear = function(year){
        this.refresh(year);

        // Return
        return this;
    };

    // Set language
    JsCalendarYearMonth.prototype.setLanguage = function(code) {
        // Check if language exist
        if (typeof code !== 'string'){
            // Throw an error
            throw new Error('JsCalendarYearMonth: Invalid language code.');
        }

        // Change language
        if( this._options.jsCalendarOptions.language !== code)
        {
            if (this._calendars.length > 0) {
                for (month = 0; month < 12; month++) {
                    var calendar = this._calendars[month];
                    calendar = calendar.setLanguage(code);
                    if( month === 0){
                        var language = calendar.languages[code];
                        this._options.jsCalendarOptions.language = code;
                        this._options.jsCalendarOptions.language.firstDayOfTheWeek = language.firstDayOfTheWeek;
                        this._options.jsCalendarOptions.language.weekdaysShort = language.weekdaysShort;
                        this._options.jsCalendarOptions.language.weekdaysMin = language.weekdaysMin;
                    }
                }
                // Refresh calendar
                this.refresh(); 
            }
        }

        // Return
        return this;
    };
    
    // Get a new object
    JsCalendarYearMonth.new = function(){
        // Create new object
        var obj = new JsCalendarYearMonth();
        // Construct calendar
        obj._construct(arguments);
        // Return new object
        return obj;
    };
    
    // Manage existing JsCalendarYearMonth objects
    var jsCalendarYearObjects = {};
    JsCalendarYearMonth.set = function(identifier, yearcalendar){
        if (yearcalendar instanceof JsCalendarYearMonth) {
            jsCalendarYearObjects[identifier] = yearcalendar;
            return true;
        }
        throw new Error('JsCalendarYearMonth: The second parameter is not a JsCalendarYearMonth.');
    };
    JsCalendarYearMonth.get = function(identifier){
        if (jsCalendarYearObjects.hasOwnProperty(identifier)) {
            return jsCalendarYearObjects[identifier];
        }
        return null;
    };
    JsCalendarYearMonth.del = function(identifier){
        if (jsCalendarYearObjects.hasOwnProperty(identifier)) {
            delete jsCalendarYearObjects[identifier];
            return true;
        }
        return false;
    };

    // Return
    return JsCalendarYearMonth;

})();

// Añadir la extensión 'custom-date-attribute'
jsCalendar.ext('custom-date-attribute', {
    update: function(instance, month) {
        for (var i = month.days.length - 1; i >= 0; i--) {
            var dayElement = instance._elements.bodyCols[i];
            var date = month.days[i];
            dayElement.setAttribute('date', 
                jsCalendar.tools.dateToString(date, 'YYYYMMDD', instance._options.language || 'en'));
        }
    }
});

// Añadir la extensión 'custom-weekend-today'
// Resalta los sábados, domingos y el día de hoy.
jsCalendar.ext('custom-weekend-today', {
    update: function(instance, month) {
        var today = new Date();
        for (var i = month.days.length - 1; i >= 0; i--) {
            var dayElement = instance._elements.bodyCols[i];
            if (month.days[i].getDay() === 0 || month.days[i].getDay() === 6) {
                dayElement.classList.add('jsCalendar-weekend-days');
            }
            if (today!=null && month.days[i].getFullYear() === today.getFullYear() && 
            month.days[i].getMonth() === today.getMonth() &&
            month.days[i].getDate() === today.getDate()) {
                dayElement.classList.add('jsCalendar-today');
                today = null;
            }
        }
    }
});
