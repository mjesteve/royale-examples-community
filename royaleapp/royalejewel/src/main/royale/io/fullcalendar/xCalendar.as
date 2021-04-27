package io.fullcalendar
{
    import org.apache.royale.core.UIBase;
	  import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.html.util.addElementToWrapper;
    
    [DefaultProperty("plugins")]

    public class xCalendar extends UIBase
    {
        private var _calendar : Object;
        
        private var _plugins : Array;
        public function set plugins(value : Array) : void { _plugins = value; }
        
        private var _events : Array;
        public function set events(value : Array) : void { _events = value; }
        public function get events() : Array { return _events; }
        
        private var _defaultView : String;
        public function set defaultView(value : String) : void { _defaultView = value; }
        public function get defaultView() : String { return _defaultView; }
        
        private var _defaultDate : Object;
        public function set defaultDate(value : Object) : void { _defaultDate = value; }
        public function get defaultDate() : Object { return _defaultDate; }
        
        private var _header : Object;
        public function set header(value : Object) : void { _header = value; }
        public function get header() : Object { return _header; }
        
        private var _editable : Boolean = true;
        public function set editable(value : Boolean) : void { _editable = value; }
        public function get editable() : Boolean { return _editable; }
        
        private var _eventLimit : Boolean = true;
        public function set eventLimit(value : Boolean) : void { _eventLimit = value; }
        public function get eventLimit() : Boolean { return _eventLimit; }
        
        public function xCalendar(el:Element)
        {
            super();
            
            this.addEventListener('beadsAdded', onInit);
        }

        public function next() : void
        {
            _calendar.next();
        }
        
        /**
		 * @private
		 */
        private function onInit(e:Event):void
		{
            var options : Object = new Object();
            var viewOptions : Object = new Object();
            var i : uint;
            
            if (_plugins)
            {
                var pluginStrings : Array = options["plugins"] = new Array();
                for (i = 0; i < _plugins.length; i++)
                {
                    pluginStrings.push(_plugins[i].name);
                    if ( _plugins[i].options )
                    {
                        viewOptions[_plugins[i].name] = _plugins[i].options;
                    }
                }
            }
            if (_events)
            {
                var eventList : Array = options["events"] = new Array();
                for (i = 0; i < _events.length; i++)
                {
                    eventList.push(_events[i].object);
                }
            }
            
            if (_defaultView) options["defaultView"] = _defaultView;
            if (_defaultDate) options["defaultDate"] = _defaultDate;
            if (_header)      options["header"]      = _header;
            options["editable"] = _editable;
            options["eventLimit"] = _eventLimit; // allow "more" link when too many events
            options["views"] = viewOptions;
            /*
            options["events"] = 
            [
                {
                  title: 'All Day Event',
                  start: '2019-04-01'
                },
                {
                  title: 'Long Event',
                  start: '2019-04-07',
                  end: '2019-04-10'
                },
                {
                  groupId: 999,
                  title: 'Repeating Event',
                  start: '2019-04-09T16:00:00'
                },
                {
                  groupId: 999,
                  title: 'Repeating Event',
                  start: '2019-04-16T16:00:00'
                },
                {
                  title: 'Conference',
                  start: '2019-04-11',
                  end: '2019-04-13'
                },
                {
                  title: 'Meeting',
                  start: '2019-04-12T10:30:00',
                  end: '2019-04-12T12:30:00'
                },
                {
                  title: 'Lunch',
                  start: '2019-04-12T12:00:00'
                },
                {
                  title: 'Meeting',
                  start: '2019-04-12T14:30:00'
                },
                {
                  title: 'Happy Hour',
                  start: '2019-04-12T17:30:00'
                },
                {
                  title: 'Dinner',
                  start: '2019-04-12T20:00:00'
                },
                {
                  title: 'Birthday Party',
                  start: '2019-04-13T07:00:00'
                },
                {
                  title: 'Click for Google',
                  url: 'http://google.com/',
                  start: '2019-04-28'
                }
            ];*/

            //_calendar = new window["FullCalendar"].Calendar(positioner, options);
            //_calendar = FullCalendar.Calendar(positioner, options);
            //_calendar.render();
        }
        
    }
}
