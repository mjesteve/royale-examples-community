(function($) {
    // Verificar si jsCalendar está disponible
    if (!$) throw 'Error: jsCalendar library was not found';

    // Constructor de YearMonthView
    var YearMonthView = function() {
        // Solo se inicializa si hay argumentos
        if (arguments.length > 0) {
            this._construct(arguments);
        }
    };

    // Versión
    YearMonthView.version = 'v1.0.0';

    // Opciones por defecto
    YearMonthView.options = {
        year: new Date().getFullYear(), // Año que se mostrará
        minYear: 1900, // Año que se mostrará
        maxYear: 2100, // Año que se mostrará
        autoResponsive: true, // Ajuste automático en pantallas pequeñas
        monthsPerRow: NaN, // Número de meses por fila
        calendarWidth: NaN, // Ancho mínimo de cada calendario
        classWrapper: 'jsCalendar-yearmonthview-container',
        class: undefined, //theme
        jsCalendarOptions: {},
    };

    // Sub-Constructor
    YearMonthView.prototype._construct = function(args) {
        // Parsear argumentos
        args = this._parseArguments(args);
        // Configurar el contenedor
        this._setTarget(args.target);
        //YearMonthView.options.calendarWidth = this.calculateCalendarWidth();
        this._calendarWidthDefault = this.calculateCalendarWidth();
        // Parsear opciones
        var options = this._parseOptions(args.options);
        // Añadir la clase 'jsCalendar-yearmonthview-container' al contenedor principal
        this._target.classList.add(this._options.classWrapper);
        // Renderizar calendarios
        this.renderCalendars();
        // Configurar eventos de redimensionamiento si es auto-responsive
        if (this._options.autoResponsive) {
            window.addEventListener('resize', this.renderCalendars.bind(this));
        }
    };

    // Parsear argumentos
    YearMonthView.prototype._parseArguments = function(args) {
        // Arguments object
        var obj = {
            target : null,
            options : {}
        };

        // If no arguments
        if (args.length === 0) {
            // Throw an error
            throw new Error('jsCalendar-yearmonthview: No parameters were given.');
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
                    throw new Error('jsCalendar-yearmonthview: Not target was given.');
                }
            }
        }

        // Many arguments
        else {

            // First is target
            obj.target = args[0];

            // If options
            if (args.length >= 3) {
                obj.options = args[2];
            }

            // If date
            if (args.length >= 2) {
                obj.options.date = args[1];
            }

        }

        // Return object
        return obj;
    };

    // Configurar el contenedor y añadir la clase automáticamente
    YearMonthView.prototype._setTarget = function(element) {
        // Parse target
        var target = $.tools.getElement(element);
        // If target not found
        if (!target) {
            // Throw an error
            throw new Error('jsCalendar-yearmonthview: Target was not found.');
        }
        else {
            // Save element
            this._target = target;
        }
    };

    // Parsear opciones
    YearMonthView.prototype._parseOptions = function(doptions) {
        // Options Object
        this._options = {};
        // Input options object (dirty)
        var options = {};

        var item;
        // Load default and input options
        for (item in YearMonthView.options) {
            // Default options
            if (YearMonthView.options.hasOwnProperty(item)) {
                if (YearMonthView.options[item] instanceof Array)
                    this._options[item] = YearMonthView.options[item].slice(0);
                else
                    this._options[item] = YearMonthView.options[item];
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

        // Check options
        if (typeof options.year !== 'undefined'){
            // If number
            if (typeof options.year === 'number') {
                this._options.year = options.year;
            }
            // If string
            else if (typeof options.year === 'string') {
                item = parseInt(options.year, new Date().getFullYear());
                if (!isNaN(item)) this._options.year = item;
            }
        }
        
        if (typeof options.classWrapper === 'string'){
            this._options.classWrapper = options.classWrapper;
        }
        
        if (typeof options.class === 'string'){
            this._options.class = options.class;
            this._calendarWidthDefault = this.calculateCalendarWidth();
        }

        if (typeof options.calendarWidth !== 'undefined'){
            // If number
            if (typeof options.calendarWidth === 'number') {
                this._options.calendarWidth = options.calendarWidth;
            }
            // If string
            else if (typeof options.calendarWidth === 'string') {
                item = parseInt(options.calendarWidth);
                if (!isNaN(item)) this._options.calendarWidth = item;
            }

            if (isNaN(this._options.calendarWidth)){
                this._options.calendarWidth = this._calendarWidthDefault;
            }
        } else {
            this._options.calendarWidth = this._calendarWidthDefault;
        }

        if (typeof options.monthsPerRow !== 'undefined'){
            // If number
            if (typeof options.monthsPerRow === 'number') {
                this._options.monthsPerRow = options.monthsPerRow;
            }
            // If string
            else if (typeof options.monthsPerRow === 'string') {
                item = parseInt(options.monthsPerRow);
                if (!isNaN(item)) this._options.monthsPerRow = item;
            }
        }

        if (typeof options.autoResponsive !== 'undefined'){
            item = options.autoResponsive.toString().toLowerCase();
            if (item === 'false') {
                this._options.autoResponsive = false;
            }
            else if (item === 'true') {
                this._options.autoResponsive = true;
            }
        }

        // Get calendar options
        this._options.jsCalendarOptions = {};
        for (item in $.options) {
            if( item === 'navigator'){
                this._options.jsCalendarOptions[item] = false; // Desactivar la navegación si está en las opciones generales
            } else {
                // Dynamic options
                if (doptions.hasOwnProperty(item)) {
                    this._options.jsCalendarOptions[item] = doptions[item];
                }
                // Dataset options
                else if (this._target.dataset.hasOwnProperty(item)) {
                    this._options.jsCalendarOptions[item] = this._target.dataset[item];
                }
            }
        }
        // Return calendar options
        return options;
    };

    // Renderizar los calendarios
    YearMonthView.prototype.renderCalendars = function() {
        const container = this._target;
        if (!container) {
            console.error(`Container with ID ${this._target} not found.`);
            return;
        }

        container.innerHTML = ''; // Limpiar el contenedor

        const containerStyle = window.getComputedStyle(container);
        var containerPadding = parseFloat(containerStyle.paddingLeft) + parseFloat(containerStyle.paddingRight);
        var containerBorder = parseFloat(containerStyle.borderLeftWidth) + parseFloat(containerStyle.borderRightWidth);
        // var containerGap = parseFloat(containerStyle.gap) * 2;
        var containerOffSet = containerPadding + containerBorder;

        var containerWidth = container.clientWidth - containerOffSet;
        var monthsPerRow, calendarWidth;
        var calendarWidth = this._calendarWidthDefault;
        if(!isNaN(this._options.calendarWidth)){
            calendarWidth = this._options.calendarWidth;
        }
        monthsPerRow = this.calculateMonthsPerRow(containerWidth, calendarWidth);
        if(!isNaN(this._options.monthsPerRow) && this._options.monthsPerRow < monthsPerRow)
        {
            monthsPerRow = this._options.monthsPerRow;
        }
        calendarWidth = Math.floor(containerWidth / monthsPerRow);
        // calendarWidth = Math.max(Math.floor(containerWidth / monthsPerRow), calendarWidth);
        //const calendarWidth = Math.max(Math.floor(containerWidth / monthsPerRow), this._options.calendarWidth);
        container.style.display = "inline-block";
        //container.style.gridTemplateColumns = `repeat(auto-fill, minmax(${calendarWidth}px, 1fr))`;
        //container.style.gridGap = "10px";

        const totalMonths = 12;
        for (let i = 0; i < totalMonths; i++) {
            const calendarDiv = document.createElement('div');
            calendarDiv.style.width = `${calendarWidth}px`; 
            /* calendarDiv.style.maxWidth = `${calendarWidth}px`; 
            calendarDiv.style.minWidth = `${calendarWidth}px`;  */
            if(this._options.class !== undefined){
                calendarDiv.className += this._options.class;
            }
            container.appendChild(calendarDiv);

            // Filtrar las opciones de YearMonthView y pasar el resto a jsCalendar
            const calendarOptions = Object.assign({}, this._options.jsCalendarOptions, {
                target: calendarDiv,
                date: new Date(this._options.year, i, 1), // Establecer mes y año
            });

            const calendar = new $.new(calendarOptions);

            /* const calendar = jsCalendar.new({
                target: calendarDiv,
                date: new Date(this.options.year, i, 1), // Establecer mes y año según la opción proporcionada
                options: this._options.jsCalendarOptions
            }); */
        }
    };

    // Calcular el número de meses por fila
    YearMonthView.prototype.calculateMonthsPerRow = function(containerWidth, calendarWidth) {
        const calculatedMonthsPerRow = Math.floor(containerWidth / calendarWidth);
        return Math.max(calculatedMonthsPerRow, 1);
    };

    // Calcular el número de meses por fila
    YearMonthView.prototype.calculateCalendarWidth = function() {
        // Crear un contenedor temporal en el DOM
        var tempContainer = document.createElement('div');
        // tempContainer.classList.add('jsCalendar');
        if (this._options === undefined || typeof this._options.class === 'undefined'){
            tempContainer.className = 'jsCalendar classic-theme';
        } else {
            tempContainer.className = 'jsCalendar ' + this._options.class;
        }

        tempContainer.style.position = 'absolute';
        tempContainer.style.left = '-9999px';
        document.body.appendChild(tempContainer);

        // Crear una fila simulada de 7 días, aplicando las clases necesarias
        for (var i = 0; i < 7; i++) {
            var dayCell = document.createElement('div');
            dayCell.className = 'jsCalendar-day';
            dayCell.textContent = '00'; // Texto simulado
            tempContainer.appendChild(dayCell);
        }

        // Forzar la recalibración de estilo
        window.getComputedStyle(tempContainer).width;

        // Obtener el ancho de una celda
        var cell = tempContainer.querySelector('.jsCalendar-day');
        var cellStyle = window.getComputedStyle(cell);
        var cellWidth = parseFloat(cellStyle.width);
        var cellPadding = parseFloat(cellStyle.paddingLeft) + parseFloat(cellStyle.paddingRight);
        var cellBorder = parseFloat(cellStyle.borderLeftWidth) + parseFloat(cellStyle.borderRightWidth);
        var cellMargin = parseFloat(cellStyle.marginLeft) + parseFloat(cellStyle.marginRight);

        // Calcular el ancho total de una celda, incluyendo márgenes
        var totalCellWidth = cellWidth + cellPadding + cellBorder + cellMargin;

        // Ancho total del calendario (7 celdas)
        var calendarWidth = totalCellWidth * 7;

        // Eliminar el contenedor temporal
        document.body.removeChild(tempContainer);

        return calendarWidth;
    };

    // Registrar YearMonthView como una extensión de jsCalendar
    $.yearmonthview = function() {
        // Crear nuevo objeto
        var obj = new YearMonthView();
        // Construir yearmonthview
        obj._construct(arguments);
        // Devolver nuevo objeto
        return obj;
    };

    // Registrar YearMonthView en jsCalendar para integración más profunda
    $.ext('YearMonthView', YearMonthView);

})(window.jsCalendar);
