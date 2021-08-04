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
		 * var link = document.createElement("link");
         * link.setAttribute("rel", "stylesheet");
         * link.setAttribute("type", "text/css");
         * link.setAttribute("href", "virtual-select/virtual-select.min.css");
         * document.head.appendChild(link);
		 * 
		 * var script = document.createElement("script");
		 * script.setAttribute("src", "virtual-select/virtual-select.min.js");
		 * document.head.appendChild(script);
		 * 
         * //link = document.createElement("link");
         * //link.setAttribute("rel", "stylesheet");
         * //link.setAttribute("type", "text/css");
         * //link.setAttribute("href", "virtual-select/tootip.min.css");
         * //document.head.appendChild(link);
         * 
         * //script = document.createElement("script");
		 * //script.setAttribute("src", "virtual-select/tooltip.min.js");
		 * //document.head.appendChild(script);
         * 
		 * </inject_script>
		*/
        public function VirtualSelect(){}
       
  /**
   * Create a VirtualSelect
   * @property {(element|string)} ele - Parent element to render VirtualSelect
   * @property {object[]} options - Array of object to show as options
		* @property {(string|number)} options[].value - Value of the option
		* @property {(string|number)} options[].label - Display text of the option
		* @property {(string|number)} options[].description - Text to show along with label
		* @property {(string|array)} options[].alias - Alternative labels to use on search. Array of string or comma separated string.
   		* @property {array} options[].options - List of options for option group
   * @property {string} [valueKey=value] - Object key to use to get value from options array
   * @property {string} [labelKey=label] - Object key to use to get label from options array
   * @property {string} [descriptionKey=description] - Object key to use to get description from options array
   * @property {string} [aliasKey=alias] - Key name to get alias from options object
   * @property {boolean} [multiple=false] - Enable multiselect
   * @property {boolean} [search=false] - Enable search
   * @property {boolean} [hideClearButton=false] - Hide clear button
   * @property {boolean} [autoSelectFirstOption=false] - Select first option by default on load
   * @property {boolean} [hasOptionDescription=false] - Has description to show along with label
   * @property {boolean} [disableSelectAll=false] - Disable select all feature of multiple select
   * @property {string} [optionsCount=5|4] - No.of options to show on viewport
   * @property {string} [optionHeight=40px|50px] - Height of each dropdown options
   * @property {string} [position=auto] - Position of dropbox (top, bottom, auto)
   * @property {string} [placeholder=Select] - Text to show when no options selected
   * @property {string} [noOptionsText=No options found] - Text to show when no options to show
   * @property {string} [noSearchResultsText=No results found] - Text to show when no results on search
   * @property {string} [selectAllText=Select all] - Text to show near select all checkbox when search is disabled
   * @property {string} [searchPlaceholderText=Search...] - Text to show as placeholder for search input
   * @property {string} [optionsSelectedText=options selected] - Text to use when displaying no.of values selected text (i.e. 3 options selected)
   * @property {string} [clearButtonText=Clear] - Tooltip text for clear button
   * @property {array} [disabledOptions] - Options to disable (array of values)
   * @property {(string|array)} [selectedValue] - Single value or array of values to select on init
   * @property {boolean} [silentInitialValueSet=false] - To avoid "change event" trigger on setting initial value
   * @property {string} [dropboxWidth] - Custom width for dropbox
   * @property {number} [zIndex=1] - CSS z-index value for dropbox
   * @property {number} [noOfDisplayValues=50] - Maximum no.of values to show in the tooltip for multi-select
   * @property {boolean} [allowNewOption=false] - Allow to add new option by searching
   * @property {boolean} [markSearchResults=false] - Mark matched term in label
   * @property {string} [tooltipFontSize=14px] - Font size for tooltip
   * @property {string} [tooltipAlignment=center] - CSS Text alignment for tooltip
   * @property {string} [tooltipMaxWidth=300px] - CSS max width for tooltip
   * @property {boolean} [showSelectedOptionsFirst=false] - Show selected options at the top of the dropbox
   * @property {string} [name] - Name attribute for hidden input
   * @property {boolean} [keepAlwaysOpen] - Keep dropbox always open with fixed height
   * @property {number} [maxValues=0] - Maximum no.of options allowed to choose in multiple select
   * @property {string} [additionalClasses] - Additional classes for wrapper element
   * @property {boolean} [showDropboxAsPopup=true] - Show dropbox as popup on small screen like mobile
   * @property {string} [popupDropboxBreakpoint=576px] - Maximum screen width that allowed to show dropbox as popup
   * @property {function} [onServerSearch] - Callback function to integrate server search
   * @property {function} [labelRenderer] - Callback function to render label, which could be used to add image, icon, or custom content
   * @property {boolean} [hideValueTooltipOnSelectAll=true] - Hide value tooltip if all options selected
   * @property {boolean} [showOptionsOnlyOnSearch=false] - Show options to select only if search value is not empty
   * @property {boolean} [selectAllOnlyVisible=false] - Select only visible options on clicking select all checkbox when options filtered by search
   */
		public static function init(options:Object):VirtualSelect { return null; }

        public function value():Object{ return null;}
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
         * Update the dataprovider.
         * 
         * There is a problem in the component and it does not recreate the dropdown items,
         * instead, we can use setSeverOptions which does.
         */
        public function setOptions(options:Array):void{}
        public var sortedOptions:Array;
        /**
         * Update Options
         * @param options 
         */
        public function setServerOptions(options:Array):void{}
	}
}