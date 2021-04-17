package org.apache.royale.community.beads.views
{
    
	import org.apache.royale.events.Event;
    import org.apache.royale.community.controls.PageNavigatorButtonBar;
    import org.apache.royale.jewel.beads.views.ButtonBarView;
    import org.apache.royale.core.IStrand;
    import org.apache.royale.core.IDataProviderModel;
    import org.apache.royale.utils.sendStrandEvent;

    public class PageNavigatorButtonBarView extends ButtonBarView
    {

        public function PageNavigatorButtonBarView (){
            super();
        }
		
		private var _buttonBar:PageNavigatorButtonBar;
		/**
		 *  the PageNavigatorButtonBar associated to this view
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.7
		 */
		override public function get buttonBar():PageNavigatorButtonBar
		{
			return _strand as PageNavigatorButtonBar;
		}
		override public function set buttonBar(value:PageNavigatorButtonBar):void
		{
			_strand = value as PageNavigatorButtonBar;
		}
		
		/**
		 *  @copy org.apache.royale.core.IBead#strand
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.8
		 */
		override public function set strand(value:IStrand):void
		{
			super.strand = value;
            var dataModel:IDataProviderModel = _strand.getBeadByType(IDataProviderModel) as IDataProviderModel;
			dataModel.addEventListener("selectedIndexChanged", selectedIndexChangeHandler);
		}

        protected function selectedIndexChangeHandler(event:Event):void
        {
            //trace("selectedindex change: " + buttonBar.selectedIndex.toString());
            //sendStrandEvent(_strand,"layoutNeeded"); --> Necesitamos lanzar un        
        }



    }
}