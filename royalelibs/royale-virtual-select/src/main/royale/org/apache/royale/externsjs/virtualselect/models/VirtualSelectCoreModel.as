package org.apache.royale.externsjs.virtualselect.models
{    
    import org.apache.royale.events.EventDispatcher;
    import org.apache.royale.core.IBeadModel;
    import org.apache.royale.core.IStrand;
    import org.apache.royale.core.ElementWrapper;
    import org.apache.royale.externsjs.virtualselect.supportClass.virtualSelectOptions;
    import org.apache.royale.externsjs.virtualselect.supportClass.IVirtualSelectControl;
    import org.apache.royale.externsjs.virtualselect.supportClass.Utils;
    import org.apache.royale.utils.sendStrandEvent;
    import org.apache.royale.core.IHasLabelField;
    import org.apache.royale.core.IHasDataProvider;
    import org.apache.royale.externsjs.virtualselect.supportClass.IVirtualSelectCoreModel;

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

    public class VirtualSelectCoreModel extends EventDispatcher implements IVirtualSelectCoreModel, IBeadModel, IHasDataProvider, IHasLabelField
    {

        public function VirtualSelectCoreModel(){
            super();
        }

		protected var _strand:IStrand;
		
        /**
         *  @copy org.apache.royale.core.IBead#strand
         *  
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion Royale 0.9.4
         */
		public function set strand(value:IStrand):void
		{
			_strand = value;
		}

		private var _labelField:String = null;
		
        /**
         *  @copy org.apache.royale.core.ISelectionModel#labelField
         *  
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion Royale 0.9.4
         */
		public function get labelField():String
		{
            if( !_labelField )
            {
                if( configOption )
                    _labelField = configOption.labelKey;
            }
			return _labelField;
		}

        /**
         *  @private
         */
		public function set labelField(value:String):void
		{
            //TODO re-render
			if (value != labelField) {
                if( configOption )
                    configOption.labelKey = value;
				_labelField = value;
				dispatchEvent(new Event("labelFieldChanged"));
			}
		}

        protected var _jsInstance:VirtualSelect;
        public function get jsInstance():VirtualSelect{ return _jsInstance; }
        //[Bindable("jsInstanceChange")]
        public function set jsInstance(value:VirtualSelect):void
        {
            _jsInstance = value;
            //_jsElement = value.$ele;
            sendStrandEvent(_strand,new Event("onCompleteInicialize"));
        }
        /**
         * Tipo de control: 'select' | 'list'
         */
        private var _typeControl:String = 'select';
        public function get typeControl():String{ return _typeControl; }
        public function set typeControl(value:String):void
        {
            _typeControl = value; 
			dispatchEvent(new Event("typeControlChange"));
        }

        // TODO
        private var _autoOptionsCount:Boolean;
        /**
         * El nº de opciones visibles se calculará en función del alto real del dropdownbox.
         * Solo aplicable cuando keepAlwaysOpen = true
         */
        public function get autoOptionsCount():Boolean{ return _autoOptionsCount; }
        public function set autoOptionsCount(value:Boolean):void{ 
            _autoOptionsCount = value; 
        }

        protected var _configOption:virtualSelectOptions;
        public function get configOption():virtualSelectOptions
        { 
            if(!_configOption)
                _configOption = (_strand as IVirtualSelectControl).fixInitConfig;
            return _configOption;
        }
        public function set configOption(opts:virtualSelectOptions):void
        {
            if(!opts)
                _configOption = null;
            Utils.shallowCopy(opts.optsInit,configOption.optsInit);
            _configOption.ele = (_strand as ElementWrapper).element;
			dispatchEvent(new Event("configOptionChange"));
        }
        /**
         * TODO
         * @property {(string[]|number[])} [disabledOptions] - Options to disable (array of values) <br/>e.g - [2, 3, 9]
         */
        private var _disabledOptions:Array = [];
        public function get disabledOptions():Array{ return _disabledOptions; }
        public function set disabledOptions(value:Array):void
        { 
            if( _disabledOptions != value)
            {
                _disabledOptions = value;  
                
			    dispatchEvent(new Event("disabledOptionsChange"));
            }
        }
        //Cuando actualicemos a la versión 1.0.39 no hará falta esta variable porque
        //existe customData
        private var _rawDataProvider:Array;
        public function get rawDataProvider():Array{ return _rawDataProvider; }

        protected var _dataProvider:Array;
        public function get dataProvider():Array
        { 
            return _dataProvider; 
        }
        public function set dataProvider(value:Array):void
        { 
            if (value === _dataProvider) return;
            if( value ){
                _rawDataProvider = Utils.cloneArray(value);
            }
            else{
                _rawDataProvider = new Array();
            }
            _dataProvider =  prepareDataItemRenderers();
            if(_jsInstance){
               _jsInstance.setServerOptions(_dataProvider);
               _dataProvider = _jsInstance.sortedOptions;
            }

            syncDataProvider();
			dispatchEvent(new Event("dataProviderChanged"));
        }

        protected function syncDataProvider():void{
            //override
            /*
            if( _configOption.multiple )
            {
                if(_dataProvider && _selectedValues)
                    syncFromValues();
                else if (!_dataProvider)
                    selectedValues = null;
            } else 
            {
                if(_dataProvider && _selectedValue)
                    syncFromValue();
                else if (!_dataProvider)
                    selectedValue = null;
            }
            */
        }

        protected function prepareDataItemRenderers():Array
        {
            var dp:Array = new Array();
            
            if(_rawDataProvider && _rawDataProvider.length>0)
            {
                var len:int = _rawDataProvider.length;
                //hasta la versión 1.29.0 no se reconocen los array's de strings.
                //los simulamos.
                var item:Object = _rawDataProvider[0];
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
                        item = _rawDataProvider[index];
                        if(isOptionString)
                            item = {label: item, value: item};
                            
                        if( fixCssItemRender ) {
                            if(index==0){
                                // Additional class set in each item of the dataprovider.(value[1..n]['classNames'])
                                if (!cssinrow && configOption.labelRenderer && !itemClassName && !configOption.multiple)
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
                    dp = _rawDataProvider.concat();
            }
            return dp;
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
    }
}