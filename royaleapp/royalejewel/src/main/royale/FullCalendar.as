package
{
	/**
	 * @externs
	 */
    COMPILE::JS
    public class FullCalendar
    {
        //public static var calendar:Calendar;
        /**
         * <inject_script>
         * var link = document.createElement("link");
             * link.setAttribute("rel", "stylesheet");
             * link.setAttribute("type", "text/css");
             * link.setAttribute("href", "fullcalendar/main.css");
             * document.head.appendChild(link);
         * var script = document.createElement("script");
         * script.setAttribute("src", "fullcalendar/main.js");
         * document.head.appendChild(script);
         *
         * var script = document.createElement("script");
         * script.setAttribute("src", "fullcalendar/fullcalendar.js");
         * document.head.appendChild(script);
         * </inject_script>
        */
        public function FullCalendar(){}

		public static function Calendar(el:Element,optionOverrides:Object=null):Class { return null; }

    }
}
