package org.apache.royale.community.jewel.beads.views
{
	COMPILE::JS
    {
	import org.apache.royale.core.IStyledUIBase;
	}
	import org.apache.royale.core.IIndexedItemRenderer;
	import org.apache.royale.core.IItemRenderer;
	import org.apache.royale.core.IRollOverModel;
	import org.apache.royale.core.ISelectableItemRenderer;
	import org.apache.royale.core.ISelectionModel;
	import org.apache.royale.core.IStrand;
	import org.apache.royale.core.IStrandWithModel;
	import org.apache.royale.html.beads.VirtualDataContainerView;
	import org.apache.royale.jewel.beads.models.ListPresentationModel;
	import org.apache.royale.jewel.beads.views.IScrollToIndexView;
	import org.apache.royale.jewel.supportClasses.list.IListPresentationModel;
	import org.apache.royale.jewel.supportClasses.scrollbar.ScrollingViewport;
	import org.apache.royale.events.Event;
	import org.apache.royale.events.KeyboardEvent;
	import org.apache.royale.events.utils.NavigationKeys;
	import org.apache.royale.utils.getSelectionRenderBead;
	import org.apache.royale.events.IEventDispatcher;
	import org.apache.royale.core.IDataProviderVirtualItemRendererMapper;
	import org.apache.royale.events.ItemRendererEvent;
	import org.apache.royale.core.ILayoutView;
	import org.apache.royale.core.ILayoutParent;
	import org.apache.royale.core.IListWithPresentationModel;
	import org.apache.royale.utils.sendStrandEvent;
	import org.apache.royale.jewel.beads.models.IJewelSelectionModel;

	/**
	 *  The VirtualListView class creates the visual elements of the org.apache.royale.jewel.List
	 *  component in a way that can be recicled to reuse as the user scrolls the list getting performance improvements
	 *  when dataproviders with lots of items are passed to the component. In This way Royale just create a few 
	 *  item renderers visible for the user, instead of one renderer for each item in the data provider. 
	 *   
	 *  A List consists of the area to display the data (in the dataGroup), any
	 *  scrollbars, and so forth.
	 *
	 *  @viewbead
	 *  @langversion 3.0
	 *  @playerversion Flash 10.2
	 *  @playerversion AIR 2.6
	 *  @productversion Royale 0.9.7
	 */
	COMPILE::JS
	public class VirtualListView extends VirtualDataContainerView implements IScrollToIndexView
	{
		public function VirtualListView()
		{
			super();
		}

		/**
		 *  @copy org.apache.royale.core.IBead#strand
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.10
		 */
		override public function set strand(value:IStrand):void
		{
			_strand = value;
			super.strand = value;
		}
        
		protected var listModel:ISelectionModel;

		protected var lastSelectedIndex:int = -1;

		override protected function handleInitComplete(event:Event):void
		{
			listModel = (_strand as IStrandWithModel).model as ISelectionModel;
			listModel.addEventListener("selectionChanged", selectionChangeHandler);
			listModel.addEventListener("rollOverIndexChanged", rollOverIndexChangeHandler);
			listModel.addEventListener("popUpCreated", itemsCreatedHandler);
			
			super.handleInitComplete(event);
			//----
			var mapper:IEventDispatcher = _strand.getBeadByType(IDataProviderVirtualItemRendererMapper) as IEventDispatcher;
			mapper.addEventListener(ItemRendererEvent.CREATED, itemCreatedHandler);
			//----
		}

		/**
		 * @private
		 * Ensure the list selects the selectedItem if some is set by the user at creation time
		 */
		override protected function itemsCreatedHandler(event:Event):void
		{
			//super.itemsCreatedHandler(event);
		 	if(listModel.selectedIndex != -1)
			{
				if( scrollToIndex(listModel.selectedIndex) )
					sendStrandEvent(_strand,"layoutNeeded");
		 		selectionChangeHandler(new Event(''));
			}
		 }

		protected function itemCreatedHandler(event:ItemRendererEvent):void
		{
			trace("itemCreatedHandler-lastSelectedIndex:", lastSelectedIndex);
			trace("itemCreatedHandler-listModel.selectedIndex:", listModel.selectedIndex);

			/*if(listModel.selectedIndex == -1)
				return;
			*/
			var selectionBead:ISelectableItemRenderer;
			var ir:IIndexedItemRenderer = event.itemRenderer as IIndexedItemRenderer;
			trace("index:", ir.index);
			/*if (ir.index == listModel.selectedIndex)
			{
				selectionBead = getSelectionRenderBead(ir);
				if (selectionBead)
					selectionBead.selected = true;
			}*/
		}

		protected var firstElementIndex:int = 1;
		/**
		 * Retrieve the renderer for a given index
		 * @royaleignorecoercion org.apache.royale.core.IIndexedItemRenderer
		 * @royaleignorecoercion org.apache.royale.core.IItemRenderer
		 */
		override public function getItemRendererForIndex(index:int):IItemRenderer
		{
			if (contentView.numElements == 0)
				return null;
			
            var itemRenderer:IIndexedItemRenderer = contentView.getElementAt(firstElementIndex) as IIndexedItemRenderer;
            if (itemRenderer == null)
                return null;

			var firstIndex:int = itemRenderer.index;
			
			if (index < firstIndex) 
				return null;
			//if (index >= (firstIndex + contentView.numElements))
            if (index >= (firstIndex + contentView.numElements - firstElementIndex)) 
				return null;
				
			return contentView.getElementAt(index - firstIndex + firstElementIndex) as IItemRenderer;			
		}
		
		/**
		 * @private
		 * @royaleignorecoercion org.apache.royale.core.IItemRenderer
		 */
		protected function selectionChangeHandler(event:Event):void
		{
			trace('selectionChangeHandler-lastSelectedIndex',lastSelectedIndex);
			trace('selectionChangeHandler-listModel.selectedIndex',listModel.selectedIndex);
			var selectionBead:ISelectableItemRenderer;
			var ir:IItemRenderer = lastSelectedIndex == -1 ? null : dataGroup.getItemRendererForIndex(lastSelectedIndex);
			if(!ir){
				itemClickedAction();
				ir = lastSelectedIndex == -1 ? null : dataGroup.getItemRendererForIndex(lastSelectedIndex);
			}				
			if (ir) 
			{
				selectionBead = getSelectionRenderBead(ir);
				if (selectionBead)
					selectionBead.selected = false;
			}

			lastSelectedIndex = listModel.selectedIndex;
			itemClickedAction();
			
			ir = lastSelectedIndex == -1 ? null : dataGroup.getItemRendererForIndex(lastSelectedIndex);	
			if (ir) 
			{
				selectionBead = getSelectionRenderBead(ir);
				if (selectionBead)
					selectionBead.selected = true;
			}
		}

		/**
		 * if the selection was not from a user click selection, then scrol to index
		 */
		protected function itemClickedAction():void
		{
			if( (listModel is IJewelSelectionModel && !(listModel as IJewelSelectionModel).isItemClicked)
			|| !(listModel is IJewelSelectionModel) )
			{
				if(scrollToIndex(lastSelectedIndex))
					sendStrandEvent(_strand,"layoutNeeded");
			}
		}

		protected var lastRollOverIndex:int = -1;

		/**
		 * @private
		 * @royaleignorecoercion org.apache.royale.core.IIndexedItemRenderer
		 * @royaleignorecoercion org.apache.royale.core.IRollOverModel
		 */
		protected function rollOverIndexChangeHandler(event:Event):void
		{
			var selectionBead:ISelectableItemRenderer;
			var ir:IItemRenderer = (lastRollOverIndex == -1) ? null : dataGroup.getItemRendererForIndex(lastRollOverIndex);			
			if (ir) 
			{
				selectionBead = getSelectionRenderBead(ir);
				if (selectionBead)
					selectionBead.hovered = false;
			}
			ir = (listModel as IRollOverModel).rollOverIndex == -1 ? null : dataGroup.getItemRendererForIndex((listModel as IRollOverModel).rollOverIndex);		 	
			if (ir) {
				selectionBead = getSelectionRenderBead(ir);
				if (selectionBead)
					selectionBead.hovered = true;
			}
			lastRollOverIndex = (listModel as IRollOverModel).rollOverIndex;
			
			//selectionChangeHandler(null);
		}

		override protected function dataProviderChangeHandler(event:Event):void
		{

		}

		public function get scrollViewport():ScrollingViewport
		{
			return viewport as ScrollingViewport;
		}
		/**
		 *  Ensures that the data provider item at the given index is visible.
		 *  
		 *  If the item is visible, the <code>verticalScrollPosition</code>
		 *  property is left unchanged even if the item is not the first visible
		 *  item. If the item is not currently visible, the 
		 *  <code>verticalScrollPosition</code>
		 *  property is changed make the item the first visible item, unless there
		 *  aren't enough rows to do so because the 
		 *  <code>verticalScrollPosition</code> value is limited by the 
		 *  <code>maxVerticalScrollPosition</code> property.
		 *
		 *  @param index The index of the item in the data provider.
		 *
		 *  @return <code>true</code> if <code>verticalScrollPosition</code> changed.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 9
		 *  @playerversion AIR 1.1
		 *  @productversion Royale 0.9.7
		 */
		public function scrollToIndex(index:int):Boolean
		{
			if (index == -1) return false;
			
			var contentView:ILayoutView = (host as ILayoutParent).getLayoutHost().contentView;
			var scrollArea:HTMLElement = (_strand as IStyledUIBase).element;

			if((_strand as IStyledUIBase).containsClass("horizontal"))
			{
				// need to be implemented
				return false;
			}else
			{
            	var pm:IListPresentationModel = (_strand as IListWithPresentationModel).presentationModel as IListPresentationModel;
				if(pm.variableRowHeight)
				{
					// need to be implemented
					//return false;
				}

				//var oldScroll:Number = Math.max(contentView.element.scrollTop, 0);
				//var scrollMaxVisible:Number = contentView.height;
				//		var scrollMinVisible:Number = Math.max(scrollArea.scrollTop - rowHeight,0);
				var oldScroll:Number = Math.max(scrollArea.scrollTop, 0);				
				var rowHeight:Number = isNaN(pm.rowHeight) ? ListPresentationModel.DEFAULT_ROW_HEIGHT : pm.rowHeight;
				var totalHeight:Number = (listModel.dataProvider.length * rowHeight) - scrollArea.clientHeight + rowHeight;
				trace("totalHeight:", totalHeight);
				trace("oldScroll:", oldScroll);

				var scrollToProposed:Number = index * rowHeight;
				var scrollMinVisible:Number = scrollArea.scrollTop;
				var scrollMaxVisible:Number = scrollArea.scrollTop + scrollArea.offsetHeight - rowHeight;
				trace("scrollToProposed index:", scrollToProposed, index);
				trace("scrollMaxVisible:", scrollMaxVisible);
				trace("scrollMinVisible:", scrollMinVisible);
				if(scrollMaxVisible < 0)
					return false;
				//some page
				//When a row starts within the visible area but ends outside:
				if(scrollToProposed-rowHeight >= scrollMinVisible && scrollToProposed+rowHeight <= scrollMaxVisible)
					return false;

				//When a row starts within the visible area but ends outside:
				trace("scrollToProposed:", scrollToProposed);
				trace("scrollMaxVisible:", scrollMaxVisible);
				trace("scrollMinVisible:", scrollMinVisible);

				if(scrollToProposed == 0 && oldScroll != 0)
				{
					scrollArea.scrollTop = scrollToProposed;					
				}
				else if(scrollToProposed < scrollMaxVisible && scrollToProposed+rowHeight > scrollMaxVisible)
				{
					//If we want to respect the default behavior (position the selected row as the first visible), the next two lines should be canceled
					//We adjust the scroll so that the row is fully visible, leaving it as the last visible...
					var offset:Number = scrollMaxVisible - scrollToProposed;
					scrollToProposed = oldScroll + rowHeight - offset;
					scrollArea.scrollTop = Math.min(scrollToProposed, totalHeight);
				}
				else if(scrollToProposed >= scrollMaxVisible)
				{
					scrollArea.scrollTop = Math.min(scrollToProposed-rowHeight, totalHeight);
				}
				else if(scrollToProposed-rowHeight < scrollMinVisible)
				{
					scrollArea.scrollTop = Math.max(scrollToProposed-rowHeight, 0);
				}

				return oldScroll != scrollArea.scrollTop;
				
			}

		}

	}

}
