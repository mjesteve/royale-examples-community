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
    import org.apache.royale.community.inspiretree.beads.models.InspireTreeModelExt;
    import org.apache.royale.events.IEventDispatcher;
    import org.apache.royale.core.IStrandWithModel;
    import org.apache.royale.community.inspiretree.vos.normalizeDataItem;
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
				_treeModel = (strand as IStrandWithModel).model as InspireTreeModelExt;
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
				if( node.children.length>0 && node.itree.state.selectable){
					//revertStateCheckedNode(node.id, true);
					revertStateNode(node);
				}
			}
		}

		//node:TreeNode
		public function revertStateNode(node:Object):void
		{
			var arOrg:Array = treeModel.dataProviderTree;
			var idxGen:int = 0;
			//No utilizamos jsTree.forEach porque no podemos salirnos del bucle una vez encontrado el nodo que queremos deshacer.
			//We do not use jsTree.forEach because we cannot exit the loop once we have found the node we want to undo.
			//(strand as IInspireTree).jsTree.forEach(function(treenode:Object):void
			var lenar:int = arOrg.length;

			for (var idxnode:int=0; idxnode < lenar; idxnode++)
			{
				var treenode:Object = (strand as IInspireTree).jsTree.model[idxnode];
				var itreal:normalizeDataItem;

				if(treenode.hasChildren())
				{
					if( treenode.id == node.id)
					{
						var lench:int = treenode.children.length;						
						for (var idxChild:int=0; idxChild < lench; idxChild++)
						{
							itreal = (arOrg[idxGen] as normalizeDataItem).children[idxChild];
							//if( !treeModel || (treeModel.markToState && !itreal.marked) )
							//{
								var itemch:Object = treenode.children[idxChild];
								if(itreal.checked)
									(strand as IInspireTree).jsTree.node(itemch.id).check(true);
								else{
									(strand as IInspireTree).jsTree.node(itemch.id).uncheck(true);
									(strand as IInspireTree).jsTree.node(itemch.id).itree.state.indeterminate = itreal.indeterminate;
								}
								(strand as IInspireTree).jsTree.node(itemch.id).itree.state.selectable = itreal.enabled;
							//}								
						}
						
						itreal = arOrg[idxGen] as normalizeDataItem;
						if(itreal.checked)
							(strand as IInspireTree).jsTree.node(treenode.id).check(true);
						else{
							(strand as IInspireTree).jsTree.node(treenode.id).uncheck(true);
							(strand as IInspireTree).jsTree.node(treenode.id).itree.state.indeterminate = itreal.indeterminate;
						}
						(strand as IInspireTree).jsTree.node(treenode.id).itree.state.selectable = itreal.enabled;
						treeModel.revertNode = arOrg[idxGen];
						//(strand as IInspireTree).updateDataViewTree(true);
						return;
					}
					idxGen++;
				}
			};
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
