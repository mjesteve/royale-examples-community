package
{
    import org.apache.royale.core.UIBase;
	  import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.html.util.addElementToWrapper;
    
    [DefaultProperty("plugins")]
	/**
	 * @externs
	 */
    COMPILE::JS
    public class FullCalendar extends UIBase
    {
		/**
         * <inject_script>
         * var link = document.createElement("link");
             * link.setAttribute("rel", "stylesheet");
             * link.setAttribute("type", "text/css");
             * link.setAttribute("href", "../lib/main.css");
             * document.head.appendChild(link);
			 * var script = document.createElement("script");
         * script.setAttribute("src", "https://github.com/mozilla-comm/ical.js/releases/download/v1.4.0/ical.js");
         * document.head.appendChild(script);
			  * var script = document.createElement("script");
         * script.setAttribute("src", "../lib/main.js");
         * document.head.appendChild(script);
         * var script = document.createElement("script");
         * script.setAttribute("src", "../lib/main.js");
         * document.head.appendChild(script);
         * </inject_script>
        */
        public function FullCalendar()
        {
           // super();
            //this.addEventListener('beadsAdded', onInit);
        }
       
		        
    }
}
