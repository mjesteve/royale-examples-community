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
		 * var script_jscalendar = document.createElement("script");
		 * script_jscalendar.setAttribute("src", "jscalendar/jscalendarloader.js");
		 * document.head.appendChild(script_jscalendar);
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