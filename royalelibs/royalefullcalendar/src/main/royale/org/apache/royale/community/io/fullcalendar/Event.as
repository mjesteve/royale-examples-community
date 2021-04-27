package org.apache.royale.community.io.fullcalendar
{
	/**
     * @externs
     */
    public class Event
    {
        /** Wrapper for org.apache.royale.community.io.fullcalendar.Event JavaScript class
         * TODO: handle changes to an event that's already in the calendar..
         */
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
        public function Event()
        {
        }
        
        private var _title : String;
        public function get title() : String { return _title; }
        public function set title(value : String) : void { _title = value; }
        
        private var _start : String;
        public function get start() : String { return _start; }
        public function set start(value : String) : void { _start = value; }
        
        private var _end : String;
        public function get end() : String { return _end; }
        public function set end(value : String) : void { _end = value; }
        
        private var _groupId : int;
        public function get groupId() : int { return _groupId; }
        public function set groupId(value : int) : void { _groupId = value; }
        
        private var _url : String;
        public function get url() : String { return _url; }
        public function set url(value : String) : void { _url = value; }
        
        public function get object() : Object
        {
            var obj : Object = new Object();
            if (_title)   obj.title   = _title;
            if (_start)   obj.start   = _start;
            if (_end)     obj.end     = _end;
            if (_groupId) obj.groupId = _groupId;
            if (_url)     obj.url     = _url;
            return obj;
        }
    }
}
