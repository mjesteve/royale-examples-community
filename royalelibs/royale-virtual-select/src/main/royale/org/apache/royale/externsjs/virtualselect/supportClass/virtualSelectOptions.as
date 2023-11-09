package org.apache.royale.externsjs.virtualselect.supportClass
{
    
    import org.apache.royale.utils.ObjectUtil;

    /**
     * @typedef {object} virtualSelectOptionsClass

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

    public class virtualSelectOptions
    {
        // la variable que se pasará a virtual-select es "optsInit": Objeto "sólo con las propiedades QUE CAMBIEN DE VALOR"
        [Transient]
        public var optsInit:Object;
        public function virtualSelectOptions(){
            super();
            optsInit = new Object();
        }
        //## Properties
        //vers.1.0.29
        /**
         * @property {(HTMLElement|string)} ele - Parent element to render VirtualSelect
         * 
         * DOM element to initialize plugin<br/>String - #sample-select <br/>Element - document.querySelector('#sample-select')
         */
        private var _ele:HTMLElement;
        public function get ele():HTMLElement{ return _ele; }
        public function set ele(value:HTMLElement):void{ _ele = value; optsInit['ele']=value;}
        /**
         * @property {string} [dropboxWrapper=self] - Parent element to render dropbox. (self, body, or any css selectror)
         * 
         * Original Default value 'self'. Use this when container of dropdown has overflow scroll or hiddden value.
         */
        private var _dropboxWrapper:String ='body';
        public function get dropboxWrapper():String{ return _dropboxWrapper; }
        public function set dropboxWrapper(value:String):void{ _dropboxWrapper = value;  optsInit['dropboxWrapper']=value;}
        /**
         * Array of object to show as options
         * List of options <br/>[<br/>  { label: 'Option 1', value: '1' }, <br/>  { label: 'Option 2', value: '2' }<br/>  ...<br/>]
         * virtualSelectOption[]
         */
        private var _options:Array = [];
        public function get options():Array{ return _options; }
        public function set options(value:Array):void{ _options = value;  optsInit['options']=value;}
            //public var options[].label:String;  //by default
            //public var options[].value:String;  //by default
            //public var options[].alias:Array;  //Alternative labels to use on search.<br/>Array of string or comma separated string.
            //public var options[].options:Array = [];  //List of options for option group
            //public var options[].description:String;  //Text to show along with label
        /**
         * @property {string} [valueKey=value] - Object key to use to get value from options array
         */
        private var _valueKey:String = 'value';
        public function get valueKey():String{ return _valueKey; }
        public function set valueKey(value:String):void{ _valueKey = value;  optsInit['valueKey']=value;}
        /**
         * @property {string} [labelKey=label] - Object key to use to get label from options array
         */
        private var _labelKey:String = 'label';
        public function get labelKey():String{ return _labelKey; }
        public function set labelKey(value:String):void{ _labelKey = value;  optsInit['labelKey']=value;}
        /**
         * @property {string} [aliasKey=alias] - Key name to get alias from options object
         */
        private var _aliasKey:String = 'alias';
        public function get aliasKey():String{ return _aliasKey; }
        public function set aliasKey(value:String):void{ _aliasKey = value;  optsInit['aliasKey']=value;}
        /**
         * @property {string} [descriptionKey=description] - Object key to use to get description from options array
         */
        private var _descriptionKey:String = 'description';
        public function get descriptionKey():String{ return _descriptionKey; }
        public function set descriptionKey(value:String):void{ _descriptionKey = value;  optsInit['descriptionKey']=value;}
        /**
         * @property {boolean} [multiple=false] - Enable multiselect
         */
        private var _multiple:Boolean = false;
        public function get multiple():Boolean{ return _multiple; }
        public function set multiple(value:Boolean):void{ _multiple = value;  optsInit['multiple']=value;}
        /**
         * Enable search feature
         * @property {boolean} false - for single select | true - for multi-select
         */
        private var _search:Boolean = false;
        public function get search():Boolean{ return _search; }
        public function set search(value:Boolean):void{ _search = value;  optsInit['search']=value;}
        /**
         * Include group title for searching
         */
        private var _searchGroup:Boolean = false;
        public function get searchGroup():Boolean{ return _searchGroup; }
        public function set searchGroup(value:Boolean):void{ _searchGroup = value;  optsInit['searchGroup']=value;}
        /**
         * @property {boolean} [disabled=false] - Disable dropdown
         */
        private var _disabled:Boolean = false;
        public function get disabled():Boolean{ return _disabled; }
        public function set disabled(value:Boolean):void{ _disabled = value;  optsInit['disabled']=value;}
        /**
         * @property {boolean} [required=false] - Enable required validation.
         * It would be triggered automatically on form submit and value change.
         * To trigger it manually use validate() method
         */
        private var _required:Boolean = false;
        public function get required():Boolean{ return _required; }
        public function set required(value:Boolean):void{ _required = value;  optsInit['required']=value;}
        /**
         * @property {boolean} [autofocus=false] - Autofocus dropdown on load
         */
        private var _autofocus:Boolean = false;
        public function get autofocus():Boolean{ return _autofocus; }
        public function set autofocus(value:Boolean):void{ _autofocus = value;  optsInit['autofocus']=value;}
        /**
         * @property {boolean} [hideClearButton=false] - Hide clear button
         */
        private var _hideClearButton:Boolean = false;
        public function get hideClearButton():Boolean{ return _hideClearButton; }
        public function set hideClearButton(value:Boolean):void{ _hideClearButton = value;  optsInit['hideClearButton']=value;}
        /**
         * @property {boolean} [autoSelectFirstOption=false] - Select first option by default on load
         */
        private var _autoSelectFirstOption:Boolean = false;
        public function get autoSelectFirstOption():Boolean{ return _autoSelectFirstOption; }
        public function set autoSelectFirstOption(value:Boolean):void{ _autoSelectFirstOption = value;  optsInit['autoSelectFirstOption']=value;}
        /**
         * @property {boolean} [hasOptionDescription=false] - Has description to show along with label
         */
        private var _hasOptionDescription:Boolean = false;
        public function get hasOptionDescription():Boolean{ return _hasOptionDescription; }
        public function set hasOptionDescription(value:Boolean):void{ _hasOptionDescription = value;  optsInit['hasOptionDescription']=value;}
        /**
         * @property {boolean} [disableSelectAll=false] - Disable select all feature of multiple select
         */
        private var _disableSelectAll:Boolean = false;
        public function get disableSelectAll():Boolean{ return _disableSelectAll; }
        public function set disableSelectAll(value:Boolean):void{ _disableSelectAll = value;  optsInit['disableSelectAll']=value;}
        /**
         * @property {Number} [optionsCount=5|4] - No.of options to show on viewport. 4 - When hasOptionDescription is true
         */
        private var _optionsCount:Number = 5;
        public function get optionsCount():Number{ return _optionsCount; }
        public function set optionsCount(value:Number):void{ _optionsCount = value;  optsInit['optionsCount']=value;}
        /**
         * @property {string} [optionHeight='40px|50px'] - Height of each dropdown options.50px - When hasOptionDescription is true
         */
        private var _optionHeight:String='35px';
        public function get optionHeight():String{ return _optionHeight; }
        public function set optionHeight(value:String):void{ _optionHeight = value;  optsInit['optionHeight']=value;}
        /**
         * @property {string} [position='bottom left'] - Position of dropbox 
         * (auto, top, bottom, top left, top right, bottom left, bottom right)
         */
        private var _position:String = 'auto';
        public function get position():String{ return _position; }
        public function set position(value:String):void{ _position = value;  optsInit['position']=value;}
        /**
         * @property {string} [textDirection=ltr] - Direction of text (ltr or rtl)
         */
        private var _textDirection:String = 'ltr';
        public function get textDirection():String{ return _textDirection; }
        public function set textDirection(value:String):void{ _textDirection = value;  optsInit['textDirection']=value;}
        /**
         * @property {(string[]|number[])} [disabledOptions] - Options to disable (array of values) <br/>e.g - [2, 3, 9]
         */
        private var _disabledOptions:Array = [];
        public function get disabledOptions():Array{ return _disabledOptions; }
        public function set disabledOptions(value:Array):void{ _disabledOptions = value;  optsInit['disabledOptions']=value;}
        /**
         * @property {(string|string[]|number[])} [selectedValue] - Single value or array of values to select on init
         */
        private var _selectedValue:Object = [];
        public function get selectedValue():Object{ return _selectedValue }
        public function set selectedValue(value:Object):void{ _selectedValue = value;  optsInit['selectedValue']=value;}
        /**
         * @property {boolean} [silentInitialValueSet=false] - To avoid "change event" trigger on setting initial value
         */
        private var _silentInitialValueSet:Boolean = false;
        public function get silentInitialValueSet():Boolean{ return _silentInitialValueSet; }
        public function set silentInitialValueSet(value:Boolean):void{ _silentInitialValueSet = value;  optsInit['silentInitialValueSet']=value;}
        /**
         * @property {string} [dropboxWidth] - Custom width for dropbox 
         */
        private var _dropboxWidth:String;
        public function get dropboxWidth():String{ return _dropboxWidth; }
        public function set dropboxWidth(value:String):void{ _dropboxWidth = value;  optsInit['dropboxWidth']=value;}
        /**
         * @property {number} [zIndex=1] - CSS z-index value for dropbox
         */
        private var _zIndex:Number = 1;
        public function get zIndex():Number{ return _zIndex; }
        public function set zIndex(value:Number):void{ _zIndex = value;  optsInit['zIndex']=value;}
        /**
         * @property {number} [noOfDisplayValues=50] - Maximum no.of values to show in the tooltip for multi-select
         */
        private var _noOfDisplayValues:Number = 50;
        public function get noOfDisplayValues():Number{ return _noOfDisplayValues; }
        public function set noOfDisplayValues(value:Number):void{ _noOfDisplayValues = value;  optsInit['noOfDisplayValues']=value;}
        /**
         * @property {boolean} [allowNewOption=false] - Allow to add new option by searching
         */
        private var _allowNewOption:Boolean = false;
        public function get allowNewOption():Boolean{ return _allowNewOption; }
        public function set allowNewOption(value:Boolean):void{ _allowNewOption = value;  optsInit['allowNewOption']=value;}
        /**
         * @property {boolean} [markSearchResults=false] - Mark matched term in label
         */
        private var _markSearchResults:Boolean = true;
        public function get markSearchResults():Boolean{ return _markSearchResults; }
        public function set markSearchResults(value:Boolean):void{ _markSearchResults = value;  optsInit['markSearchResults']=value;}
        /**
         * @property {string} [tooltipFontSize='14px'] - Font size for tooltip
         */
        private var _tooltipFontSize:String = '14px';
        public function get tooltipFontSize():String{ return _tooltipFontSize; }
        public function set tooltipFontSize(value:String):void{ _tooltipFontSize = value;  optsInit['tooltipFontSize']=value;}
        /**
         * @property {string} [tooltipAlignment=center] - CSS Text alignment for tooltip
         */
        private var _tooltipAlignment:String = 'center';
        public function get tooltipAlignment():String{ return _tooltipAlignment; }
        public function set tooltipAlignment(value:String):void{ _tooltipAlignment = value;  optsInit['tooltipAlignment']=value;}
        /**
         * @property {string} [tooltipMaxWidth='300px'] - CSS max width for tooltip
         */
        private var _tooltipMaxWidth:String = '300px';
        public function get tooltipMaxWidth():String{ return _tooltipMaxWidth; }
        public function set tooltipMaxWidth(value:String):void{ _tooltipMaxWidth = value;  optsInit['tooltipMaxWidth']=value;}
        /**
         * @property {boolean} [showSelectedOptionsFirst=false] - Show selected options at the top of the dropbox
         */
        private var _showSelectedOptionsFirst:Boolean = false;
        public function get showSelectedOptionsFirst():Boolean{ return _showSelectedOptionsFirst; }
        public function set showSelectedOptionsFirst(value:Boolean):void{ _showSelectedOptionsFirst = value;  optsInit['showSelectedOptionsFirst']=value;}
        /**
         * @property {string} [name] - Name attribute for hidden input
         * It would be useful for form submit to server
         */
        private var _name:String;
        public function get name():String{ return _name; }
        public function set name(value:String):void{ _name = value;  optsInit['name']=value;}
        /**
         * @property {boolean} [keepAlwaysOpen] - Keep dropbox always open with fixed height
         */
        private var _keepAlwaysOpen:Boolean = false;
        public function get keepAlwaysOpen():Boolean{ return _keepAlwaysOpen; }
        public function set keepAlwaysOpen(value:Boolean):void{ _keepAlwaysOpen = value;  optsInit['keepAlwaysOpen']=value;}
        /**
         * @property {number} [maxValues=0] - Maximum no.of options allowed to choose in multiple select
         * 0 - for no limit
         */
        private var _maxValues:Number = 0;
        public function get maxValues():Number{ return _maxValues; }
        public function set maxValues(value:Number):void{ _maxValues = value;  optsInit['maxValues']=value;}
        /**
         * @property {string} [additionalClasses] - Additional classes for wrapper element
         */
        private var _additionalClasses:String ="vscomp-royale";
        public function get additionalClasses():String{ return _additionalClasses; }
        public function set additionalClasses(value:String):void{ _additionalClasses = value;  optsInit['additionalClasses']=value;}
        /**
         * @property {boolean} [showDropboxAsPopup=true] - Show dropbox as popup on small screen like mobile
         */
        private var _showDropboxAsPopup:Boolean = true;
        public function get showDropboxAsPopup():Boolean{ return _showDropboxAsPopup; }
        public function set showDropboxAsPopup(value:Boolean):void{ _showDropboxAsPopup = value;  optsInit['showDropboxAsPopup']=value;}
        /**
         * @property {string} [popupDropboxBreakpoint='576px'] - Maximum screen width that allowed to show dropbox as popup
         */
        private var _popupDropboxBreakpoint:String = '576px';
        public function get popupDropboxBreakpoint():String{ return _popupDropboxBreakpoint; }
        public function set popupDropboxBreakpoint(value:String):void{ _popupDropboxBreakpoint = value;  optsInit['popupDropboxBreakpoint']=value;}
        /**
         * @property {string} [popupPosition=center] - Position of the popup (left, center, or right)
         */
        private var _popupPosition:String = 'center';
        public function get popupPosition():String{ return _popupPosition; }
        public function set popupPosition(value:String):void{ _popupPosition = value;  optsInit['popupPosition']=value;}
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
        private var _onServerSearch:Function;
        public function get onServerSearch():Function{ return _onServerSearch; }
        public function set onServerSearch(value:Function):void{ _onServerSearch = value;  optsInit['onServerSearch']=value;}
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
        private var _labelRenderer:Function;
        public function get labelRenderer():Function{ return _labelRenderer; }
        public function set labelRenderer(value:Function):void{ _labelRenderer = value;  optsInit['labelRenderer']=value;}
        /**
         * @property {string} [ariaLabelledby] - ID of the label element to use as a11y attribute aria-labelledby
         */
        private var _ariaLabelledby:String;
        public function get ariaLabelledby():String{ return _ariaLabelledby; }
        public function set ariaLabelledby(value:String):void{ _ariaLabelledby = value;  optsInit['ariaLabelledby']=value;}
        /**
         * @property {boolean} [hideValueTooltipOnSelectAll=true] - Hide value tooltip if all options selected
         */
        private var _hideValueTooltipOnSelectAll:Boolean = true;
        public function get hideValueTooltipOnSelectAll():Boolean{ return _hideValueTooltipOnSelectAll; }
        public function set hideValueTooltipOnSelectAll(value:Boolean):void{ _hideValueTooltipOnSelectAll = value;  optsInit['hideValueTooltipOnSelectAll']=value;}
        /**
         * @property {boolean} [showOptionsOnlyOnSearch=false] - Show options to select only if search value is not empty
         */
        private var _showOptionsOnlyOnSearch:Boolean = false;
        public function get showOptionsOnlyOnSearch():Boolean{ return _showOptionsOnlyOnSearch; }
        public function set showOptionsOnlyOnSearch(value:Boolean):void{ _showOptionsOnlyOnSearch = value;  optsInit['showOptionsOnlyOnSearch']=value;}
        /**
         * @property {boolean} [selectAllOnlyVisible=false] - Select only visible options on clicking select all checkbox when options filtered by search
         */
        private var _selectAllOnlyVisible:Boolean = false;
        public function get selectAllOnlyVisible():Boolean{ return _selectAllOnlyVisible; }
        public function set selectAllOnlyVisible(value:Boolean):void{ _selectAllOnlyVisible = value;  optsInit['selectAllOnlyVisible']=value;}
        /**
         * @property {boolean} [alwaysShowSelectedOptionsCount=false] - By default, no.of options selected text would be shown when there is no enough 
         * space to show all selected values. Set true to override this.
         */
        private var _alwaysShowSelectedOptionsCount:Boolean = false;
        public function get alwaysShowSelectedOptionsCount():Boolean{ return _alwaysShowSelectedOptionsCount; }
        public function set alwaysShowSelectedOptionsCount(value:Boolean):void{ _alwaysShowSelectedOptionsCount = value;  optsInit['alwaysShowSelectedOptionsCount']=value;}
        /**
         * @property {boolean} [disableAllOptionsSelectedText=false] - By default, when all values selected "All (10)"value text would be shown. 
         * Set true to show value text as "10 options selected".
         */
        private var _disableAllOptionsSelectedText:Boolean = false;
        public function get disableAllOptionsSelectedText():Boolean{ return _disableAllOptionsSelectedText; }
        public function set disableAllOptionsSelectedText(value:Boolean):void{ _disableAllOptionsSelectedText = value;  optsInit['disableAllOptionsSelectedText']=value;}
        /**
         * @property {boolean} [showValueAsTags=false] - Show each selected values as tags with remove icon
         */ 
        private var _showValueAsTags:Boolean = false;
        public function get showValueAsTags():Boolean{ return _showValueAsTags; }
        public function set showValueAsTags(value:Boolean):void{ _showValueAsTags = value;  optsInit['showValueAsTags']=value;}
        /**
         * @property {boolean} [disableOptionGroupCheckbox=false] - Disable option group title checkbox
         */
        private var _disableOptionGroupCheckbox:Boolean = false;
        public function get disableOptionGroupCheckbox():Boolean{ return _disableOptionGroupCheckbox; }
        public function set disableOptionGroupCheckbox(value:Boolean):void{ _disableOptionGroupCheckbox = value;  optsInit['disableOptionGroupCheckbox']=value;}
        /**
         * @property {boolean} [enableSecureText=false] - Set true to replace HTML tags from option's text (value and label) to prevent XSS attack.
         * This feature is not enabled by default to avoid performance issue.
         */
        private var _enableSecureText:Boolean = false;
        public function get enableSecureText():Boolean{ return _enableSecureText; }
        public function set enableSecureText(value:Boolean):void{ _enableSecureText = value;  optsInit['enableSecureText']=value;}
        /**
         * @property {boolean} [setValueAsArray=false] - Set value for hidden input in array format (e.g. '["1", "2"]')
         */
        private var _setValueAsArray:Boolean = false;
        public function get setValueAsArray():Boolean{ return _setValueAsArray; }
        public function set setValueAsArray(value:Boolean):void{ _setValueAsArray = value;  optsInit['setValueAsArray']=value;}
        /**
         * @property {string} [emptyValue=''] - Empty value to use for hidden input when no value is selected 
         * (e.g. 'null' or '[]' or 'none')
         */
        private var _emptyValue:String = '';
        public function get emptyValue():String{ return _emptyValue; }
        public function set emptyValue(value:String):void{ _emptyValue = value;  optsInit['emptyValue']=value;}
        /**
         * @property {boolean} [disableValidation=false] - Disable required validation
         */
        private var _disableValidation:Boolean = false;
        public function get disableValidation():Boolean{ return _disableValidation; }
        public function set disableValidation(value:Boolean):void{ _disableValidation = value;  optsInit['disableValidation']=value;}
        /**
         * @property {boolean} [useGroupValue=false] - Group's value would be returned when all of its child options selected
         */
        private var _useGroupValue:Boolean = false;
        public function get useGroupValue():Boolean{ return _useGroupValue; }
        public function set useGroupValue(value:Boolean):void{ _useGroupValue = value;  optsInit['useGroupValue']=value;}
        /**
         * @property {string} [maxWidth='250px'] - Maximum width for the select element
         */
        private var _maxWidth:String=null;
        public function get maxWidth():String{ return _maxWidth; }
        public function set maxWidth(value:String):void{ _maxWidth = value;  optsInit['maxWidth']=value;}
        
        //## Text Properties. Update below properties to change display texts.
        /**
         * @property {string} [placeholder=Select] - Text to show when no options selected
         */
        private var _placeholder:String = 'Select';
        public function get placeholder():String{ return _placeholder; }
        public function set placeholder(value:String):void{ _placeholder = value;  optsInit['placeholder']=value;}
        /**
         * @property {string} [noOptionsText='No options found'] - Text to show when no options to show
         */
        private var _noOptionsText:String = 'No options found';
        public function get noOptionsText():String{ return _noOptionsText; }
        public function set noOptionsText(value:String):void{ _noOptionsText = value; ObjectUtil.addNonEnumerableProperty(optsInit,'noOptionsText',value);}
        /**
         * @property {string} [noSearchResultsText='No results found'] - Text to show when no results on search
         */
        private var _noSearchResultsText:String = 'No results found';
        public function get noSearchResultsText():String{ return _noSearchResultsText; }
        public function set noSearchResultsText(value:String):void{ _noSearchResultsText = value;  optsInit['noSearchResultsText']=value;}
        /**
         * @property {string} [selectAllText='Select all'] - Text to show near select all checkbox when search is disabled
         */
        private var _selectAllText:String = 'Select all';
        public function get selectAllText():String{ return _selectAllText; }
        public function set selectAllText(value:String):void{ _selectAllText = value;  optsInit['selectAllText']=value;}
        /**
         * @property {string} [searchPlaceholderText='Search...'] - Text to show as placeholder for search input
         */
        private var _searchPlaceholderText:String = 'Search...';
        public function get searchPlaceholderText():String{ return _searchPlaceholderText; }
        public function set searchPlaceholderText(value:String):void{ _searchPlaceholderText = value;  optsInit['searchPlaceholderText']=value;}
        /**
         * @property {string} [optionsSelectedText='options selected'] - Text to use when displaying no.of values selected text
         * (i.e. 3 options selected)
         */
        private var _optionsSelectedText:String = 'options selected';
        public function get optionsSelectedText():String{ return _optionsSelectedText; }
        public function set optionsSelectedText(value:String):void{ _optionsSelectedText = value;  optsInit['optionsSelectedText']=value;}
        /**
         * @property {string} [optionSelectedText='option selected'] - Text to use when displaying no.of values selected text
         * and only one value is selected (i.e. 1 option selected)
         */
        private var _optionSelectedText:String;
        public function get optionSelectedText():String{ return _optionSelectedText; }
        public function set optionSelectedText(value:String):void{ _optionSelectedText = value;  optsInit['optionSelectedText']=value;}
        /**
         * @property {string} [allOptionsSelectedText=All] - Text to use when displaying all values selected text
         * (i.e. All (10))
         */
        private var _allOptionsSelectedText:String = 'All';
        public function get allOptionsSelectedText():String{ return _allOptionsSelectedText; }
        public function set allOptionsSelectedText(value:String):void{ _allOptionsSelectedText = value;  optsInit['allOptionsSelectedText']=value;}
        /**
         * @property {string} [clearButtonText=Clear] - Tooltip text for clear button
         */
        private var _clearButtonText:String = 'Clear';
        public function get clearButtonText():String{ return _clearButtonText; }
        public function set clearButtonText(value:String):void{ _clearButtonText = value;  optsInit['clearButtonText']=value;}
        /**
         * @property {string} [moreText='more...'] - Text to show when more than noOfDisplayValues options selected
         * (i.e + 10 more...)
         */
        private var _moreText:String = 'more...';
        public function get moreText():String{ return _moreText; }
        public function set moreText(value:String):void{ _moreText = value;  optsInit['moreText']=value;}
        /**
         * 1.0.30
         * Search options by startsWith() method
         * Default false
         */
        private var _searchByStartsWith:Boolean = false;
        public function get searchByStartsWith():Boolean{ return _searchByStartsWith; }
        public function set searchByStartsWith(value:Boolean):void{ _searchByStartsWith = value;  optsInit['searchByStartsWith']=value;}
        /**
         * 1.0.31
         * Throttle time for updating dropbox position on scroll event (in milliseconds)
         * Default 100
         */
        private var _updatePositionThrottle:Number = 100;
        public function get updatePositionThrottle():Number{ return _updatePositionThrottle; }
        public function set updatePositionThrottle(value:Number):void{ _updatePositionThrottle = value;  optsInit['updatePositionThrottle']=value;}
        /**
         * 1.0.36
         * By default, no.of options selected text would be shown when there is no enough 
         * space to show all selected values. Set true to show labels even though there is no enough space.
         * 
         * Default false
         */
        private var _alwaysShowSelectedOptionsLabel:Boolean = false;
        public function get alwaysShowSelectedOptionsLabel():Boolean{ return _alwaysShowSelectedOptionsLabel; }
        public function set alwaysShowSelectedOptionsLabel(value:Boolean):void{ _alwaysShowSelectedOptionsLabel = value;  optsInit['alwaysShowSelectedOptionsLabel']=value;}
        /**
         * 1.0.37
         * Scroll selected option to viewport on dropbox open.
         * 
         * Default true
         */
        private var _focusSelectedOptionOnOpen:Boolean = true;
        public function get focusSelectedOptionOnOpen():Boolean{ return _focusSelectedOptionOnOpen; }
        public function set focusSelectedOptionOnOpen(value:Boolean):void{ _focusSelectedOptionOnOpen = value;  optsInit['focusSelectedOptionOnOpen']=value;}
        /**
         * 1.0.38
         * Allow searching by label ignoring diacritics
         * 
         * Default false
         */
        private var _searchNormalize:Boolean = false;
        public function get searchNormalize():Boolean{ return _searchNormalize; }
        public function set searchNormalize(value:Boolean):void{ _searchNormalize = value;  optsInit['searchNormalize']=value;}
        /**
         * 1.0.38
         * Option used to enhance accessibility when using the search functionality on the dropdowns
         * 
         * Default 'Search'
         */
        private var _searchFormLabel:String = 'Search';
        public function get searchFormLabel():String{ return _searchFormLabel; }
        public function set searchFormLabel(value:String):void{ _searchFormLabel = value;  optsInit['searchFormLabel']=value;}
        /**
         * 1.0.38
         * Option used to enhance accessibility when using the search functionality on the dropdowns
         * 
         * Default 'Options list'
         */
        private var _ariaLabelText:String = 'Options list';
        public function get ariaLabelText():String{ return _ariaLabelText; }
        public function set ariaLabelText(value:String):void{ _ariaLabelText = value;  optsInit['ariaLabelText']=value;}
        /**
         * 1.0.39.1
         * Hide SelectDisplay OnkeepAlwaysOpen
         * 
         * Default true
         */
        private var _hideSelectDisplayOnkeepAlwaysOpen:Boolean = true;
        public function get hideSelectDisplayOnKeepAlwaysOpen():Boolean{ return _hideSelectDisplayOnkeepAlwaysOpen; }
        public function set hideSelectDisplayOnKeepAlwaysOpen(value:Boolean):void{ _hideSelectDisplayOnkeepAlwaysOpen = value;  optsInit['hideSelectDisplayOnKeepAlwaysOpen']=value;}
    }
}