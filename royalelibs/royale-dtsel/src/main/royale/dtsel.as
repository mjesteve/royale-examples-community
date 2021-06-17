package
{

	/**
	 * @externs
	 */
	COMPILE::JS
	public class dtsel{

		/**
		 * <inject_script>
         *          
		 * var link = document.createElement("link");
         * link.setAttribute("rel", "stylesheet");
         * link.setAttribute("type", "text/css");
         * link.setAttribute("href", "js/dtsel.css");
         * document.head.appendChild(link);
		 * 
		 * var script = document.createElement("script");
		 * script.setAttribute("src", "js/dtsel.js");
		 * document.head.appendChild(script);
		 * </inject_script>
		*/
        public function dtsel(target:HTMLElement, opt:Object=null){
            
		}
        public function DTS(elem, config):void { } 
		
		public function DTBox(elem, settings):void { } 
		public function getterSetter(key, default_val):void { } 
		public function addHandler(key, handlerFn):void { }
		public function setPosition(e):void { }
		public function handler(e):void { }
		public function makeGrid(rows, cols, className, firstRowClass, clickHandler):void { }

		public function makeRow(label, name, range, changeHandler):void { }
		public function getOffset(elem):void { } 
		public function empty(e):void { } 
		public function tryAppendChild(newChild, refNode):void { }
		public function hookFuncs():void { }

		public function sortByStringIndex(arr, string):void { }

		public function filterFormatKeys(keys, format):void { }
		public function parseData(value, format, formatObj, setHooks) :void { }
		public function parseDate(value, settings):void { }
		public function parseTime(value, settings):void { }
		public function renderDate(value, settings):void { }
		public function renderTime(value, settings) :void { }
		public function isEqualDate(date1, date2):void { } 
		public function padded(val, pad, default_val):void { } 
		public function setDefaults(obj, objDefaults):void { }
		
		
	}
}