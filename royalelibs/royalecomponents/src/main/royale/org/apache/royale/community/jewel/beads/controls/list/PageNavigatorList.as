package org.apache.royale.community.jewel.beads.controls.list
{
    
    import org.apache.royale.collections.ArrayListView;
    import org.apache.royale.collections.ArrayList;
	import org.apache.royale.core.Bead;
	import org.apache.royale.core.IStrand;
    import org.apache.royale.jewel.DataContainer;
	import org.apache.royale.events.Event;
    import org.apache.royale.community.controls.PageNavigatorButtonBar;
    import org.apache.royale.community.vo.PageNavigatorButtonBarVO;
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

		protected function addListListeners():void 
		{
			if(_pageNavigator)
			{
				_pageNavigator.addEventListener('change', manualNavigationEventHandler);
				PageNavigatorButtonBarModel(_pageNavigator.model).addEventListener('pageSizeChanged', pageSizedEventHandler);
				PageNavigatorButtonBarModel(_pageNavigator.model).addEventListener('maxNavButtonsChanged', configChangedEventHandler);
				PageNavigatorButtonBarModel(_pageNavigator.model).addEventListener('currentPageChanged', valueCommitPageEventHandler);
			}
		}

		protected function removeListListeners():void 
		{
			if(_pageNavigator)
			{
				_pageNavigator.removeEventListener('change', manualNavigationEventHandler);
				PageNavigatorButtonBarModel(_pageNavigator.model).removeEventListener('pageSizeChanged', pageSizedEventHandler);
				PageNavigatorButtonBarModel(_pageNavigator.model).removeEventListener('maxNavButtonsChanged', configChangedEventHandler);
				PageNavigatorButtonBarModel(_pageNavigator.model).removeEventListener('currentPageChanged', valueCommitPageEventHandler);
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

		private var filtering:Boolean;
		protected function valueCommitPageEventHandler(event:Event):void
		{
			//We will only act when currentPage has been set programmatically, directly in the Paginator.
			if(filtering)
				return;
            var proposedPage:int = (event.target.selectedItem as PageNavigatorButtonBarVO).valuePage;
            applyFilter(_pageNavigator.currentPage);
		}

		protected function manualNavigationEventHandler(event:Event):void
		{
            var proposedPage:int = (event.target.selectedItem as PageNavigatorButtonBarVO).valuePage;
            applyFilter(proposedPage);
		}

		protected function configChangedEventHandler(event:Event):void
		{
			//Force a refresh of the list dataprovider
			applyFilter(_pageNavigator.currentPage);
		}

		protected function pageSizedEventHandler(event:Event):void
		{
			//Force a refresh of the list dataprovider
			applyFilter();
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

        protected function applyFilter(proposedPage:int = -1):void
        {
			if(!_pageNavigator)
				return;

			filtering = true;
			
			var ar:Array = !_dataProvider ? new Array() : _dataProvider.source;
            var asourceSearch:ArrayListView = new ArrayListView(new ArrayList(ar));
			
			if( filterFunction && ar.length > 0 )
			{
				asourceSearch.filterFunction = filterFunction;
            	asourceSearch.refresh();
				ar = asourceSearch.toArray();
				asourceSearch = new ArrayListView(new ArrayList(ar));
			}

			if(ar.length <= 0)
			{
            	_pageNavigator.totalItems = 0;
				_pageNavigator.currentPage = -1;
				(_strand as DataContainer).dataProvider = new ArrayList();

				filtering = false;
				return;
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
			(_strand as DataContainer).dataProvider = new ArrayList(asourceSearch.toArray());

			filtering = false;
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