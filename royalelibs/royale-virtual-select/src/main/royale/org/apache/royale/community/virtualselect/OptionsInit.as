package org.apache.royale.community.virtualselect
{
    public class OptionsInit
    {        
        public var ele:Element;  //DOM element to initialize plugin<br/>String - #sample-select <br/>Element - document.querySelector('#sample-select')
        public var options:Array = [];  //List of options <br/>[<br/>  { label: 'Option 1', value: '1' }, <br/>  { label: 'Option 2', value: '2' }<br/>  ...<br/>]
            //public var options[].label:String;  //by default
            //public var options[].value:String;  //by default
            //public var options[].alias:Array;  //Alternative labels to use on search.<br/>Array of string or comma separated string.
            //public var options[].options:Array = [];  //List of options for option group
            //public var options[].description:String;  //Text to show along with label
        public var valueKey:String = 'value';  //Object key to use to get value from options array
        public var labelKey:String = 'label';  //Object key to use to get label from options array
        public var aliasKey:String = 'alias';  //Object key to use to get alias from options array
        public var descriptionKey:String = 'description';  //Object key to use to get description from options array

        public var disabledOptions:Array = [];  //List of values to disable options <br/>e.g - [2, 3, 9]
        public var multiple:Boolean = false;  //Enable multi-select
        public var search:Boolean = false;  //Enable search feature (false - for single select <br/>true - for multi-select)
        public var hideClearButton:Boolean = false;  //Hide clear value button
        public var autoSelectFirstOption:Boolean = false;  //Select first option by default on load
        public var hasOptionDescription:Boolean = false;  //Has description to show along with label
        public var disableSelectAll:Boolean = false;  //Disable select all feature of multiple select
        public var optionsCount:Number = 5;  //4 | 5, No. of options to show on viewport <br/>4 - When hasOptionDescription is true
        public var optionHeight:String = '40px';  //40px | 50px. Height of each dropdown options <br/>50px - When hasOptionDescription is true
        public var position:String = 'auto';  //Position of dropbox (top, bottom, auto)
        public var placeholder:String = 'Select';  //Text to show when no options selected
        public var noOptionsText:String = 'No options found';  //Text to show when no options to show
        public var noSearchResultsText:String = 'No results found';  //Text to show when no results on search
        public var selectAllText:String = 'Select all';  //Text to show near select all checkbox when search is disabled
        public var searchPlaceholderText:String = 'Search...';  //Text to show as placeholder for search input
        public var optionsSelectedText:String = 'options selected';  //Text to use when displaying no.of values selected text (i.e. 3 options selected)
        public var clearButtonText:String = 'Clear';  //Tooltip text for clear button
        public var selectedValue:Array = [];  //Single value or array of values to select on init
        public var silentInitialValueSet:Boolean = false;  //To avoid change event trigger on setting initial value
        public var dropboxWidth:String;  //Custom width for dropbox
        public var zIndex:Number = 1;  //CSS z-index value for dropbox
        public var noOfDisplayValues:Number = 50;  //Maximum no.of values to show in the tooltip for multi-select
        public var allowNewOption:Boolean = false;  //Allow to add new option by searching
        public var tooltipFontSize:String = '14px';  //Font size for tooltip
        public var tooltipAlignment:String = 'center';  //CSS Text alignment for tooltip
        public var tooltipMaxWidth:String = '300px';  //CSS max width for tooltip
        public var showSelectedOptionsFirst:Boolean = false;  //Show selected options at the top of the dropbox
        public var markSearchResults:Boolean = false;  //Mark matched term in label
        public var name:String;  //Name attribute for hidden input<br>It would be useful for form submit to server
        public var keepAlwaysOpen:Boolean = false;  //Keep dropbox always open with fixed height
        public var maxValues:Number = 0;  //Maximum no.of options allowed to choose in multiple select<br>0 - for no limit
        public var additionalClasses:String;  //Additional classes for wrapper element
        public var showDropboxAsPopup:Boolean = true;  //Show dropbox as popup on small screen like mobile
        public var popupDropboxBreakpoint:String = '576px';  //Maximum screen width that allowed to show dropbox as popup
        public var onServerSearch:Function;  //Callback function to integrate server search
        public var labelRenderer:Function;  //Callback function to render label, which could be used to add image, icon, or custom content
        public var hideValueTooltipOnSelectAll:Boolean = true;  //Hide value tooltip if all options selected
        public var showOptionsOnlyOnSearch:Boolean = false;  //Show options to select only if search value is not empty
        public var selectAllOnlyVisible:Boolean = false;  //Select only visible options on clicking select all checkbox when options filtered by search

        public function OptionsInit():void{}
    }
}