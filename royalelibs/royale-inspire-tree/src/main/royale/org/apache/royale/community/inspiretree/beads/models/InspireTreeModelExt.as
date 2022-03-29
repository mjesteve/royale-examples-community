package org.apache.royale.community.inspiretree.beads.models
{
	import org.apache.royale.collections.IArrayList;
	import org.apache.royale.community.inspiretree.supportClasses.IInspireTree;
	import org.apache.royale.events.IEventDispatcher;
	import org.apache.royale.collections.ArrayList;
	import org.apache.royale.community.inspiretree.vos.normalizeDataItem;

	//COMPILE::JS
	public class InspireTreeModelExt extends InspireTreeModel
	{
		/**
		 *  Constructor.
		 */
		public function InspireTreeModelExt()
		{
			super();
			isExtends = true;
		}

		/**
		 *  @private
		 *  @royaleignorecoercion org.apache.royale.collections.IArrayList
		 */
		override public function set dataProvider(value:Object):void
		{
			if( value == null)
				value = [];

			var tmpdata:Array;
			if(value is IArrayList)
			{
				tmpdata = normalizeDataProvider(IArrayList(value).source);
			}else{
				tmpdata = normalizeDataProvider(value as Array);
			}
			//tmpdata 			--> flat, normalized
			//_dataProviderTree --> tree, normalized
			//treeData 			--> tree, itemTreeNode (* jsTree)
			treeData = (_strand as IInspireTree).prepareTreeDataFromArray(tmpdata, _dataProviderTree);
			
			super.dataProvider = new ArrayList(tmpdata);

			(_strand as IEventDispatcher).dispatchEvent("onPrepareTreeDataComplete");
		}

		override public function get dataProviderTree():Array
		{
			return _dataProviderTree;
		}

		private var _revertNode:Object;
		public function get revertNode():Object{ return _revertNode; }
		public function set revertNode(value:Object):void
		{ 
			_revertNode = value; 
            (_strand as IEventDispatcher).dispatchEvent("revertNodeChanged");
		}

		private function normalizeDataProvider(ar:Array):Array
		{	
			if(!ar)
				return null;
			var arnor:Array = new Array();
			var len:int = ar.length;
			for(var index:int = 0; index < len; index++)
			{
				arnor.push( new normalizeDataItem(ar[index]) );
			}
			return arnor;
		}
		
		public var checkboxFunction:Function;
		public var markDOMFunction:Function;

		public var markIsDisabled:Boolean = true;
		
		//"unchecked" and "same" do not correspond to any "state" of InspireTree, they are for convenience.
        [Inspectable(category="General", enumeration="checked,unchecked,indeterminate,same,selectable")]
		public var markToState:String = "same";
		
	}

}
