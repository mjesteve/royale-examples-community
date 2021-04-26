package io.fullcalendar
{
    public class daygrid
    {
        /** Wrapper for io.fullcalendar.daygrid JavaScript class
         * <inject_html>
         *	<link href='fullcalendar/daygrid/main.css' rel='stylesheet' />
         *	<script src='fullcalendar/daygrid/main.js'></script>
         * </inject_html>
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
