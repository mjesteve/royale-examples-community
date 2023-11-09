package org.apache.royale.externsjs.virtualselect.controls
{
	import org.apache.royale.externsjs.virtualselect.models.VirtualSelectModel;
	import org.apache.royale.externsjs.virtualselect.views.VirtualSelectView;
	import org.apache.royale.externsjs.virtualselect.supportClass.IVirtualSelectControl;
	import org.apache.royale.externsjs.virtualselect.supportClass.virtualSelectOptions;
	
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

	public class VirtualSelectRoyale extends VirtualSelectBasicRoyale implements IVirtualSelectControl
    {
        /**
         *  Constructor.
         */
        public function VirtualSelectRoyale()
		{
			super();
            typeControl = 'select';
		}

        override protected function get modelBead():VirtualSelectModel
        {
            return model as VirtualSelectModel;
        }

        override protected function get modelView():VirtualSelectView
        {
            return view as VirtualSelectView;
        }
    
		/*protected function onBeadsAdded(event:Event):void
		{
            removeEventListener('beadsAdded', onBeadsAdded);
		}*/

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
                _fixInitConfig.multiple = false;
            }
            return _fixInitConfig;
        }

        override public function set configOption(opts:virtualSelectOptions):void
        {
            if( opts && opts.multiple )
                opts.multiple = false;

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
         * @return  String
         */
        [Bindable("onChange")]
        override public function get selectedLabel():Object
        {
            if(modelBead.jsInstance)
                return modelBead.jsInstance.getDisplayValue().toLocaleString();
            else
                return '';
        }
        /**
         * Get selected selectedValue.
         */
        public function get selectedIndex():int
        {
            return modelBead.selectedIndex;
        }
        [Bindable("onChange")]
        public function set selectedIndex(value:int):void
        {
            modelBead.selectedIndex = value;
        }
        /**
         * Get selected option's details. It would contains isNew: true property for options added newly by allowNewOption
         */
        public function get selectedItem():Object
        {
            return modelBead.selectedItem;
        }
        [Bindable("onChange")]
        public function set selectedItem(value:Object):void
        {
            modelBead.selectedItem = value;
        }
        /**
         * Get selected selectedValue.
         */
        public function get selectedValue():Object
        {
            return modelBead.selectedValue;
        }
        [Bindable("onChange")]
        public function set selectedValue(value:Object):void
        {
            modelBead.selectedValue = value;
        }

        public function get rawSelectedItem():Object
        { 
            var _rawSelectedItem:Object;
            if(modelBead.rawDataProvider && modelBead.rawDataProvider.length != 0)
            {
                var index:Number = selectedIndex;
                if(index != -1)
                    _rawSelectedItem = modelBead.rawDataProvider[index];
            }
            return _rawSelectedItem; 
        }

	}
}