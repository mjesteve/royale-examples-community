
package org.apache.royale.community.jewel.beads.models
{
	import org.apache.royale.jewel.beads.models.ComboBoxModel;
	import org.apache.royale.collections.IArrayList;
	import mx.utils.ObjectUtil;

	/**
	 *  The ComboBoxModel class bead extends org.apache.royale.jewel.beads.models.ComboBoxModel (exenteds org.apache.royale.jewel.beads.models.ArrayListSelectionModel)
	 *  and adds the text being displayed by the org.apache.royale.jewel.ComboBox's input field.
	 * 
	 *  Custom getItemIndex function: objects are compared taking into account only Enumerable properties.
	 *  Calling functions overwritten: selectedItem, setDataProvider
	 *
	 *  @langversion 3.0
	 *  @playerversion Flash 10.2
	 *  @playerversion AIR 2.6
	 *  @productversion Royale 0.9.8
	 */
	public class ComboBoxModelJwExt extends ComboBoxModel
	{
		/**
		 *  constructor.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.8
		 */
		public function ComboBoxModelJwExt()
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
            	dispatchChange("selectionChanged");
				return;
			} 
            if (value == _selectedIndex) //Add
			{
				if (_selectedItem  != _dataProvider.getItemAt(_selectedIndex) )
				{
					_selectedItem = _dataProvider.getItemAt(_selectedIndex);
            		dispatchChange("selectionChanged");
				}
				return;
			}

            _selectedIndex = value < _dataProvider.length ? value : _dataProvider.length - 1;
            if (_selectedIndex != -1) {
                _selectedItem = _dataProvider.getItemAt(_selectedIndex);
            } else {
                _selectedItem = null;
            }

            dispatchChange("selectionChanged");
		}
		
		override public function set selectedItem(value:Object):void
		{

            if (value == _selectedItem) {
				if (_dataProvider) {
					// Change: (_selectedIndex != (_selectedIndex = _dataProvider.getItemIndex(value)))
					if (_selectedIndex != (_selectedIndex = getItemIndex(value))) {
                        dispatchChange("selectionChanged");
					}
				}
            } else {
                _selectedItem = value;
                if (_dataProvider) {
                    // Change: _selectedIndex = _dataProvider.getItemIndex(value);
                    _selectedIndex = getItemIndex(value);
                    dispatchChange("selectionChanged");
				}
			}
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

            return itemChanged;
		}

		/**
		 *  Fetches an item from the collection given an index. #ArrayList.getItemIndex
		 */
		public function getItemIndex(item:Object, strictEqualityCheck:Boolean = false):int
		{
			if(!_dataProvider || _dataProvider.length == 0)
				return -1;

			var props:Array = ObjectUtil.getEnumerableProperties(_dataProvider[0]);
			if(props.length == 0)
				return _dataProvider.getItemIndex(item);
				
			var propsItIn:Array = ObjectUtil.getEnumerableProperties(item);

			for (var idx:int; idx < _dataProvider.length; idx++)
			{
				var itdp:Object = _dataProvider[idx];				
				var isequal:Boolean = true;

				for each(var propIn:String in propsItIn)
				{					
					if(!itdp.hasOwnProperty(propIn))
					{
						isequal = false;
						break;
					}					
					if(!strictEqualityCheck && itdp[propIn] != item[propIn])
					{
						isequal = false;
						break;
					}
					if(strictEqualityCheck && itdp[propIn] !== item[propIn])
					{
						isequal = false;
						break;
					}					
				}
				if(isequal)
					return idx;
			}
			return -1;
		}

	}
}
