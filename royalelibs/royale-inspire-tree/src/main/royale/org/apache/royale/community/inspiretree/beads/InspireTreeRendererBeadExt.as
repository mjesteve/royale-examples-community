package org.apache.royale.community.inspiretree.beads
{
	/**
	 *  @langversion 3.0
	 *  @playerversion Flash 10.2
	 *  @playerversion AIR 2.6
	 *  @productversion Royale 0.9.8
	 */
	import org.apache.royale.events.IEventDispatcher;
	import org.apache.royale.community.inspiretree.beads.models.InspireTreeModelExt;
	import org.apache.royale.community.inspiretree.supportClasses.IInspireTree;
	import org.apache.royale.community.inspiretree.vos.normalizeDataItem;
	import org.apache.royale.core.IStrandWithModel;

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
				_treeModel = (strand as IStrandWithModel).model as InspireTreeModelExt;
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
		//"unchecked" and "same" do not correspond to any "state" of InspireTree, they are for convenience.
        [Inspectable(category="General", enumeration="checked,unchecked,indeterminate,same,selectable")]
		public function set markToState(value:String):void
		{ 
			_markToState = value; 
			if(treeModel)
				treeModel.markToState = value;
		}

		override protected function init(event:Event):void
		{
			(strand as IEventDispatcher).removeEventListener("initComplete", init);
			(strand as IEventDispatcher).addEventListener("onBeforeCreation", removeListeners);
			//(strand as IEventDispatcher).addEventListener("onCreationComplete", updateHost);
			(strand as IEventDispatcher).addEventListener("revertNodeChanged", updateHost);

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

		private function removeListeners():void
		{
			(strand as IEventDispatcher).removeEventListener("onBeforeCreation", removeListeners);
			(strand as IEventDispatcher).addEventListener("onCreationComplete", updateHost);

			if( !(strand as IInspireTree).jsTree )
				return;

			(strand as IInspireTree).jsTree.off('node.checked', onNodeCheckedHandler);
		}

		override protected function updateHost(event:Event = null):void
		{
				
			(strand as IEventDispatcher).removeEventListener("onCreationComplete", updateHost);
			(strand as IEventDispatcher).addEventListener("onBeforeCreation", removeListeners);

			if(!initialized || !treeModel.dataProviderTree)
				return;

			(strand as IInspireTree).jsTree.on('node.checked', onNodeCheckedHandler);
			(strand as IInspireTree).jsTree.on('node.unchecked', onNodeCheckedHandler);

			var hostComponent:IInspireTree = strand as IInspireTree;
			if(treeModel.revertNode)
				hostComponent.jsTree.reload();
			var idxChild:int;
			var marked:Boolean;

			//No utilizamos jsTree.forEach porque no podemos salirnos del bucle una vez encontrado el nodo que queremos deshacer.
			//We do not use jsTree.forEach because we cannot exit the loop once we have found the node we want to undo.
			//(strand as IInspireTree).jsTree.forEach(function(treenode:Object):void
			//hostComponent.jsTree.forEach(function(treenode:Object):void{

			var lenar:int = treeModel.dataProviderTree.length;
			for (var idxnode:int=0; idxnode < lenar; idxnode++)
			{
				var treenode:Object = hostComponent.jsTree.model[idxnode];
				var itreal:normalizeDataItem;
				
				//if( !treeModel.revertNode || (treeModel.revertNode && treenode.id == treeModel.revertNode.id))
				//{
					if(treenode.hasChildren())
					{
						var numactive:int = 0;
						var row:HTMLElement;
						var titlerow:HTMLElement;
						var wholerow:HTMLElement;
						var lench:int = treenode.children.length;
						for (idxChild=0; idxChild < lench; idxChild++)
						{
							itreal = (treeModel.dataProviderTree[idxnode] as normalizeDataItem).children[idxChild];
							marked = markDOMFunction(treenode.children[idxChild],(itreal as normalizeDataItem).data);
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
								numactive++;
							}
						}

						row = treenode.itree.ref as HTMLElement;
						titlerow = treenode.itree.ref.childNodes[0] as HTMLElement;
						wholerow = treenode.itree.ref.childNodes[1] as HTMLElement;
						if(numactive == 0) //Disabled root
						{
							row.setAttribute('type',treeModel.stringTypeMarkDOM);
							titlerow.setAttribute('type',treeModel.stringTypeMarkDOM);
							wholerow.setAttribute('type',treeModel.stringTypeMarkDOM);
						}else{
							if(treeModel.checkboxMode && numactive<lench)
							{
								var checkboxRoot:HTMLElement = titlerow.children[1] as HTMLElement;
								checkboxRoot.addEventListener( "click", checkRootMark, true ); //fase captura
							}
							row.removeAttribute("type");
							titlerow.removeAttribute("type");
							wholerow.removeAttribute("type");
						}
					}
				//}
				
			}
			//);
		}

		private function checkRootMark(event:Event):void
		{
			event.preventDefault();
			event.stopImmediatePropagation();
			//event.path[2] = "li" parent - node
			//attributes[1] = data-uid
			var idNode:String = event.path[2].attributes[1].value as String;
			trace(idNode);
			var treeNode:Object = (strand as IInspireTree).jsTree.node(idNode);
			var vNode:Object = (event.currentTarget as Object).$V;
			if( (vNode.props.indeterminate as Boolean) == true )
			{
				//go to "checked"
				trace(vNode);
			}else if( (vNode.props.checked as Boolean) == true ){
				//go to "uncheked"
			}else{
				//go to "checked"
			}
			var oldvalue:Boolean = vNode.props.checked as Boolean;
			if(oldvalue == false)
			var newvalue:Boolean = !oldvalue;
			
		}

		public function onNodeCheckedHandler(treeNode:Object, isLoadEvent:Boolean):void
		{
			//(strand as IInspireTree).jsTree.off('node.checked', onNodeCheckedHandler);
			trace(treeNode);
			//treeNode.uncheck(true);
		}

		protected function updateHostOld(event:Event = null):void
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
		}
		
	}

    COMPILE::SWF
	public class InspireTreeRendererBeadExt
	{
    }
}
