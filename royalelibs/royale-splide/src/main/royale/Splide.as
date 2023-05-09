package
{
	
	import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.html.util.addElementToWrapper;
    
	/**
	 * @externs
	 */
	COMPILE::JS
    public class Splide extends org.apache.royale.core.UIBase {
        
        private var _options:Object;
    	/**
		 * <inject_script>
         *          
		 * var link_splide = document.createElement("link");
         * link_splide.setAttribute("rel", "stylesheet");
         * link_splide.setAttribute("type", "text/css");
         * link_splide.setAttribute("href", "splide/css/splide.min.css");
         * document.head.appendChild(link_splide);
		 * 
		 * var script_splide = document.createElement("script");
		 * script_splide.setAttribute("src", "splide/js/splide.js");
		 * document.head.appendChild(script_splide); 
		 * </inject_script>
		*/
        public function Splide() {
            super();
        }
        
        override public function addedToParent():void {
            super.addedToParent();
           // createSplide();
        }
        
       
    }


}