package Andrew.io.fullcalendar
{
	/**
	 * @externs
	 */
    COMPILE::JS
    public class interaction
    {
        /**
         * <inject_script>
         * // Wrapper for io.fullcalendar.interaction JavaScript class
         * var link = document.createElement("link");
             * link.setAttribute("rel", "stylesheet");
             * link.setAttribute("type", "text/css");
             * link.setAttribute("href", "fullcalendar/interaction/main.js");
             * document.head.appendChild(link);
         * var script = document.createElement("script");
         * script.setAttribute("src", "fullcalendar/interaction/main.js");
         * document.head.appendChild(script);
         * </inject_script>
        */
        public function interaction()
        {
        }
        
        public function get name() : String
        {
            return "interaction";
        }
        
    }
}
