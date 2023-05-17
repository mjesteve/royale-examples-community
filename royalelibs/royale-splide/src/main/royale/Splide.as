package
{
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.html.elements.Div;
    import org.apache.royale.html.util.addElementToWrapper;
	/**
	 * @externs
	 */
	COMPILE::JS
    public class Splide extends Div {
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

            addEventListener("initComplete", init);
        }

        private function init():void {
            var splideElement:WrappedHTMLElement = element as WrappedHTMLElement;
            var options:Object = getOptions();
			COMPILE::JS{
            var splideJS:Object = addElementToWrapper(this, "div") as Object;
            splideJS.className = "splide";
            splideElement.appendChild(splideJS.element);

            new (window["Splide"] as Class)(splideJS.element, options);
			}
        }

        private function getOptions():Object {
            var options:Object = {};

            // Set your SplideJS options here
            options.type = "loop";
            options.perPage = 3;
            options.perMove = 1;
            options.gap = "1rem";

            return options;
        }
    }
}

