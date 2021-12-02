package org.apache.royale.community.inspiretree.controls
{
    COMPILE::SWF {
    import flash.events.Event;
    }

	COMPILE::JS
	{
		import InspireTree;
		import InspireTreeDOM;
    	import org.apache.royale.core.IDataProviderModel;
    	import org.apache.royale.core.IMXMLDocument;
    	import org.apache.royale.core.ISelectionModel;
		import org.apache.royale.core.StyledUIBase;
        import org.apache.royale.core.WrappedHTMLElement;
    	import org.apache.royale.community.inspiretree.beads.models.InspireTreeModel;
    	import org.apache.royale.community.inspiretree.supportClasses.IInspireTree;
    	import org.apache.royale.community.inspiretree.vos.ItemTreeNode;
        import org.apache.royale.html.util.addElementToWrapper;
    	import org.apache.royale.events.Event;
    	import org.apache.royale.utils.MXMLDataInterpreter;
	}
    /**
     *  It triggers just before launching the creation.  
	 * 
	 *  It can be captured to make adjustments before creating the js instance.
	 *  (See InspireTreePaginateBead)
     */
	[Event(name="onBeforeCreation", type="org.apache.royale.events.Event")]
    /**
     *  Indicates that the creation is complete.  
     */
	[Event(name="onCreationComplete", type="org.apache.royale.events.Event")]
	/*

	*/
	[Event(name="onPrepareTreeDataComplete", type="org.apache.royale.events.Event")]

	COMPILE::JS
	public class InspireTreeBasicControl extends StyledUIBase implements IMXMLDocument, IInspireTree
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
		public function InspireTreeBasicControl()
		{
			super();			
			//typeNames = "inspiretree";
            addEventListener("beadsAdded", beadsAddedHandler);
        }

        private var _mxmlDescriptor:Array;
		private var _mxmlDocument:Object = this;

		/**
		 *  @copy org.apache.royale.core.Application#MXMLDescriptor
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.4
		 */
		public function get MXMLDescriptor():Array
		{
			return _mxmlDescriptor;
		}
		
		/**
		 *  @private
		 */
		public function setMXMLDescriptor(document:Object, value:Array):void
		{
			_mxmlDocument = document;
			_mxmlDescriptor = value;
		}

		/**
		 *  @copy org.apache.royale.core.Application#generateMXMLAttributes()
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.4
		 */
		public function generateMXMLAttributes(data:Array):void
		{
			MXMLDataInterpreter.generateMXMLProperties(this, data);
		}

		/**
		 *  @copy org.apache.royale.core.ItemRendererClassFactory#mxmlContent
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.4
         * 
         *  @royalesuppresspublicvarwarning
		 */
		public var mxmlContent:Array;

        private function beadsAddedHandler(event:Event):void
        {
			removeEventListener("beadsAdded", beadsAddedHandler);
        }

		override public function addedToParent():void
		{
			super.addedToParent();
			//The model is loaded
			if (!_initialized)
			{
				dispatchEvent(new Event("initComplete"));				
				
				if(!InspireTreeModel(model).useCustomStyle)
				{
					if(!InspireTreeModel(model).checkboxMode && !containsClass('withoutcheckbox'))
						addClass('withoutcheckbox');
				}
				reCreateViewTree();
				_initialized = true;
			}
		}

		private var _uid:String;
		public function get uid():String{ return _uid; }
		public function set uid(value:String):void{ _uid = value; }

		private var _initialized:Boolean = false;
        public function isInitialized():Boolean { return _initialized ? true:false;};

		private var _jsTree:InspireTree;
		public function get jsTree():InspireTree{ return _jsTree; }
		public function set jsTree(value:InspireTree):void{ _jsTree = value; }
		private var _jsTreeDOM:InspireTreeDOM;
		public function get jsTreeDOM():InspireTreeDOM{ return _jsTreeDOM; }
		public function set jsTreeDOM(value:InspireTreeDOM):void{ _jsTreeDOM = value; }

		// Init ---------------------------------------- Data configuration [wip] -------------------------------------------------

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
		public function get labelFunctionParent():Function{ return InspireTreeModel(model).labelFunctionParent; }
		public function set labelFunctionParent(value:Function):void{ InspireTreeModel(model).labelFunctionParent = value; }
		/**
		 * Function to obtain the description of the parent nodes.
		 * <p>The <code>labelFunctionChild</code> property takes a reference to a function. 
     	 * The function takes a single argument which is the item in the data provider and returns a String:</p>
    	 * 
		 *  <pre>myLabelFunction(item:Object):String</pre>
      	 * 
     	 *  @param item The data item. Null items return the empty string. 
		 */
		public function get labelFunctionChild():Function { return InspireTreeModel(model).labelFunctionChild; }
		public function set labelFunctionChild(value:Function):void{ InspireTreeModel(model).labelFunctionChild = value; }

		public function prepareTreeDataFromArray(dpArray:Array):Array
		{ 	
			// The dpArray should be sorted according to the desired display
			var localdataProviderTree:Array = new Array();
			for (var idxGen:int=0; idxGen < dpArray.length; idxGen++)
        	{
				var itemGroup:Object = new ItemTreeNode();
				itemGroup.text = labelFunctionParent(dpArray[idxGen]);

				var idobjPrev:String = boundField ? dpArray[idxGen][boundField]:'root';

				for (var idxChild:int=idxGen; idxChild < dpArray.length; idxChild++)
				{
					var idobjCurr:String = boundField ? dpArray[idxChild][boundField]:'root';
					if(idobjPrev == idobjCurr)
					{
						var itemDetail:Object = new ItemTreeNode();
						itemDetail.text = labelFunctionChild(dpArray[idxChild]);
							
						itemGroup.children.push(itemDetail);
					
						idxGen++;
					}
					else
					{
						idxGen--;
						break;
					}						
				}

				localdataProviderTree.push(itemGroup);
			}
			return localdataProviderTree;		
		}
		// End ---------------------------------------- Data configuration -------------------------------------------------

		
		public function updateDataViewTree():void
        { 
			if(!_initialized)
				return;

			jsTree.reload();
        }
		/**
		 * Recreate the InspireTree instance with the current options.
		 */
		public function reCreateViewTree(onlyView:Boolean=false):void
		{			
            dispatchEvent(new Event("onBeforeCreation"));

			//if(!onlyView || !jsTree)
			jsTree = new InspireTree(InspireTreeModel(model).configOption);

			jsTreeDOM = new InspireTreeDOM(jsTree, InspireTreeModel(model).configOptionView);

			uid = element.getAttribute('data-uid'); trace(uid);
			// To make the view independent from the control, the assignment of icons must be done in the bead and not here...
			// We will capture in the bead the event "onCreationComplete" and there we will call updateImagesOnParentChild()
		 	//(getBeadByType(InspireTreeIconBead) as InspireTreeIconBead).updateImagesOnParentChild();
            dispatchEvent(new Event("onCreationComplete"));
		}
		
	}	

	COMPILE::SWF
	public class InspireTreeBasicControl
	{
		public function InspireTreeBasicControl()
		{
		}
	}
	
}