package org.apache.royale.community.inspiretree.controls
{
    COMPILE::SWF {
    import flash.events.Event;
    }

	COMPILE::JS
	{
    	import org.apache.royale.community.inspiretree.vos.ItemTreeNode;
    	import org.apache.royale.core.IDataProviderModel;
    	import org.apache.royale.community.inspiretree.vos.normalizeDataItem;
    	import org.apache.royale.community.inspiretree.beads.models.InspireTreeModelExt;
	}

	COMPILE::JS
	public class InspireTreeBasicControlExt extends InspireTreeBasicControl
	{

		public function InspireTreeBasicControlExt()
		{
			super();
			isExtends = true;
        }

		override public function addedToParent():void
		{
			super.addedToParent();

			//All beads are loaded
			if (!_initialized)
			{
				dispatchEvent(new Event("initComplete"));

				if(tmpDataProvider){
					IDataProviderModel(model).dataProvider = tmpDataProvider;
					tmpDataProvider=null;
				}

				if(!treeModel.useCustomStyle)
				{
					if(!treeModel.checkboxMode && !containsClass('withoutcheckbox'))
						addClass('withoutcheckbox');
				}
				reCreateViewTree();
				_initialized = true;
			}
		}

		protected function get treeModel():InspireTreeModelExt{
			return InspireTreeModelExt(model);
		}

		public function get markIsDisabled():Boolean{ return treeModel.markIsDisabled; }
		public function set markIsDisabled(value:Boolean):void{ treeModel.markIsDisabled = value; }
		
		public function get markToState():String{ return treeModel.markToState; }
		public function set markToState(value:String):void{ treeModel.markToState = value; }

		override public function prepareTreeDataFromArray(... args):Array
		{
			if(!args[0])
				return new Array();
			var flatNormalizedArray:Array = args[0] as Array;			
			var treeNormalizedArray:Array = args[1] ? args[1] as Array : new Array;
			
			var treeArray:Array = new Array();
			var lendp:int = flatNormalizedArray.length;
			for (var idxGen:int=0; idxGen < lendp; idxGen++)
        	{
				var iChildCheckedCount:int = 0;
				var iChildUnCheckedCount:int = 0;
				var iChildMarkedCount:int = 0;
				var itemdp:normalizeDataItem = (flatNormalizedArray[idxGen] as normalizeDataItem);
				var itemGroup:Object = new ItemTreeNode();

				itemGroup.text = labelFunctionParent(itemdp.data);
				var idobjPrev:String = boundField ? itemdp.data[boundField]:'root';

				for (var idxChild:int=idxGen; idxChild < lendp; idxChild++)
				{
					var itemdpchild:normalizeDataItem = (flatNormalizedArray[idxChild] as normalizeDataItem);
					var idobjCurr:String = boundField ? itemdpchild.data[boundField]:'root';
					if(idobjPrev == idobjCurr)
					{
						var itemDetail:Object = new ItemTreeNode();
						itemDetail.text = labelFunctionChild(itemdpchild.data);

						if(treeModel.showCheckboxes && treeModel.checkboxFunction)
						{
							itemdpchild.checked = treeModel.checkboxFunction(itemDetail, itemdpchild.data);
							itemDetail.itree.state.checked = itemdpchild.checked;
						}
						if(treeModel.useCustomRenderer && treeModel.markDOMFunction)
						{
							itemdpchild.marked = treeModel.markDOMFunction(itemDetail, itemdpchild.data);
							if(treeModel.markToState && itemdpchild.marked)
							{
								iChildMarkedCount++
								itemDetail.itree.state[treeModel.markToState]=true;
								if(treeModel.showCheckboxes)
								{
									if(itemDetail.itree.state.indeterminate)
									{
										itemDetail.itree.state.checked = false;
										if(treeModel.markIsDisabled)
											itemDetail.itree.state.selectable = false;
									}else if(treeModel.markToState = "unchecked")
										itemDetail.itree.state.checked = false;
								}
							}
							if(treeModel.markIsDisabled)
							{
								itemdpchild.enabled = !itemdpchild.marked;
								itemDetail.itree.state.selectable = itemdpchild.enabled;
							}
						}
						itemGroup.children.push(itemDetail);

						if(treeModel.showCheckboxes)
						{
							if(itemDetail.itree.state.checked == true)
								iChildCheckedCount++; //how many children nodes are selected of a parent
							else
								iChildUnCheckedCount++;
						}

						idxGen++;
					}
					else
					{
						idxGen--;
						break;
					}
				}

				if(itemGroup.children.length >0)
				{
					if(treeModel.showCheckboxes){
						if(iChildCheckedCount == itemGroup.children.length)
							itemGroup.checked = true;
						else if(iChildUnCheckedCount == itemGroup.children.length)
							itemGroup.checked = false;
						else
							itemGroup.itree.state.indeterminate = true;

						itemGroup.itree.state.checked = itemGroup.checked;
					}

					if(treeModel.useCustomRenderer && iChildMarkedCount == itemGroup.children.length)
					{
						itemGroup.marked = true;
						if(treeModel.markToState)
							itemGroup.itree.state[treeModel.markToState]=true;

						if(treeModel.showCheckboxes)
						{
							if(itemGroup.itree.state.indeterminate)
							{
								itemGroup.itree.state.checked = false;
								if(treeModel.markIsDisabled)
									itemGroup.itree.state.selectable = false;
							}else if(treeModel.markToState = "unchecked")
								itemGroup.itree.state.checked = false;
							
							itemGroup.checked = itemGroup.itree.state.checked;
						}
						if(treeModel.markIsDisabled)
						{
							itemGroup.enabled = !itemGroup.marked;
							itemGroup.itree.state.selectable = itemGroup.enabled;
						}
					}
				}

				treeArray.push(itemGroup);
			}
			return treeArray;
		}

	}

	COMPILE::SWF
	public class InspireTreeBasicControlExt
	{
		public function InspireTreeBasicControlExt()
		{
		}
	}

}