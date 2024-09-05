/*
 * jsCalendarYearMonth v0.1.3-beta
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

function jsCalendarYearMonth(element, options) {
    // Parsear opciones
    this._options = this._parseOptions(options);
    
    // Establecer el año
    this._year = this._options.year || new Date().getFullYear();

    // Crear el contenedor principal
    this._container = element;
    this._container.classList.add('jsCalendar-yearmonth');
    
    // Almacenar las instancias de los calendarios
    this._calendars = [];

    // Crear la vista anual
    this._render();
}

// Version
jsCalendarYearMonth.version = 'v0.1.3-beta';

// Asignar métodos individualmente al prototipo de jsCalendarYearMonth

// Método _parseOptions
jsCalendarYearMonth.prototype._parseOptions = function(options) {
    var defaultOptions = {
        language: 'en',
        zeroFill: false,
        monthFormat: 'month',
        dayFormat: 'D',
        firstDayOfTheWeek: false,
        navigator: false,
        navigatorPosition: 'both',
        onMonthRender: false,
        onDayRender: false,
        onDateRender: false,

        year: new Date().getFullYear(),
        minYear: 0,
        maxYear: 0,
        themeClasses: [], // Array de clases de temas
        yearNavigator: true,
        yearNavigatorPosition : 'both', //'both', 'left', 'right'
        navIcons: false, //'fontawesome', 'material'
        fontawesomePrefix: 'fa', //'fa' v.4.7, 'fas' v.5-6
        extensions: [],
        selectedDates: [], // Array de fechas seleccionadas
        renderHeader: null, // Función personalizada para renderizar la cabecera
        customYearTitle:null,   // Función personalizada que devolverá el texto a incluir como título.
        responsiveLayout: true, // true: inline, false: hace caso a monthsPerRow
        monthsPerRow: 4, // Número de meses por fila
        onPrevYear: null,   // Función personalizada para navegar al año anterior
        onNextYear: null,    // Función personalizada para navegar al año siguiente
        onYearChanged: null,  // Nueva opción para onYearChanged
        onDateClick: null,     // Nueva opción para onDateClick
    };

    // Crear un objeto de opciones combinando las opciones predeterminadas y las proporcionadas
    var parsedOptions = Object.assign({}, defaultOptions, options);

    // Set min annuary year
    if (typeof parsedOptions.minYear !== 'undefined' && parsedOptions.minYear !== '0' && parsedOptions.minYear !== 0) {
        if(!Number.isInteger(parsedOptions.minYear) || parsedOptions.minYear < 0) {
            parsedOptions.minYear = defaultOptions.minYear;            
        } else {
            if( parsedOptions.year < parsedOptions.minYear ){
                parsedOptions.year = parsedOptions.minYear;
            }
        }
    } else {
        parsedOptions.minYear = defaultOptions.minYear;
    }
    // Set max annuary year
    if (typeof parsedOptions.maxYear !== 'undefined' && parsedOptions.maxYear !== '0' && parsedOptions.maxYear !== 0) {
        if(!Number.isInteger(parsedOptions.maxYear) || parsedOptions.maxYear < 0) {
            parsedOptions.maxYear = defaultOptions.maxYear;       
        } else {
            if( parsedOptions.year > parsedOptions.maxYear ){
                parsedOptions.year = parsedOptions.maxYear;
            }
        }
    } else {
        parsedOptions.maxYear = defaultOptions.maxYear;
    }

    // Validar que monthsPerRow sea un número entero en el rango de 1 a 12
    if (!parsedOptions.responsiveLayout && (typeof parsedOptions.monthsPerRow !== 'number' || 
        parsedOptions.monthsPerRow < 1 || 
        parsedOptions.monthsPerRow > 12 || 
        !Number.isInteger(parsedOptions.monthsPerRow)) ) {
        console.warn(`Valor inválido para monthsPerRow (${parsedOptions.monthsPerRow}). Se usará el valor predeterminado de ${defaultOptions.monthsPerRow}.`);
        parsedOptions.monthsPerRow = defaultOptions.monthsPerRow;
    }

    return parsedOptions;
};

// Método _render
jsCalendarYearMonth.prototype._render = function() {
    var wrapper = this._container;

    // Renderizar la cabecera
    var header = this._renderHeader(this._options.onPrevYear ? this._options.onPrevYear.bind(this) : this._prevYear.bind(this),
    this._options.onNextYear ? this._options.onNextYear.bind(this) : this._nextYear.bind(this));
    wrapper.appendChild(header);

    this._updateButtonsNavYear();    
    
    // Renderizar el anuario
    if( this._options.responsiveLayout ) {
        this._renderBodyResponsive();
    } else {
        this._renderBodyColsRow();
    }
};

// Método _render no responsive. cols per row.
jsCalendarYearMonth.prototype._renderBodyColsRow = function() {
    var wrapper = this._container;
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
jsCalendarYearMonth.prototype._renderBodyResponsive = function() {
    var wrapper = this._container;
    // Crear calendarios mensuales
    for (var i = 0; i < 12; i++) {
        var monthContainer = document.createElement("div");
        wrapper.appendChild(monthContainer);

        var calendar = this._renderMonth(wrapper, monthContainer, i);
        this._calendars.push(calendar);
    }
};

// Método _renderHeader
jsCalendarYearMonth.prototype._renderHeader = function(onPrevYear, onNextYear) {
    var header;

    if (typeof this._options.renderHeader === 'function') {
        header = this._options.renderHeader(this._year, onPrevYear, onNextYear);
    } else {
        header = document.createElement("div");
        header.className = "year-header";

        // Texto del año
        var title = document.createElement('span');
        title.className = "year-title";
        var txttitle = this._year;

        // Verificar si hay una función personalizada para renderizar el título del año
        if (typeof this._options.customYearTitle === 'function') {
            txttitle = this._options.customYearTitle(this._year);
        }

        var prevNav;
        var nextNav;
        if (this._options.yearNavigator) {
            if (typeof this._options.navIcons === 'string' && (this._options.navIcons === 'fontawesome' || this._options.navIcons === 'material')) {
                prevNav = document.createElement('i');
                prevNav.className = "year-nav iconbutton prev ";
                if (this._options.navIcons === 'fontawesome'){
                    prevNav.className += this._options.fontawesomePrefix +' fa-angle-left'; // Icono de FontAwesome - chevron
                } else {
                    // Icono de Material Design para navegar al año anterior
                    prevNav.className += "material-icons";
                    prevNav.textContent = "chevron_left";  // Ícono de "flecha a la izquierda"
                }
                prevNav.style.cursor = 'pointer';
            } else {
                prevNav = document.createElement("div");
                prevNav.className = "year-nav textbutton prev";
            }
            prevNav.onclick = onPrevYear; // Usar función pasada
        }

        if (this._options.yearNavigator) {

            if (typeof this._options.navIcons === 'string' && (this._options.navIcons === 'fontawesome' || this._options.navIcons === 'material')) {
                nextNav = document.createElement('i');
                nextNav.className = "year-nav iconbutton next ";
                if (this._options.navIcons === 'fontawesome'){
                    nextNav.className += this._options.fontawesomePrefix +' fa-angle-right'; // Icono de FontAwesome
                } else {
                    nextNav.className += "material-icons";
                    nextNav.textContent = "chevron_right";  // Ícono de "flecha a la derecha"
                }
                nextNav.style.cursor = 'pointer';
            } else {
                nextNav = document.createElement("div");
                nextNav.className = "year-nav textbutton next";
            }
            nextNav.onclick = onNextYear;
        }

        title.textContent = txttitle;

        if (!this._options.yearNavigator) {
            header.appendChild(title);
        } else {
            if (this._options.yearNavigatorPosition === 'left') {
                header.appendChild(prevNav);
                header.appendChild(nextNav);
                header.appendChild(title);
            } else if (this._options.yearNavigatorPosition === 'right') {
                header.appendChild(title);
                header.appendChild(prevNav);
                header.appendChild(nextNav);
            } else {
                header.appendChild(prevNav);
                header.appendChild(title);
                header.appendChild(nextNav);
            }
        }
    }

    return header;
};
// Método _renderMonth
jsCalendarYearMonth.prototype._renderMonth = function(wrapper, monthContainer, month) {
    // Aplicar las clases de tema especificadas
    this._options.themeClasses.forEach(function(themeClass) {
        monthContainer.classList.add(themeClass);
    });

    var calendar = jsCalendar.new(monthContainer, 0, {
        language: this._options.language,
        zeroFill: this._options.zeroFill,
        monthFormat: this._options.monthFormat,
        dayFormat: this._options.dayFormat,
        firstDayOfTheWeek: !this._options.firstDayOfTheWeek ? undefined : this._options.firstDayOfTheWeek,
        navigator: false,
        onMonthRender: this._options.onMonthRender,
        onDayRender: this._options.onDayRender,
        onDateRender: this._options.onDateRender,
    });
    calendar.goto(new Date(this._year, month, 1));

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
    this._selectDatesForMonth(calendar, month + 1);

    return calendar;
};

// Método updateYear
jsCalendarYearMonth.prototype.updateYear = function(newYear) {
    if(newYear > 0 && this._year !== newYear && 
        (this._options.minYear === 0 || (this._options.minYear !== 0 && newYear >= this._options.minYear)) && 
        (this._options.maxYear === 0 || (this._options.maxYear !== 0 && newYear <= this._options.maxYear))
    ){

        const oldYear = this._year;
        this._year = newYear;

        var title = this._container.querySelector(".year-title");
        var txttitle = this._year;

        // Verificar si hay una función personalizada para renderizar el título del año
        if (typeof this._options.customYearTitle === 'function') {
            txttitle = this._options.customYearTitle(this._year);
        }
        title.textContent = txttitle;

        for (var i = 0; i < 12; i++) {
            this._calendars[i].goto(new Date(this._year, i, 1));
            this._selectDatesForMonth(this._calendars[i], i + 1);
        }

        // Dispatchar el evento onYearChanged
        var event = new CustomEvent('onYearChanged', {
            detail: { newYear: this._year, oldYear: oldYear }
        });
        this._container.dispatchEvent(event);

        // Ejecutar la función onYearChanged si está definida en las opciones
        if (typeof this._options.onYearChanged === 'function') {
            this._options.onYearChanged(this._year, oldYear);
        }
    }

    this._updateButtonsNavYear();
};

// Método _updateButtonsNavYear
jsCalendarYearMonth.prototype._updateButtonsNavYear = function() {
    if(!this._options.yearNavigator || (this._options.minYear === 0 && this._options.maxYear === 0)){
        return;
    }

    // Control de deshabilitación para el botón "Anterior"
    var navButtonPrev = this._container.getElementsByClassName('prev')[0];
    if(navButtonPrev !== undefined && this._options.minYear !== 0 && this._year <= this._options.minYear){
        navButtonPrev.setAttribute('disabled','');
    } else if (navButtonPrev) {
        navButtonPrev.removeAttribute('disabled');
    }

    // Control de deshabilitación para el botón "Siguiente"
    var navButtonNext = this._container.getElementsByClassName('next')[0];
    if(navButtonNext !== undefined && this._options.maxYear !== 0 && this._year >= this._options.maxYear){
        navButtonNext.setAttribute('disabled','');
    } else if (navButtonNext) {
        navButtonNext.removeAttribute('disabled');
    }
};

// Método _prevYear
jsCalendarYearMonth.prototype._prevYear = function() {
    this.updateYear(this._year - 1);
};

// Método _nextYear
jsCalendarYearMonth.prototype._nextYear = function() {
    this.updateYear(this._year + 1);
};

// Método _applyExtensions
jsCalendarYearMonth.prototype._applyExtensions = function(calendar) {
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

// Método _selectDatesForMonth
jsCalendarYearMonth.prototype._selectDatesForMonth = function(calendar, month) {
    var datesToSelect = this._options.selectedDates.filter(function(date) {
        var selectedDate = new Date(date);
        return selectedDate.getFullYear() === this._year && (selectedDate.getMonth() + 1) === month;
    }, this);

    if (datesToSelect.length > 0) {
        var dateObjects = datesToSelect.map(function(date) {
            return new Date(date);
        });
        calendar.select(dateObjects);
    }
};

// Método updateSelectedDates
jsCalendarYearMonth.prototype.updateSelectedDates = function(newSelectedDates) {
    // Actualizar las fechas seleccionadas en las opciones
    this._options.selectedDates = newSelectedDates;

    // Limpiar las fechas seleccionadas actuales en cada calendario
    for (var i = 0; i < 12; i++) {
        /* // Desmarcar cada fecha individualmente
        var selectedDates = this._calendars[i].getSelected();
        selectedDates.forEach(date => this._calendars[i].unselect(date));  */

        // Desmarcar todas las fechas
        this._calendars[i].clearselect();
        // Seleccionar las nuevas fechas
        this._selectDatesForMonth(this._calendars[i], i + 1); 
    }
};

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
