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
    import org.apache.royale.externsjs.virtualselect.supportClass.virtualSelectOptionsClass;
	import org.apache.royale.externsjs.virtualselect.supportClass.Utils;
	
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

	[DefaultProperty("configOption")]

	public class VirtualSelectJwExt extends StyledUIBase
    {
        protected var typeControl:String = 'select';

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
			typeNames = "virtual-select";

            this.addEventListener('beadsAdded', init);
		}
        
		override public function addedToParent():void
		{
			super.addedToParent();
            dispatchEvent(new Event("creationComplete"));

            observeElementSize(element,onSizeChangeMyContainer);
            element.addEventListener('change', changeHandler);
            element.addEventListener('beforeOpen', beforeOpenHandler);
            element.addEventListener('afterOpen', afterOpenHandler);
            element.addEventListener('reset', resetHandler);
		}
    
		/**
		 * Creates an visual-select jsInstance.
		 * @param make Configuration item and data after init.
		 */
		protected function init(event:Event):void
		{
            this.removeEventListener('beadsAdded', init);
            jsInstance = VirtualSelect.init(configOption.optsInit);
		}

        protected var _fixInitConfig:virtualSelectOptionsClass;
        public function get fixInitConfig():virtualSelectOptionsClass
        {
            if(!_fixInitConfig){
                _fixInitConfig = new virtualSelectOptionsClass();
                _fixInitConfig.markSearchResults = true;
                _fixInitConfig.optionHeight = "35px"; // TODO: _itemRenderer.sass - ListItemRenderer variables - $item-min-height: 34px
                _fixInitConfig.tooltipFontSize = "14px"; //TODO get font-size CSS
                //By default we override the 250px max-width restriction. Together with the modification of the CSS class ".vscomp-ele".
                _fixInitConfig.maxWidth = null;
                _fixInitConfig.zIndex = 80;
                _fixInitConfig.optionsCount = 5;
                _fixInitConfig.dropboxWrapper = 'body';
                _fixInitConfig.showValueAsTags = false;
                _fixInitConfig.position = 'bottom left';
                _fixInitConfig.keepAlwaysOpen = false;
                _fixInitConfig.placeholder = "\u21F2 ...";
            }
            return _fixInitConfig;
        }

        protected var _configOption:virtualSelectOptionsClass;
        //[Bindable("configOptionChange")]
        //Clonamos los objetos para asegurarnos de controlar el seteo de la configuración
        public function get configOption():virtualSelectOptionsClass
        { 
            if(!_configOption)
                _configOption = fixInitConfig;
            return _configOption;
        }
        public function set configOption(opts:virtualSelectOptionsClass):void
        {
            if(!opts)
                return;
            Utils.shallowCopy(opts.optsInit,configOption.optsInit);
            // seteamos manualmente las propiedades personalizadas que no están en optsInit
            configOption.ele = element;
        }

        public function setConfigOptions(opts:virtualSelectOptionsClass):void
        {
            configOption = opts;
            if(jsInstance)
                recreateComponent();            
        }

        public var _jsElement:Object;
        protected var _jsInstance:VirtualSelect;
        public function get jsInstance():VirtualSelect{ return _jsInstance; }
        public function set jsInstance(value:VirtualSelect):void
        {
            _jsInstance = value;
            _jsElement = value.$ele;

            /*var nlist:NodeList = element.getElementsByClassName('vscomp-toggle-button');
            if(nlist && nlist.length>0)
            {
                var etxt:HTMLDivElement = nlist[0] as HTMLDivElement;
                if(configOption.hideSelectDisplayOnKeepAlwaysOpen)
                    etxt.style['display']='none';
                else
                    etxt.addEventListener('click', clickHandler);
            }*/

            dispatchEvent(new Event("onCompleteInicialize"));
        }

        protected function recreateComponent():void
        {
            if(jsInstance)
            {
                // Al utilizar, en set dataprovider, la función Array.concat() en vez de ObjectUtil.clone (porque tarda mucho)
                // el dataprovider interno queda unido con el asignado actualizándolo al seleccionar los items.
                // Reseteamos para anular cualquier posible selección.
                jsInstance.reset();
                jsInstance.destroy();
            }
                
            jsInstance = VirtualSelect.init(configOption.optsInit);
            render();
        }
        //Cuando actualicemos a la versión 1.0.39 no hará falta esta variable porque
        //existe customData
        public var rawDataProvider:Array;
        public function get dataProvider():Array
        { 
            if(_jsInstance)
                return _jsInstance.sortedOptions;
            else
                return rawDataProvider; 
        }

        //[Bindable("dataProviderChange")]
        public function set dataProvider(value:Array):void
        { 
            if( rawDataProvider == value)
                return;
            
            // Con mx.ObjectUtil.copy | clone con 15.000 registros tarda mucho
            // 
            if( value )
                rawDataProvider = value.concat();
            else
                rawDataProvider = new Array();
            render();
        }

        protected function render():void
        {
            var dp:Array = new Array();
            
            if(rawDataProvider && rawDataProvider.length>0)
            {
                var len:int = rawDataProvider.length;
                //hasta la versión 1.29.0 no se reconocen los array's de strings.
                //los simulamos.
                var item:Object = rawDataProvider[0];
                var isOptionString:Boolean = item is String || item is Number ? true:false;
                //rectificamos el padding a 0. Para ello utilizamos la propiedad "classNames" de cada option
                //debemos agregar manualmente el atributo si no existe.
                var cssinrow:Boolean = false;
                if(item.hasOwnProperty('classNames'))
                    cssinrow = true;
                
                var fixCssItemRender:Boolean = configOption.labelRenderer || cssinrow || classNamesLabelRenderer ? true:false;
                if( isOptionString || fixCssItemRender )
                {
                    // Additional class for each itemrenderer set by the user.
                    var itemClassName:String = !classNamesLabelRenderer?'':classNamesLabelRenderer;
                    for(var index:int = 0; index < len; index++)
                    {
                        item = rawDataProvider[index];
                        if(isOptionString)
                            item = {label: item, value: item};
                            
                        if( fixCssItemRender ) {
                            if(index==0){
                                // Additional class set in each item of the dataprovider.(value[1..n]['classNames'])
                                if (!cssinrow && _configOption.labelRenderer && !itemClassName && !_configOption.multiple)
                                    itemClassName = 'nopadding';
                            }
                            var cssrow:String = !item['classNames']?'':item['classNames']+'';
                            if(cssrow!='')
                                cssrow = (itemClassName?' ':'')+cssrow;
                            item['classNames'] = itemClassName+cssrow;
                        }  
                        dp.push(item);
                    }                    
                }else
                    dp = rawDataProvider;
            }
            //_configOption.options = dp;
            if(_jsInstance){
                //_jsInstance.setOptions(value);
               _jsInstance.setServerOptions(dp);
            }
        }
        /**
         * selectedItem devolverá el item seleccionado con toda la información existente y no sólo
         * los datos resumidos (label, value, alias)
         */
        private var _returnFullDetailsItem:Boolean = false;
        public function get returnFullDetailsItem():Boolean{ return _returnFullDetailsItem; }
        public function set returnFullDetailsItem(value:Boolean):void{ _returnFullDetailsItem = value; }
        /**
         * El nº de opciones visibles se calculará en función del alto real del dropdownbox.
         * Solo aplicable cuando keepAlwaysOpen = true
         */
        private var _autoOptionsCount:Boolean = false;
        public function get autoOptionsCount():Boolean{ return _autoOptionsCount; }
        public function set autoOptionsCount(value:Boolean):void
        { 
            _autoOptionsCount = value; 
        }
        /**
         * options[].classNames
         * Se añadirá un atributo a cada item, del dataprovider, 
         */
        private var _classNamesLabelRenderer:String;
        public function get classNamesLabelRenderer():String
        {
            return _classNamesLabelRenderer; 
        }
        public function set classNamesLabelRenderer(value:String):void
        {
            _classNamesLabelRenderer = value; 
        }
        /**
         * List of values to disable options <br/>e.g - [2, 3, 9]
         */
        public function get disabledOptions():Array{ return _configOption.disabledOptions; }
        [Bindable("disabledOptionsChange")]
        public function set disabledOptions(value:Array):void
        { 
            _configOption.disabledOptions = value; 
            if(_jsElement){
                //_jsElement.setDisabledOptions(value);
                _jsInstance.setDisabledOptionsMethod(value);
            }
        }
        /**
         * Get selected selectedValue.
         */
        public function get selectedValue():Object
        {
            if(_jsElement)
                return _jsElement.value;
            else
                return null;
        }
        [Bindable("onChange")]
        public function set selectedValue(value:Object):void
        {
            _configOption.selectedValue = value;
            if(_jsElement)
            {
                // Hay métodos que solo funcionan si son llamados desde el Element y no desde la Instancia del control
                // https://github.com/sa-si-dev/virtual-select/blob/c3eb001e2af339c9dff538e84f89da426ac9afe6/src/virtual-select.js#L866
                //_jsElement.setValue(value);
                _jsInstance.setValueMethod(value,false);
            }
        }
        public function get selectedValues():Array
        {
            if(_jsInstance)
                return _jsInstance.selectedValues;
            else
                return null;
        }

        //private var _rawSelectedItem:Object;
        public function get rawSelectedItem():Object
        { 
            var _rawSelectedItem:Object;
            if(rawDataProvider && rawDataProvider.length != 0)
            {
                var index:Number = selectedIndex;
                if(index != -1)
                    _rawSelectedItem = rawDataProvider[index];
            }
            return _rawSelectedItem; 
        }

        private var _selectedItems:Array;
        public function get selectedItems():Array{ 
            return _selectedItems; 
        }
        [Bindable("onChange")]
        public function set selectedItems(value:Array):void{ 
            
            if(rawDataProvider && rawDataProvider.length!=0 && _jsElement){
                //_jsElement.setValue(value);
                //jsInstance.setValue(value);
                jsInstance.setValueMethod(value,false);
                _selectedItems = _jsInstance.getSelectedOptions({fullDetails: _returnFullDetailsItem, keepSelectionOrder: true});
            }else
                _selectedItems = null;

        }
        /**
         * Get selected option's details. It would contains isNew: true property for options added newly by allowNewOption
         */
        public function get selectedItem():Object
        {
            if(rawDataProvider && rawDataProvider.length!=0 && _jsElement){
                _selectedItems = _jsInstance.getSelectedOptions({fullDetails: _returnFullDetailsItem, keepSelectionOrder: true});
                if( _selectedItems) {
                    if( _selectedItems is Array && _selectedItems.length != 0)
                        return _selectedItems[0];
                    else
                        return _selectedItems;
                }else
                    return null;
            }
            else
                return null;
        }
        [Bindable("onChange")]
        public function set selectedItem(value:Object):void
        {
            var valueItem:Object;
            if(_configOption.valueKey && value)
                valueItem = value[_configOption.valueKey];

            if(_jsElement){
                if(!valueItem){
                    _jsElement.reset();
                    return;
                }
                _jsElement.setValue(valueItem);
            }
            else
                _configOption.selectedValue = valueItem;
        }
        
        /**
         * Get selected option's display value (i.e label)
         */
        [Bindable("onChange")]
        public function get selectedLabel():Object
        {
            if(_jsElement)
                return _jsInstance.getDisplayValue();
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
            if(_jsElement)
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
                //trace("CHANGE WIDTH", localwidth, element.offsetWidth);
                localwidth = element.offsetWidth;
            }
            if(_configOption.keepAlwaysOpen && _autoOptionsCount )
            {
                //AutoHeight. Pendiente porque la librería no permite el cambio de opciones después de la inicialización.
                var ith:Number = Math.ceil(height/Number(getNumCharacters( _configOption.optionHeight)));
                if( _configOption.optionsCount != ith )
                {
                    _configOption.optionsCount = ith;
                }
            }
        }
		public static function getNumCharacters( content:String ):String{
			var patron:RegExp = /\d+/g;
			var resultado:String = content.match(patron).toString();
			resultado = changeCharacter(",","",resultado)
			return resultado;
		}

		public static function changeCharacter(carorigen:String,cardestino:String,str:String):String
		{
			var i:int;
			var c:String;
			var f:String="";

			for (i=0; i<=str.length-1;i++){
				c=str.substr(i,1);
				if (c==carorigen){
					if (cardestino.length>0){f=f+cardestino;}
				}else{
					f=f+c;
				}
			}
			return(f);
		}

        protected function clickHandler(event:Event):void
        {
            dispatchEvent(new Event("onButtonClick"));
        }

        protected var _selectedItem:Object;
        protected function changeHandler(event:Event):void
        {
            if(event.target.innerText.toString().indexOf("Select") != -1)
            {
                event.target.querySelector(".vscomp-toggle-button").style = "width:100% !important";
                event.target.querySelector(".vscomp-clear-button").style = "width:0% !important";
                event.target.querySelector(".vscomp-clear-icon").style = "width:0% !important";
                event.target.querySelector(".vscomp-option-text").style = "width:100% !important";



            }
            else
            {
                event.target.querySelector(".vscomp-toggle-button").style = "width:94% !important";
                event.target.querySelector(".vscomp-clear-button").style = "width:6% !important";
                event.target.querySelector(".vscomp-clear-icon").style = "width:14px !important";
                event.target.querySelector(".vscomp-option-text").style = "width:94% !important";

            }
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

        public function reset():void{
            if(rawDataProvider && rawDataProvider.length!=0 && jsInstance && _selectedItems && _selectedItems.length>0)
                jsInstance.reset();
        }
        
	}
}