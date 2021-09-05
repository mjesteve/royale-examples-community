package org.apache.royale.community.controls
{
    COMPILE::JS{
        import org.apache.royale.core.WrappedHTMLElement;
        import org.apache.royale.html.util.addElementToWrapper;
    }
    import org.apache.royale.events.Event;
    import org.apache.royale.community.virtualselect.OptionsInit;
    import org.apache.royale.core.StyledUIBase;
    import VirtualSelect;
    import org.apache.royale.utils.observeElementSize;
	
    /**
     *  Click in the component
     */
	[Event(name="onButtonClick", type="org.apache.royale.events.Event")]
    /**
     *  Indicates that the creation is complete.  
     */
	[Event(name="onCreationComplete", type="org.apache.royale.events.Event")]
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
    /**
     *  Change event would be trigged on choosing option 
     */
	[Event(name="onChange", type="org.apache.royale.events.Event")]
    /**
     *  This event will be triggered before the dropbox is opened.
     */
	[Event(name="onBeforeOpen", type="org.apache.royale.events.Event")]
    /**
     *  This event will be triggered after the dropbox is opened.
     */
	[Event(name="onAfterOpen", type="org.apache.royale.events.Event")]
    /**
     *  This event would be triggered when clear button is clicked or form is reset.
     */
	[Event(name="onReset", type="org.apache.royale.events.Event")]

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

            //The default values assigned in the variable definitions, of the _configOption class, are not really taken.
            //Any default values that we want to "make effective" we have to set specifically:

            _configOption = new OptionsInit
            _configOption.ele = element;
            _configOption.silentInitialValueSet = true;
            _configOption.markSearchResults = true;
            _configOption.optionHeight = "34px"; // _itemRenderer.sass - ListItemRenderer variables - $item-min-height: 34px
            _configOption.zIndex = 80;
            _configOption.dropboxWrapper = 'body';
            _configOption.showValueAsTags = false;
            _configOption.position = 'bottom';
		}
        
		override public function addedToParent():void
		{
			super.addedToParent();
            dispatchEvent(new Event("onCreationComplete"));
            // When properties are not of simple type (String, Number,...), even if they are set in the mxml tag, 
            // they are set after creation.
            setTimeout(init,125);
		}
        /**
         * Test. Debug all dispatched events
         */
        override public function dispatchEvent(event:Event):Boolean {
            //trace("********** VirtualSelectJwExt: EVENT ", event);
            return super.dispatchEvent(event);
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
        private function get instance():VirtualSelect{ return _instance; }
        private function set instance(value:VirtualSelect):void
        {
            if( _instance === value)
                return;
           
            _instance = value;
            var nlist:NodeList = element.getElementsByClassName('vscomp-toggle-button');
            if(nlist && nlist.length>0)
            {
                var etxt:HTMLDivElement = nlist[0] as HTMLDivElement;
                etxt.addEventListener('click', clickHandler);
                if(_type == 'list')
                    etxt.style['display']='none';
            }
            
            observeElementSize(element,onSizeChangeMyContainer);
            element.addEventListener('change', changeHandler);
            element.addEventListener('beforeOpen', beforeOpenHandler);
            element.addEventListener('afterOpen', afterOpenHandler);
            element.addEventListener('reset', resetHandler);

            dispatchEvent(new Event("onCompleteInicialize"));
        }
        private var localwidth:Number;
        private function onSizeChangeMyContainer():void
        {
            if(localwidth != element.offsetWidth)
            {
                trace("CHANGE WIDTH", localwidth, element.offsetWidth);
                localwidth = element.offsetWidth;
            }
        }

        private function clickHandler(event:Event):void
        {
            dispatchEvent(new Event("onButtonClick"));
        }

        private function changeHandler(event:Event):void
        {
            dispatchEvent(new Event("onChange"));
        }

        private function beforeOpenHandler(event:Event):void
        {
            dispatchEvent(new Event("onBeforeOpen"));
        }

        private function afterOpenHandler(event:Event):void
        {
            dispatchEvent(new Event("onAfterOpen"));
        }

        private function resetHandler(event:Event):void
        {
            dispatchEvent(new Event("onReset"));
        }
    
		/**
         * TEMPORAL, LO QUITARÉ
		 * Creates an visual-select instance.
		 * @param make Configuration item and data after init.
		 */
		public function init(make:Boolean = false):void
		{
            if(!instance)
                instance = VirtualSelect.init(_configOption as Object);
            /*else
            {          
                instance.setProps(_configOption as Object);
                instance.setDisabledOptions(_configOption.disabledOptions);
                instance.setOptions(_configOption.options);
                instance.render();
            }*/
		}

        public function getDisplayValue():Object
        {
            if(_instance)
                return _instance.getDisplayValue();
            else
                return null;
        }

        public function getSelectedOptions():Object
        {
            if(_instance)
                return _instance.getSelectedOptions();
            else
                return null;
        }
        /**
         * type: 'select' or 'list'
         */
        private var _type:String = 'select';
        public function get type():String
        { 
            return _type; 
        }
        [Inspectable(category="General", enumeration="list,select")]
        public function set type(value:String):void
        { 
            _type = value;
            if(value == 'list')
            {
                if(!_configOption.keepAlwaysOpen)
                    _configOption.keepAlwaysOpen = true;
                _configOption.zIndex = 1;                   
            } 
        }

        public function get dataProvider():Array
        { 
            if(_instance)
                return _instance.sortedOptions;
            else
                return _configOption.options; 
        }
        [Bindable]
        public function set dataProvider(value:Array):void
        { 
            _configOption.options = value ? value : new Array;
            if(_instance){
                //_instance.setOptions(value);
               _instance.setServerOptions(value);
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
        public function get disabledOptions():Array{ return _configOption.disabledOptions; }
        [Bindable]
        public function set disabledOptions(value:Array):void
        { 
            _configOption.disabledOptions = value; 
            if(_instance){
                _instance.setDisabledOptions(value);
            }
        }
        /**
         * Enable multi-select
         */
        public function get multiple():Boolean{ return _configOption.multiple; }
        public function set multiple(value:Boolean):void{ _configOption.multiple = value;}
        /**
         * Maximum no.of options allowed to choose in multiple select<br>0 - for no limit
         */
        public function get maxValues():Number{ return _configOption.maxValues; }
        public function set maxValues(value:Number):void{ _configOption.maxValues = value; }
        /**
         * selectedValue: Single value or array of values to select on init
         * 
         * This property is only used to assign the selected initial values and its name can cause confusion.  
         * I rename it to initialSelectedValue
         * 
         * Note: When properties are not of simple type (String, Number,...), even if they are set in the mxml tag, 
         * they are set after creation. To apply it we manually perform the update.
         * (The .setValue does not work properly)
         */
        public function get initialSelectedValue():Object{ return _configOption.selectedValue; }
        public function set initialSelectedValue(value:Object):void
        { 
            _configOption.selectedValue = value;
            if(_instance)
                _instance.setValue(value);
        }
        /**
         * Get selected value.
         * 
         * [todo]
         * In Royale implementation the Binding has been simulated - setter.
         * (The .setValue does not work properly)
         */
        public function get value():Object
        {
            if(_instance)
                return _instance.value;
            else
                return null;
        }
        [Bindable]
        public function set value(value:Object):void
        {
            if(_instance)
                _instance.setValue(value);
            else
                _configOption.selectedValue = value;
        }
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
        /**
         * Keep dropbox always open with fixed height
         */
        public function get keepAlwaysOpen():Boolean{ return _configOption.keepAlwaysOpen; }
        public function set keepAlwaysOpen(value:Boolean):void
        {
            if(!value && _type == 'list')
                value = true;
            _configOption.keepAlwaysOpen = value; 
        }
        /**
         * Position of dropbox (top, bottom, auto)
         */
        public function get position():String{ return _configOption.position; }
        [Inspectable(category="General", enumeration="auto,bottom,top")]
        public function set position(value:String):void
        { 
            _configOption.position = value; 
        }

        public var hideClearButton:Boolean = false;  //Hide clear value button
        public var autoSelectFirstOption:Boolean = false;  //Select first option by default on load
        public var hasOptionDescription:Boolean = false;  //Has description to show along with label
        public var disableSelectAll:Boolean = false;  //Disable select all feature of multiple select
        public var optionsCount:String = '5';  //4|5: 5, No. of options to show on viewport <br/>4 - When hasOptionDescription is true
        public var optionHeight:String = '40px';  //40px|50px. 40px. Height of each dropdown options <br/>50px - When hasOptionDescription is true
        

        public var placeholder:String = 'Select';  //Text to show when no options selected
        public var noOptionsText:String = 'No options found';  //Text to show when no options to show
        public var noSearchResultsText:String = 'No results found';  //Text to show when no results on search
        public var selectAllText:String = 'Select all';  //Text to show near select all checkbox when search is disabled
        public var searchPlaceholderText:String = 'Search...';  //Text to show as placeholder for search input
        public var optionsSelectedText:String = 'options selected';  //Text to use when displaying no.of values selected text (i.e. 3 options selected)
        public var clearButtonText:String = 'Clear';  //Tooltip text for clear button
        public var silentInitialValueSet:Boolean = false;  //To avoid change event trigger on setting initial value
        public var dropboxWidth:String;  //Custom width for dropbox
        
        /**
         * CSS z-index value for dropbox
         */
        private var _zIndex:Number = -1;
        public function get zIndex():Number{ return _configOption.zIndex; }
        public function set zIndex(value:Number):void
        {
             _zIndex = value; 
            if(_type == 'list' || _configOption.keepAlwaysOpen)
                _configOption.zIndex = 1;
            else   
                configOption.zIndex = value;
        }

        public var noOfDisplayValues:Number = 50;  //Maximum no.of values to show in the tooltip for multi-select
        public var allowNewOption:Boolean = false;  //Allow to add new option by searching
        public var tooltipFontSize:String = '14px';  //Font size for tooltip
        public var tooltipAlignment:String = 'center';  //CSS Text alignment for tooltip
        public var tooltipMaxWidth:String = '300px';  //CSS max width for tooltip
        public var showSelectedOptionsFirst:Boolean = false;  //Show selected options at the top of the dropbox
        
        public var name:String;  //Name attribute for hidden input<br>It would be useful for form submit to server

        /**
         * Additional classes for wrapper element
         */
        public function get additionalClasses():String{ return _configOption.additionalClasses; }
        public function set additionalClasses(value:String):void{ _configOption.additionalClasses = value; }

        public var showDropboxAsPopup:Boolean = true;  //Show dropbox as popup on small screen like mobile
        public var popupDropboxBreakpoint:String = '576px';  //Maximum screen width that allowed to show dropbox as popup
        public var onServerSearch:Function;  //Callback function to integrate server search
        public var labelRenderer:Function;  //Callback function to render label, which could be used to add image, icon, or custom content
        public var hideValueTooltipOnSelectAll:Boolean = true;  //Hide value tooltip if all options selected
        public var showOptionsOnlyOnSearch:Boolean = false;  //Show options to select only if search value is not empty
        public var selectAllOnlyVisible:Boolean = false;  //Select only visible options on clicking select all checkbox when options filtered by search

        //vers.1.0.15
        /**
         * Show each selected values as tags with remove icon
         */
        public function get showValueAsTags():Boolean{ return _configOption.showValueAsTags; }
        public function set showValueAsTags(value:Boolean):void{ _configOption.showValueAsTags = value; }
        /**
         * Parent element to render dropbox. (self, body, or any css selectror)
         * Use this when container of dropdown has overflow scroll or hiddden value.
         * 
         * (In the royale wrapper this property must always be set to "body", so that it is always fully visible. We do not give access to the property. )
         */
        //public function get dropboxWrapper():String{ return _configOption.dropboxWrapper; }
        //public function set dropboxWrapper(value:String):void{ _configOption.dropboxWrapper = value; }
        /**
         * By default, no.of options selected text would be shown when there is no enough space to show all selected values. 
         * Set true to override this.
         */
        public function get alwaysShowSelectedOptionsCount():Boolean{ return _configOption.alwaysShowSelectedOptionsCount; }
        public function set alwaysShowSelectedOptionsCount(value:Boolean):void{ _configOption.alwaysShowSelectedOptionsCount = value; }
        /**
         * By default, when all values selected "All (10)" value text would be shown. 
         * Set true to show value text as "10 options selected". 
         */
        public function get disableAllOptionsSelectedText():Boolean{ return _configOption.disableAllOptionsSelectedText; }
        public function set disableAllOptionsSelectedText(value:Boolean):void{ _configOption.disableAllOptionsSelectedText = value; }
        /**
         * Text to use when displaying no.of values selected text and only one value is selected (i.e. 1 option selected)
         */
        public function get optionSelectedText():String{ return _configOption.optionSelectedText; }
        public function set optionSelectedText(value:String):void{ _configOption.optionSelectedText = value; }
        /**
         * Text to use when displaying all values selected text (i.e. All (10))
         */
        public function get allOptionsSelectedText():String{ return _configOption.allOptionsSelectedText; }
        public function set allOptionsSelectedText(value:String):void{ _configOption.allOptionsSelectedText = value; }
        /**
         * Text to show when more than noOfDisplayValues options selected (i.e + 10 more...)
         */
        public function get moreText():String{ return _configOption.moreText; }
        public function set moreText(value:String):void{ _configOption.moreText = value; }
	}
}