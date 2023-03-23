package org.apache.royale.externsjs.virtualselect.controls
{
    COMPILE::JS{
        import org.apache.royale.core.WrappedHTMLElement;
        import org.apache.royale.html.util.addElementToWrapper;
    }
    import org.apache.royale.events.Event;
    import org.apache.royale.core.StyledUIBase;
    import org.apache.royale.utils.observeElementSize;
    import VirtualSelect;
    import org.apache.royale.utils.ObjectUtil;
    import org.apache.royale.externsjs.virtualselect.supportClass.OptionsInit;
	//import mx.utils.ObjectUtil;
	
    /**
     *  Click in the component
     */
	[Event(name="onButtonClick", type="org.apache.royale.events.Event")]
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

	[DefaultProperty("inst")]

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
            initConfig();
		}

        protected function initConfig():void
        {   
            _configOption = new OptionsInit
            _configOption.ele = element;
            _configOption.markSearchResults = true;
            _configOption.optionHeight = "35px"; // TODO: _itemRenderer.sass - ListItemRenderer variables - $item-min-height: 34px
            _configOption.tooltipFontSize = "14px"; //TODO get font-size CSS
            //By default we override the 250px max-width restriction. Together with the modification of the CSS class ".vscomp-ele".
            _configOption.maxWidth = null;
            _configOption.zIndex = 80;
            _configOption.optionsCount = 5;
            _configOption.dropboxWrapper = 'body';
            _configOption.showValueAsTags = false;
            _configOption.position = 'bottom left';
            _configOption.keepAlwaysOpen = false;
        }
        
		override public function addedToParent():void
		{
			super.addedToParent();
            dispatchEvent(new Event("creationComplete"));
            setTimeout(init,125);
		}
    
        protected var typeControl:String = 'select';
		/**
		 * Creates an visual-select instance.
		 * @param make Configuration item and data after init.
		 */
		protected function init(make:Boolean = false):void
		{
            if(instance)
                instance.destroy();
            trace(configOption);
            instance = VirtualSelect.init(configOption);
		}
        /**
         * Test. Debug all dispatched events
         */
        /*override public function dispatchEvent(event:Event):Boolean {
            //trace("********** VirtualSelectJwExt: EVENT ", event);
            return super.dispatchEvent(event);
        }*/

        protected var _configOption:OptionsInit;
        [Bindable("configOptionChange")]
        public function get configOption():OptionsInit{ 
            return _configOption; 
        }
        public function set configOption(value:OptionsInit):void
        {
            if(!value){
                initConfig();
                return;
            }

            ObjectUtil.shallowCopy(value,_configOption);
            _configOption.ele = element;
        }

        public var inst:Object;
        protected var _instance:VirtualSelect;
        protected function get instance():VirtualSelect{ return _instance; }
        protected function set instance(value:VirtualSelect):void
        {
            if( _instance )
                _instance.destroy();
                
            _instance = value;
            inst = value.$ele;

            var nlist:NodeList = element.getElementsByClassName('vscomp-toggle-button');
            if(nlist && nlist.length>0)
            {
                var etxt:HTMLDivElement = nlist[0] as HTMLDivElement;
                etxt.addEventListener('click', clickHandler);
                if(!_configOption.showSelectDisplay)
                    etxt.style['display']='none';
            }
            
            observeElementSize(element,onSizeChangeMyContainer);
            element.addEventListener('change', changeHandler);
            element.addEventListener('beforeOpen', beforeOpenHandler);
            element.addEventListener('afterOpen', afterOpenHandler);
            element.addEventListener('reset', resetHandler);

            dispatchEvent(new Event("onCompleteInicialize"));
        }
        
        public function get dataProvider():Array
        { 
            if(_instance)
                return _instance.sortedOptions;
            else
                return _configOption.options; 
        }

        [Bindable("dataProviderChange")]
        public function set dataProvider(value:Array):void
        { 
            var dp:Array = new Array();
            //hasta la versión 1.29.0 no se reconocen los array's de strings.
            //los simulamos.
            if(value && value.length>0 && (value[0] is String || value[0] is Number) ) {
                var len:int = value.length;
                for(var index:int = 0; index < len; index++)
                {
                    dp.push( {label:value[index], value:value[index]});
                }
            }else if(value)
                dp = value;
            
            _configOption.options = dp;
            if(_instance){
                //_instance.setOptions(value);
               _instance.setServerOptions(dp);
            }
        }

        /**
         * List of values to disable options <br/>e.g - [2, 3, 9]
         */
        public function get disabledOptions():Array{ return _configOption.disabledOptions; }
        [Bindable("disabledOptionsChange")]
        public function set disabledOptions(value:Array):void
        { 
            _configOption.disabledOptions = value; 
            if(inst){
                inst.setDisabledOptions(value);
            }
        }
        /**
         * Get selected selectedValue.
         */
        public function get selectedValue():Object
        {
            if(inst)
                return inst.value;
            else
                return null;
        }
        [Bindable("onChange")]
        public function set selectedValue(value:Object):void
        {
            if(inst)
                inst.setValue(value);
            else
                _configOption.selectedValue = value;
        }
        /**
         * Get selected option's details. It would contains isNew: true property for options added newly by allowNewOption
         */
        public function get selectedItem():Object
        {
            if(inst)
                return _instance.getSelectedOptions();
            else
                return null;
        }
        [Bindable("onChange")]
        public function set selectedItem(value:Object):void
        {
            var valueItem:Object;
            if(_configOption.valueKey && value)
                valueItem = value[_configOption.valueKey];
            
            trace(valueItem);

            if(inst){
                trace(selectedItem);
                if(!valueItem){
                    inst.reset();
                    return;
                }
                inst.setValue(valueItem);
            }
            else
                _configOption.selectedValue = valueItem;
            
            trace(inst.value);
        }
        /**
         * Get selected option's display value (i.e label)
         */
        [Bindable("onChange")]
        public function get selectedLabel():Object
        {
            if(inst)
                return _instance.getDisplayValue();
            else
                return null;
        }
        /**
         * Get selected selectedValue.
         */
        public function get selectedIndex():int
        {
            if(_selectedItem)
                return _selectedItem.index;
            else
                return -1;
        }
        [Bindable("onChange")]
        public function set selectedIndex(value:int):void
        {
            if(inst)
            {
                if(value == -1)
                    selectedValue = null;
                else{
                    var dp:Array = dataProvider;
                    for each(var item:Object in dp)
                    {
                        if(parseInt(item['index']) == value){
                            selectedValue = dp[value]['value'];
                            break;
                        }
                    }
                }
            }
        }
        /**
         * Parent element to render dropbox. (self, body, or any css selectror)
         * Use this when container of dropdown has overflow scroll or hiddden value.
         * 
         * (In the royale wrapper this property must always be set to "body", so that it is always fully visible. We do not give access to the property. )
         */
        //public function get dropboxWrapper():String{ return _configOption.dropboxWrapper; }
        //public function set dropboxWrapper(value:String):void{ _configOption.dropboxWrapper = value; }
        protected var localwidth:Number;
        protected function onSizeChangeMyContainer():void
        {
            if(localwidth != element.offsetWidth)
            {
                trace("CHANGE WIDTH", localwidth, element.offsetWidth);
                localwidth = element.offsetWidth;
            }
        }

        protected function clickHandler(event:Event):void
        {
            dispatchEvent(new Event("onButtonClick"));
        }

        protected var _selectedItem:Object;
        protected function changeHandler(event:Event):void
        {
            _selectedItem = selectedItem;
            dispatchEvent(new Event("onChange"));
        }

        protected function beforeOpenHandler(event:Event):void
        {
            dispatchEvent(new Event("onBeforeOpen"));
        }

        protected function afterOpenHandler(event:Event):void
        {
            dispatchEvent(new Event("onAfterOpen"));
        }

        protected function resetHandler(event:Event):void
        {
            dispatchEvent(new Event("onReset"));
        }
	}
}