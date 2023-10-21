
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
			if(!_dataProvider || _dataProvider.length == 0 || item == null)
				return -1;

			for (var idx:int, lendp:int = _dataProvider.length; idx < lendp; idx++)
			{
				var itdp:Object = _dataProvider[idx];				
				if( ObjectUtil.compare(item,itdp) == 0)
					return idx;
			}
			return -1;
		}

		/*public function getItemIndex(item:Object, strictEqualityCheck:Boolean = false):int
		{
			if(!_dataProvider || _dataProvider.length == 0 || item == null)
				return -1;

			var props:Array, propsItIn:Array;
			//0: dynamic object, 1: typing object
			var typeItDP:int=-1;
			var typeItIn:int=-1;
			trace( "isPrototypeOf(item)",isPrototypeOf(item), "item.__proto__.ROYALE_CLASS_INFO", item.__proto__.ROYALE_CLASS_INFO );
			
			typeItIn = item.__proto__.ROYALE_CLASS_INFO == undefined ? 0:1;
			props = ObjectUtil.getEnumerableProperties(item);
			if(props.length == 0)
			{
				if(item.__proto__.ROYALE_CLASS_INFO == undefined)
					return _dataProvider.getItemIndex(item);
				else
					props = item.__proto__.ROYALE_CLASS_INFO.localTraits.props;

				if(props.length == 0)
					return _dataProvider.getItemIndex(item);

			}

			typeItDP = _dataProvider[0].__proto__.ROYALE_CLASS_INFO == undefined ? 0:1;
			propsItIn = ObjectUtil.getEnumerableProperties(_dataProvider[0]);
			if(propsItIn.length == 0)
			{
				if(_dataProvider[0].__proto__.ROYALE_CLASS_INFO == undefined)
					return _dataProvider.getItemIndex(item);
				else
					propsItIn = _dataProvider[0].__proto__.ROYALE_CLASS_INFO.localTraits.props;

				if(propsItIn.length == 0)
					return _dataProvider.getItemIndex(item);

			}

			for (var idx:int, lendp:int = _dataProvider.length; idx < lendp; idx++)
			{
				var itdp:Object = _dataProvider[idx];				
				var isequal:Boolean = true;
				var npNoPrim:int = 0;

				for (var idxprop:int, lenprops:int = propsItIn.length; idxprop < lenprops; idxprop++)
				{
					var propIn:String = propsItIn[idxprop] as String;

					var theType:String = typeof item[propIn];
					trace( propIn, "Type",theType );
					if( (theType==="object" && !(item[propIn] is Date)) || theType==="function" ){
						npNoPrim++;
						continue;
					}

					if(props.indexOf(propIn) == -1)
					{
						isequal = false;
						break;
					}
					if(item[propIn] is Date || itdp[propIn] is Date)
					{
						if( ObjectUtil.dateCompare(itdp[propIn] as Date,item[propIn] as Date) != 0 )
						{
							isequal = false;
							break;
						}
					}else{
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
				}
				if(isequal){
					if(npNoPrim == propsItIn.length)
						return _dataProvider.getItemIndex(item);

					return idx;
				}
			}
			return -1;
		}*/

	}
}
