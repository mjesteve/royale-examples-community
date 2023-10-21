package org.apache.royale.community.controls
{
	import org.apache.royale.jewel.supportClasses.scrollbar.ScrollingViewport;
	import org.apache.royale.jewel.VirtualList
	import org.apache.royale.community.jewel.beads.views.VirtualListView;
	import org.apache.royale.jewel.supportClasses.combobox.IComboBoxPresentationModel;
	import org.apache.royale.html.util.getModelByType;
	import org.apache.royale.jewel.beads.models.ComboBoxPresentationModel;
	import org.apache.royale.jewel.supportClasses.list.IListPresentationModel;
	import org.apache.royale.jewel.beads.models.ListPresentationModel;

	public class VirtualListJwExt extends org.apache.royale.jewel.VirtualList
	{
		/**
		 *  constructor.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.4
		 */
		public function VirtualListJwExt()
		{
			super();
            addEventListener("beadsAdded", beadsAddedHandler);
        }

        private function beadsAddedHandler(event:Event):void
        {
			removeEventListener("beadsAdded", beadsAddedHandler);
			/*if (presentationModel != null) {
                (presentationModel as IListPresentationModel).variableRowHeight = false;
			}*/
			
			/*if( _observerScrollBar)
			{
				var bo:ObserverVerticalScrollBa = loadBeadFromValuesManager(ObserverVerticalScrollBar, "", this) as ObserverVerticalScrollBar;
				if( !bo )
				{
					bo = new ObserverVerticalScrollBar;
					addBead(bo);
				}
				
			}*/
        }

		public function get scrollViewport():ScrollingViewport
		{
			return (view as VirtualListView).scrollViewport;
		}

		private var _observerScrollBar:Boolean;
		public function get observerScrollBar():Boolean{ return _observerScrollBar; }
		public function set observerScrollBar(value:Boolean):void
		{ 
			_observerScrollBar = value; 
		}

	}
}
