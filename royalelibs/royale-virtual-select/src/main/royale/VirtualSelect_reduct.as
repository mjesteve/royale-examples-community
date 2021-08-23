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
		 * var script_virtualselect = document.createElement("script");
		 * script_virtualselect.setAttribute("src", "./virtual-select/virtualselectloader.js");
		 * document.head.appendChild(script_virtualselect);
         * 
		 * </inject_script>
		*/
        public function VirtualSelect(){}
       
        /**
        * Creates, initialises and returns a new instance of VirtualSelect
        */
		public static function init(options:Object):VirtualSelect { return null; }

        /**
         * Get selected value
         */
        public var value:Object;
        /**
         * Select the options
         * String | Array
         * @param value 
         */
        public function setValue(value:Object):void{}
        public function reset(value:Object):void{}
        public function setDisabledOptions(disabledOptions:Array, setOptionsProp:Boolean=false):void{}
        /**
         * Select / Deselect all options
         * @param isSelected 
         */
        public function toggleSelectAll(isSelected:Boolean):void{}
        /**
         * To check that if all options selected or not
         */
        public function isAllSelected():void{}
        /**
         * To add a new option with existing options
         * @param data 
         */
        public function addOption(data:Array):void{}
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
         * To destroy the virtual select instance from the element
         */
        public function destroy():void{}
        /**
         * Update the dataprovider.
         * 
         * There is a problem in the component and it does not recreate the dropdown items,
         * instead, we can use setSeverOptions which does.
         */
        public function setOptions(options:Array):void{}
        /**
         * Update Options
         * @param options 
         */
        public function setServerOptions(options:Array):void{}

        public var sortedOptions:Array;
        //public var initialSelectedValue:Object;
	}
}