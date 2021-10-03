package org.apache.royale.community.jewel.beads.views
{
    import org.apache.royale.jewel.List;
    import org.apache.royale.jewel.VirtualList;
    import org.apache.royale.jewel.beads.views.VirtualComboBoxPopUpView;
    import org.apache.royale.jewel.supportClasses.combobox.ComboBoxPopUp;

    /**
	 *  The VirtualComboBoxPopUpViewJwExt class is a view bead for the VirtualComboBoxPopUp.
     * 
     *  This class creates a VirtualList that will be pop up when the combo box needs
     *  to show the associated list
     * 
     *  Test: override get list. Asign itemRenderer.
     * 
	 *  @viewbead	 
	 */
	public class VirtualComboBoxPopUpViewJwExt extends VirtualComboBoxPopUpView
	{
		/**
		 *  constructor
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.7
		 */
		public function VirtualComboBoxPopUpViewJwExt()
		{
			super();
		}
        
        override public function get list():List
        {
            if(!_list) {
                _list = new VirtualList();
				_list.addEventListener("beadsAdded", beadsAddedHandler);

                /* add in this extension */
                if((_strand as ComboBoxPopUp).itemRenderer)
                {
                    _list.itemRenderer = (_strand as ComboBoxPopUp).itemRenderer;
                }
            }
            return _list;
        }
    }
}