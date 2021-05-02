package org.apache.royale.community.jewel.beads.models
{
    
    import org.apache.royale.jewel.beads.models.ArrayListSelectionModel;

    public class ArrayListSelectionModelJwExt extends org.apache.royale.jewel.beads.models.ArrayListSelectionModel
    {
		/**
		 *  Constructor.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9
		 */
		public function ArrayListSelectionModelJwExt()
		{
		}
		
		/*
		override public function set selectedItem(value:Object):void
		{
            if (value == _selectedItem) {
				if (_dataProvider) {
					if (_selectedIndex != (_dataProvider.getItemIndex(value))) {
                        dispatchChange("selectionChanged");
					}
				}
            } else {
                _selectedItem = value;
                if (_dataProvider) {
                    _selectedIndex = _dataProvider.getItemIndex(value);
                    dispatchChange("selectionChanged");
                }
			}
		}
		*/
    }

}
