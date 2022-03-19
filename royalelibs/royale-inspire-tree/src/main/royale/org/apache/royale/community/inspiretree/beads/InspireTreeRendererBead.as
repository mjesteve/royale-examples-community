package org.apache.royale.community.inspiretree.beads
{
	import TreeNode;

	/**
	 *  @langversion 3.0
	 *  @playerversion Flash 10.2
	 *  @playerversion AIR 2.6
	 *  @productversion Royale 0.9.8
	 */
	import org.apache.royale.core.IBead;
	import org.apache.royale.core.IBeadModel;
	import org.apache.royale.core.IStrand;
	import org.apache.royale.core.Strand;
	import org.apache.royale.community.inspiretree.beads.models.InspireTreeModel;
	import org.apache.royale.events.IEventDispatcher;
	import org.apache.royale.community.inspiretree.controls.InspireTreeBasicControl;
	import org.apache.royale.community.inspiretree.supportClasses.IInspireTreeRenderer;

    COMPILE::JS
	public class InspireTreeRendererBead  extends Strand implements IBead, IInspireTreeRenderer
	{
		/**
		 *  constructor
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.7
		 */

		public function InspireTreeRendererBead()
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
		}

		protected var initialized:Boolean = false;

		private var _treeModel:InspireTreeModel;
		private function get treeModel():InspireTreeModel{
			if(_strand && !_treeModel)
			{
				_treeModel = _strand.getBeadByType(IBeadModel) as InspireTreeModel;
			}
			return _treeModel;
		}

		private function init(event:Event):void
		{
			(_strand as IEventDispatcher).removeEventListener("initComplete", init);
			(_strand as IEventDispatcher).addEventListener("onCreationComplete", updateHost);

			if(treeModel)
			{
				treeModel.useCustomRenderer = true;
                //updateHost(null);
			    initialized = true;
			}
		}

		private var _activeItemField:String = "";
		/**
		 * Name of the attribute, in the dataProvider, where the active value is defined.
		 * Expected values: 0/1 or true/false
		 */
		public function get activeItemField():String {return _activeItemField; }
		public function set activeItemField(value:String):void{ _activeItemField = value;}
		/**
		 * Function to get the active status of the child nodes.
		 * <p>The <code>activeItemFunction</code> property takes a reference to a function.
     	 * The function takes a single argument which is the item of the data provider and returns a boolean:</p>
    	 *
		 *  <pre>myActiveFunction(item:Object):Boolean</pre>
      	 *
     	 *  @param item The data item. Null items return false.
		 */
		private var _activeItemFunction:Function = itemChildActived;
		public function get activeItemFunction():Function{return _activeItemFunction; }
		public function set activeItemFunction(value:Function):void{ _activeItemFunction = value;}

		private function itemChildActived(itemDataProv:Object):Boolean
		{
			if(!itemDataProv || !activeItemField)
				return false;

			if( itemDataProv[activeItemField] == null )
				return false;

			if( itemDataProv[activeItemField] is Number )
				return Number(itemDataProv[activeItemField])>0 ? true:false;

			if( itemDataProv[activeItemField] is Boolean )
				return itemDataProv[activeItemField] as Boolean;

			return false;
		}

        public function prepareRenderer(node:Object):Object
        {
           // (node as ItemTreeNode).itree.state.selectable = false;
            return node;
        }

		private function updateHost(event:Event = null):void
		{
			if(!strand)
				return;

			var hostComponent:InspireTreeBasicControl = strand as InspireTreeBasicControl;
			if(!hostComponent.dataProvider)
				return;

			var idxNode:int = 0;
			for (var idxGen:int=0; idxGen < hostComponent.dataProvider.length; idxGen++)
        	{
				var treenode:Object = hostComponent.jsTree.model[idxNode];
				if(treenode.children!=null)
				{
					var numnoactive:int = 0;
					var actived:Boolean;
					var row:HTMLElement;
					var wholerow:HTMLElement;
					for (var idxChild:int=0; idxChild < treenode.children.length; idxChild++)
					{
						if( idxGen < hostComponent.dataProvider.length)
						{
							actived = activeItemFunction(hostComponent.dataProvider[idxGen]);
							row = treenode.children[idxChild].itree.ref as HTMLElement;						
							wholerow = treenode.children[idxChild].itree.ref.childNodes[1] as HTMLElement;
							if( actived )
							{
								row.removeAttribute("type");
								wholerow.removeAttribute("type");
								numnoactive++;
							}else{
								row.setAttribute('type',"disabled");
								wholerow.setAttribute('type',"disabled");
							}
						}
						idxGen++;
					}

					row = treenode.itree.ref as HTMLElement;						
					wholerow = treenode.itree.ref.childNodes[1] as HTMLElement;
					if(numnoactive == 0) //Disabled root
					{
						row.setAttribute('type',"disabled");
						wholerow.setAttribute('type',"disabled");
					}else{
						row.removeAttribute("type");
						wholerow.removeAttribute("type");
					}
				}
				idxNode++;
			}
		}

	}

    COMPILE::SWF
	public class InspireTreeRendererBead
	{
    }
}
