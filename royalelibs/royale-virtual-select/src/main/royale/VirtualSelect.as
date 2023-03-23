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
         * link_virtualselect = document.createElement("link");
         * link_virtualselect.setAttribute("rel", "stylesheet");
         * link_virtualselect.setAttribute("type", "text/css");
         * link_virtualselect.setAttribute("href", "virtual-select/tooltip.min.css");
         * document.head.appendChild(link_virtualselect);
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
        public function setValue(value:Object):void{}
        
        public function reset():void{}
        /**
         * Update the dataprovider.
         * 
         * There is a problem in the component and it does not recreate the dropdown items,
         * instead, we can use setSeverOptions which does.
         * 
         * @param options Array
         */
        public function setOptions(options:Array):void{}
        /**
         * 
         * @param disabledOptions Array - list of disabled option's values (or true to disable all options)
         * @param keepValue Boolean - set true to keep selected value
         */
        public function setDisabledOptions(disabledOptions:Array, keepValue:Boolean=false):void{}
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
        public function addOption(optionDetails:Array):void{}
        /**
         * Get selected value which is added as "new option" (allowNewOption: true)
         * @return 
         */
        public function getNewValue():Object{ return null;}
        /**
         * Get selected option's display value (i.e label)
         * @return 
         */
        public function getDisplayValue():Object{ return null;}
        /**
         * Get selected option's details. 
         * It would contains isNew: true property for options added newly by allowNewOption
         * @return 
         */
        public function getSelectedOptions():Object{ return null;}
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
         * To trigger required validation programmatically 
         */
        public function validate():void{}
        /**
         * To trigger required validation programmatically 
         */
        public function toggleRequired(isRequired:Boolean):void{}

	}
}