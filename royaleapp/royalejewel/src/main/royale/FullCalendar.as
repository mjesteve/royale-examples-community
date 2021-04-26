package 
{
	/**
	 * @externs
	 */
    COMPILE::JS
    public class FullCalendar
    {

        /**
         * <inject_script>
         * var link = document.createElement("link");
             * link.setAttribute("rel", "stylesheet");
             * link.setAttribute("type", "text/css");
             * link.setAttribute("href", "fullcalendar/main.js");
             * document.head.appendChild(link);
         * var script = document.createElement("script");
         * script.setAttribute("src", "fullcalendar/main.js");
         * document.head.appendChild(script);
         * </inject_script>
        */
        public function FullCalendar()
        {
        }
        
		public static function Calendar(el:Element,optionOverrides:Object=null):Object { return null; }

    }
}
