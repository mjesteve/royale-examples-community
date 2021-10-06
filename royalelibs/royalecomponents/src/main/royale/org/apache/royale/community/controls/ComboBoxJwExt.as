package org.apache.royale.community.controls {

    import org.apache.royale.collections.ArrayListView;
    import org.apache.royale.collections.IArrayList;
    import org.apache.royale.core.IDataProviderModel;
    import org.apache.royale.core.ClassFactory;
    import org.apache.royale.core.ValuesManager;
    import org.apache.royale.events.Event;
    import org.apache.royale.jewel.ComboBox;
    import org.apache.royale.jewel.beads.controls.combobox.ComboBoxDisabled;
    import org.apache.royale.jewel.beads.controls.combobox.ComboBoxListCloseOnClick;
    import org.apache.royale.jewel.beads.controls.combobox.ComboBoxTextPrompt;
    import org.apache.royale.jewel.beads.controls.combobox.ComboBoxTruncateText;
    import org.apache.royale.utils.loadBeadFromValuesManager;

    import org.apache.royale.community.beads.models.ISelectionByFieldModel;
    import org.apache.royale.community.itemRenderers.LabelTruncateItemRenderer;
    import org.apache.royale.community.jewel.beads.controls.combobox.SearchFilterJwExt;
    import org.apache.royale.community.jewel.beads.controls.combobox.ComboBoxReadOnly;

	[Event(name="selectedValueChange", type="org.apache.royale.events.Event")]
    /**
     * Extension the Jewel ComboBox.
     *
     * - New emptyDisabled property to indicate whether to disable the component if there is no data.
     * - New property 'disabled'. Enable or disable the control.
     *      The ComboBoxDisabled bead is automatically loaded.
     * - Automatically loads the ComboBoxTruncateText bead.     *
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

            loadTextPromp();
            loadTextTruncate();
            loadActivePopupControls();
            loadSearchText();
            loadEmptyBead();
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

        /***************************************************************************************
         * itemRendererTruncateByDefault - 
         */
        private var _itemRendererTruncateByDefault:Boolean=false;
        public function set itemRendererTruncateByDefault(value:Boolean):void
        {
            _itemRendererTruncateByDefault = value;
            // The pseudo-class css itemrenderertruncate has the IItemRenderer assigned to it.
            // It adds the css selector but does not recognise the IItemRenderer assigned by ClassReference.
            //if(value)
            //{
            //    addClass('itemrenderertruncate');
            //}
        }

        override protected function loadBeads():void
        {
            // We must assign the itemRenderer to the control before loading the IBeadView bead.
            if(_itemRendererTruncateByDefault)
            {
                //it works.
                //This option may not be ideal because even if the itemrenderer is different, references to LabelTruncateItemRenderer will still be needed.
                itemRenderer = new ClassFactory(LabelTruncateItemRenderer);
                
                //This option does not work. Any style specified in the css class is recognised but the IItemRenderer is not obtained.
                //This is perhaps the best option. No dependency is loaded until an itemRenderer is assigned.
                //addClass('itemrenderertruncate'); 
                activePopupControls = false;
            }
            super.loadBeads();
        }

        /***************************************************************************************
         * activeTextPromp - ComboBoxTextPrompt bead
         */
        private var _activeTextPromp:Boolean;
        public function set activeTextPromp(value:Boolean):void
        {
            _activeTextPromp = value;
        }

        private var _textPrompt:String = COMBO_BOX_TEXT_PROMPT;
        public function get textPrompt():String{ return _textPrompt; }
        public function set textPrompt(value:String):void
        {
            _textPrompt = value; 
            if(_activeTextPromp && textPromptBead)
                textPromptBead.prompt = _textPrompt;
        }

        private var textPromptBead:ComboBoxTextPrompt;
        private function loadTextPromp():void
        {
            if(_activeTextPromp)
            {               
                //Opcionales por tag o por Css
                textPromptBead = loadBeadFromValuesManager(ComboBoxTextPrompt, "comboBoxTextPrompt", this) as ComboBoxTextPrompt;
                if(textPromptBead == null)
                {
                    textPromptBead = new ComboBoxTextPrompt;
                    addBead(textPromptBead);
                }
                textPromptBead.prompt = _textPrompt;
            }
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
         * activePopupControls - comboBoxListCloseOnClick bead 
         * 
         * We load by default a custom ItemRenderer, to close the popup on click we must 
         * load the bead ComboBoxListCloseOnClick.
         * 
         ***************************************************************************************/
        private var _activePopupControls:Boolean = true;
        public function set activePopupControls(value:Boolean):void
        {
            _activePopupControls = value;
        }
        private function loadActivePopupControls():void
        {
            if(!_activePopupControls || _itemRendererTruncateByDefault)
            {
                //If the itemRenderer is read-only, clicking on any graphical part should trigger the click and close the popup.
                var _clickBead:ComboBoxListCloseOnClick = loadBeadFromValuesManager(ComboBoxListCloseOnClick, "comboBoxListCloseOnClick", this) as ComboBoxListCloseOnClick;
                if(_clickBead == null)
                {
                    var customIt:Boolean = (itemRenderer!=null);
                    if(!customIt){
                        customIt = (ValuesManager.valuesImpl.getValue(this, "iItemRenderer") != null);
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

            if (!_disabledBead && !_readOnlyBead) return;
            if (!_emptyDisabled && !_emptyReadOnly) return;
            if (_disabled) return;

            if(_emptyDisabled)
                _disabledBead.disabled = (lengthDataProvider() <= 0);
            else if(_emptyReadOnly)
                _readOnlyBead.readOnly = (lengthDataProvider() <= 0);
        }

        private var _emptyDisabled:Boolean = false;
        /* public function get emptyDisabled():Boolean {
            return _disabledBead ? _emptyDisabled : false;
        } */

        public function set emptyDisabled(value:Boolean):void
        {
            _emptyDisabled = value;
            if(!isCreateComplete)
                return;                
            updateDisabled();
        }

        private var _emptyReadOnly:Boolean = false;
        /* public function get emptyReadOnly():Boolean {
            return _disabledBead ? _emptyReadOnly : false;
        } */

        public function set emptyReadOnly(value:Boolean):void
        {
            _emptyReadOnly = value;
            if(!isCreateComplete)
                return;                
            updateDisabled();
        }

        private var _disabled:Boolean = false;
        private var _disabledBead:ComboBoxDisabled;
        private var _readOnlyBead:ComboBoxReadOnly;
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

            if( _disabled || 
                (!_disabled && _disabledBead)  || 
                (!_disabled && _readOnlyBead) || 
                _emptyDisabled || _emptyReadOnly )
            { 
                if(_emptyDisabled){
                    if( _disabledBead == null)
                    {
                        _disabledBead = new ComboBoxDisabled();
                        addBead(_disabledBead);
                    }
                    _disabledBead.disabled = _disabled;
                }
                else if(_emptyReadOnly) 
                {
                    if( _readOnlyBead == null)
                    {
                        _readOnlyBead = new ComboBoxReadOnly();
                        addBead(_readOnlyBead);
                    }
                    _readOnlyBead.readOnly = _disabled;
                }
            }

            if( (_emptyDisabled || _emptyReadOnly) && !_disabled)
            {
                if(_emptyDisabled)
                    _disabledBead.disabled = (lengthDataProvider() <= 0);
                else if(_emptyReadOnly)
                    _readOnlyBead.readOnly = (lengthDataProvider() <= 0);
            }
        }

        private function loadEmptyBead():void
        {
			_disabled = false;
            _disabledBead = loadBeadFromValuesManager(ComboBoxDisabled, "comboBoxDisabled", this) as ComboBoxDisabled;
            if(_disabledBead == null && _emptyDisabled)
            {
                _disabledBead = new ComboBoxDisabled();
                addBead(_disabledBead);
            }
            //By default the Disabled bead is initialized to true. In this case, we force false.
            if(_disabledBead) 
                _disabledBead.disabled = _disabled;
            else
            {
                _readOnlyBead = loadBeadFromValuesManager(ComboBoxReadOnly, "comboBoxReadOnly", this) as ComboBoxReadOnly;
                if(_readOnlyBead == null && _emptyReadOnly) 
                {
                    _readOnlyBead = new ComboBoxReadOnly();
                    addBead(_readOnlyBead);                
                }
                if(_readOnlyBead)                    
                    _readOnlyBead.readOnly = _disabled;

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
            if(model is ISelectionByFieldModel && valueField != "")
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
