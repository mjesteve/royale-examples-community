package org.apache.royale.community.views.draganddrop.supportClasses
{

    import org.apache.royale.events.Event;
    import org.apache.royale.community.views.draganddrop.vos.CTypeDragDropDisplay;

    public class DragDropItemEvent extends Event
    {
		public static const SET_SELECTED:String = "setSelected";

        public function DragDropItemEvent(type:String, selectedDragDropario:CTypeDragDropDisplay=null)
        {
			super(type, true, true);
            this.selectedHorario = selectedHorario;
		}

        public var selectedHorario:CTypeDragDropDisplay;

    }

}