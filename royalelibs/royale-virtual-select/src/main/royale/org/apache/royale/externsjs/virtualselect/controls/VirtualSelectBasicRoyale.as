package org.apache.royale.externsjs.virtualselect.controls
{
    COMPILE::JS{
        import org.apache.royale.core.WrappedHTMLElement;
        import org.apache.royale.html.util.addElementToWrapper;
    }
    import org.apache.royale.events.Event;
    import org.apache.royale.core.StyledUIBase;
	import org.apache.royale.externsjs.virtualselect.supportClass.IVirtualSelectControl;
	import org.apache.royale.externsjs.virtualselect.supportClass.virtualSelectOptions;
	import org.apache.royale.externsjs.virtualselect.supportClass.IVirtualSelectCoreModel;
	import org.apache.royale.externsjs.virtualselect.supportClass.IVirtualSelectView;
	
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

	public class VirtualSelectBasicRoyale extends StyledUIBase implements IVirtualSelectControl
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
        public function VirtualSelectBasicRoyale()
		{
			super();			
			typeNames = "virtual-select";

            //this.addEventListener('beadsAdded', onBeadsAdded);
		}
        
		override public function addedToParent():void
		{
			super.addedToParent();
            modelBead.typeControl = typeControl;
            dispatchEvent(new Event("creationComplete"));
		}

        protected function get modelBead():IVirtualSelectCoreModel
        {
            return model as IVirtualSelectCoreModel;
        }

        protected function get modelView():IVirtualSelectView
        {
            return view as IVirtualSelectView;
        }
    
		/*protected function onBeadsAdded(event:Event):void
		{
            removeEventListener('beadsAdded', onBeadsAdded);
		}*/

        protected var _fixInitConfig:virtualSelectOptions;
        public function get fixInitConfig():virtualSelectOptions
        {
            if(!_fixInitConfig){
                _fixInitConfig = new virtualSelectOptions();
                //By default we override the 250px max-width restriction. Together with the modification of the CSS class ".vscomp-ele".
                _fixInitConfig.maxWidth = null;
                _fixInitConfig.optionsCount = 5;
                _fixInitConfig.placeholder = "\u21F2 ...";
                _fixInitConfig.searchPlaceholderText = " ... 🔎︎";
            }
            return _fixInitConfig;
        }

        protected var _configOption:virtualSelectOptions;
        //Clonamos los objetos para asegurarnos de controlar el seteo de la configuración
        public function get configOption():virtualSelectOptions
        { 
            if( modelBead )
                return modelBead.configOption;
            else
                return _configOption;
        }
        public function set configOption(opts:virtualSelectOptions):void
        {
            if( modelBead )
                modelBead.configOption = opts;
            else
                _configOption = opts;
        }

        public function setConfigOptionProperty(key:String, value:Object, immediateUpdate:Boolean):void
        {
            /*if( modelBead.hasOwnProperty(key) )
            {
                modelBead[key] = value;
                if(immediateUpdate){
                    modelView.setConfigOptions(null);
                }
            }*/
        }

        public function get rawDataProvider():Array
        { 
            return modelBead.rawDataProvider; 
        }

        public function get dataProvider():Object
        { 
            return modelBead.dataProvider; 
        }
        public function set dataProvider(value:Object):void
        { 
            modelBead.dataProvider = value;
        }
        
        public function get autoOptionsCount():Boolean{ return modelBead.autoOptionsCount; }
        public function set autoOptionsCount(value:Boolean):void { modelBead.autoOptionsCount = value; }

        public function get classNamesLabelRenderer():String{return modelBead.classNamesLabelRenderer; }
        public function set classNamesLabelRenderer(value:String):void { modelBead.classNamesLabelRenderer = value; }
        /**
         * List of values to disable options <br/>e.g - [2, 3, 9]
         */
        public function get disabledOptions():Array{ return modelBead.disabledOptions; }
        public function set disabledOptions(value:Array):void
        { 
            modelBead.disabledOptions = value; 
        }        
        /**
         * Get selected option's display value (i.e label)
         * @return  Array || String
         */
        [Bindable("onChange")]
        public function get selectedLabel():Object
        {
            if(modelBead.jsInstance)
                return modelBead.jsInstance.getDisplayValue();
            else
                return null;
        }

        public function reset():void{
            modelView.reset();
        }
        
	}
}