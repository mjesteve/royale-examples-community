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
	import org.apache.royale.core.IDataProviderModel;
	import org.apache.royale.community.inspiretree.beads.models.InspireTreeModelExt;
	import org.apache.royale.community.inspiretree.supportClasses.IInspireTree;
	import org.apache.royale.community.inspiretree.vos.normalizeDataItem;

    COMPILE::JS
	public class InspireTreeRendererBeadExt extends InspireTreeRendererBead
	{
		/**
		 *  constructor
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.7
		 */

		public function InspireTreeRendererBeadExt()
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
		
		override public function set markDOMFunction(value:Function):void
		{ 
			super.markDOMFunction = value;
			if(treeModel)
				treeModel.markDOMFunction = value;
		}

		private var _markIsDisabled:Boolean = true;
		public function get markIsDisabled():Boolean{ return _markIsDisabled; }
		public function set markIsDisabled(value:Boolean):void
		{ 
			_markIsDisabled = value;
			if(treeModel)
				treeModel.markIsDisabled = value;
		}
		private var _markToState:String;
		public function get markToState():String{ return _markToState; }
		public function set markToState(value:String):void
		{ 
			_markToState = value; 
			if(treeModel)
				treeModel.markToState = value;
		}

		override protected function init(event:Event):void
		{
			(strand as IEventDispatcher).removeEventListener("initComplete", init);
			(strand as IEventDispatcher).addEventListener("onCreationComplete", updateHost);

			if(treeModel)
			{
				treeModel.useCustomRenderer = true;
				if( stringTypeMarkDOM )
					treeModel.stringTypeMarkDOM = stringTypeMarkDOM;

				if(!treeModel.markDOMFunction && _markDOMFunction)
					treeModel.markDOMFunction = _markDOMFunction;

				if( _markToState )
					treeModel.markToState = _markToState;
				
				treeModel.markIsDisabled = _markIsDisabled;

			    initialized = true;
			}
		}

		override protected function updateHost(event:Event = null):void
		{
			if(!strand || !initialized)
				return;

			var hostComponent:IInspireTree = strand as IInspireTree;			
			if(!treeModel.dataProvider)
				return;
			var modelDada:Array = treeModel.dataProvider.source;
			var idxGen:int = 0;
			var idxChild:int=0;
			var isMarked:Boolean = false;
			var marked:Boolean;
			var treenode:Object;
			/*
			hostComponent.jsTree.forEach(function(treenode:Object):void
			{
                var mark:int = 0;
				if(treenode.children!=null)
				{
					for (idxChild=0; idxChild < treenode.children.length; idxChild++)
					{
						if( idxGen < modelDada.length)
						{
							var itemdata:Object = normalizeDataItem(modelDada[idxGen]).data;
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
				hostComponent.jsTree.reload();*/
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
								var itemdata:Object = normalizeDataItem(modelDada[idxGen]).data;
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
			//}
		}
		
	}

    COMPILE::SWF
	public class InspireTreeRendererBeadExt
	{
    }
}
