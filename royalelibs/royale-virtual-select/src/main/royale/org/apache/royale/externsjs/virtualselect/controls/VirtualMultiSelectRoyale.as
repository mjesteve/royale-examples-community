package org.apache.royale.externsjs.virtualselect.controls
{
	import org.apache.royale.externsjs.virtualselect.models.VirtualMultiSelectModel;
	import org.apache.royale.externsjs.virtualselect.views.VirtualSelectView;
	import org.apache.royale.externsjs.virtualselect.supportClass.IVirtualSelectControl;
	import org.apache.royale.externsjs.virtualselect.supportClass.virtualSelectOptions;
	import org.apache.royale.externsjs.virtualselect.supportClass.IVirtualMultiSelectModel;
	import org.apache.royale.externsjs.virtualselect.supportClass.IVirtualSelectModel;
	
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

	public class VirtualMultiSelectRoyale extends VirtualSelectBasicRoyale implements IVirtualSelectControl
    {
        /**
         *  Constructor.
         */
        public function VirtualMultiSelectRoyale()
		{
			super();
            typeControl = 'list';
		}

        override protected function get modelBead():VirtualMultiSelectModel
        {
            return model as VirtualMultiSelectModel;
        }

        override protected function get modelView():VirtualSelectView
        {
            return view as VirtualSelectView;
        }
        
        override public function get fixInitConfig():virtualSelectOptions
        {
            if(!_fixInitConfig){
                _fixInitConfig = new virtualSelectOptions();
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
                _fixInitConfig.searchPlaceholderText = " ... 🔎︎";
                _fixInitConfig.multiple = true;
            }
            return _fixInitConfig;
        }

        override public function set configOption(opts:virtualSelectOptions):void
        {
            if( opts && !opts.multiple )
                opts.multiple = true;

            super.configOption = opts;
        }

        override public function setConfigOptionProperty(key:String, value:Object, immediateUpdate:Boolean):void
        {
            if( modelBead.hasOwnProperty(key) )
            {
                modelBead[key] = value;
                if(immediateUpdate){
                    modelView.setConfigOptions(null);
                }
            }
        }
        /**
         * Get selected option's display value (i.e label)
         */
        [Bindable("onChange")]
        override public function get selectedLabel():Object
        {
            if(modelBead.jsInstance)
                return modelBead.jsInstance.getDisplayValue();
            else
                return null;
        }

        public function get selectedIndices():Array
        {
            return modelBead.selectedIndices;
        }

        [Bindable("onChange")]
        public function set selectedIndices(value:Array):void
        {
            modelBead.selectedIndices = value;
        }
        
        public function get selectedItems():Array{ 
            return modelBead.selectedItems; 
        }
        [Bindable("onChange")]
        public function set selectedItems(value:Array):void
        { 
            modelBead.selectedItems = value;
        }

        public function get selectedValues():Array
        {
            return modelBead.selectedValues;
        }
        [Bindable("onChange")]
        public function set selectedValues(value:Array):void
        { 
            modelBead.selectedValues = value;
        }

        //private var _rawSelectedItem:Object;
        public function get rawSelectedItems():Array
        { 
            if(!modelBead.selectedIndices || modelBead.selectedIndices.length == 0 ||
               !modelBead.rawDataProvider || modelBead.rawDataProvider.length == 0)
               return null;
            
            var _rawSelectedItem:Array;
            var len:int = modelBead.rawDataProvider.length;
            for(var index:int = 0; index < len; index++) {
                _rawSelectedItem.push( modelBead.rawDataProvider[index] );
            }            
            return _rawSelectedItem; 
        }
	}
}