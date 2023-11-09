package
{
	/**
	 * @externs
	 */
	COMPILE::JS
	public class VirtualSelect{

		/**
		 * <inject_script>
         *
		 * var link_virtualselect = document.createElement("link");
         * link_virtualselect.setAttribute("rel", "stylesheet");
         * link_virtualselect.setAttribute("type", "text/css");
         * link_virtualselect.setAttribute("href", "./virtual-select/virtual-select.css");
         * document.head.appendChild(link_virtualselect);
		 *
		 * var script_virtualselect = document.createElement("script");
		 * script_virtualselect.setAttribute("src", "./virtual-select/virtual-select.js");
		 * document.head.appendChild(script_virtualselect);
         *
		 * // No incluimos tootip.min.css porque esta incluido en virtual-select.css
         * // We do not include tooltip.min.css because it is included in virtual-select.css
         *
         * script_virtualselect = document.createElement("script");
		 * script_virtualselect.setAttribute("src", "virtual-select/tooltip.min.js");
		 * document.head.appendChild(script_virtualselect);
         *
		 * </inject_script>
		*/
        public function VirtualSelect(){}

        /**
        * Creates, initialises and returns a new instance of VirtualSelect
        */
		public static function init(options:Object):VirtualSelect { return null; }

        public var options:Array;
        public var sortedOptions:Array;
        //public var initialSelectedValue:Object;
        public var selectedValues:Array;
        public var $ele:Object;
        /**
         * Get selected value
         */
        public var value:Object;
        /**
         * Select the options (single value or array of values)
         * @param value String | Array
         * [@param noEventTrigger - set true to avoid event trigger]
         */
        public function setValueMethod(value:Object, silentChange:Boolean):void{}

        public function reset():void{}
        /**
         * Update the dataprovider.
         *
         * There is a problem in the component and it does not recreate the dropdown items,
         * instead, we can use setSeverOptions which does.
         *
         * @param options Array
         */
        public function setOptionsMethod(options:Array, keepValue:Boolean=true):void{}
        //public function setOptions(options:Array):void{}
        /**
         *
         * @param disabledOptions Array - list of disabled option's values (or true to disable all options)
         * @param keepValue Boolean - set true to keep selected value
         */
        public function setDisabledOptionsMethod(disabledOptions:Array, keepValue:Boolean=false):void{}
        //public function setDisabledOptions(disabledOptions:Array, keepValue:Boolean=false):void{}
        /**
         * Select / Deselect all options
         * @param isAllSelected Boolean
         */
        public function toggleSelectAll(isAllSelected:Boolean):void{}
        /**
         * To check that if all options selected or not
         */
        public function isAllSelected():void{}
        /**
         * To add a new option with existing options
         * @param optionDetails
         */
        public function addOptionMethod(optionDetails:Array):void{}
        //public function addOption(optionDetails:Array):void{}
        /**
         * Get selected value which is added as "new option" (allowNewOption: true)
         * @return
         */
        public function getNewValueMethod():Object{ return null;}
        //public function getNewValue():Object{ return null;}
        /**
         * Get selected option's display value (i.e label)
         * @return
         */
        //public function getDisplayValueMethod():Object{ return null;}
        public function getDisplayValue():Object{ return null;}
        /**
         * Get selected option's details.
         * It would contains isNew: true property for options added newly by allowNewOption
         * @param args  Object {fullDetails:Boolean = false, keepSelectionOrder:Boolean = false}
         * @return
         */
        public function getSelectedOptions(args:Object):Array{ return null;}
        /**
         * To open dropbox programmatically
         */
        public function open():void{}
        /**
         * To close dropbox programmatically
         */
        public function close():void{}
        /**
         * To focus dropdown element programmatically
         */
        public function focus():void{}
        /**
         * o enable dropdown element programmatically
         */
        public function enable():void{}
        /**
         * To disable dropdown element programmatically
         */
        public function disable():void{}
        /**
         * To destroy the virtual select instance from the element
         */
        public function destroy():void{}
        /**
         * (form
         */
        public function validate():void{}
        /**
         * To trigger required validation programmatically
         */
        public function toggleRequiredMethod(isRequired:Boolean):void{}
        //public function toggleRequired(isRequired:Boolean):void{}
        /**
         *
         */
        public function onResizeMethod():void{}

        /**
         * Use this method to set options while loading options from server.
         *
         * function onSampleSelectServerSearch(searchValue, virtualSelect) {
         *  //project developer has to define anyMehodToGetDataFromServer function to make API call
         *  anyMehodToGetDataFromServer(searchValue).then(function(newOptions) {
         *  virtualSelect.setServerOptions(newOptions);
         * });
         * }
         * @param options
         */
        public function setServerOptions(options:Array):void{}
        /**
         * 1.0.32
         * Throttle time for updating dropbox position on scroll event (in milliseconds)
         *
         * @param enabledOptions - list of enabled option's values or true to enable all options
         * @param keepValue - set true to keep selected value
         */
        public function setEnabledOptions(enabledOptions:Object, keepValue:Boolean):void{}
        /**
         * 1.0.36
         * Get disabled option's details.
         * Return Array
         */
        public function getDisabledOptions():Array{ return null; }
	}
}