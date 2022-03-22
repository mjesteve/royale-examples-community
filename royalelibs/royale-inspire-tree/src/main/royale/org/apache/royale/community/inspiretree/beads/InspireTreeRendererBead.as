package org.apache.royale.community.inspiretree.beads
{
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
				if( stringTypeMarkDOM )
					treeModel.stringTypeMarkDOM = stringTypeMarkDOM;
			    initialized = true;
			}
		}

		private var _markDOMField:String = "";
		/**
		 * Name of the attribute, in the dataProvider, where the active value is defined.
		 * Expected values: 0/1 or true/false
		 */
		public function get markDOMField():String {return _markDOMField; }
		public function set markDOMField(value:String):void{ _markDOMField = value;}
		/**
		 * Function to get the active status of the child nodes.
		 * <p>The <code>markDOMFunction</code> property takes a reference to a function.
     	 * The function takes a single argument which is the item of the data provider and returns a boolean:</p>
    	 *
		 *  <pre>myActiveFunction(item:Object):Boolean</pre>
      	 *
     	 *  @param item The data item. Null items return false.
		 */
		private var _markDOMFunction:Function = itemMarkDOMFunction;
		public function get markDOMFunction():Function{return _markDOMFunction; }
		public function set markDOMFunction(value:Function):void{ _markDOMFunction = value;}

		private var _stringTypeMarkDOM:String;
		public function get stringTypeMarkDOM():String
		{ 
			return _stringTypeMarkDOM; 
		}
		public function set stringTypeMarkDOM(value:String):void
		{ 
			_stringTypeMarkDOM = value; 
			if( treeModel )
				treeModel.stringTypeMarkDOM = value;
		}

		private function itemMarkDOMFunction(itemDataProv:Object):Boolean
		{
			if(!itemDataProv || !markDOMField)
				return false;

			if( itemDataProv[markDOMField] == null )
				return false;

			if( itemDataProv[markDOMField] is Number )
				return Number(itemDataProv[markDOMField])>0 ? true:false;

			if( itemDataProv[markDOMField] is Boolean )
				return itemDataProv[markDOMField] as Boolean;

			return false;
		}

        public function prepareRenderer(node:Object):Object
        {
           // (node as ItemTreeNode).itree.state.selectable = false;
            return node;
        }

		private function updateHost(event:Event = null):void
		{
			if(!strand || !initialized)
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
					var titlerow:HTMLElement;
					var wholerow:HTMLElement;
					for (var idxChild:int=0; idxChild < treenode.children.length; idxChild++)
					{
						if( idxGen < hostComponent.dataProvider.length)
						{
							actived = markDOMFunction(hostComponent.dataProvider[idxGen]);
							row = treenode.children[idxChild].itree.ref as HTMLElement;						
							titlerow = treenode.children[idxChild].itree.ref.childNodes[0] as HTMLElement;
							wholerow = treenode.children[idxChild].itree.ref.childNodes[1] as HTMLElement;
							if( actived )
							{
								row.removeAttribute("type");
								titlerow.removeAttribute("type");
								wholerow.removeAttribute("type");
								numnoactive++;
							}else{
								row.setAttribute('type',treeModel.stringTypeMarkDOM);
								titlerow.setAttribute('type',treeModel.stringTypeMarkDOM);
								wholerow.setAttribute('type',treeModel.stringTypeMarkDOM);
							}
						}
						idxGen++;
					}

					row = treenode.itree.ref as HTMLElement;
					titlerow = treenode.itree.ref.childNodes[0] as HTMLElement;
					wholerow = treenode.itree.ref.childNodes[1] as HTMLElement;
					if(numnoactive == 0) //Disabled root
					{
						row.setAttribute('type',treeModel.stringTypeMarkDOM);
						titlerow.setAttribute('type',treeModel.stringTypeMarkDOM);
						wholerow.setAttribute('type',treeModel.stringTypeMarkDOM);
					}else{
						row.removeAttribute("type");
						titlerow.removeAttribute("type");
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
