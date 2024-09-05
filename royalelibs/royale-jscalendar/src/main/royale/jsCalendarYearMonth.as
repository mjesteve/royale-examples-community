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
		 * var link_jscalendar = document.createElement("link");
         * link_jscalendar.setAttribute("rel", "stylesheet");
         * link_jscalendar.setAttribute("type", "text/css");
         * link_jscalendar.setAttribute("href", "jscalendar/source/jsCalendarYearMonth.css");
         * document.head.appendChild(link_jscalendar);
		 * 
		 * var script_jscalendar = document.createElement("script");
		 * script_jscalendar.setAttribute("src", "jscalendar/source/jsCalendarYearMonth.js");
		 * document.head.appendChild(script_jscalendar);
         * 
		 * </inject_script>
		*/
        public function jsCalendarYearMonth(target:HTMLElement, options:Object=null){
            //
            // Set a Minimum date for the calendar.
            // Limit to only current month: .min = "now"; .max = "now"
            // @param   target                      Container
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
	}
}