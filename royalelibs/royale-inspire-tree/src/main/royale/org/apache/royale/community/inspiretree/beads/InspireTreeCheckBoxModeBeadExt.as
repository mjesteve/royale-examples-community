package org.apache.royale.community.inspiretree.beads
{

	/**
	 *  @langversion 3.0
	 *  @playerversion Flash 10.2
	 *  @playerversion AIR 2.6
	 *  @productversion Royale 0.9.8
	 */
	COMPILE::JS{
	import org.apache.royale.community.inspiretree.supportClasses.IInspireTree;
    import org.apache.royale.events.Event;
    import org.apache.royale.core.StyledUIBase;
    import org.apache.royale.community.inspiretree.vos.ItemTreeNode;
    import org.apache.royale.collections.IArrayList;
    import org.apache.royale.community.inspiretree.beads.models.InspireTreeModelExt;
    import org.apache.royale.core.IBeadModel;
    import org.apache.royale.events.IEventDispatcher;
    import org.apache.royale.community.inspiretree.vos.normalizeDataItem;
	}
    COMPILE::JS
	public class InspireTreeCheckBoxModeBeadExt  extends InspireTreeCheckBoxModeBead
	{

		public function InspireTreeCheckBoxModeBeadExt()
		{
			super();
		}

		override protected function get treeModel():InspireTreeModelExt
		{
			if(strand && !_treeModel)
			{
				_treeModel = strand.getBeadByType(IBeadModel) as InspireTreeModelExt;
			}
			return _treeModel as InspireTreeModelExt;
		}
		
		override public function set checkboxFunction(value:Function):void
		{ 
			super.checkboxFunction = value;
			if(treeModel)
				treeModel.checkboxFunction = value;
		}

		override protected function init(event:Event):void
		{
			(strand as IEventDispatcher).removeEventListener("initComplete", init);

			if(treeModel)
			{
				treeModel.showCheckboxes = showCheckboxes;
				treeModel.checkedIsSelected = checkedIsSelected;
				if(showCheckboxes)
				{
					if(!treeModel.checkboxFunction && _checkboxFunction)
						treeModel.checkboxFunction = _checkboxFunction;
				}
				if(treeModel.checkboxMode && treeModel.treeData)
				{
					completeTreeData(null,null);
					if( readOnly )
						onReadOnlyChange(null);
				}
			}
		}
		
		override protected function completeTreeData(event:Event, revertTreeData:Array = null):Array
		{
			if( !treeModel) return null;
			if(revertTreeData)
				return revertTreeData;
			else
				return treeModel.treeData;
		}

		override public function itemChildChecked(itemTreeData:Object, itemDataProv:Object):Boolean
		{
			if(!itemTreeData || !itemDataProv || !checkboxField)
				return false;

			if( itemDataProv[checkboxField] == null )
				return false;

			if( itemDataProv[checkboxField] is Number )
				return Number(itemDataProv[checkboxField])>0 ? true:false;

			if( itemDataProv[checkboxField] is Boolean )
				return itemDataProv[checkboxField] as Boolean;

			return false;
		}

		//node:ItemTreeNode
		override public function onClickHandler(event:*, node:Object):void
		{
			
			var wParent:Number = (strand as StyledUIBase).width;
			var wItem:Number = Number( node.itree.ref.clientWidth ? node.itree.ref.clientWidth:0 );
			var wScroll:Number = (wParent-wItem);
			var wIcon:Number = 20;
			if( Number(event["offsetX"]) >= wParent - (wIcon + wScroll) )
			{
				//Only folder node
				var treenode:Object = IInspireTree(strand).jsTree.node(node.id);
				if( treenode.hasChildren() ){
					//revertStateCheckedNode(node.id, true);
					revertStateNode(treenode);
				}
			}
		}

		//node:TreeNode
		public function revertStateNode(node:Object):void
		{
			var arOrg:Array = treeModel.dataProviderTree;
			
		}

		override public function revertStateCheckedNode(pNodeFilter:String, byID:Boolean):String
		{
			var idNodeParent:String;
			var arOrg:Array = treeModel.dataProviderTree;
			arOrg = completeTreeData(null,arOrg);
			var lenar:int = arOrg.length;

			for (var idxnode:int=0; idxnode < lenar; idxnode++)
			{
				var it:Object = arOrg[idxnode]; //var it:ItemTreeNode;
				var itreal:Object = (strand as IInspireTree).jsTree.model[idxnode]; //var itreal:TreeNode //jsTree.node(it.id)

				if( (byID && itreal.id == pNodeFilter) || (!byID && itreal.text == pNodeFilter) )
				{
					if(it.children && it.children.length>0)
					{
						var lench:int = it.children.length;
						for (var idxnch:int=0; idxnch < lench; idxnch++)
						{
							var itemch:Object = it.children[idxnch];
							itemch.id = itreal.children[idxnch].id;
							if(!itemch.itree.state.selectable)
								continue;
							if(!itemch.itree.state.checked)
								(strand as IInspireTree).jsTree.node(itemch.id).uncheck(true);
							else
								(strand as IInspireTree).jsTree.node(itemch.id).check(true);
						}
					}

					if(itreal.itree.state.checked != it.itree.state.checked)
					{
						(strand as IInspireTree).jsTree.node(it.id).refreshIndeterminateState();
					}
					break;
				}
			}

			return idNodeParent;
		}

		override protected function updateHost(event:Event = null):void
		{
			if(!strand)
				return;

			var existClass:Boolean = (strand as StyledUIBase).element.classList.contains("editrevert");
			if(revertIcon && showCheckboxes){
				if( !existClass ) {
					(strand as StyledUIBase).element.classList.add("editrevert");
					if((strand as IInspireTree).jsTree)
						(strand as IInspireTree).jsTree.on('node.click', onClickHandler);
				}
			}else if( existClass ) {
				(strand as StyledUIBase).element.classList.remove("editrevert");
				if((strand as IInspireTree).jsTree)
					(strand as IInspireTree).jsTree.off('node.click', onClickHandler);
			}
			if(event)
				IInspireTree(strand).reCreateViewTree();
		}

	}

    COMPILE::SWF
	public class InspireTreeCheckBoxModeBeadExt
	{
    }
}
