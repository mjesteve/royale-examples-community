package org.apache.royale.community.inspiretree.controls
{
    COMPILE::SWF {
    import flash.events.Event;
    }

	COMPILE::JS
	{
    	import org.apache.royale.community.inspiretree.vos.ItemTreeNode;
    	import org.apache.royale.community.inspiretree.vos.normalizeDataItem;
    	import org.apache.royale.community.inspiretree.beads.models.InspireTreeModelExt;
    	import org.apache.royale.core.IDataProviderModel;
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
		//"unchecked" and "same" do not correspond to any "state" of InspireTree, they are for convenience.
        [Inspectable(category="General", enumeration="checked,unchecked,indeterminate,same,selectable")]
		public function set markToState(value:String):void{ treeModel.markToState = value; }

		override public function prepareTreeDataFromArray(flatArrayIn:Array):Array
		{
			if(!flatArrayIn)
				return [new Array(), new Array()];
			//var flatArrayIn:Array = args[0] as Array;			
			//var treeArrayOut:Array = args[1];
			var treeArrayOut:Array = new Array();
			var treeArray:Array = new Array();
			var lendp:int = flatArrayIn.length;
			for (var idxGen:int=0; idxGen < lendp; idxGen++)
        	{
				var iChildCheckedCount:int = 0;
				var iChildUnCheckedCount:int = 0;
				var iChildMarkedCount:int = 0;
				var itemdp:normalizeDataItem = flatArrayIn[idxGen] as normalizeDataItem;
				var idobjPrev:String = boundField ? itemdp.data[boundField]:'root';

				var childMark:Array = new Array();
				var itemGroup:Object = new ItemTreeNode();
				itemGroup.text = labelFunctionParent(itemdp.data);

				for (var idxChild:int=idxGen; idxChild < lendp; idxChild++)
				{
					var itemdpchild:normalizeDataItem = flatArrayIn[idxChild] as normalizeDataItem;
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
								if(treeModel.markToState != "same")
								{
									if(treeModel.markToState != "unchecked")
										itemDetail.itree.state[treeModel.markToState]=true;

									if(treeModel.showCheckboxes)
									{
										if(treeModel.markToState == "unchecked")
										{
											itemDetail.itree.state.checked = false;
											itemDetail.itree.state.indeterminate = false;
										}else if(treeModel.markToState == "checked")
										{
											itemDetail.itree.state.checked = true;
											itemDetail.itree.state.indeterminate = false;	
										}else if(treeModel.markToState == "indeterminate")
										{
											itemDetail.itree.state.checked = false;
										}
									}
								}

								if(treeModel.markIsDisabled)
									itemDetail.itree.state.selectable = false;
							}

							if(treeModel.markIsDisabled)
							{
								itemdpchild.enabled = !itemdpchild.marked;
								itemDetail.itree.state.selectable = itemdpchild.enabled;
							}

							itemdpchild.checked = itemDetail.itree.state.checked;
							itemdpchild.indeterminate = itemDetail.itree.state.indeterminate;
						}
						(itemGroup.children as Array).push(itemDetail);
						childMark.push(itemdpchild);

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

				var itemGroupNorm:normalizeDataItem = new normalizeDataItem(itemdp.data);
				itemGroupNorm.children = childMark;

				if((itemGroup.children as Array).length >0)
				{
					if(treeModel.showCheckboxes){
						if(iChildCheckedCount == (itemGroup.children as Array).length)
							itemGroup.itree.state.checked = true;
						else if(iChildUnCheckedCount == (itemGroup.children as Array).length)
							itemGroup.itree.state.checked = false;
						else
							itemGroup.itree.state.indeterminate = true;

						itemGroupNorm.checked = itemGroup.itree.state.checked;
						itemGroupNorm.indeterminate = itemGroup.itree.state.indeterminate;
					}

					if(treeModel.useCustomRenderer && iChildMarkedCount == (itemGroup.children as Array).length)
					{
						itemGroupNorm.marked = true;

						if(treeModel.markToState && treeModel.markToState != "unchecked" && treeModel.markToState != "same")
							itemGroup.itree.state[treeModel.markToState]=true;

						if(treeModel.showCheckboxes)
						{
							if(treeModel.markToState && treeModel.markToState == "unchecked" && treeModel.markToState != "same"){
								itemGroup.itree.state.checked = false;
								itemGroup.itree.state.indeterminate = false;									
							}

							if(itemGroup.itree.state.checked){
								itemGroup.itree.state.indeterminate = false;
							}else
							if(itemGroup.itree.state.indeterminate)
							{
								itemGroup.itree.state.checked = false;
								if(treeModel.markIsDisabled)
									itemGroup.itree.state.selectable = false;
							}
						}
						itemGroupNorm.checked = itemGroup.itree.state.checked;
						itemGroupNorm.indeterminate = itemGroup.itree.state.indeterminate;
						if(treeModel.markIsDisabled)
						{
							itemGroupNorm.enabled = !itemGroupNorm.marked;
							itemGroup.itree.state.selectable = itemGroupNorm.enabled;
						}
					}

				}

				treeArray.push(itemGroup);
				treeArrayOut.push(itemGroupNorm);
			}
			return [treeArray, treeArrayOut];
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