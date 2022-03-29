package org.apache.royale.community.inspiretree.beads.models
{
	import org.apache.royale.community.inspiretree.vos.OptionsTree;
	import org.apache.royale.community.inspiretree.vos.ConfigDOM;
	import org.apache.royale.core.HTMLElementWrapper;
	import org.apache.royale.utils.sendEvent;
	import org.apache.royale.collections.IArrayList;
	import org.apache.royale.community.inspiretree.supportClasses.IInspireTree;
	import org.apache.royale.events.IEventDispatcher;
	import org.apache.royale.collections.ArrayList;
	import mx.utils.ObjectUtil;

	//COMPILE::JS
	public class InspireTreeModel extends ArrayListSelectionModelTmp
	{
		/**
		 *  Constructor.
		 */
		public function InspireTreeModel()
		{
			super();
		}

		protected var isExtends:Boolean = false;

		/**
		 *  @private
		 *  @royaleignorecoercion org.apache.royale.collections.IArrayList
		 */
		override public function set dataProvider(value:Object):void
		{
			
			if( value == null)
				value = [];

			if(value is IArrayList)
			{
				super.dataProvider = value;
			}else{
				super.dataProvider = new ArrayList(value as Array);
			}
			if(isExtends)
				return;

			if(value is IArrayList)
			{
				treeData = (_strand as IInspireTree).prepareTreeDataFromArray(IArrayList(value).source);
				//_dataProviderTree = (_strand as IInspireTree).prepareTreeDataFromArray(IArrayList(value).source);
			}else{
				treeData = (_strand as IInspireTree).prepareTreeDataFromArray(value as Array);
				//_dataProviderTree = (_strand as IInspireTree).prepareTreeDataFromArray(value as Array);
			}
            //When cloning treeData, the type of the items is lost. (ItemTreeNode)
            _dataProviderTree = cloneArray(treeData);
			(_strand as IEventDispatcher).dispatchEvent("onPrepareTreeDataComplete");
		}

		protected var _dataProviderTree:Array = new Array();
		/**
		 * Original DataProvider formatted as expected by Tree
		 */
		public function get dataProviderTree():Array
		{
			return _dataProviderTree;
			/*if(dataProvider is IArrayList)
				return (_strand as IInspireTree).prepareTreeDataFromArray(IArrayList(dataProvider).source);
			else
				return (_strand as IInspireTree).prepareTreeDataFromArray(dataProvider as Array);
			*/
		}

		protected var _treeData:Array;// = new Array();
		/**
		 * DataProvider assigned to the Tree. It undergoes the same changes as the JS object.
		 */
		public function get treeData():Array { return _treeData; }
		public function set treeData(value:Array):void
		{
			if (value == _treeData) return;

			_treeData = value;
			//A mapping-binding is performed between the js object and the as object.
			configOption.data = _treeData;
			dispatchEvent(new Event("treeDataChanged"));
		}

		private var _childrenField:String = "children";
		/**
		 * Name of the attribute, in the dataProvider, where the child nodes are specified
		 */
		public function get childrenField():String { return _childrenField; }
		public function set childrenField(value:String):void
		{
			if (value != _childrenField) {
				_childrenField = value;
				dispatchEvent(new Event("childrenFieldChanged"));
			}
		}

		private var _boundField:String = "";
		/**
		 * When a non-hierarchical dataProvider is set, 'boundField', shall indicate the grouping attribute
		 */
		public function get boundField():String { return _boundField; }
		public function set boundField(value:String):void
		{
			if (value != _boundField) {
				_boundField = value;
				dispatchEvent(new Event("boundFieldChanged"));
			}
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
		private var _labelFunctionParent:Function = null;
		public function get labelFunctionParent():Function
		{
			if(!_labelFunctionParent)
				return itemToLabel;
			else
				return _labelFunctionParent;
		}
		public function set labelFunctionParent(value:Function):void{ _labelFunctionParent = value; }
		/**
		 * Function to obtain the description of the parent nodes.
		 * <p>The <code>labelFunctionChild</code> property takes a reference to a function.
     	 * The function takes a single argument which is the item in the data provider and returns a String:</p>
    	 *
		 *  <pre>myLabelFunction(item:Object):String</pre>
      	 *
     	 *  @param item The data item. Null items return the empty string.
		 */
		private var _labelFunctionChild:Function = null;
		public function get labelFunctionChild():Function
		{
			if(!_labelFunctionChild)
				return itemToLabel;
			else
				return _labelFunctionChild;
		}
		public function set labelFunctionChild(value:Function):void{ _labelFunctionChild = value; }

		private var _checkboxMode:Boolean = false;
		public function get checkboxMode():Boolean { return _checkboxMode; }
		/**
		 * Show checkbox on each node
		*/
		public function set checkboxMode(value:Boolean):void
		{
			if(_checkboxMode != value)
			{
				_checkboxMode = value;
				if( value )
					configOption.selection.mode = 'checkbox';
				else
					configOption.selection.mode = 'tree'; //default
                sendEvent(this,"checkboxModeChanged");
			}
		}

		private var _showCheckboxes:Boolean = false;
		public function get showCheckboxes():Boolean { return _showCheckboxes; }
		/**
		 * Show checkbox on each node
		*/
		public function set showCheckboxes(value:Boolean):void
		{
			if(_showCheckboxes != value)
			{
				//configOption.showCheckboxes = value;
				checkboxMode = value;
				configOptionView.showCheckboxes = value;
				_showCheckboxes = value;
                sendEvent(this,"showCheckboxesChanged");
			}
		}
		/**
		 * Allow Drag and Drop
		 */
		private var _allowDragAndDrop:Boolean = false;
		public function get allowDragAndDrop():Boolean { return _allowDragAndDrop; }
		public function set allowDragAndDrop(value:Boolean):void
		{
			if(_allowDragAndDrop != value)
			{
				_allowDragAndDrop = value;
				configOptionView.dragAndDrop = _allowDragAndDrop;
                sendEvent(this,"allowDragAndDropChanged");
			}
		}
		private var _checkedIsSelected:Boolean = true; //InspireTree JS Default Behavior
		public function get checkedIsSelected():Boolean{ return _checkedIsSelected; }
		public function set checkedIsSelected(value:Boolean):void
		{
			if (value == _checkedIsSelected) return;

			_checkedIsSelected = value;
			configOption.selection["checkedIsSelected"] = value;
		}

		/**
		 * Show paginated nodes.
		 * By default 10 nodes per page will be displayed, to change this, set the 'numNodesPage' property.
		 */
		private var _paginate:Boolean = false;
		public function get paginate():Boolean{ return _paginate; }
		public function set paginate(value:Boolean):void
		{
			if(_paginate != value)
			{
				_paginate = value;
                sendEvent(this,"paginateChanged");
			}
		}
        /**
         *  How many nodes are rendered/loaded at once.
         *  Used with deferrals. Defaults to nodes which fit in the container.
         */
        private var _numNodesPage:Number = -1;
        public function get numNodesPage():Number{ return _numNodesPage; }
        public function set numNodesPage(value:Number):void
		{
			if(_numNodesPage != value)
			{
				_numNodesPage = value;
				if(isNaN(_numNodesPage))
					_numNodesPage = 10;
                sendEvent(this,"numNodesPageChanged");
			}
		}

		private var _configOption:OptionsTree;
		public function get configOption():OptionsTree
		{
			if(!_configOption)
			{
				_configOption = new OptionsTree();
				_configOption.selection = {
					autoDeselect: true,
					autoSelectChildren: false,
					disableDirectDeselection: true,
					mode: 'tree',
					multiple: false,
					require: false,
					checkedIsSelected: false //As List
				};
				_configOption.data = [];
			}
			return _configOption;
		}
		public function set configOption(value:OptionsTree):void
		{
			if(_configOption != value)
			{
				_configOption = value;
                sendEvent(this,"ConfigOptionChanged");
			}
		}

		private var _configOptionView:ConfigDOM;
		public function get configOptionView():ConfigDOM
		{
			if(!_configOptionView)
			{
				_configOptionView = new ConfigDOM();
				_configOptionView.target = (_strand as HTMLElementWrapper).element;
				_configOptionView.nodeHeight = 35;
				_configOptionView.deferredRendering = false;
				_configOptionView.dragAndDrop = false;
			}
			return _configOptionView;
		}
		public function set configOptionView(value:ConfigDOM):void
		{
			if(_configOptionView != value)
			{
				_configOptionView = value;
                sendEvent(this,"ConfigOptionViewChanged");
			}
		}

		public var renderingNeededDataChange:Boolean = false;
		private var _useCustomStyle:Boolean = false;
		public function get useCustomStyle():Boolean{ return _useCustomStyle; }
		public function set useCustomStyle(value:Boolean):void
		{ 
			_useCustomStyle = value; 
			renderingNeededDataChange = true;
		}
		public var stringTypeMarkDOM:String = "markInactived";
		private var _useCustomRenderer:Boolean = false;		
		public function get useCustomRenderer():Boolean{ return _useCustomRenderer; }
		public function set useCustomRenderer(value:Boolean):void
		{ 
			_useCustomRenderer = value;
			renderingNeededDataChange = true;
		}

		protected function itemToLabel(item:Object):String
		{
			if(!item || item==null)
				return '';

			if(labelField && item.hasOwnProperty(labelField))
				return item[labelField];
			
			return '';
		}

        protected function clone(source:Array):Array
        {
            if(!source)
                return null;
            else
			{
				var ar:Array = new Array();
				var len:int = source.length;
				for(var index:int = 0; index < len; index++) {	ar.push( source[index] );	}
				return ar;
			}
        }

        protected function cloneArray(source:Array):Array
        {
            if(!source)
                return null;
            else
			{
                return ObjectUtil.clone(source) as Array;
			}
        }
		
	}

}
