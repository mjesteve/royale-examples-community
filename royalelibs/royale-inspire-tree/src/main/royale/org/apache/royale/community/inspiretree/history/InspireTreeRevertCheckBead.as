package org.apache.royale.community.inspiretree.beads
{	
	
	/**  
	 *  @langversion 3.0
	 *  @playerversion Flash 10.2
	 *  @playerversion AIR 2.6
	 *  @productversion Royale 0.9.8
	 */
	COMPILE::JS{
	import org.apache.royale.core.IBead;
    import org.apache.royale.core.IBeadModel;
	import org.apache.royale.core.IStrand;
	import org.apache.royale.core.Strand;
    import org.apache.royale.events.Event;
    import org.apache.royale.events.IEventDispatcher;
    import org.apache.royale.community.inspiretree.beads.models.InspireTreeModel;
    import org.apache.royale.community.inspiretree.IInspireTree;
    import org.apache.royale.core.StyledUIBase;
    import org.apache.royale.community.inspiretree.vos.ItemTreeNode;
	}
	/**
	 * Deprecate - Use the combined bead "InspireTreeIconBead" instead.
	 */
    COMPILE::JS
	public class InspireTreeRevertCheckBead  extends Strand implements IBead
	{
		/**
		 *  constructor
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.7
		 */

		public function InspireTreeRevertCheckBead()
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
			(_strand as IEventDispatcher).addEventListener("onBeforeCreation", init);
		} 

		private function init(event:Event):void
		{
			if( (_strand.getBeadByType(IBeadModel) as InspireTreeModel).checkboxMode == false && _revertIcon)
				revertIcon = false;

			if(revertIcon)
				(_strand as IEventDispatcher).addEventListener("onCreationComplete", createListeners);
		}

		private function createListeners():void
		{
			(_strand as IInspireTree).jsTree.on('node.click', onClickHandler);
		}

		private var _revertIcon:Boolean = false;
		public function get revertIcon():Boolean{ return _revertIcon; }
		public function set revertIcon(value:Boolean):void
		{ 
			if(_revertIcon != value)
			{
				if(value && (_strand.getBeadByType(IBeadModel) as InspireTreeModel).checkboxMode == false)
					return;
				_revertIcon = value; 
				updateHost();
			}
		}

		private function updateHost():void
		{
			if(!strand)	
				return;

			if(_revertIcon){
				(_strand as StyledUIBase).element.classList.add("editrevert");
				if((_strand as IInspireTree).jsTree)
					(_strand as IInspireTree).jsTree.on('node.click', onClickHandler);
			}else{									
				(_strand as StyledUIBase).element.classList.remove("editrevert");
				if((_strand as IInspireTree).jsTree)
					(_strand as IInspireTree).jsTree.off('node.click', onClickHandler);
			}

		}
			  
		public function onClickHandler(event:*, node:ItemTreeNode):void
		{
			if(event["clientX"] >= (_strand as StyledUIBase).width - 20)
			{
				fn_RevertSpecificNode(node.id, true);
			}
		}
		
		public function fn_RevertSpecificNode(pNodeFilter:String, byID:Boolean):String
		{ 	
			var idNodeParent:String;
			var arOrg:Array = (_strand.getBeadByType(IBeadModel) as InspireTreeModel).dataProviderTree;
			var lenar:int = arOrg.length;

			for (var idxnode:int=0; idxnode < lenar; idxnode++)
			{
				var it:Object = arOrg[idxnode]; //var it:ItemTreeNode;
				var itreal:Object = (_strand as IInspireTree).jsTree.model[idxnode]; //var itreal:TreeNode //jsTree.node(it.id)

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
								(_strand as IInspireTree).jsTree.node(itemch.id).uncheck(true);
							else
								(_strand as IInspireTree).jsTree.node(itemch.id).check(true);
						}					
					}

					if(itreal.itree.state.checked != it.itree.state.checked)
					{
						(_strand as IInspireTree).jsTree.node(it.id).refreshIndeterminateState();
					}
					break;
				}
			}

			return idNodeParent;
		}


	}

    COMPILE::SWF
	public class InspireTreeRevertCheckBead
	{
    }
}
