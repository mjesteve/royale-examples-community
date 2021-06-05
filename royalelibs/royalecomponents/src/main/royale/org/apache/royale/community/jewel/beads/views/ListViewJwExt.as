package org.apache.royale.community.jewel.beads.views
{
	COMPILE::SWF
	{
	import org.apache.royale.core.IStrand;
	}
	COMPILE::JS
    {
	import org.apache.royale.core.IStyledUIBase;
	}
	import org.apache.royale.core.IBeadLayout;
	import org.apache.royale.core.IItemRenderer;
	import org.apache.royale.core.UIBase;
	import org.apache.royale.jewel.beads.layouts.GapConstants;
	import org.apache.royale.jewel.beads.layouts.HorizontalLayout;
	import org.apache.royale.jewel.beads.models.ListPresentationModel;
	import org.apache.royale.jewel.beads.views.ListView;
	import org.apache.royale.jewel.supportClasses.list.IListPresentationModel;
	import org.apache.royale.jewel.supportClasses.scrollbar.ScrollingViewport;

	/**
	 *  The ListView class creates the visual elements of the org.apache.royale.jewel.List
	 *  component. A List consists of the area to display the data (in the dataGroup), any
	 *  scrollbars, and so forth.
	 *
	 *  ListViewJwExt is IBeanView to ListViewExt.
	 *  Added scrollViewport property to make the viewport private variable public.
	 * 
	 *  @viewbead
	 *  @langversion 3.0
	 *  @playerversion Flash 10.2
	 *  @playerversion AIR 2.6
	 *  @productversion Royale 0.9.4
	 */
	COMPILE::JS
	public class ListViewJwExt extends org.apache.royale.jewel.beads.views.ListView
	{
		public function ListViewJwExt()
		{
		}

		public function get scrollViewport():ScrollingViewport
		{
			return viewport as ScrollingViewport;
		}

		/**
		 *  Ensures that the data provider item at the given index is visible.
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
		override public function scrollToIndex(index:int):Boolean
		{
			if (index == -1) return false;
			
			var scrollArea:HTMLElement = (_strand as IStyledUIBase).element;
			var oldScroll:Number;
			var scrollToProposed:Number = 0;
			var scrollMaxVisible:Number = 0;
			var offset:Number = 0;

			if((_strand as IStyledUIBase).containsClass("horizontal"))
			{
                var layout:HorizontalLayout = (_strand as UIBase).getBeadByType(IBeadLayout) as HorizontalLayout;

				//[TODO] identify variableColWidth (itemExpand, itemsSpaceBetween, itemsSpaceAround, explicitHeight...)
				//At this point, the closest calculation is the actual sum = variableColWidht
				var variableColWidth:Boolean = true;

				oldScroll = scrollArea.scrollLeft;
				var totalWidth:Number = 0;
				var colWidth:Number = 0;
				var i:int = 0;
				
				if(variableColWidth)
				{
					totalWidth = scrollArea.scrollWidth - scrollArea.offsetWidth;
					for (i = 0; i <= index; i++)
					{
						var ir0:IItemRenderer = dataGroup.getItemRendererForIndex(i) as IItemRenderer;
						colWidth = ir0.element.offsetWidth + (layout.gap * GapConstants.GAP_STEP);
						if( i < index )
							scrollToProposed += colWidth;
					}
				} else 
				{
					//We could "assume" that the width of the first itemrenderer will give us the predefined width.
					var ir1:IItemRenderer = dataGroup.getItemRendererForIndex(0) as IItemRenderer;					
					colWidth = ir1.element.offsetWidth + (layout.gap * GapConstants.GAP_STEP);
					totalWidth = listModel.dataProvider.length * colWidth - scrollArea.clientWidth;
					scrollToProposed = index * colWidth;
				}

				scrollMaxVisible = scrollArea.scrollLeft + scrollArea.offsetWidth;
				if(scrollToProposed <= scrollMaxVisible && scrollToProposed+colWidth > scrollMaxVisible)
				{
					offset = scrollMaxVisible - scrollToProposed;
					scrollToProposed = oldScroll + colWidth - offset;
					scrollArea.scrollLeft = Math.min(scrollToProposed, totalWidth);
				}
				else if(scrollToProposed >= scrollMaxVisible || scrollToProposed < oldScroll)
				{
					scrollArea.scrollLeft = Math.min(scrollToProposed, totalWidth);
				}

				return oldScroll != scrollArea.scrollLeft;

			}else
			{
				oldScroll = scrollArea.scrollTop;
				var pm:IListPresentationModel = _strand.getBeadByType(IListPresentationModel) as IListPresentationModel;
				var totalHeight:Number = 0;
				var rowHeight:Number;

				if(pm.variableRowHeight)
				{
					//each item render can have its own height
					totalHeight = scrollArea.scrollHeight - scrollArea.offsetHeight;

					for (var i:int = 0; i <= index; i++)
					{
						var ir:IItemRenderer = dataGroup.getItemRendererForIndex(i) as IItemRenderer;
						if(ir)
						{
							rowHeight = ir.element.offsetHeight
							if( i < index )
								scrollToProposed += rowHeight;
						}else{
							//Hiedra. Cuando se elimina un registro del dataprovider lastindexselected 
							//puede contener un valor incorrecto y no existir el itemRenderer.
							//Se debería depurar y solucionar en el SDK.
							trace("ItemRenderer Index:",i.toString(),"lenght total:",index.toString());
						}
					}
				} else
				{
					// all items renderers with same height
					rowHeight = isNaN(pm.rowHeight) ? ListPresentationModel.DEFAULT_ROW_HEIGHT : pm.rowHeight;
					totalHeight = listModel.dataProvider.length * rowHeight - scrollArea.clientHeight;
					scrollToProposed = index * rowHeight;
				}

				scrollMaxVisible = scrollArea.scrollTop + scrollArea.offsetHeight;

				//When a row starts within the visible area but ends outside:
				if(scrollToProposed <= scrollMaxVisible && scrollToProposed+rowHeight > scrollMaxVisible)
				{
					//If we want to respect the default behavior (position the selected row as the first visible), the next two lines should be canceled
					//We adjust the scroll so that the row is fully visible, leaving it as the last visible...
					offset = scrollMaxVisible - scrollToProposed;
					scrollToProposed = oldScroll + rowHeight - offset;
					scrollArea.scrollTop = Math.min(scrollToProposed, totalHeight);
				}

				//The verticalScrollPosition will only be changed if the element is not currently visible.
				else if(scrollToProposed >= scrollMaxVisible || scrollToProposed < oldScroll)
				{
					scrollArea.scrollTop = Math.min(scrollToProposed, totalHeight);
				}

				return oldScroll != scrollArea.scrollTop;
			}
		}

	}

	COMPILE::SWF
	public class ListViewJwExt extends org.apache.royale.jewel.beads.views.ListView
	{
		public function ListViewJwExt()
		{
			super();
		}
	}
}
