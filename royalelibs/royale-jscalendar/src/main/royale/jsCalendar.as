package
{

	/**
	 * @externs
	 */
	COMPILE::JS
	public class jsCalendar{

		/**
		 * <inject_script>
         *          
		 * var link = document.createElement("link");
         * link.setAttribute("rel", "stylesheet");
         * link.setAttribute("type", "text/css");
         * link.setAttribute("href", "jscalendar/source/jsCalendar.css");
         * document.head.appendChild(link);
		 * 
		 * var script = document.createElement("script");
		 * script.setAttribute("src", "jscalendar/source/jsCalendar.js");
		 * document.head.appendChild(script);
		 * 
		 * script = document.createElement("script"); script.setAttribute("src", "https://cdn.jsdelivr.net/npm/simple-jscalendar@1.4.4/source/jsCalendar.lang.be.js"); script.setAttribute("integrity", "sha384-czOMAb4auqx/S7EgTYgb/Sb3xNKzvCN3heba5z2IR80vAI72y55KvGpYQMOJF0Ul"); script.setAttribute("crossorigin", "anonymous"); document.head.appendChild(script);
		 * script = document.createElement("script"); script.setAttribute("src", "https://cdn.jsdelivr.net/npm/simple-jscalendar@1.4.4/source/jsCalendar.lang.ca.js"); script.setAttribute("integrity", "sha384-qzGOaC9zqJRFiV0hpjawSZ5AZyBN/5LfGURBE+pQVG6jZZG4hZjJI7l8ob7UUsfI"); script.setAttribute("crossorigin", "anonymous"); document.head.appendChild(script);
		 * script = document.createElement("script"); script.setAttribute("src", "https://cdn.jsdelivr.net/npm/simple-jscalendar@1.4.4/source/jsCalendar.lang.de.js"); script.setAttribute("integrity", "sha384-i0GkTTXTirBg3whOHw5AqlI80IINcvOfx2HjQ/x4uqJ+wsB465gvhaekGGxPlxVX"); script.setAttribute("crossorigin", "anonymous"); document.head.appendChild(script);
		 * script = document.createElement("script"); script.setAttribute("src", "https://cdn.jsdelivr.net/npm/simple-jscalendar@1.4.4/source/jsCalendar.lang.es.js"); script.setAttribute("integrity", "sha384-HnSecKq1jgs1/eJQQpOiIb4Wtq7hlMC6nsooaNN+1JPTdzYSbiMP9f8xqKjque1e"); script.setAttribute("crossorigin", "anonymous"); document.head.appendChild(script);
		 * script = document.createElement("script"); script.setAttribute("src", "https://cdn.jsdelivr.net/npm/simple-jscalendar@1.4.4/source/jsCalendar.lang.fr.js"); script.setAttribute("integrity", "sha384-Ob75mVgpo9t5GyveJWKmg21yW1VCLgGe15lpXGHPbfizJmbuG0JnxdwOg7sbYelv"); script.setAttribute("crossorigin", "anonymous"); document.head.appendChild(script);
		 * script = document.createElement("script"); script.setAttribute("src", "https://cdn.jsdelivr.net/npm/simple-jscalendar@1.4.4/source/jsCalendar.lang.gr.js"); script.setAttribute("integrity", "sha384-PRRiiI0gLDo7hU5jD+aJQxbUSjjXHJeL0CdFAynqIWD9XATAYPQpKQkwrqjM+b8t"); script.setAttribute("crossorigin", "anonymous"); document.head.appendChild(script);
		 * script = document.createElement("script"); script.setAttribute("src", "https://cdn.jsdelivr.net/npm/simple-jscalendar@1.4.4/source/jsCalendar.lang.hu.js"); script.setAttribute("integrity", "sha384-yP2k8rRYSOiAc2PfxQ/WAFjMVRoA8AMxGZhlutbHXDc9vGMeokM2qyF2fLHaGPxo"); script.setAttribute("crossorigin", "anonymous"); document.head.appendChild(script);
		 * script = document.createElement("script"); script.setAttribute("src", "https://cdn.jsdelivr.net/npm/simple-jscalendar@1.4.4/source/jsCalendar.lang.it.js"); script.setAttribute("integrity", "sha384-3PiSuWThRXpAvOjasZXyIrVl5H2x296VPhp9D0NebW9V5rcHzCSx4Dh5WRd+pQVO"); script.setAttribute("crossorigin", "anonymous"); document.head.appendChild(script);
		 * script = document.createElement("script"); script.setAttribute("src", "https://cdn.jsdelivr.net/npm/simple-jscalendar@1.4.4/source/jsCalendar.lang.ja.js"); script.setAttribute("integrity", "sha384-O/JkPTslqFkNst65hIikWD7NVsNBRN2vGvprEt9n9tXPKFwocawTwKvwAnPOOZRc"); script.setAttribute("crossorigin", "anonymous"); document.head.appendChild(script);
		 * script = document.createElement("script"); script.setAttribute("src", "https://cdn.jsdelivr.net/npm/simple-jscalendar@1.4.4/source/jsCalendar.lang.nl.js"); script.setAttribute("integrity", "sha384-pitfgw0cn6lUL67KU0jVykK7GIZnS0xqH4nBIIgGo6rSSADgyHdWfoDvoR78juHd"); script.setAttribute("crossorigin", "anonymous"); document.head.appendChild(script);
		 * script = document.createElement("script"); script.setAttribute("src", "https://cdn.jsdelivr.net/npm/simple-jscalendar@1.4.4/source/jsCalendar.lang.no.js"); script.setAttribute("integrity", "sha384-exBlQuh0Apw5DoBAJVxPYJRKYrQjOScXHmQHX9ZA/jZb92Ec6NQjOddl/GexPkCS"); script.setAttribute("crossorigin", "anonymous"); document.head.appendChild(script);
		 * script = document.createElement("script"); script.setAttribute("src", "https://cdn.jsdelivr.net/npm/simple-jscalendar@1.4.4/source/jsCalendar.lang.pt.js"); script.setAttribute("integrity", "sha384-NF3X/E9s0p9PqeJxs+kx2xFHOAfiuNlGpIiwzLBET1Y0pejnfmOm5DJhn6ioTpCr"); script.setAttribute("crossorigin", "anonymous"); document.head.appendChild(script);
		 * script = document.createElement("script"); script.setAttribute("src", "https://cdn.jsdelivr.net/npm/simple-jscalendar@1.4.4/source/jsCalendar.lang.ru.js"); script.setAttribute("integrity", "sha384-xVQY3RcL7F/s9lcv9KNRyquT4kypFWf4OsQPGvpOcB70qhCvQ5P5KdhSygsc6GQg"); script.setAttribute("crossorigin", "anonymous"); document.head.appendChild(script);
		 * script = document.createElement("script"); script.setAttribute("src", "https://cdn.jsdelivr.net/npm/simple-jscalendar@1.4.4/source/jsCalendar.lang.sk.js"); script.setAttribute("integrity", "sha384-fusvqbkUQKgP3X7NX3lUxQEc5yG0V1vbZx8q246R4Bsl/Mzichrn3n8rOWOvJpSB"); script.setAttribute("crossorigin", "anonymous"); document.head.appendChild(script);
		 * script = document.createElement("script"); script.setAttribute("src", "https://cdn.jsdelivr.net/npm/simple-jscalendar@1.4.4/source/jsCalendar.lang.sv.js"); script.setAttribute("integrity", "sha384-fisTE5VLKPsxo5RbFtTLJ1T0j6y8a3SlylIzHZaXSErsJNIy3P82uGhomnRoPc4m"); script.setAttribute("crossorigin", "anonymous"); document.head.appendChild(script);
		 * script = document.createElement("script"); script.setAttribute("src", "https://cdn.jsdelivr.net/npm/simple-jscalendar@1.4.4/source/jsCalendar.lang.tr.js"); script.setAttribute("integrity", "sha384-9u6ZxP0FkigNhAYvsyxqA97/kjtLLv3cdS5isu5KP/vjQlguqdG76uS4UOEoNk7y"); script.setAttribute("crossorigin", "anonymous"); document.head.appendChild(script);
		 * script = document.createElement("script"); script.setAttribute("src", "https://cdn.jsdelivr.net/npm/simple-jscalendar@1.4.4/source/jsCalendar.lang.uk.js"); script.setAttribute("integrity", "sha384-tVzYxj0/QLUOY8QNd3YSzik+Zi4ShGbZTMd72rTA3xTtQMyrFquKRPsp1nsZdMJl"); script.setAttribute("crossorigin", "anonymous"); document.head.appendChild(script);
		 * script = document.createElement("script"); script.setAttribute("src", "https://cdn.jsdelivr.net/npm/simple-jscalendar@1.4.4/source/jsCalendar.lang.zh.js"); script.setAttribute("integrity", "sha384-V0QPacMFDmO6dM4PsEqgwCew+6CzJCk0LaaL/cRM1+LQZjoh5GH64OHX+RNLuORd"); script.setAttribute("crossorigin", "anonymous"); document.head.appendChild(script);
		 * 
		 *
		 * //------------ Optional Themes -------------
		 * link = document.createElement("link");
         * link.setAttribute("rel", "stylesheet"); link.setAttribute("type", "text/css"); link.setAttribute("href", "jscalendar/themes/jsCalendar.clean.css");
         * document.head.appendChild(link);
		 * 
         * link = document.createElement("link");
         * link.setAttribute("rel", "stylesheet"); link.setAttribute("type", "text/css"); link.setAttribute("href", "jscalendar/themes/jsCalendar.darkseries.css");
         * document.head.appendChild(link);
         * 
		 * link = document.createElement("link");
         * link.setAttribute("rel", "stylesheet"); link.setAttribute("type", "text/css"); link.setAttribute("href", "jscalendar/themes/jsCalendar.micro.css");
         * document.head.appendChild(link);
         * 
		 * link = document.createElement("link");
         * link.setAttribute("rel", "stylesheet"); link.setAttribute("type", "text/css"); link.setAttribute("href", "jscalendar/themes/jsCalendar.medium.css");
         * document.head.appendChild(link);
		 * 
		 *
		 * //------------ Optional Extensions -------------
		 * script = document.createElement("script");
		 * script.setAttribute("src", "jscalendar/extensions/jsCalendar.datepicker.js"); document.head.appendChild(script);
		 * link = document.createElement("link");
         * 
		 * link = document.createElement("link");
         * link.setAttribute("rel", "stylesheet"); link.setAttribute("type", "text/css"); link.setAttribute("href", "jscalendar/themes/jsCalendar.eventmarks.css");
         * document.head.appendChild(link);
		 * 
		 * script = document.createElement("script");
		 * script.setAttribute("src", "jscalendar/extensions/jsCalendar.eventmarks.js");
		 * document.head.appendChild(script);
         * 
		 * </inject_script>
		*/
        public function jsCalendar(target:HTMLElement, date:Object=null, options:Object=null){
            //
            // Set a Minimum date for the calendar.
            // Limit to only current month: .min = "now"; .max = "now"
            // @param   target                      Container
            //
            // @param   date    Date Object | Timestamp Number | String                         The date for the calendar
            //                  Date Object                     Using the javascript date	    new Date()
            //                  Timestamp Number                Using a timestamp               new Date(2017, 0, 30).getTime() | 1485727200000
            //                  String                          Date string                     "30/01/2017" | "30-01-2017" | "now"
            //
            // @param   options Object                          The options for the calendar
            //                  "target"                        HTML element
            //                  "date"	                        Date | Number | String          Set the calendar's date.
            //                  "navigator"	                    true | false                    Enable/Disable month's navigation buttons.
            //                  "navigatorPosition"	            "both" | "left" | "right"       Set the month's navigation position
            //                  "zeroFill"	                    true | false                    Enable/Disable date's number zero fill.
            //                  "monthFormat"	                String                          Custom month string format
            //                  "dayFormat"	                    String                          Custom day of the week string format
            //                  "firstDayOfTheWeek" | "fdotw"	String | Number                 Select the first day of the week
            //                                                  String
            //                                                      Day's full name (based on the language)     "Monday"
            //                                                      Day's number 1-7 starting from Sunday       "2"
            //                                                  Number
            //                                                      Day's number 1-7 starting from Sunday       2
            //                                                  String | Number
            //                  "language"	                    String
            //                                                      Belarusian	be | Catalan	ca | Chinese	zh | Dutch	nl | English	en | French	fr
            //                                                      German	de | Greek	gr | Hungarian	hu | Italian	it | Japanese	ja | Norwegian	no
            //                                                      Portuguese	pt | Russian	ru | Slovak	sk | Swedish	sv | Spanish	es | Turkish	tr
            //                                                      Ukrainian	uk
            //                  "min"	                        false | Date
            //                  "max"	                        false | Date
            //
		}
        /**
         * Set the calendar date.
         */
		public function setLanguage(languageCode:String):void{
		}
        /**
         * Set a Minimum date for the calendar.
         * Limit to only current month: .min = "now"; .max = "now"
         */
		public function min(falseDateNow:Object):void{
		}
        /**
         * Set a Maximum date for the calendar.
         */
		public function max(falseDateNow:Object):void{
		}
        /**
         * Move to the next month.
         * n    Go to month + n
         *      Nan, go to next month
         */
        public function next(n:Number = NaN):void{
        }
        /**
         * Move to the previous month.
         * n    Go to month - n
         *      Nan, go to previous month
         */
        public function previous(n:Number = NaN):void{
        }
        /**
         * Go to a specific date.
         * Error compilation: "'goto' is not allowed here"
         */
        /*public function goto(date:Date):void{
        }*/
        /**
         * Set the calendar date.
         */
        public function set(date:Date):void{
        }
        /**
         * Refreshes the calendar, updating the HTML of the calendar (mainly for developers).
         * If a date is provided, the calendar will refresh to that date (exactly like the goto method).
         * (Refresh layout)
         */
        public function refresh(date:Date = null):void{
        }
        /**
         * Reset the calendar date.
         */
		public function reset():void{
		}
        /**
         * Select days on the calendar.
         */
		public function select(arr:Array=null):void{
		}
        /**
         * Unselect days on the calendar.
         */
		public function unselect(arr:Array=null):void{
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
		public function getSelected(options:Object=null):Array{
            return null;
		}
        /**
         * Check if selected.
         */
		public function isSelected(date:Date):Boolean{
            return null;
		}
        /**
         * Check if visible.
         */
		public function isVisible(date:Date):Boolean{
            return null;
		}
        /**
         * Check if in month.
         */
		public function isInMonth(date:Date):Boolean{
            return null;
		}


        // Add a event listeners
        /**
         * Add a click event on the calendar.
         * On month change	.onMonthChange(function(event, date){ ... })
         * On day click	    .onDateClick(function(event, date){ ... })
         */
        public function onDateClick(callback:Function):void
        {
        }
        public function onMonthChange(callback:Function):void
        {
        }
        public function onDayRender(callback:Function):void
        {
        }
        public function onDateRender(callback:Function):void
        {
        }
        public function onMonthRender(callback:Function):void
        {
        }

	}
}