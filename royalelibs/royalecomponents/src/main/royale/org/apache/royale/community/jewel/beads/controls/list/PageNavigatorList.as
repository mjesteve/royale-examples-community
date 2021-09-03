package org.apache.royale.community.jewel.beads.controls.list
{
    
	import org.apache.royale.core.Bead;
	import org.apache.royale.core.IStrand;
	import org.apache.royale.events.Event;
    import org.apache.royale.jewel.List;
    import org.apache.royale.community.controls.PageNavigatorButtonBar;
    import org.apache.royale.community.vo.PageNavigatorButtonBarVO;
    import org.apache.royale.collections.ArrayListView;
    import org.apache.royale.collections.ArrayList;
    import org.apache.royale.community.beads.models.PageNavigatorButtonBarModel;

    public class PageNavigatorList  extends Bead
    {
		/**
		 *  constructor.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.6
		 */
		public function PageNavigatorList()
		{
		}

		private var _pageNavigator:PageNavigatorButtonBar;
		[Bindable]
		public function get pageNavigator():PageNavigatorButtonBar
		{
			return _pageNavigator;
		}
		public function set pageNavigator(value:PageNavigatorButtonBar):void
		{
			removeListListeners();
			
			_pageNavigator = value;

			addListListeners();
		}

		protected function addListListeners():void {
			if(_pageNavigator)
			{
				_pageNavigator.addEventListener('change', pageChangedEventHandler);
				PageNavigatorButtonBarModel(_pageNavigator.model).addEventListener('pageSizeChanged', pageSizeChangedEventHandler);
			}
		}

		protected function removeListListeners():void {
			if(_pageNavigator)
			{
				_pageNavigator.removeEventListener('change', pageChangedEventHandler);
				PageNavigatorButtonBarModel(_pageNavigator.model).removeEventListener('pageSizeChanged', pageSizeChangedEventHandler);
			}
		}
		
		/**
		 *  @copy org.apache.royale.core.IBead#strand
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.6
		 *  @royaleignorecoercion org.apache.royale.events.IEventDispatcher;
		 */
		override public function set strand(value:IStrand):void
		{
			_strand = value;
			//listenOnStrand('dataProviderChanged', dataProviderListChangedEventHandler);
		}

		private function pageChangedEventHandler(event:Event):void
		{
            var proposedPage:int = (event.target.selectedItem as PageNavigatorButtonBarVO).valuePage;
            applyFilter(proposedPage);
		}

		private function pageSizeChangedEventHandler(event:Event):void
		{
            _pageNavigator.currentPage = -1;
            applyFilter(1);
		}
		
		private var _dataProvider:ArrayList;
		[Bindable("dataProviderChanged")]
        public function get dataProvider():ArrayList
        {
            return _dataProvider;
        }
        public function set dataProvider(value:ArrayList):void
        {
            _dataProvider = value;
			applyFilter();
        }

        private function applyFilter(proposedPage:int = -1):void
        {
			if(!_pageNavigator)
				return;

			var ar:Array = !_dataProvider ? new Array() : _dataProvider.source;
            var asourceSearch:ArrayListView = new ArrayListView(new ArrayList(ar));
			
			if( filterFunction )
			{
				asourceSearch.filterFunction = filterFunction;
            	asourceSearch.refresh();
				ar = asourceSearch.toArray();
				asourceSearch = new ArrayListView(new ArrayList(ar));
			}
            _pageNavigator.totalItems = asourceSearch.length;
            var totalPages:int = Math.ceil(_pageNavigator.totalItems/_pageNavigator.pageSize);
            var indexToPos:int = 0;

            if(proposedPage < 1)
                proposedPage = 1;

            if(proposedPage > totalPages)
                proposedPage = totalPages;

        	_pageNavigator.currentPage = proposedPage != _pageNavigator.currentPage ? proposedPage : _pageNavigator.currentPage;
            var loc_pagesize:int = _pageNavigator.pageSize > _pageNavigator.totalItems ? _pageNavigator.totalItems : _pageNavigator.pageSize;
            var startIndexPage:int = (_pageNavigator.currentPage - 1) * loc_pagesize;
            var endIndexPage:int = Math.min(startIndexPage + loc_pagesize - 1, _pageNavigator.totalItems - 1);

            //Op1: We filter AsourceAll
            var ireg:int = -1;
            var isInSearch:Boolean = true;
            var exitFor:Boolean = false;
            
            asourceSearch.filterFunction = function(item:Object):Boolean
            {
                if(exitFor)
                    return false;

                ireg +=1;
                if(ireg >= startIndexPage && ireg <= endIndexPage){
                    return true;
                }else{
                    exitFor = (ireg > endIndexPage);
                    return false;
                }
            }

            asourceSearch.refresh();
			(_strand as List).dataProvider = new ArrayList(asourceSearch.toArray());
        }

		private var _filterFunction:Function = null;
		public function get filterFunction():Function{ return _filterFunction; }
		/**
		 *  set your custom filter logic.
		 *  function(item:Object):Boolean
		 */
		public function set filterFunction(value:Function):void
		{ 
			_filterFunction = value; 

			if(dataProvider)
				applyFilter();

		}

    }
}