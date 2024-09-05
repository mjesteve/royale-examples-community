package
{

	/**
	 * @externs
	 */
	COMPILE::JS
	public class jsCalendarYearMonth{

		/**
		 * <inject_script>
         *          
		 * //var link_jscalendar = document.createElement("link");
         * //link_jscalendar.setAttribute("rel", "stylesheet");
         * //link_jscalendar.setAttribute("type", "text/css");
         * //link_jscalendar.setAttribute("href", "jscalendar/source/jsCalendarYearMonth.css");
         * //document.head.appendChild(link_jscalendar);
		 * 
		 * //var script_jscalendar = document.createElement("script");
		 * //script_jscalendar.setAttribute("src", "jscalendar/source/jsCalendarYearMonth.js");
		 * //document.head.appendChild(script_jscalendar);
         * 
		 * </inject_script>
		*/
        public function jsCalendarYearMonth(target:HTMLElement, year:Number=0, options:Object=null){
        /*
        // Default options
        JsCalendarYearMonth.options = {
            // jsCalendar component options. These will be carried over to each of the jsCalendar sub-components (months)
                language: 'en',
                zeroFill: false,
                monthFormat: 'month',
                dayFormat: 'D',
                firstDayOfTheWeek: false,
                navigator: false,           //In jsCalendarYearMonth it is ignored, always - false -
                navigatorPosition: 'both',
                min : false,                //In jsCalendarYearMonth it is ignored, always - false -
                max : false,                //In jsCalendarYearMonth it is ignored, always - false -
                onMonthRender: false,
                onDayRender: false,
                onDateRender: false,
            // jsCalendarYearMonth component's own options
                year: 0,
                minYear: 0,
                maxYear: 0,
                themeClasses: [],               // String | Array, Clases CSS - Themes
                responsiveLayout: true,         // true:  The display of the months, inside the component, will adapt to the container
                                                // false: The months per row will be determined by "monthsPerRow"
                monthsPerRow: 4,                // Number of months per row. Fixed.
                yearNavigator: true,
                yearNavigatorPosition : 'both', // 'both', 'left', 'right'
                navIcons: false,                // 'fontawesome', 'material'
                fontawesomePrefix: 'fa',        // 'fa' v.4.7, 'fas' v.5-6
                selectedDates: [],              // String | Array. Dates selected when initializing
                                                // selectedDates: "01-05-2024"
                                                // selectedDates: ["01-05-2024","01-10-2024"]
                extensions: [],                 // Extensions to apply to the months that make up the annual calendar.
                                                // Custom extensions can be added (jsCalendar.ext(...))
                                                // The component includes two extensions:
                                                //  - 'custom-weekend-today': Highlights Saturdays, Sundays (class 'jsCalendar-weekend-days') and today ('jsCalendar-today')
                                                //  - 'custom-date-attribute': Adds the "date" attribute to the DOM objects of the days of the month (td) 
                                                //                             with the string of the date that it represents. 
                                                // For example:
                                                // <tr>
                                                // <td date="01/01/2024">01</td>
                                                // <td date="02/01/2024">02</td>
                                                // ...
                                                // <td date="06/01/2024" class="jsCalendar-weekend-days" style="background-color: rgb(255, 235, 59);">06</td>
                                                // <td date="07/01/2024" class="jsCalendar-weekend-days" style="background-color: rgb(255, 235, 59);">07</td></tr>

                renderHeader: null,             // Custom function to render the calendar header.
                                                // If a "title" is created in the customization and you want it to be recognized as such by the 
                                                // component, you must add the CSS class 'year-title' to it.
                                                // Similarly, if you create navigation buttons and add the CSS class 'prev' or 'next' to them, 
                                                // for the previous year or next year button respectively, they will also be recognized by the 
                                                // component (only if yearNavigator: true has been indicated in the configuration options)
                                                // In JS:
                                                function(year) {
                                                    var customHeader = document.createElement('div');
                                                    customHeader.className = 'custom-year-header';

                                                    var title = document.createElement('h1');
                                                    title.className = 'year-title';
                                                    title.textContent = 'Calendario de ' + year;
                                                    customHeader.appendChild(title);

                                                    var subtitle = document.createElement('p');
                                                    subtitle.textContent = '¡Personaliza este calendario a tu gusto!';
                                                    customHeader.appendChild(subtitle);

                                                    return customHeader;
                                                }
                customYearTitle:null,           // Custom function that will return the text to include as the title.
                
                onPrevYear: null,               // Custom function to be executed instead of previous()
                                                // onPrevYear: function() {
                                                //     this.setYear(this._year - 2);
                                                // }

                onNextYear: null,               // Custom function to be executed instead of next()
                                                // onNextYear: function() {
                                                //     this.setYear(this._year + 2);
                                                // }

                onYearChanged: null,            // Custom function that will be called, by the component, when the displayed year changes.
                                                // Another option is to capture the CustomEvent dispatched by the component:
                                                // 
                                                // var calendarElement = document.getElementById('year-calendar');
                                                // var yearCalendar = new jsCalendarYearMonth(calendarElement);
                                                // calendarElement.addEventListener('onYearChanged', function(event) {
                                                //     var newYear = event.detail.newYear;
                                                //     console.log("El año ha cambiado a:", newYear, event.detail.oldYear);
                                                //     var print_year = document.getElementById("my-input-b");
                                                //     print_year.value = newYear;
                                                });

                onDateClick: null,              // Nueva opción para onDateClick
                                                // 
                                                // Another option is to capture the onDateClick Event dispatched by the component:
                                                // 
                                                // var calendarElement = document.getElementById('year-calendar');
                                                // calendarElement.addEventListener('onDateClick', function(event) {
                                                //     console.log("Day click:", event.detail.date);
                                                //     var print_date = document.getElementById("my-input-a");
                                                //     print_date.value = jsCalendar.tools.dateToString(event.detail.date, 'DAY, DD MONTH YYYY', 'es');
                                                // });
            };
        */
        }
        /**
         * Move to the next year.
         * n    Go to year + n
         *      Nan, go to next year
         */
        public function nextYear(n:Number = NaN):void{
        }
        /**
         * Move to the previous year.
         * n    Go to year - n
         *      Nan, go to previous year
         */
        public function previousYear(n:Number = NaN):void{
        }
        /**
         * Set the calendar language.
         */
		public function setLanguage(languageCode:String):void{
		}
        /**
         * Set the calendar year.
         */
        public function gotoYear(year:Number):void{
        }
        /**
         * Set the calendar year.
         */
        public function setYear(year:Number):void{
        }
        /**
         * Refreshes the calendar, updating the HTML of the calendar (mainly for developers).
         * If a year is provided, the calendar will refresh to that date (exactly like the goto method).
         * (Refresh layout)
         */
        public function refresh(year:Number = null):void{
        }
        /**
         * Reset the calendar year. (Year of initialization or last year set via setYear)
         */
		public function reset():void{
		}
        /**
         * Select days on the calendar.
         */
		public function selectDates(arr:Array=null):void{
		}
        /**
         * Unselect days on the calendar.
         */
		public function unselectDates(arr:Array=null):void{
		}
        /**
         * Clear select.
         */
		public function clearSelected():void{
		}
        /**
         * Get selected
         * @param   options
         *          "sort"  true                Sort in ascending order
         *                  "asc"|"desc"        Sort in ascending/descending order
         *          "type"  "timestamp"         Format dates as timestamp integer
         *                  "date"              Format dates as javascript Date
         *                  String with month format(*) or day format(**)
         *                                      Format dates as javascript Date
         *                                      (*) Default "month"
         *                                          "MONTH"|"month"     Month's full name	        February
         *                                          "MMM"|"mmm"	        Month's first 3 letters	    Feb
         *                                          "##"	            Month's number (zerofilled)	02
         *                                          "#"                 Month's number	            2
         *                                          "YYYY"|"yyyy"	    Year	                    2017
         *
         *                                      Codes can be combined. For example, for the February
         *                                      month of the year 2017, the code "##/YYYY" would display 02/2017
         *
         *                                     (**) Default "D"
         *                                          "DAY"|"day"         Day's full name	            Monday
         *                                          "DDD"|"ddd"	        Day's first 3 letters	    Mon
         *                                          "DD"|"dd"           Day's first 2 letters   	Mo
         *                                          "D"                 Day's first letter          M
         */
		public function clearSelect(options:Object=null):Array{
            return null;
		}
        /**
         * Check if date is selected
         */
		public function isSelected(date:Date):Boolean{
            return null;
		}
        /**
         * Check if date is visible.
         */
		public function isVisible(date:Date):Boolean{
            return null;
		}
        /**
         * Check if in month.
         */
		public function isInYear(date:Date):Boolean{
            return null;
		}
        public function freeze():void
        {
        }
        public function unfreeze():void
        {
        }
		public function isFrozen():Boolean{
            return null;
		}

	}
}