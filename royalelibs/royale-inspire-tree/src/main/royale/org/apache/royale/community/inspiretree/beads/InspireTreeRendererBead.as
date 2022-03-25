package org.apache.royale.community.inspiretree.beads
{
	/**
	 *  @langversion 3.0
	 *  @playerversion Flash 10.2
	 *  @playerversion AIR 2.6
	 *  @productversion Royale 0.9.8
	 */
	import org.apache.royale.core.IBead;
	import org.apache.royale.core.IStrand;
	import org.apache.royale.core.Strand;
	import org.apache.royale.community.inspiretree.beads.models.InspireTreeModel;
	import org.apache.royale.events.IEventDispatcher;
	import org.apache.royale.community.inspiretree.controls.InspireTreeBasicControl;
	import org.apache.royale.community.inspiretree.supportClasses.IInspireTreeRenderer;
	import org.apache.royale.core.IDataProviderModel;
	import org.apache.royale.core.IStrandWithModel;

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
			(_strand as IEventDispatcher).addEventListener("onCreationComplete", updateHost);

			if(treeModel)
			{
				treeModel.useCustomRenderer = true;
				if( stringTypeMarkDOM )
					treeModel.stringTypeMarkDOM = stringTypeMarkDOM;
			    initialized = true;
			}
		}

		protected var _markDOMField:String = "";
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
		protected var _markDOMFunction:Function = itemMarkDOMFunction;
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

		private function itemMarkDOMFunction(itemTreeData:Object, itemFlatData:Object):Boolean
		{
			if(!itemFlatData || !markDOMField)
				return false;

			if( itemFlatData[markDOMField] == null )
				return false;

			if( itemFlatData[markDOMField] is Number )
				return Number(itemFlatData[markDOMField])>0 ? true:false;

			if( itemFlatData[markDOMField] is Boolean )
				return itemFlatData[markDOMField] as Boolean;

			return false;
		}

        public function prepareRenderer(node:Object):Object
        {
            //(node as ItemTreeNode).itree.state.indeterminate = true;
            return node;
        }

		protected function updateHost(event:Event = null):void
		{
			if(!strand || !initialized)
				return;

			var hostComponent:InspireTreeBasicControl = strand as InspireTreeBasicControl;
			if(!hostComponent.dataProvider)
				return;
			var modelDada:Array = IDataProviderModel(hostComponent.model).dataProvider.source;
			var idxGen:int = 0;
			var idxChild:int=0;
			var isMarked:Boolean = false;
			var marked:Boolean;
			var treenode:Object;

			hostComponent.jsTree.forEach(function(treenode:Object):void
			{
                var mark:int = 0;
				if(treenode.children!=null)
				{
					for (idxChild=0; idxChild < treenode.children.length; idxChild++)
					{
						if( idxGen < modelDada.length)
						{
							var itemdata:Object = modelDada[idxGen];
							marked = markDOMFunction(treenode.children[idxChild],itemdata);
							if( marked ){
								treenode.children[idxChild].itree.state.checked = false;
								treenode.children[idxChild].itree.state.indeterminate = true;
								treenode.children[idxChild].itree.state.selectable = false;
								isMarked = true;
                                mark++;
							}
						}
						idxGen++;
					}
					if(mark == treenode.children.length) //Disabled root
					{
						treenode.itree.state.checked = false;
						treenode.itree.state.indeterminate = true;
						treenode.itree.state.selectable = false;
					}
				}
			});
			if(isMarked)
			{
				//We have to reload the data for the DOM to be updated.
				hostComponent.jsTree.reload();
				idxGen=0;
				hostComponent.jsTree.forEach(function(treenode:Object):void
				{
					if(treenode.children!=null)
					{
						var numnoactive:int = 0;
						var row:HTMLElement;
						var titlerow:HTMLElement;
						var wholerow:HTMLElement;
						for (idxChild=0; idxChild < treenode.children.length; idxChild++)
						{
							if( idxGen < modelDada.length)
							{
								var itemdata:Object = modelDada[idxGen];
								marked = markDOMFunction(treenode.children[idxChild],itemdata);
								row = treenode.children[idxChild].itree.ref as HTMLElement;						
								titlerow = treenode.children[idxChild].itree.ref.childNodes[0] as HTMLElement;
								wholerow = treenode.children[idxChild].itree.ref.childNodes[1] as HTMLElement;
								if( marked ){								
									row.setAttribute('type',treeModel.stringTypeMarkDOM);
									titlerow.setAttribute('type',treeModel.stringTypeMarkDOM);
									wholerow.setAttribute('type',treeModel.stringTypeMarkDOM);
								}else{
									row.removeAttribute("type");
									titlerow.removeAttribute("type");
									wholerow.removeAttribute("type");
									numnoactive++;
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
				});
			}
		}
		
	}

    COMPILE::SWF
	public class InspireTreeRendererBead
	{
    }
}
