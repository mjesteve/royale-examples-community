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
        function DTS(elem, config):void { } 
		
		function DTBox(elem, settings):void { } 
		function getterSetter(key, default_val):void { } 
		function addHandler(key, handlerFn):void { }
		function setPosition(e):void { }
		function handler(e):void { }
		function makeGrid(rows, cols, className, firstRowClass, clickHandler):void { }

		function makeRow(label, name, range, changeHandler):void { }
		function getOffset(elem):void { } 
		function empty(e):void { } 
		function tryAppendChild(newChild, refNode):void { }
		function hookFuncs():void { }

		function sortByStringIndex(arr, string):void { }

		function filterFormatKeys(keys, format):void { }
		function parseData(value, format, formatObj, setHooks) :void { }
		function parseDate(value, settings):void { }
		function parseTime(value, settings):void { }
		function renderDate(value, settings):void { }
		function renderTime(value, settings) :void { }
		function isEqualDate(date1, date2):void { } 
		function padded(val, pad, default_val):void { } 
		function setDefaults(obj, objDefaults):void { }
		
		
	}
}