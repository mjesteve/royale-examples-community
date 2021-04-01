
package org.apache.royale.community.jewel.beads.models
{
	import org.apache.royale.community.beads.models.ISelectionByFieldModel;
	import org.apache.royale.collections.CollectionUtils;
  	import org.apache.royale.collections.ICollectionView;
	import org.apache.royale.community.jewel.beads.models.ComboBoxModelJwExt;
	import org.apache.royale.collections.IArrayList;
	import mx.utils.ObjectUtil;
	/**
	 *  The ComboBoxByFieldModel class bead extends extends org.apache.royale.community.jewel.beads.models.ComboBoxModelJwExt
	 *  and adds the valueField and selectedValue properties.
	 *
	 *  @langversion 3.0
	 *  @playerversion Flash 10.2
	 *  @playerversion AIR 2.6
	 *  @productversion Royale 0.9.8
	 */
	public class ComboBoxByFieldModel extends ComboBoxModelJwExt implements ISelectionByFieldModel
		{
		/**
		 *  constructor.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.8
		 */
		public function ComboBoxByFieldModel()
		{
		}

		override public function set selectedIndex(value:int):void
		{
            if (!_dataProvider) {
                _selectedIndex = value;
                return;
            }

            if (value == -1) //Add
			{
                _selectedIndex = value;
				_selectedItem = null;
			}
			else if (value == _selectedIndex) //Add
			{
				if (_selectedItem  != _dataProvider.getItemAt(_selectedIndex) )
					_selectedItem = _dataProvider.getItemAt(_selectedIndex);
				else
					return;
			}else
			{
				_selectedIndex = value < _dataProvider.length ? value : _dataProvider.length - 1;
				if (_selectedIndex != -1)
					_selectedItem = _dataProvider.getItemAt(_selectedIndex);
				else
					_selectedItem = null;
			}

			if(_valueField != "" && _selectedItem)
				_selectedValue = _selectedItem[_valueField];
			else
				_selectedValue = null;

            dispatchChange("selectionChanged");
		}

		override public function set selectedItem(value:Object):void
		{
			var itemChanged:Boolean;

            if (value == _selectedItem) {
				if (_dataProvider) {
					// Change: (_selectedIndex != (_selectedIndex = _dataProvider.getItemIndex(value)))
					if (_selectedIndex != (_selectedIndex = getItemIndex(value))) {
                        itemChanged = true;
					}
				}
            } else {
                _selectedItem = value;
                if (_dataProvider) {
                    // Change: _selectedIndex = _dataProvider.getItemIndex(value);
                    _selectedIndex = getItemIndex(value);
                    itemChanged = true;
				}
			}

			if(_valueField != "")
			{
				var selval:Object = null;
				if(_selectedItem)
					selval = _selectedItem[_valueField];

				if(selval != _selectedValue)
				{
					_selectedValue = selval;
					itemChanged = true;
				}
			}

			if(itemChanged)
                dispatchChange("selectionChanged");
		}

		override public function setDataProvider(value:Object):Boolean
		{
            _dataProvider = value as IArrayList;

            var itemChanged:Boolean;

			if (_dataProvider) {
                if (_selectedItem) {
					//Change: _selectedIndex = _dataProvider.getItemIndex(_selectedItem);
                    _selectedIndex = getItemIndex(_selectedItem);

                    if (_selectedIndex == -1) {
                        _selectedItem = null;
                        itemChanged = true;
                    }
                } else {
                    if (_selectedIndex != -1) {
                        if (_selectedIndex < _dataProvider.length) {
                            _selectedItem = _dataProvider.getItemAt(_selectedIndex);
                            itemChanged = true;
                        } else {
                            _selectedIndex = -1;
							_selectedItem = null;
                        }
                    }
                }

            } else {
                itemChanged = _selectedItem != null;
                _selectedItem = null;
                _selectedIndex = -1;
            }

			if(_valueField != "" && itemChanged)
			{
				var selval:Object = null;
				if(_selectedItem)
					selval = _selectedItem[_valueField];

				if(selval != _selectedValue)
				{
					_selectedValue = selval;
					itemChanged = true;
				}
			}

            return itemChanged;
		}

		private var _valueField:String = "";
        /**
         *  @copy org.apache.royale.community.beads.models.ISelectionByFieldModel#valueField
         *
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion Royale 0.9.8
         */
        public function get valueField():String {
            return _valueField;;
        }
        public function set valueField(value:String):void {
            _valueField = value || "";
        }

		protected var _selectedValue:Object;
        /**
         *  @copy org.apache.royale.community.beads.models.ISelectionByFieldModel#selectedValue
         *
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion Royale 0.9.8
         */
        //[Bindable("selectedValueChange")]
		public function get selectedValue():Object
		{
            return _selectedValue;
		}
		public function set selectedValue(value:Object):void
		{
			if(_valueField == "")
				return;

			var aux:* = null;
			if(value != null)
			{
				aux = CollectionUtils.getItemByField(dataProvider as ICollectionView,_valueField,value);
			}

			if(aux == null){
				selectedItem = null;
				selectedIndex = -1;
				_selectedValue = null;
			}
			else if (aux !== selectedItem){
            	_selectedValue = value;
				selectedItem = aux;
			}

		}

	}
}