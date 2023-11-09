package org.apache.royale.externsjs.virtualselect.supportClass
{
    
    /**
     * @typedef {object} virtualSelectOptions

    * @typedef {object} virtualSelectOption
    * @property {(string|number)} value - Value of the option
    * @property {(string|number)} label - Display text of the option
    * @property {(string|number)} [description] - Text to show along with label
    * @property {(string|string[])} [alias] - Alternative labels to use on search. Array of string or
    * comma separated string.
    * @property {any} [customData] - Any custom data to store with the options and it would be available
    * with getSelectedOptions() result.
    * @property {virtualSelectOption[]} [options] - List of options for option group
    */

	COMPILE::JS
    public class virtualSelectOptionsSimple
    {
        
        public function virtualSelectOptionsSimple(){}
        //## Properties
        //vers.1.0.29
        /**
         * @property {(HTMLElement|string)} ele - Parent element to render VirtualSelect
         * 
         * DOM element to initialize plugin<br/>String - #sample-select <br/>Element - document.querySelector('#sample-select')
         */
        public var ele:HTMLElement;
        /**
         * @property {string} [dropboxWrapper=self] - Parent element to render dropbox. (self, body, or any css selectror)
         * 
         * Original Default value 'self'. Use this when container of dropdown has overflow scroll or hiddden value.
         */
        public var dropboxWrapper:String ='body';
        /**
         * Array of object to show as options
         * List of options <br/>[<br/>  { label: 'Option 1', value: '1' }, <br/>  { label: 'Option 2', value: '2' }<br/>  ...<br/>]
         * virtualSelectOption[]
         */
        public var options:Array = [];
            //public var options[].label:String;  //by default
            //public var options[].value:String;  //by default
            //public var options[].alias:Array;  //Alternative labels to use on search.<br/>Array of string or comma separated string.
            //public var options[].options:Array = [];  //List of options for option group
            //public var options[].description:String;  //Text to show along with label
        /**
         * @property {string} [valueKey=value] - Object key to use to get value from options array
         */
        public var valueKey:String = 'value';
        /**
         * @property {string} [labelKey=label] - Object key to use to get label from options array
         */
        public var labelKey:String = 'label';
        /**
         * @property {string} [aliasKey=alias] - Key name to get alias from options object
         */
        public var aliasKey:String = 'alias';
        /**
         * @property {string} [descriptionKey=description] - Object key to use to get description from options array
         */
        public var descriptionKey:String = 'description';
        /**
         * @property {boolean} [multiple=false] - Enable multiselect
         */
        public var multiple:Boolean = false;
        /**
         * Enable search feature
         * @property {boolean} false - for single select | true - for multi-select
         */
        public var search:Boolean = false;
        /**
         * Include group title for searching
         */
        public var searchGroup:Boolean = false;
        /**
         * @property {boolean} [disabled=false] - Disable dropdown
         */
        public var disabled:Boolean = false;
        /**
         * @property {boolean} [required=false] - Enable required validation.
         * It would be triggered automatically on form submit and value change.
         * To trigger it manually use validate() method
         */
        public var required:Boolean = false;
        /**
         * @property {boolean} [autofocus=false] - Autofocus dropdown on load
         */
        public var autofocus:Boolean = false;
        /**
         * @property {boolean} [hideClearButton=false] - Hide clear button
         */
        public var hideClearButton:Boolean = false;
        /**
         * @property {boolean} [autoSelectFirstOption=false] - Select first option by default on load
         */
        public var autoSelectFirstOption:Boolean = false;
        /**
         * @property {boolean} [hasOptionDescription=false] - Has description to show along with label
         */
        public var hasOptionDescription:Boolean = false;
        /**
         * @property {boolean} [disableSelectAll=false] - Disable select all feature of multiple select
         */
        public var disableSelectAll:Boolean = false;
        /**
         * @property {Number} [optionsCount=5|4] - No.of options to show on viewport. 4 - When hasOptionDescription is true
         */
        public var optionsCount:Number = 5;
        /**
         * @property {string} [optionHeight='40px|50px'] - Height of each dropdown options.50px - When hasOptionDescription is true
         */
        public var optionHeight:String='35px';
        /**
         * @property {string} [position='bottom left'] - Position of dropbox 
         * (auto, top, bottom, top left, top right, bottom left, bottom right)
         */
        public var position:String = 'auto';
        /**
         * @property {string} [textDirection=ltr] - Direction of text (ltr or rtl)
         */
        public var textDirection:String = 'ltr';
        /**
         * @property {(string[]|number[])} [disabledOptions] - Options to disable (array of values) <br/>e.g - [2, 3, 9]
         */
        public var disabledOptions:Array = [];
        /**
         * @property {(string|string[]|number[])} [selectedValue] - Single value or array of values to select on init
         */
        public var selectedValue:Object = [];
        /**
         * @property {boolean} [silentInitialValueSet=false] - To avoid "change event" trigger on setting initial value
         */
        public var silentInitialValueSet:Boolean = false;
        /**
         * @property {string} [dropboxWidth] - Custom width for dropbox 
         */
        public var dropboxWidth:String;
        /**
         * @property {number} [zIndex=1] - CSS z-index value for dropbox
         */
        public var zIndex:Number = 1;
        /**
         * @property {number} [noOfDisplayValues=50] - Maximum no.of values to show in the tooltip for multi-select
         */
        public var noOfDisplayValues:Number = 50;
        /**
         * @property {boolean} [allowNewOption=false] - Allow to add new option by searching
         */
        public var allowNewOption:Boolean = false;
        /**
         * @property {boolean} [markSearchResults=false] - Mark matched term in label
         */
        public var markSearchResults:Boolean = true;
        /**
         * @property {string} [tooltipFontSize='14px'] - Font size for tooltip
         */
        public var tooltipFontSize:String = '14px';
        /**
         * @property {string} [tooltipAlignment=center] - CSS Text alignment for tooltip
         */
        public var tooltipAlignment:String = 'center';
        /**
         * @property {string} [tooltipMaxWidth='300px'] - CSS max width for tooltip
         */
        public var tooltipMaxWidth:String = '300px';
        /**
         * @property {boolean} [showSelectedOptionsFirst=false] - Show selected options at the top of the dropbox
         */
        public var showSelectedOptionsFirst:Boolean = false;
        /**
         * @property {string} [name] - Name attribute for hidden input
         * It would be useful for form submit to server
         */
        public var name:String;
        /**
         * @property {boolean} [keepAlwaysOpen] - Keep dropbox always open with fixed height
         */
        public var keepAlwaysOpen:Boolean = false;
        /**
         * @property {number} [maxValues=0] - Maximum no.of options allowed to choose in multiple select
         * 0 - for no limit
         */
        public var maxValues:Number = 0;
        /**
         * @property {string} [additionalClasses] - Additional classes for wrapper element
         */
        public var additionalClasses:String ="vscomp-royale";
        /**
         * @property {boolean} [showDropboxAsPopup=true] - Show dropbox as popup on small screen like mobile
         */
        public var showDropboxAsPopup:Boolean = true;
        /**
         * @property {string} [popupDropboxBreakpoint='576px'] - Maximum screen width that allowed to show dropbox as popup
         */
        public var popupDropboxBreakpoint:String = '576px';
        /**
         * @property {string} [popupPosition=center] - Position of the popup (left, center, or right)
         */
        public var popupPosition:String = 'center';
        /**
         * @property {function} [onServerSearch] - Callback function to integrate server search
         *          
         * function onSampleSelectServerSearch(searchValue, virtualSelect) {
         *      // project developer has to define anyMehodToGetDataFromServer function to make API call
         *      anyMehodToGetDataFromServer(searchValue).then(function(newOptions) 
         *      {
         *          virtualSelect.setServerOptions(newOptions); 
         *      }
         *  );
         * }
         */
        public var onServerSearch:Function;
        /**
         * @property {function} [labelRenderer] - Callback function to render label, which could be used to add image, icon, or custom content
         * 
         * function sampleLabelRenderer(data) {
         *      let prefix = '';
         *      
         *      // skipping options those are added newly by allowNewOption feature
         *      if (!data.isCurrentNew && !data.isNew) {
         *          // project developer has to add their own logic to create image/icon tag
         *          let flagIndex = data.value % flagClasses.length;
         *          prefix = `<i class="flag flag-${flagClasses[flagIndex]}"></i>`;
         *      } else {
         *          // common image/icon could be added for new options
         *      }
         * 
         *      return `${prefix}${data.label}`;
         */
        public var labelRenderer:Function;
        /**
         * @property {string} [ariaLabelledby] - ID of the label element to use as a11y attribute aria-labelledby
         */
        public var ariaLabelledby:String;
        /**
         * @property {boolean} [hideValueTooltipOnSelectAll=true] - Hide value tooltip if all options selected
         */
        public var hideValueTooltipOnSelectAll:Boolean = true;
        /**
         * @property {boolean} [showOptionsOnlyOnSearch=false] - Show options to select only if search value is not empty
         */
        public var showOptionsOnlyOnSearch:Boolean = false;
        /**
         * @property {boolean} [selectAllOnlyVisible=false] - Select only visible options on clicking select all checkbox when options filtered by search
         */
        public var selectAllOnlyVisible:Boolean = false;
        /**
         * @property {boolean} [alwaysShowSelectedOptionsCount=false] - By default, no.of options selected text would be shown when there is no enough 
         * space to show all selected values. Set true to override this.
         */
        public var alwaysShowSelectedOptionsCount:Boolean = false;
        /**
         * @property {boolean} [disableAllOptionsSelectedText=false] - By default, when all values selected "All (10)"value text would be shown. 
         * Set true to show value text as "10 options selected".
         */
        public var disableAllOptionsSelectedText:Boolean = false;
        /**
         * @property {boolean} [showValueAsTags=false] - Show each selected values as tags with remove icon
         */ 
        public var showValueAsTags:Boolean = false;
        /**
         * @property {boolean} [disableOptionGroupCheckbox=false] - Disable option group title checkbox
         */
        public var disableOptionGroupCheckbox:Boolean = false;
        /**
         * @property {boolean} [enableSecureText=false] - Set true to replace HTML tags from option's text (value and label) to prevent XSS attack.
         * This feature is not enabled by default to avoid performance issue.
         */
        public var enableSecureText:Boolean = false;
        /**
         * @property {boolean} [setValueAsArray=false] - Set value for hidden input in array format (e.g. '["1", "2"]')
         */
        public var setValueAsArray:Boolean = false;
        /**
         * @property {string} [emptyValue=''] - Empty value to use for hidden input when no value is selected 
         * (e.g. 'null' or '[]' or 'none')
         */
        public var emptyValue:String='';
        /**
         * @property {boolean} [disableValidation=false] - Disable required validation
         */
        public var disableValidation:Boolean = false;
        /**
         * @property {boolean} [useGroupValue=false] - Group's value would be returned when all of its child options selected
         */
        public var useGroupValue:Boolean = false;
        /**
         * @property {string} [maxWidth='250px'] - Maximum width for the select element
         */
        public var maxWidth:String=null;
        
        //## Text Properties. Update below properties to change display texts.
        /**
         * @property {string} [placeholder=Select] - Text to show when no options selected
         */
        public var placeholder:String = 'Select';
        /**
         * @property {string} [noOptionsText='No options found'] - Text to show when no options to show
         */
        public var noOptionsText:String = 'No options found';
        /**
         * @property {string} [noSearchResultsText='No results found'] - Text to show when no results on search
         */
        public var noSearchResultsText:String = 'No results found';
        /**
         * @property {string} [selectAllText='Select all'] - Text to show near select all checkbox when search is disabled
         */
        public var selectAllText:String = 'Select all';
        /**
         * @property {string} [searchPlaceholderText='Search...'] - Text to show as placeholder for search input
         */
        public var searchPlaceholderText:String = 'Search...';
        /**
         * @property {string} [optionsSelectedText='options selected'] - Text to use when displaying no.of values selected text
         * (i.e. 3 options selected)
         */
        public var optionsSelectedText:String = 'options selected';
        /**
         * @property {string} [optionSelectedText='option selected'] - Text to use when displaying no.of values selected text
         * and only one value is selected (i.e. 1 option selected)
         */
        public var optionSelectedText:String;
        /**
         * @property {string} [allOptionsSelectedText=All] - Text to use when displaying all values selected text
         * (i.e. All (10))
         */
        public var allOptionsSelectedText:String = 'All';
        /**
         * @property {string} [clearButtonText=Clear] - Tooltip text for clear button
         */
        public var clearButtonText:String = 'Clear';
        /**
         * @property {string} [moreText='more...'] - Text to show when more than noOfDisplayValues options selected
         * (i.e + 10 more...)
         */
        public var moreText:String = 'more...';
        /**
         * 1.0.30
         * Search options by startsWith() method
         * Default false
         */
        public var searchByStartsWith:Boolean = false;
        /**
         * 1.0.31
         * Throttle time for updating dropbox position on scroll event (in milliseconds)
         * Default 100
         */
        public var updatePositionThrottle:Number = 100;
        /**
         * 1.0.36
         * By default, no.of options selected text would be shown when there is no enough 
         * space to show all selected values. Set true to show labels even though there is no enough space.
         * 
         * Default false
         */
        public var alwaysShowSelectedOptionsLabel:Boolean = false;
        /**
         * 1.0.37
         * Scroll selected option to viewport on dropbox open.
         * 
         * Default true
         */
        public var focusSelectedOptionOnOpen:Boolean = true;
        /**
         * 1.0.38
         * Allow searching by label ignoring diacritics
         * 
         * Default false
         */
        public var searchNormalize:Boolean = false;
        /**
         * 1.0.38
         * Option used to enhance accessibility when using the search functionality on the dropdowns
         * 
         * Default 'Search'
         */
        public var searchFormLabel:String = 'Search';
        /**
         * 1.0.38
         * Option used to enhance accessibility when using the search functionality on the dropdowns
         * 
         * Default 'Options list'
         */
        public var ariaLabelText:String = 'Options list';
        /**
         * 1.0.39.1
         * Hide SelectDisplay OnkeepAlwaysOpen
         * 
         * Default true
         */
        public var hideSelectDisplayOnKeepAlwaysOpen:Boolean = true;
    }
}