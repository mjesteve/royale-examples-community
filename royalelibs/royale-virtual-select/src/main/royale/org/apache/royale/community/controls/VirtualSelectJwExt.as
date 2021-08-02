package org.apache.royale.community.controls
{
    COMPILE::JS{
        import org.apache.royale.core.WrappedHTMLElement;
        import org.apache.royale.html.util.addElementToWrapper;
    }
    import org.apache.royale.core.UIBase;
    import org.apache.royale.utils.sendEvent;
    import org.apache.royale.events.Event;
    import org.apache.royale.community.virtualselect.OptionsInit;
    import org.apache.royale.core.StyledUIBase;
	
    /**
     *  Indicates that the creation is complete.  
     */
	[Event(name="creationComplete", type="org.apache.royale.events.Event")]
    /**
     *  Indicates that the initialization of the Instance is complete.  
     */
	[Event(name="onCompleteInicialize", type="org.apache.royale.events.Event")]
	
    /**
     *  Indicates that the configuration of the Instance is complete.  
     */
	[Event(name="onCompleteConfig", type="org.apache.royale.events.Event")]
    /**
     *  indicates that the update of the configuration of the Instance is complete
     */
	[Event(name="onUpdateConfig", type="org.apache.royale.events.Event")]

	public class VirtualSelectJwExt extends StyledUIBase
    {

		/**
		 * @royaleignorecoercion org.apache.royale.core.WrappedHTMLElement
		 * @royaleignorecoercion org.apache.royale.html.util.addElementToWrapper
         */
        COMPILE::JS
        override protected function createElement():WrappedHTMLElement
        {
			addElementToWrapper(this, 'div');
            return element;
        }

        /**
         *  Constructor.
         */
        public function VirtualSelectJwExt()
		{
			super();			
			typeNames = "";

            _configOption = new OptionsInit
            _configOption.ele = element;
            //_configOption.zIndex = 100;
		}
        
		override public function addedToParent():void
		{
			super.addedToParent();
            dispatchEvent(new Event("creationComplete"));
		}
		/**
		 * Dispatches a "layoutNeeded" event
		 */
		public function layoutNeeded():void
		{
			sendEvent(this,"layoutNeeded");
		}

        private var _isConfigure:Boolean;
        [Bindable("onCompleteConfig")]
        public function get isConfigure():Boolean{ 
            return _isConfigure; 
        }
        public function set isConfigure(value:Boolean):void{
            _isConfigure = value; 
        }

        //POR AHORA ES PÚBLICO POR SI QUEREMOS ASIGNAR LA CONFIGURACIÓN EN BRUTO
        private var _configOption:OptionsInit;
        [Bindable("configOptionChange")]
        public function get configOption():OptionsInit{ 
            return _configOption; 
        }
        public function set configOption(value:OptionsInit):void
        { 
            if(_configOption != value)
            {
                _configOption = value;                
            }

        }

        protected var _instance:VirtualSelect;
        public function get instance():VirtualSelect{ return _instance; }
        public function set instance(value:VirtualSelect):void
        {
            if( _instance === value)
                return;
           
            _instance = value;
            dispatchEvent(new Event("onCompleteInicialize"));
        }
    
        private var _initiationInProcess:Boolean = false;
		/**
         * TEMPORAL, LO QUITARÉ
		 * Creates an visual-select instance.
		 * @param make Configuration item and data after init.
		 */
		public function init(make:Boolean = false):void
		{
            if(_initiationInProcess)
                return;
            
            _initiationInProcess = true;

            if(!instance)
                instance = VirtualSelect.init(_configOption as Object);
            
            _initiationInProcess = false;
		}

        [Bindable("dataChange")]
        public function get dataProvider():Array
        { 
            if(_instance)
                return _instance.sortedOptions();
            else
                return _configOption.options; 
        }
        public function set dataProvider(value:Array):void
        { 
            _configOption.options = value ? value : new Array;
            if(_instance){
                _instance.setOptions(value);
            }
        }

        //Object key to use to get value from options array
        public function get valueKey():String{ return _configOption.valueKey; }
        public function set valueKey(value:String):void{ _configOption.valueKey = value; }
         //Object key to use to get label from options array
        public function get labelKey():String{ return _configOption.labelKey; }
        public function set labelKey(value:String):void{ _configOption.labelKey = value; }
         //Object key to use to get label from options array//Object key to use to get alias from options array
        public function get aliasKey():String{ return _configOption.aliasKey; }
        public function set aliasKey(value:String):void{ _configOption.aliasKey = value; }
         //Object key to use to get description from options array
        public function get descriptionKey():String{ return _configOption.descriptionKey; }
        public function set descriptionKey(value:String):void{ _configOption.descriptionKey = value; }

        /**
         * List of values to disable options <br/>e.g - [2, 3, 9]
         */
        [Bindable]
        public function get disabledOptions():Array{ return _configOption.disabledOptions; }
        public function set disabledOptions(value:Array):void{ _configOption.disabledOptions = value; }        
        /**
         * Enable multi-select
         */
        public function get multiple():Boolean{ return _configOption.multiple; }
        public function set multiple(value:Boolean):void{ _configOption.multiple = value; }       
        /**
         * Enable search feature (false - for single select <br/>true - for multi-select)
         */
        public function get search():Boolean{ return _configOption.search; }
        public function set search(value:Boolean):void{ _configOption.search = value; }    
        /**
         * Mark matched term in label
         */
        public function get markSearchResults():Boolean{ return _configOption.markSearchResults; }
        public function set markSearchResults(value:Boolean):void{ _configOption.markSearchResults = value; }

        public var hideClearButton:Boolean = false;  //Hide clear value button
        public var autoSelectFirstOption:Boolean = false;  //Select first option by default on load
        public var hasOptionDescription:Boolean = false;  //Has description to show along with label
        public var disableSelectAll:Boolean = false;  //Disable select all feature of multiple select
        public var optionsCount:Number = 5;  //4 | 5, No. of options to show on viewport <br/>4 - When hasOptionDescription is true
        public var optionHeight:String = '40px|50px';  //40px | 50px. Height of each dropdown options <br/>50px - When hasOptionDescription is true
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
	}
}