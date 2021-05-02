package org.apache.royale.community.beads.models {

	import org.apache.royale.events.Event;
	import org.apache.royale.jewel.beads.models.ButtonBarModel;

    public class PageNavigatorButtonBarModel extends ButtonBarModel {

        /**
         *  Constructor.
         *
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion Royale 0.0
         */
        public function PageNavigatorButtonBarModel() {
        }

        private var _maxNavButtons:int = 0;

        public function get maxNavButtons():int {
            return _maxNavButtons;
        }

        public function set maxNavButtons(value:int):void {
            if(_maxNavButtons != value){
                _maxNavButtons = value;
			    dispatchEvent(new Event("maxNavButtonsChanged"));
            }
        }

        private var _pageSize:int = 1;

        public function get pageSize():int {
            return _pageSize;
        }

        public function set pageSize(value:int):void {
            if(_pageSize != value){
                _pageSize = value;
			    dispatchEvent(new Event("pageSizeChanged"));
            }
        }

        private var _totalItems:int;

        public function get totalItems():int {
            return _totalItems;
        }

        public function set totalItems(value:int):void {
            if(_totalItems != value){
                _totalItems = value;
			    dispatchEvent(new Event("totalItemsChanged"));
            }
        }

        private var _currentPage:int;

        public function get currentPage():int {
            return _currentPage;
        }

        public function set currentPage(value:int):void {
            if(_currentPage != value){
                _currentPage = value;
			    dispatchEvent(new Event("currentPageChanged"));
                /** Podríamos añadir una función buildPager() que se podría overridear en el .as del componente? */
            }
        }

        private var _totalPages:int;

        public function get totalPages():int {
            return _totalPages;
        }

        public function set totalPages(value:int):void {
            if(_totalPages != value){
                _totalPages = value;
			    dispatchEvent(new Event("totalPagesChanged"));
            }
        }

        private var _startIndex:int;

        public function get startIndex():int {
            return _startIndex;
        }

        public function set startIndex(value:int):void {
            if(_startIndex != value){
                _startIndex = value;
			    dispatchEvent(new Event("startIndexChanged"));
            }
        }
        private var _endIndex:int;

        public function get endIndex():int {
            return _endIndex;
        }

        public function set endIndex(value:int):void {
            if(_endIndex != value){
                _endIndex = value;
			    dispatchEvent(new Event("endIndexChanged"));
            }
        }
    }


}
