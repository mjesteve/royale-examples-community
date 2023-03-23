package org.apache.royale.community.jewel.beads.controls.combobox
{
    import org.apache.royale.core.DispatcherBead;
    import org.apache.royale.core.IStrand;
    import org.apache.royale.core.ValuesManager;
    import org.apache.royale.events.IEventDispatcher;
    import org.apache.royale.events.MouseEvent;
    import org.apache.royale.jewel.ComboBox;
    import org.apache.royale.jewel.List;
    import org.apache.royale.jewel.beads.controls.combobox.IComboBoxView;
    import org.apache.royale.core.IStrandWithModelView;
    import org.apache.royale.jewel.beads.views.ComboBoxPopUpView;

    /**
	 *  The ComboBoxListCloseOnClick bead class is a specialty bead that can be used with
     *  a Jewel ComboBox with a custom renderer to allow closing the popup list in when click renderer.
     *  
     *  The default combobox has just a label and the list is closed on click. A Custom renderer
     *  doesn't close by default (we can have complex items with inputs and other controls that we want to clisk and operate),
     *  os is up to the developer add this bead if wants to close the popup list on click
	 *
	 *  @langversion 3.0
	 *  @playerversion Flash 10.2
	 *  @playerversion AIR 2.6
	 *  @productversion Royale 0.9.8
	 */
    public class ComboBoxListCloseOnClick extends DispatcherBead {

        /**
		 *  constructor.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.8
		 */
        public function ComboBoxListCloseOnClick(){
        }

        private var _list:List;
        private var comboView:IComboBoxView;
        
        public override function set strand(value:IStrand):void
		{
            super.strand = value;

            var comboBox:ComboBox = (value as ComboBox);
            comboView = (comboBox.view as IComboBoxView);
            var itemRendererClass:Class = ValuesManager.valuesImpl.getValue(value, "iItemRenderer") as Class;
            // Checking that the bead is applied to a Jewel ComboBox and has a custom item renderer assigned
            if (comboView && (comboBox.itemRenderer || itemRendererClass != null)){
                (value as IEventDispatcher).addEventListener('popUpOpened', popUpOpenedHandler, false);
                (value as IEventDispatcher).addEventListener('popUpClosed', popUpClosedHandler, false);
            }
		}

        protected function popUpOpenedHandler():void {
			list = ((comboView.popup as IStrandWithModelView).view as ComboBoxPopUpView).list;
		}

		protected function popUpClosedHandler():void {
			list = null;
		}

        [Bindable]
		public function get list():List
		{
			return _list;
		}
        public function set list(value:List):void
        {
            _list = value;
            COMPILE::JS
			{
			if (list != null)
	            list.addEventListener(MouseEvent.CLICK, onListClick);
            }
        }

        private function onListClick(event:MouseEvent):void
        {
			list.removeEventListener(MouseEvent.CLICK, onListClick);
            comboView.popUpVisible = false;
        }
        
    }
}