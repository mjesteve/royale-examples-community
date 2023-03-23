package org.apache.royale.externsjs.inspiretree.beads
{

	/**
	 *  @langversion 3.0
	 *  @playerversion Flash 10.2
	 *  @playerversion AIR 2.6
	 *  @productversion Royale 0.9.8
	 */
	COMPILE::JS{
    import org.apache.royale.externsjs.inspiretree.beads.models.InspireTreeModel;
	import org.apache.royale.externsjs.inspiretree.supportClasses.IInspireTree;
	import org.apache.royale.core.IBead;
	import org.apache.royale.core.IStrand;
	import org.apache.royale.core.Strand;
    import org.apache.royale.events.Event;
    import org.apache.royale.events.IEventDispatcher;
    import org.apache.royale.core.StyledUIBase;
    import org.apache.royale.events.ValueEvent;
    import org.apache.royale.collections.IArrayList;
    import org.apache.royale.core.IStrandWithModel;
	}
    COMPILE::JS
	public class InspireTreeCheckBoxModeBead  extends Strand implements IBead
	{
		/**
		 *  constructor
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.7
		 */

		public function InspireTreeCheckBoxModeBead()
		{
			super();
		}
        private var _strand:IStrand;

		/**
		 *  @copy org.apache.royale.core.IBead#strand
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.4
		 */
        public function get strand():IStrand
        {
            return _strand;
        }
		/**
		 *  @copy org.apache.royale.core.IBead#strand
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.4
		 */
		public function set strand(value:IStrand):void
		{
            _strand = value;
			(_strand as IEventDispatcher).addEventListener("initComplete", init);
			(_strand as IEventDispatcher).addEventListener("beforeCreation", onBeforeCreationTree);
			(_strand as IEventDispatcher).addEventListener("prepareTreeDataComplete", completeTreeData);
			(_strand as IEventDispatcher).addEventListener("readonlyChange", onReadOnlyChange);
		}

		protected var _treeModel:InspireTreeModel;
		protected function get treeModel():InspireTreeModel{
			if(_strand && !_treeModel)
			{
				_treeModel = (_strand as IStrandWithModel).model as InspireTreeModel;
			}
			return _treeModel;
		}

		protected function init(event:Event):void
		{
			(_strand as IEventDispatcher).removeEventListener("initComplete", init);

			if(treeModel)
			{
				//InspireTree JS does not support mode switching after initialization. For now we don't either.
				///treeModel.checkboxMode = true;
				///treeModel.showCheckboxes = _showCheckboxes;
				//treeModel.addEventListener("checkboxModeChanged", updateHost);
				//treeModel.addEventListener("showCheckboxesChanged", updateHost);

				treeModel.showCheckboxes = _showCheckboxes;
				treeModel.checkedIsSelected = _checkedIsSelected;
				if(treeModel.checkboxMode && treeModel.treeData)
				{
					completeTreeData(null,null);
					if( readOnly )
						onReadOnlyChange(null);
				}
			}
		}

		private function onBeforeCreationTree(event:Event):void
		{
			if(_revertIcon && _showCheckboxes)
				(_strand as IEventDispatcher).addEventListener("creationComplete", createListeners);
		}

		protected function completeTreeData(event:Event, revertTreeData:Array = null):Array
		{
			if( !_treeModel) return null;

			var data:Array = [];

			if(_treeModel.dataProvider is IArrayList)
				data = IArrayList(_treeModel.dataProvider).source;
			else
				data = _treeModel.dataProvider as Array;

			var treeData:Array;
			if(revertTreeData)
				treeData = revertTreeData;
			else
				treeData = _treeModel.treeData;

			var idxGen:int=0;

			for (var idxGr:int=0; idxGr < treeData.length; idxGr++)
        	{
                //When cloning treeData, the type of the items is lost and the conversion fails. (ItemTreeNode)
				//var itemGroup:Object = ItemTreeNode(treeData[idxGr]);
				var itemGroup:Object = treeData[idxGr];
				var iChildCheckedCount:int = 0;
				var iChildUnCheckedCount:int = 0;

				for (var idxChild:int=0; idxChild < itemGroup.children.length; idxChild++)
				{
                    //When cloning treeData, the type of the items is lost and the conversion fails. (ItemTreeNode)
					//var itemDetail:ItemTreeNode = ItemTreeNode(itemGroup.children[idxChild]);
					var itemDetail:Object = itemGroup.children[idxChild];
					itemDetail.itree.state.checked = _checkboxFunction(itemDetail, data[idxGen+idxChild]);

					if(itemDetail.itree.state.checked == true)
						iChildCheckedCount++; //how many children nodes are selected of a parent
					else
						iChildUnCheckedCount++;
				}

				if( itemGroup.children.length >0)
				{
					if(iChildCheckedCount == itemGroup.children.length)
						itemGroup.itree.state.checked = true;
					else if(iChildUnCheckedCount == itemGroup.children.length)
						itemGroup.itree.state.checked = false;
					else
						itemGroup.itree.state.indeterminate = true;
				}

				idxGen+=itemGroup.children.length;
			}

			return treeData;
		}

		private function createListeners():void
		{
			(_strand as IEventDispatcher).removeEventListener("creationComplete", createListeners);
			updateHost();
		}

		protected var _showCheckboxes:Boolean = true;
		/**
		 * Show checkbox on each node
		*/
        [Bindable("showCheckboxesChanged")]
		public function get showCheckboxes():Boolean
		{
			return _showCheckboxes;
		}
		public function set showCheckboxes(value:Boolean):void
		{
			if(_treeModel)
			{
				if(value == _showCheckboxes && value == treeModel.showCheckboxes) return;

				treeModel.showCheckboxes = value;
				if(IInspireTree(_strand).isInitialized())
					IInspireTree(_strand).reCreateViewTree( true );
			}
			_showCheckboxes = value;
		}
		protected var _checkboxField:String = "";
		/**
		 * Name of the attribute, in the dataProvider, where the checked value is defined.
		 * Expected values: 0/1 or true/false
		 */
		public function get checkboxField():String {return _checkboxField; }
		public function set checkboxField(value:String):void{ _checkboxField = value;}
		/**
		 * Function to get the check status of the child nodes.
		 * <p>The <code>checkboxFunction</code> property takes a reference to a function.
     	 * The function takes a single argument which is the item of the data provider and returns a boolean:</p>
    	 *
		 *  <pre>myLabelFunction(itemTreeData:Object, itemFlatData:Object):Boolean</pre>
      	 *
     	 *  @param item The data item. Null items return false.
		 */
		protected var _checkboxFunction:Function = itemChildChecked;
		public function get checkboxFunction():Function{return _checkboxFunction; }
		public function set checkboxFunction(value:Function):void{ _checkboxFunction = value;}

		public function itemChildChecked(itemTreeData:Object, itemFlatData:Object):Boolean
		{
			if(!itemTreeData || !itemFlatData || !checkboxField)
				return false;

			if( itemFlatData[checkboxField] == null )
				return false;

			if( itemFlatData[checkboxField] is Number )
				return Number(itemFlatData[checkboxField])>0 ? true:false;

			if( itemFlatData[checkboxField] is Boolean )
				return itemFlatData[checkboxField] as Boolean;

			return false;
		}

		private var _revertIcon:Boolean = false;
		public function get revertIcon():Boolean
		{
			return _revertIcon;
		}
		public function set revertIcon(value:Boolean):void
		{
			if(_revertIcon != value && !readOnly)
			{
                if( value && !_showCheckboxes )
                    return;
				_revertIcon = value;
				updateHost();
			}
			if(readOnly)
				lastRevertVal = value;
		}

		protected var _checkedIsSelected:Boolean = false;
		public function get checkedIsSelected():Boolean{
			return _checkedIsSelected;
		}
		public function set checkedIsSelected(value:Boolean):void
		{
			if(_treeModel)
			{
				if(value == _checkedIsSelected && _treeModel.checkedIsSelected == value) return;

				_treeModel.checkedIsSelected = value;
				if(IInspireTree(_strand).isInitialized())
					IInspireTree(_strand).reCreateViewTree( true );
			}
			_checkedIsSelected = value;
		}

		protected var lastRevertVal:Boolean = false;
		protected var readOnly:Boolean = false;
		protected function onReadOnlyChange(event:ValueEvent):void
		{
			if(event)
				readOnly = Boolean(event.value);

			if(!_showCheckboxes)
				return;

			if( readOnly )
			{
				lastRevertVal = _revertIcon;
				_revertIcon = false;
			}else{
				_revertIcon = lastRevertVal;
			}
			updateHost();
		}

		//node:ItemTreeNode
		public function onClickHandler(event:*, node:Object):void
		{

			var wParent:Number = (_strand as StyledUIBase).width;
			var wItem:Number = Number( node.itree.ref.clientWidth ? node.itree.ref.clientWidth:0 );
			var wScroll:Number = (wParent-wItem);
			var wIcon:Number = 20;
			if( Number(event["offsetX"]) >= wParent - (wIcon + wScroll) )
			{
				//Only folder node
				if( node.children.length>0 && node.itree.state.selectable){
					revertStateCheckedNode(node.id, true);
				}
			}
		}

		public function revertStateCheckedNode(pNodeFilter:String, byID:Boolean):String
		{
			var idNodeParent:String;
			var arOrg:Array = treeModel.dataProviderTree;
			arOrg = completeTreeData(null,arOrg);
			var lenar:int = arOrg.length;

			for (var idxnode:int=0; idxnode < lenar; idxnode++)
			{
				var it:Object = arOrg[idxnode]; //var it:ItemTreeNode;
				var itreal:Object = (_strand as IInspireTree).jsTree.model[idxnode]; //var itreal:TreeNode //jsTree.node(it.id)

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
								(_strand as IInspireTree).jsTree.node(itemch.id).uncheck(true);
							else
								(_strand as IInspireTree).jsTree.node(itemch.id).check(true);
						}
					}

					if(itreal.itree.state.checked != it.itree.state.checked)
					{
						(_strand as IInspireTree).jsTree.node(it.id).refreshIndeterminateState();
					}
					break;
				}
			}

			return idNodeParent;
		}

		/**
		 * Check/Uncheck all nodes
		 * @param valueChecked [true|false] true Check all nodes
		 */
		public function checkAllNode(valueChecked:Boolean):void
		{
			var idNodeParent:String;
			var arOrg:Array = treeModel.treeData;
			var lenar:int = arOrg.length;

			for (var idxnode:int=0; idxnode < lenar; idxnode++)
			{
				var it:Object = arOrg[idxnode]; //var it:ItemTreeNode;
				var itreal:Object = (_strand as IInspireTree).jsTree.model[idxnode]; //var itreal:TreeNode //jsTree.node(it.id)

				if(it.children && it.children.length>0)
				{
					var lench:int = it.children.length;
					for (var idxnch:int=0; idxnch < lench; idxnch++)
					{
						var itemch:Object = it.children[idxnch];
						itemch.id = itreal.children[idxnch].id;

						if(!valueChecked) {
							if(itemch.itree.state.checked)
								(_strand as IInspireTree).jsTree.node(itemch.id).uncheck(true);
						}else if(!itemch.itree.state.checked){
								(_strand as IInspireTree).jsTree.node(itemch.id).check(true);
						}
					}
				}

				if(itreal.itree.state.checked != it.itree.state.checked)
				{
					(_strand as IInspireTree).jsTree.node(it.id).refreshIndeterminateState();
				}
			}

		}

		protected function updateHost(event:Event = null):void
		{
			if(!strand)
				return;

			var existClass:Boolean = (_strand as StyledUIBase).element.classList.contains("editrevert");
			if(_revertIcon && _showCheckboxes){
				if( !existClass ) {
					(_strand as StyledUIBase).element.classList.add("editrevert");
					if((_strand as IInspireTree).jsTree)
						(_strand as IInspireTree).jsTree.on('node.click', onClickHandler);
				}
			}else if( existClass ) {
				(_strand as StyledUIBase).element.classList.remove("editrevert");
				if((_strand as IInspireTree).jsTree)
					(_strand as IInspireTree).jsTree.off('node.click', onClickHandler);
			}
			if(event)
				IInspireTree(_strand).reCreateViewTree();
		}

	}

    COMPILE::SWF
	public class InspireTreeCheckBoxModeBead
	{
    }
}
