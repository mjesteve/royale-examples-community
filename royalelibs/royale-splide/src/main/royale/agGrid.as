package
{
    import org.apache.royale.events.Event;
    import org.apache.royale.events.MouseEvent;
    import org.apache.royale.core.HTMLElementWrapper;
    import org.apache.royale.core.UIBase;
    import org.apache.royale.core.WrappedHTMLElement;
	/**
	 * @externs
	 */
	COMPILE::JS
    public class agGrid{
		/**
		 * <inject_script>
         *         
		 * 
		 * var ag = document.createElement("script");
		 * ag.setAttribute("src", "aggrid/ag-grid-community.js");
		 * document.head.appendChild(ag); 
         * 
         * var ag2 = document.createElement("script");
		 * ag2.setAttribute("src", "aggrid/ag-grid-community.min.js");
		 * document.head.appendChild(ag2); 
         * 
         * var ag3 = document.createElement("script");
		 * ag3.setAttribute("src", "aggrid/ag-grid-community.min.nostyle.js");
		 * document.head.appendChild(ag3); 
         * 
		 * var ag4 = document.createElement("script");
		 * ag4.setAttribute("src", "aggrid/ag-grid-community.nostyle.js");
		 * document.head.appendChild(ag4); 
         * 
		 * </inject_script>
         * 
		*/
        public function agGrid(){}
		
		public static function Grid(gridDiv:WrappedHTMLElement, gridOptions:Object):void { }


       
    }
}

