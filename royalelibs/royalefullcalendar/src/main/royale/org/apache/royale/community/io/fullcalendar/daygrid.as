package org.apache.royale.community.io.fullcalendar
{
	/**
	 * @externs
	 */
    COMPILE::JS
    public class daygrid
    {
        /**
         * <inject_script>
         * // Wrapper for org.apache.royale.community.io.fullcalendar.daygrid JavaScript class
         * var link = document.createElement("link");
             * link.setAttribute("rel", "stylesheet");
             * link.setAttribute("type", "text/css");
             * link.setAttribute("href", "fullcalendar/daygrid/main.js");
             * document.head.appendChild(link);
         * var script = document.createElement("script");
         * script.setAttribute("src", "fullcalendar/daygrid/main.js");
         * document.head.appendChild(script);
         * </inject_script>
        */
        public function daygrid()
        {
        }
        
        public function get name() : String
        {
            return "dayGrid";
        }

        public function get options() : Object
        {
            return { showNonCurrentDates : _showNonCurrentDates };
        }
        
        private var _showNonCurrentDates : Boolean = true;
        public function get showNonCurrentDates() : Boolean { return _showNonCurrentDates; }
        public function set showNonCurrentDates(value : Boolean) : void { _showNonCurrentDates = value; }
        
    }
}
