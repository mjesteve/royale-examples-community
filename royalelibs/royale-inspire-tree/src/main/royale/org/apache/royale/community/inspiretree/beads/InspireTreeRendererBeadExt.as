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

			//(strand as IInspireTree).jsTree.off('node.checked', onNodeCheckedHandler);
		}

		override protected function updateHost(event:Event = null):void
		{
				
			(strand as IEventDispatcher).removeEventListener("onCreationComplete", updateHost);
			(strand as IEventDispatcher).addEventListener("onBeforeCreation", removeListeners);

			if(!initialized || !treeModel.dataProviderTree)
				return;

			//(strand as IInspireTree).jsTree.on('node.checked', onNodeCheckedHandler);
			//(strand as IInspireTree).jsTree.on('node.unchecked', onNodeCheckedHandler);

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
				
				if(treenode.hasChildren())
				{
					var arAct:Array = new Array();					
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
							arAct.push(titlerow);
						}
					}

					row = treenode.itree.ref as HTMLElement;
					titlerow = treenode.itree.ref.childNodes[0] as HTMLElement;
					wholerow = treenode.itree.ref.childNodes[1] as HTMLElement;
					if(arAct.length == 0) //Disabled root
					{
						row.setAttribute('type',treeModel.stringTypeMarkDOM);
						titlerow.setAttribute('type',treeModel.stringTypeMarkDOM);
						wholerow.setAttribute('type',treeModel.stringTypeMarkDOM);
					}else{
						row.removeAttribute("type");
						titlerow.removeAttribute("type");
						wholerow.removeAttribute("type");
						if(treeModel.checkboxMode && arAct.length<lench)
						{
							var checkbox:HTMLElement = titlerow.children[1] as HTMLElement;
							checkbox.addEventListener( "click", checkRootMark, true ); //fase captura

							for (idxChild=0; idxChild < arAct.length; idxChild++)
							{
								checkbox = (arAct[idxChild] as HTMLElement).children[0] as HTMLElement;
								checkbox.addEventListener( "click", checkChildMark, true ); //fase captura
							}
						}
					}
				}
			}
			//);
		}

		private function checkRootMark(event:Event):void
		{
			event.preventDefault();
			event.stopImmediatePropagation();

			var vNode:Object = (event.currentTarget as Object).$V;
			var newstate:String;
			if( (vNode.props.indeterminate as Boolean) == true || (vNode.props.checked as Boolean) == false )
				newstate = "checked";
			else
				newstate = "unchecked";
			
			//event.path[2] = "li" parent - node
			//attributes[1] = data-uid
			var idNode:String = event.path[2].attributes[1].value as String;
			setTimeout(setRootStateBatch,125,idNode,newstate);
		}

		private function checkChildMark(event:Event):void
		{
			event.preventDefault();
			/*event.stopImmediatePropagation();

			var vNode:Object = (event.currentTarget as Object).$V;
			var newstate:String;
			if( (vNode.props.checked as Boolean) == false )
				newstate = "checked";
			else
				newstate = "unchecked";
			
			//event.path[2] = "li" parent - node
			//attributes[1] = data-uid
			var idNode:String = event.path[2].attributes[1].value as String;
			setTimeout(setRootStateBatch,125,idNode,newstate);*/
		}

		private function setRootStateBatch(idNode:String, newState:String):void
		{
			var treenode:Object = (strand as IInspireTree).jsTree.node(idNode);			
			var lench:int = treenode.children.length;						
			for (var idxChild:int=0; idxChild < lench; idxChild++)
			{
				var itemch:Object = treenode.children[idxChild];
				var wholerow:HTMLElement = itemch.itree.ref.childNodes[1] as HTMLElement;				
				if( wholerow.getAttribute('type') != treeModel.stringTypeMarkDOM ){
					if( newState == "checked")
						(strand as IInspireTree).jsTree.node(itemch.id).check(true);
					else
						(strand as IInspireTree).jsTree.node(itemch.id).uncheck(true);
				}
			}
			
			if( newState == "checked")
				treenode.check(true);
			else
				treenode.uncheck(true);
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
