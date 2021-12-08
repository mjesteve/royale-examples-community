package org.apache.royale.community.inspiretree.history
{
    COMPILE::SWF {
    import flash.events.Event;
    }

	COMPILE::JS
	{
		import InspireTree;
		import InspireTreeDOM;
    	import org.apache.royale.core.IDataProviderModel;
    	import org.apache.royale.core.ISelectionModel;
		import org.apache.royale.core.StyledUIBase;
        import org.apache.royale.core.WrappedHTMLElement;
    	import org.apache.royale.events.Event;
        import org.apache.royale.html.util.addElementToWrapper;
    	import org.apache.royale.community.inspiretree.beads.models.InspireTreeModel;
    	import org.apache.royale.community.inspiretree.vos.ItemTreeNode;
    	import org.apache.royale.core.StyledUIBase;
    	import org.apache.royale.community.inspiretree.IInspireTree;
	}
    /**
     *  Indicates that the creation is complete.  
     */
	[Event(name="onCreationComplete", type="org.apache.royale.events.Event")]
    /**
     *  It triggers just before launching the creation.  
	 * 
	 *  It can be captured to make adjustments before creating the js instance.
	 *  (See InspireTreePaginateBead)
     */
	[Event(name="onBeforeCreation", type="org.apache.royale.events.Event")]

	COMPILE::JS
	public class InspireTreeBasicControl_WithTests extends StyledUIBase implements IInspireTree
	{
		/**
		 * @royaleignorecoercion org.apache.royale.core.WrappedHTMLElement
		 * @royaleignorecoercion org.apache.royale.html.util.addElementToWrapper
         */
        override protected function createElement():WrappedHTMLElement
        {
			addElementToWrapper(this, 'div');
            return element;
        }
        /**
         *  Constructor.
         */
		public function InspireTreeBasicControl_WithTests()
		{
			super();			
			//typeNames = "inspiretree";
		}

		override public function addedToParent():void
		{
			super.addedToParent();
			//The model is loaded
            reCreateViewTree();
		}

        private var isInitialized:Boolean = false;

		/**
		 * TODO - to protected
		 */
		private var _jsTree:InspireTree;
		public function get jsTree():InspireTree{ return _jsTree; }
		public function set jsTree(value:InspireTree):void{ _jsTree = value; }
		public var jsTreeDOM:InspireTreeDOM;

		// Init ---------------------------------------- Data configuration -------------------------------------------------

        [Bindable("labelFieldChanged")]
		public function get labelField():String
		{
			return IDataProviderModel(model).labelField;
		}
		/**
		 * @royaleignorecoercion org.apache.royale.core.IDataProviderModel
		 */
		public function set labelField(value:String):void
		{
            IDataProviderModel(model).labelField = value;
		}

		/**
		 * Name of the attribute, in the dataProvider, where the child nodes are specified
		 */
		public function get childrenField():String { return InspireTreeModel(model).childrenField; }
		public function set childrenField(value:String):void{ InspireTreeModel(model).childrenField = value; }
		/**
		 * When a non-hierarchical dataProvider is set, 'boundField', shall indicate the grouping attribute
		 */
		public function get boundField():String { return InspireTreeModel(model).boundField; }
		public function set boundField(value:String):void{ InspireTreeModel(model).boundField = value; }
		/**
		 * Name of the attribute, in the dataProvider, where the checked value is defined.
		 * Expected values: 0/1 or true/false
		 */
		public function get checkboxField():String { return InspireTreeModel(model).checkboxField; }
		public function set checkboxField(value:String):void{ InspireTreeModel(model).checkboxField = value; }

        [Bindable("dataProviderChanged")]
		public function get dataProvider():Object
		{
			return IDataProviderModel(model).dataProvider;
		}
		/**
		 * @royaleignorecoercion org.apache.royale.core.IDataProviderModel
		 */
		public function set dataProvider(value:Object):void
		{
			IDataProviderModel(model).dataProvider = value;
			updateDataViewTree();            
		}

        [Bindable("selectionChanged")]
		public function get selectedIndex():int
		{
			return ISelectionModel(model).selectedIndex;
		}
		/**
		 * @royaleignorecoercion org.apache.royale.core.ISelectionModel
		 */
		public function set selectedIndex(value:int):void
		{
			ISelectionModel(model).selectedIndex = value;
		}

        [Bindable("selectionChanged")]
		public function get selectedItem():Object
		{
			return ISelectionModel(model).selectedItem;
		}
		public function set selectedItem(value:Object):void
		{
			ISelectionModel(model).selectedItem = value;
		}

        //[Bindable("checkboxModeChanged")]
		/** 
		 * Show checkbox on each node
		*/
		public function get checkboxMode():Boolean {
			return InspireTreeModel(model).checkboxMode; 
		}
		public function set checkboxMode(value:Boolean):void
		{
			InspireTreeModel(model).checkboxMode = value;
		}

        //[Bindable("allowDragAndDropChanged")]
		/**
		 * Allow Drag and Drop
		 */
		public function get allowDragAndDrop():Boolean {
			return InspireTreeModel(model).allowDragAndDrop; 
		}
		public function set allowDragAndDrop(value:Boolean):void
		{ 
			InspireTreeModel(model).allowDragAndDrop = value;
		}
		
		/**
		 * Function to obtain the description of the parent nodes.
		 * <p>The <code>labelFunctionParent</code> property takes a reference to a function. 
     	 * The function takes a single argument which is the item in the data provider and returns a String:</p>
    	 * 
		 *  <pre>myLabelFunction(item:Object):String</pre>
      	 * 
     	 *  @param item The data item. Null items return the empty string. 
		 */
		public var labelFunctionParent:Function = itemToLabel;
		/**
		 * Function to obtain the description of the parent nodes.
		 * <p>The <code>labelFunctionChild</code> property takes a reference to a function. 
     	 * The function takes a single argument which is the item in the data provider and returns a String:</p>
    	 * 
		 *  <pre>myLabelFunction(item:Object):String</pre>
      	 * 
     	 *  @param item The data item. Null items return the empty string. 
		 */
		public var labelFunctionChild:Function = itemToLabel;
		/**
		 * Function to get the check status of the child nodes.
		 * <p>The <code>checkboxFunction</code> property takes a reference to a function. 
     	 * The function takes a single argument which is the item of the data provider and returns a boolean:</p>
    	 * 
		 *  <pre>myLabelFunction(item:Object):Boolean</pre>
      	 * 
     	 *  @param item The data item. Null items return false. 
		 */
		public var checkboxFunction:Function = itemChildChecked;

		private function itemToLabel(item:Object):String
		{
			if(!item || item==null)
				return '';

			if(InspireTreeModel(model).labelField && item.hasOwnProperty(InspireTreeModel(model).labelField))
				return item[InspireTreeModel(model).labelField];
			
			return '';
		}
		
		private function itemChildChecked(item:Object):Boolean
		{
			if(!item || item==null)
				return false;

			if(checkboxField && item.hasOwnProperty(checkboxField))
			{
				if( item[checkboxField] != null )
					return false;
				
				if( item[checkboxField] is Number )
					return Number(item[checkboxField])>0 ? true:false;

				if( item[checkboxField] is Boolean )
					return item[checkboxField] as Boolean;
			}
			
			return false;
		}

		public function prepareTreeDataFromArray(dpArray:Array):Array
		{ 	
			// The dpArray should be sorted according to the desired display
			var localdataProviderTree:Array = new Array();
			for (var idxGen:int=0; idxGen < dpArray.length; idxGen++)
        	{
				var itemGroup:Object = new ItemTreeNode();
				if(labelFunctionParent != null)
					itemGroup.text = labelFunctionParent(dpArray[idxGen]);
				else
					itemGroup.text = itemToLabel(dpArray[idxGen]);

				var idobjPrev:String = boundField ? dpArray[idxGen][boundField]:'root';
				var iChildCheckedCount:int = 0;
				var iChildUnCheckedCount:int = 0;

				for (var idxChild:int=idxGen; idxChild < dpArray.length; idxChild++)
				{
					var idobjCurr:String = boundField ? dpArray[idxChild][boundField]:'root';
					if(idobjPrev == idobjCurr)
					{
						var itemDetail:Object = new ItemTreeNode();
						
						if(labelFunctionChild != null)
							itemDetail.text = labelFunctionChild(dpArray[idxChild]);
						else
							itemDetail.text = itemToLabel(dpArray[idxChild]);
							
						if(checkboxMode)
						{
							if(checkboxFunction !== null)
								itemDetail.itree.state.checked = checkboxFunction(dpArray[idxChild]);
							else
								itemDetail.itree.state.checked = itemChildChecked(dpArray[idxChild]);
							
							if(itemDetail.itree.state.checked == true)
								iChildCheckedCount++; //how many children nodes are selected of a parent
							else
								iChildUnCheckedCount++;
						}

						itemGroup.children.push(itemDetail);
					
						idxGen++;
					}
					else
					{
						idxGen--;
						break;
					}						
				}

				if(checkboxMode && itemGroup.children.length >0)
				{
					if(iChildCheckedCount == itemGroup.children.length)
						itemGroup.itree.state.checked = true;
					else if(iChildUnCheckedCount == itemGroup.children.length)
						itemGroup.itree.state.checked = false;
					else
						itemGroup.itree.state.indeterminate = true;						
				}

				localdataProviderTree.push(itemGroup);
			}
			return localdataProviderTree;		
		}		

		// End ---------------------------------------- Data configuration -------------------------------------------------


		// Init --------------------------------------- Image settings on InspireTree --------------------------------------
		private var _revertIcon:Boolean = false;
		public function get revertIcon():Boolean{ return _revertIcon; }
		public function set revertIcon(value:Boolean):void
		{ 
			if(_revertIcon != value)
			{
				if(value){
					element.classList.add("editrevert");
					if(jsTree)
						jsTree.on('node.click', onClickHandler);
				}else{					
					element.classList.remove("editrevert");
					if(jsTree)
						jsTree.off('node.click', onClickHandler);
				}
				_revertIcon = value; 
			}
		}

		public var addImageToParentNode:Boolean = false;
		public var addImageToChildNodes:Boolean = false;
		
		public function updateDataViewTree():void
        { 
			if(!isInitialized)
				return;

			jsTree.reload();
			setTimeout(addImagesToTreeView,125);
        }
		/**
		 * Recreate the InspireTree instance with the current options.
		 */
		public function reCreateViewTree():void
		{
            isInitialized = false;
			if(jsTree)
			{
				//InspireTreeModel(model).treeData = InspireTreeModel(model).dataProviderTree;
			}

            dispatchEvent(new Event("onBeforeCreation"));

			if(!InspireTreeModel(model).checkboxMode && revertIcon)
				revertIcon = false;
			
			jsTree = new InspireTree(InspireTreeModel(model).configOption);
			if(revertIcon)
			{	
				jsTree.on('node.click', onClickHandler);
			}
			jsTreeDOM = new InspireTreeDOM(jsTree, InspireTreeModel(model).configOptionView);

			if(InspireTreeModel(model).configOption.data && InspireTreeModel(model).configOption.data.length>0)
				setTimeout(addImagesToTreeView,125);
			
            isInitialized = true;
            dispatchEvent(new Event("onCreationComplete"));
		}
				
		public function addImagesToTreeView():void
		{ 
				return;
			if(revertIcon)
			{
				var iParentIndex:int =0;

				for(var x:int=0; x<2; x++){
					var nodeList:HTMLCollection;
					if(x == 0)
						nodeList = element.getElementsByClassName("icon-folder-open") as HTMLCollection;
					else
						nodeList = element.getElementsByClassName("icon-folder") as HTMLCollection;

					var lnnodes:int = nodeList ? nodeList.length : -1;

					for(var i:int = 0;i<lnnodes;i++)
					{
						//if(jsTree["model"][iParentIndex].children.length>0)
						//{
							var prev:HTMLElement = nodeList[i] as HTMLElement;
							/*if(!prev.classList.contains("icon-revert"))
								prev.classList.add("icon-revert");
							*/
							prev.setAttribute('allowRevert',"true");
						//}
					}
			
				}

			}
		}
				
		public function addImagesToTreeView_old():void
		{ 
			if(!addImageToParentNode && !addImageToChildNodes && !revertIcon)
				return;

			var iParentIndex:int =0;
			var iChildIndex:int =0;
			var nodeList:HTMLCollection = element.getElementsByClassName("wholerow") as HTMLCollection;
			var lnnodes:int = nodeList ? nodeList.length : -1;

			for(var i:int = 0;i<lnnodes;i++)
			{
				if(jsTree["model"][iParentIndex].children.length>0)
				{
					var prev:HTMLElement = nodeList[i] as HTMLElement;

					var str:String = "<div class=\"wholerow\"> ";					
					if(addImageToParentNode == true)
					{
						str += "<img style=\"padding-left:25px\" class=\"Treeparentimg\" src='assets/inspiretree/personal_24.png'> ";
					}

					if(revertIcon == true)
					{
						str += "<span  width='20' height='20' style='float:right; cursor: pointer;' > <img class=\"revImage\" src='assets/inspiretree/repeater24.png'  > </span>";
					}
					str += "</div>";
					
					prev.outerHTML= str; 

					nodeList[i] = prev;
					//The lastchild is de button revert
					nodeList[i].lastChild.addEventListener("click",fn_RevertClickHandler);
					
					
					for(var j:int = 0;j<jsTree["model"][iParentIndex].children.length;j++)
					{
						iChildIndex++;
						var prevChild:HTMLElement = nodeList[iChildIndex] as HTMLElement;
						if(addImageToChildNodes == true)
						{
							var str2:String = "<div class=\"wholerow\"> ";
							str2 += "<img style=\"padding-left:45px;\" class=\"Treeparentimg\" src='assets/inspiretree/UserIco24_2.png'> ";
							str2 += "</div>";	
							prevChild.outerHTML= str2; 
							nodeList[iChildIndex] = prev; 	
						}
					}
					
					i += jsTree["model"][iParentIndex].children.length;
					iParentIndex++;
					iChildIndex++;
					
				}
			}
			
        }

		public function fn_RevertClickHandler(event:Event):void //PointerEvent
		{
			// [todo] use the API 
			//text node parent
			var txtnodeParent:String = event.target["parentElement"]["parentElement"]["parentElement"]["children"][0]["textContent"];
			var idNodeParent:String = fn_RevertSpecificNode(txtnodeParent, false);
			// [todo] This expands all nodes. You have to pass the index of the node you want to expand.
			//jsTree.nodes().expandDeep();
			if(idNodeParent)
			{
				jsTree.node(idNodeParent).collapse();
				jsTree.node(idNodeParent).expand();
			}
		}
		
		public function fn_RevertSpecificNode(pNodeFilter:String, byID:Boolean):String
		{ 	
			var idNodeParent:String;
			var arOrg:Array = InspireTreeModel(model).dataProviderTree;
			var lenar:int = arOrg.length;

			for (var idxnode:int=0; idxnode < lenar; idxnode++)
			{
				var it:Object = arOrg[idxnode]; //var it:ItemTreeNode;
				var itreal:Object = jsTree.model[idxnode]; //var itreal:TreeNode //jsTree.node(it.id)

				if( (byID && itreal.id == pNodeFilter) || (!byID && itreal.text == pNodeFilter) )
				{					
					if(it.children && it.children.length>0)
					{
						var lench:int = it.children.length;
						for (var idxnch:int=0; idxnch < lench; idxnch++)
						{
							var itemch:Object = it.children[idxnch];
							itemch.id = itreal.children[idxnch].id;

							if(!itemch.itree.state.checked)
								jsTree.node(itemch.id).uncheck(true);
							else
								jsTree.node(itemch.id).check(true);
						}					
					}

					if(itreal.itree.state.checked != it.itree.state.checked)
					{
						jsTree.node(it.id).refreshIndeterminateState();
					}
					break;
				}
			}

			return idNodeParent;
		}
			  
		public function onClickHandler(event:*, node:ItemTreeNode):void
		{
			trace('click:', 'Node:', node);
			trace('click:', 'Node Id:', node.id, width),event["clientX"];
			if(event["clientX"] >= width - 20)
			{
				fn_RevertSpecificNode(node.id, true);
			}
		}
		
	}	

	COMPILE::SWF
	public class InspireTreeBasicControl_WithTests
	{
		public function InspireTreeBasicControl_WithTests()
		{
		}
	}
	
}