package org.apache.royale.community.controls {

    import org.apache.royale.jewel.ComboBox;
    import org.apache.royale.utils.loadBeadFromValuesManager;
    import org.apache.royale.jewel.beads.controls.combobox.ComboBoxTruncateText;
    import org.apache.royale.jewel.beads.controls.combobox.ComboBoxDisabled;
    import org.apache.royale.jewel.beads.controls.combobox.ComboBoxTextPrompt;
    import org.apache.royale.jewel.beads.controls.combobox.ComboBoxListCloseOnClick;
    import org.apache.royale.events.Event;
    import org.apache.royale.collections.IArrayList;
    import org.apache.royale.collections.ArrayListView;
    import org.apache.royale.core.ValuesManager;
    import org.apache.royale.community.beads.models.ISelectionByFieldModel;
    import org.apache.royale.community.jewel.beads.controls.combobox.SearchFilterJwExt;
    import org.apache.royale.core.IDataProviderModel;

	[Event(name="selectedValueChange", type="org.apache.royale.events.Event")]
    /**
     * Extension the Jewel ComboBox.
     *
     * - New emptyDisabled property to indicate whether to disable the component if there is no data.
     * - New property 'disabled'. Enable or disable the control.
     *      The ComboBoxDisabled bead is automatically loaded.
     * - Automatically loads the ComboBoxTruncateText bead.
     *
     * [TODO - If necessary...] - New property 'prompt'.
     * - New property 'prompt'. Default COMBO_BOX_TEXT_PROMPT
     *      The ComboBoxTextPrompt bead is automatically loaded.
     */
    public class ComboBoxJwExt extends ComboBox {

        private static const COMBO_BOX_TEXT_PROMPT:String = "\u21F2 ...";

        private var isCreateComplete:Boolean = false;

        public function ComboBoxJwExt() {
            super();
            addEventListener("beadsAdded", beadsAddedHandler);
        }

        private function beadsAddedHandler(event:Event):void
        {
			removeEventListener("beadsAdded", beadsAddedHandler);

            loadActivePopupControls();
            loadSearchText();
            loadTextTruncate();
            loadTextPromp();

			_disabled = false;
            if(_disabledBead == null){ //Not bead in mxml
                _disabledBead = loadBeadFromValuesManager(ComboBoxDisabled, "comboBoxDisabled", this) as ComboBoxDisabled; //Not bead in CSS
                if(_disabledBead == null)
                {
                    _disabledBead = new ComboBoxDisabled();
                    addBead(_disabledBead);
                }
            }
            //By default the Disabled bead is initialized to true. In this case, we force false.
            if(_disabledBead) 
                _disabledBead.disabled = _disabled;

            isCreateComplete = true;
            
            //When the dataProvider is set directly in the MXML Tag, at this point in the code, 
            //the dataProvider property of the model does not yet expose the set object and the 
            //emptyDisabled bead disables the control. To avoid this, we delay the check.
            setTimeout(updateDisabled,125);
        }

        private function loadTextTruncate():void
        {
            //Optional by tag or by Css
            loadBeadFromValuesManager(ComboBoxTruncateText, "comboBoxTruncateText", this);
        }

        private function loadTextPromp():void
        {
            //Opcionales por tag o por Css
            var textPromptBead:ComboBoxTextPrompt = loadBeadFromValuesManager(ComboBoxTextPrompt, "comboBoxTextPrompt", this) as ComboBoxTextPrompt;
            if(textPromptBead) textPromptBead.prompt = COMBO_BOX_TEXT_PROMPT;
        }

        /***************************************************************************************
         * activeSearch - SearchFilter bead
         */
        private var _activeSearch:Boolean;
        public function set activeSearch(value:Boolean):void
        {
            _activeSearch = value;
        }
        private function loadSearchText():void
        {
            if(_activeSearch)
            {
                var _searchTextBead:SearchFilterJwExt = loadBeadFromValuesManager(SearchFilterJwExt, "comboBoxSearchText", this) as SearchFilterJwExt;
                if(_searchTextBead == null)
                {
                    addBead(new SearchFilterJwExt());
                }
            }
        }

        /***************************************************************************************
         * activePopupControls - comboBoxListCloseOnClick bead (only if custom itemrenderer)
         * 
         * We load by default a custom ItemRenderer, to close the popup on click we must 
         * load the bead ComboBoxListCloseOnClick.
         * 
         ***************************************************************************************/
        private var _activePopupControls:Boolean = false;
        public function set activePopupControls(value:Boolean):void
        {
            _activePopupControls = value;
        }
        private function loadActivePopupControls():void
        {
            if(!_activePopupControls  && view)
            {
                var _clickBead:ComboBoxListCloseOnClick = loadBeadFromValuesManager(ComboBoxListCloseOnClick, "comboBoxListCloseOnClick", this) as ComboBoxListCloseOnClick;
                if(_clickBead == null)
                {
                    var customIt:Boolean = (itemRenderer!=null);
                    if(!customIt){
                        customIt = (ValuesManager.valuesImpl.getValue(view.host, "iItemRenderer") != null);
                        // Checking that the bead is applied to a Jewel ComboBox and has a custom item renderer assigned
                        if( customIt ){
                            _clickBead = new ComboBoxListCloseOnClick();
                            addBead(_clickBead);
                        }
                    }
                }
            }

        }

        /***************************************************************************************
         * emptyDisabled - disabled - ComboBoxDisabled bead
         */

        override public function set dataProvider(value:Object):void
        {
            //Piotr's recommendation - Direct setting instead of super.dataProvider = value
            IDataProviderModel(model).dataProvider = value;

            if(!isCreateComplete)
                return;

            if (!_disabledBead) return;
            if (!emptyDisabled) return;
            if (_disabled)      return;

            _disabledBead.disabled = (lengthDataProvider() <= 0);
        }

        private var _emptyDisabled:Boolean = true;
        public function get emptyDisabled():Boolean {
            return _disabledBead ? _emptyDisabled : false;
        }

        public function set emptyDisabled(value:Boolean):void
        {
            _emptyDisabled = value;

            if(!isCreateComplete)
                return;
                
            updateDisabled();
        }

        private var _disabled:Boolean = false;
        private var _disabledBead:ComboBoxDisabled;
        /**
         * Disabled-Bead. Direct setter
         * @return
         */
        public function get disabled():Boolean
        {
            return _disabledBead ?_disabledBead.disabled : _disabled;
        }

        public function set disabled(value:Boolean):void
        {
            if(!isCreateComplete)
                return;

            if(_disabled == value)
                return;

            _disabled = value;
            updateDisabled();
        }

        public function updateDisabled():void
        {
            if(!isCreateComplete)
                return;

            if(_disabled || (!_disabled && _disabledBead) || _emptyDisabled)
            {
                if(_disabledBead == null)
                {
                    _disabledBead = new ComboBoxDisabled();
                    addBead(_disabledBead);
                }
                _disabledBead.disabled = _disabled;
            }

            if(_emptyDisabled && !_disabled)
            {
                _disabledBead.disabled = (lengthDataProvider() <= 0);
            }
        }

        public function lengthDataProvider():int 
        {
            var size:int = 0
            if (IDataProviderModel(model).dataProvider) {
                if (IDataProviderModel(model).dataProvider is ArrayListView)
                    size = (IDataProviderModel(model).dataProvider as ArrayListView).list.length;
                else
                    size = (IDataProviderModel(model).dataProvider as IArrayList).length;
            }
            return size;
        }

        /***************************************************************************************
         * valueField - selectedValue - selectedChange
         */
        public function get valueField():String 
        {
            if(model is ISelectionByFieldModel)
                return ISelectionByFieldModel(model).valueField;
            else
                return "";
        }
        public function set valueField(value:String):void
        {
            if(model is ISelectionByFieldModel)
            {
                ISelectionByFieldModel(model).valueField = value;
            }
        }

        [Bindable("selectionChanged")]
		/**
		 *  The value of prop. valueField currently selected. Changing this value also
		 *  changes the selectedIndex and selectedItem properties.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.4
		 *  @royaleignorecoercion org.apache.royale.core.ISelectionModel
		 */
		public function get selectedValue():Object
		{
            if(model is ISelectionByFieldModel)
                return ISelectionByFieldModel(model).selectedValue;
            else
                return null;
		}
		public function set selectedValue(value:Object):void
		{
            if(model is ISelectionByFieldModel)
            {
                ISelectionByFieldModel(model).selectedValue = value;
            }
		}
        
		public function get selectedValueString():String
		{
            if(model is ISelectionByFieldModel)
            {
                if(ISelectionByFieldModel(model).selectedValue != null)
                    return ISelectionByFieldModel(model).selectedValue.toLocaleString();
                else
                    return '';
            }else
                return '';
		}
        
		public function get selectedLabel():String
		{
            if(selectedItem)
            {
				if (selectedItem is String) {
					return selectedItem.toString();
				} else {
					if(labelField){
                        return selectedItem[labelField].toString();
                    }else{
						return selectedItem[0].toString();
					}
				}
            }else
                return '';
		}

        public function reset():void
        {
            if(model is ISelectionByFieldModel)
            {
                ISelectionByFieldModel(model).selectedValue = null;
            }else{
                selectedItem = null;
                selectedIndex = -1;
            }
        }

        override public function dispatchEvent(event:Event):Boolean {
            return super.dispatchEvent(event);
        }

    }
}
