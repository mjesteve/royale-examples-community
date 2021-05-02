package org.apache.royale.community.jewel.beads.controllers
{
	import org.apache.royale.events.ItemClickedEvent;
	import org.apache.royale.utils.sendEvent;
	import org.apache.royale.jewel.beads.controllers.ListSingleSelectionMouseController;
	import org.apache.royale.jewel.beads.models.IJewelSelectionModel;

    /**
     *  The Jewel ListSingleSelectionMouseController class is a controller for
     *  org.apache.royale.jewel.List.
     *
     *  Controllers watch for events from the interactive portions of a View and
     *  update the data model or dispatch a semantic event.
     *  This controller watches for events from the item renderers
     *  and updates an ISelectionModel (which only supports single
     *  selection).  Other controller/model pairs would support
     *  various kinds of multiple selection.
     *
     *  Jewel controller takes into account if the component
     *
     *  @langversion 3.0
     *  @playerversion Flash 10.2
     *  @playerversion AIR 2.6
     *  @productversion Royale 0.9.4
     */
	public class ListSingleSelectionMouseControllerJwExt extends org.apache.royale.jewel.beads.controllers.ListSingleSelectionMouseController
	{
        /**
         *  Constructor.
         *
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion Royale 0.9.4
         */
		public function ListSingleSelectionMouseControllerJwExt()
		{
			super();
		}

        // identify when the selection is from a user click or when is programatically
		override protected function selectedHandler(event:ItemClickedEvent):void
		{
            if(listModel.selectedIndex != event.index || listModel.selectedItem != event.data){

                if(listModel is IJewelSelectionModel)
                    (listModel as IJewelSelectionModel).isItemClicked = true;
                listModel.selectedIndex = event.index;
                listModel.selectedItem = event.data;
                sendEvent(listView.host, "change");
                if(listModel is IJewelSelectionModel)
                    (listModel as IJewelSelectionModel).isItemClicked = false;
            }
		}

	}
}
