package org.apache.royale.community.controls 
{
    import org.apache.royale.collections.ArrayList;
    import org.apache.royale.html.beads.models.ButtonBarModel;
    import org.apache.royale.jewel.ToggleButtonBar;
    import org.apache.royale.community.vo.PagesNavigationButtonBarVO;
    import org.apache.royale.community.beads.models.PagesNavigationButtonBarModel;

    /**
     *  The PagesNavigationButtonBar class is a component that displays a set of ToggleButtons. The PagesNavigationButtonBar
     *  is actually an ToggleButtonBar (IconButtonBar) with an itemRenderer that produces Jewel ToggleButtons.
     *
     *  By default buttons are equally sized, by setting `widthType` to NaN.
     *
     *  The ToggleButtonBar uses the following beads:
     *
     *  org.apache.royale.core.IBeadModel: the data model for the ButtonBar, including the dataProvider. ("org.apache.royale.html.beads.models.ButtonBarModel")
     *  org.apache.royale.core.IBeadView: constructs the parts of the component. ("org.apache.royale.jewel.beads.views.ButtonBarView")
     *  org.apache.royale.core.IBeadController: handles input events. ("org.apache.royale.jewel.beads.controllers.ListSingleSelectionMouseController")
     *  org.apache.royale.core.IBeadLayout: sizes and positions the component parts. ("org.apache.royale.jewel.beads.layouts.ButtonBarLayout")
     *  org.apache.royale.core.IDataProviderItemRendererMapper: produces itemRenderers. ("org.apache.royale.html.beads.DataItemRendererFactoryForCollectionView")
     *  org.apache.royale.core.IItemRenderer: the class or class factory to use. (PagesNavigationButtonBarItemRenderer)
     *
     *  ButtonBar:
     *  IItemRendererClassFactory: ClassReference("org.apache.royale.core.ItemRendererClassFactory");
     *  IItemRenderer: ClassReference("org.apache.royale.jewel.itemRenderers.ButtonBarItemRenderer");
     *  IItemRenderer: ClassReference("org.apache.royale.jewel.itemRenderers.ToggleButtonBarItemRenderer");
     *  IItemRendererInitializer: ClassReference("org.apache.royale.jewel.beads.itemRenderers.ButtonBarItemRendererInitializer");
     *
     *  @toplevel
     *  @langversion 3.0
     *  @playerversion Flash 10.2
     *  @playerversion AIR 2.6
     *  @productversion Royale 0.9.7
     */
    public class PagesNavigationButtonBar extends org.apache.royale.jewel.ToggleButtonBar {
        /**
         *  constructor.
         *
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion Royale 0.9.7
         */
        
        public function PagesNavigationButtonBar() {
            super();
            PagesNavigationButtonBarModel(model).widthType = ButtonBarModel.PERCENT_WIDTHS;
/*
            typeNames = "jewel buttonbar";

			// default height and rowHeight
			height = rowHeight = 38;
*/
        }

        public var pages:ArrayList = new ArrayList();

		/**
		 * @royaleignorecoercion org.apache.royale.community.beads.models.PagesNavigationButtonBarModel
		 */
        public function get maxNavButtons():int {
            return PagesNavigationButtonBarModel(model).maxNavButtons;
        }
		/**
		 * @royaleignorecoercion org.apache.royale.community.beads.models.PagesNavigationButtonBarModel
		 */
        public function set maxNavButtons(value:int):void {
            PagesNavigationButtonBarModel(model).maxNavButtons = value;
        }
		/**
		 * @royaleignorecoercion org.apache.royale.community.beads.models.PagesNavigationButtonBarModel
		 */
        public function get pageSize():int {
            return PagesNavigationButtonBarModel(model).pageSize;
        }
		/**
		 * @royaleignorecoercion org.apache.royale.community.beads.models.PagesNavigationButtonBarModel
		 */
        public function set pageSize(value:int):void {
            PagesNavigationButtonBarModel(model).pageSize = value;
        }
		/**
		 * @royaleignorecoercion org.apache.royale.community.beads.models.PagesNavigationButtonBarModel
		 */
        public function get totalItems():int {
            return PagesNavigationButtonBarModel(model).totalItems;
        }
		/**
		 * @royaleignorecoercion org.apache.royale.community.beads.models.PagesNavigationButtonBarModel
		 */
        public function set totalItems(value:int):void {
            PagesNavigationButtonBarModel(model).totalItems = value;
        }
		/**
		 * @royaleignorecoercion org.apache.royale.community.beads.models.PagesNavigationButtonBarModel
		 */
        public function get currentPage():int {
            return PagesNavigationButtonBarModel(model).currentPage;
        }
		/**
		 * @royaleignorecoercion org.apache.royale.community.beads.models.PagesNavigationButtonBarModel
		 */
        public function set currentPage(value:int):void 
        {
            var loc_maxNavButtons:int = maxNavButtons;
            var loc_totalItems:int = totalItems;
            var loc_pageSize:int = pageSize;
            var loc_totalPages:int = 0;
            var loc_startPage:int = 0;
            var loc_endPage:int = 0;
            var loc_startIndex:int = 0;
            var loc_endIndex:int = 0;

            var loc_indexToSelect:int = -1;
            var pageIn:int = value;
            pages = new ArrayList();

            if(value < 0 || loc_totalItems <= 0)
            {
                PagesNavigationButtonBarModel(model).currentPage = -1;
                PagesNavigationButtonBarModel(model).totalPages = 0;
                startIndex = -1;
                endIndex = -1;
                dataProvider = pages;
                selectedIndex = -1;
                return;
            }

            if (loc_pageSize <= 0)
                loc_pageSize = 8;

            if (loc_maxNavButtons < 0)
                loc_maxNavButtons = 0;

            loc_totalPages = Math.ceil(loc_totalItems / loc_pageSize);
            if (loc_totalPages <= loc_maxNavButtons) {
                loc_maxNavButtons = loc_totalPages;
            }

            if (pageIn < 1) {
                pageIn = 1;
            } else if (pageIn > loc_totalPages) {
                pageIn = loc_totalPages;
            }

            loc_startIndex = (pageIn - 1) * loc_pageSize;
            loc_endIndex = Math.min(loc_startIndex + loc_pageSize - 1, loc_totalItems - 1);

            if (loc_totalPages <= loc_maxNavButtons) {
                loc_startPage = 1;
                loc_endPage = loc_totalPages;
            } else {
                var maxNavButtonsBeforeCurrentPage:int = Math.floor(loc_maxNavButtons / 2);
                var maxNavButtonsAfterCurrentPage:int = Math.ceil(loc_maxNavButtons / 2) - 1;
                if (pageIn <= maxNavButtonsBeforeCurrentPage) {
                    loc_startPage = 1;
                    loc_endPage = loc_maxNavButtons;
                } else if (pageIn + maxNavButtonsAfterCurrentPage >= loc_totalPages) {
                    loc_startPage = loc_totalPages - loc_maxNavButtons + 1;
                    loc_endPage = loc_totalPages;
                } else {
                    loc_startPage = pageIn - maxNavButtonsBeforeCurrentPage;
                    loc_endPage = pageIn + maxNavButtonsAfterCurrentPage;
                }

                /**
                 * La primera y la última página, siempre estarán visibles.
                 * Siempre que el num.total de pag. sea mayor al num.de botones que se desea tener siempre visibles
                 * aparecerán los botones extra de desplazamiento.
                 * Cuando la pri.pag > 1 aparecerá la pag.1 -> anterior -> pag.2 ...
                 * Cuando la ult.pag < total.pages aparecerá ult.pag.-1 -> siguiente -> ult.pag.
                 */

                if (loc_startPage > 1 && loc_endPage > 1 && loc_totalPages > loc_maxNavButtons) {
                    if (pageIn > 1) {

                        if (loc_endPage == loc_totalPages && pageIn < loc_totalPages - maxNavButtonsAfterCurrentPage) {
                            loc_endPage -= 1;
                            loc_startPage -= 1;
                        }

                        if (loc_endPage < loc_maxNavButtons + loc_startPage) {
                            pages.addItem(new PagesNavigationButtonBarVO("1", 1));
                            //pages.addItem(new PagesNavigationButtonBarVO("❮", pageIn - 1));
                            pages.addItem(new PagesNavigationButtonBarVO("",pageIn-1,FontAwesome5IconType.ANGLE_LEFT)); //MaterialIconType.KEYBOARD_ARROW_LEFT
                            loc_indexToSelect += 2;
                        }

                        if (loc_endPage == loc_maxNavButtons) {
                            loc_startPage += 1;
                            loc_endPage += 1;
                        }

                    }
                }

            }

            for (var idx:int = loc_startPage; idx <= loc_endPage; idx++) {
                pages.addItem(new PagesNavigationButtonBarVO(idx.toString(), idx, "", (pageIn == idx)));
                if (pageIn == idx)
                    loc_indexToSelect += idx-loc_startPage+1;
            }

            if (pageIn < loc_totalPages - maxNavButtonsAfterCurrentPage) {
                //pages.addItem(new PagesNavigationButtonBarVO("❯", pageIn + 1)); //FontAwesome5IconType.ANGLE_RIGHT //MaterialIconType.KEYBOARD_ARROW_RIGHT
                pages.addItem(new PagesNavigationButtonBarVO("",pageIn+1,FontAwesome5IconType.ANGLE_RIGHT));
                pages.addItem(new PagesNavigationButtonBarVO(loc_totalPages.toString(), loc_totalPages));
            }

            PagesNavigationButtonBarModel(model).currentPage = pageIn;
            PagesNavigationButtonBarModel(model).totalPages = loc_totalPages;
            startIndex = loc_startIndex;
            endIndex = loc_endIndex;

            _indexToSelect = loc_indexToSelect;
            dataProvider = pages;
            selectedIndex = _indexToSelect; 
            //Para poder quitarnos el indexToSelect, al asignar el selectedIndex se debería actualizar un item del dataprovider para que 
            //el DataitemRendererFactoryForCollectionView lance el itemUpdatedHandler y actualice el itemRenderer. QUIZÁ a través del controller.selectedIndexChange?

            //trace("selectedIndex/currentPage: " + loc_indexToSelect.toString() + " / " + pageIn.toString());
        }
        
        private var _indexToSelect:int = -1;

        public function get indexToSelect():int
        {
        	return _indexToSelect;
        }

		/**
		 * @royaleignorecoercion org.apache.royale.community.beads.models.PagesNavigationButtonBarModel
		 */
        public function get startIndex():int {
            return PagesNavigationButtonBarModel(model).startIndex;
        }
		/**
		 * @royaleignorecoercion org.apache.royale.community.beads.models.PagesNavigationButtonBarModel
		 */
        public function set startIndex(value:int):void {
            PagesNavigationButtonBarModel(model).startIndex = value;
        }
		/**
		 * @royaleignorecoercion org.apache.royale.community.beads.models.PagesNavigationButtonBarModel
		 */
        public function get endIndex():int {
            return PagesNavigationButtonBarModel(model).endIndex;
        }
		/**
		 * @royaleignorecoercion org.apache.royale.community.beads.models.PagesNavigationButtonBarModel
		 */
        public function set endIndex(value:int):void {
            PagesNavigationButtonBarModel(model).endIndex = value;
        }

    }

}
