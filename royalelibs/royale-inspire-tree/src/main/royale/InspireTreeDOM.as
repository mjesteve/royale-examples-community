package
{
	COMPILE::JS
    {
        import InspireTree;
        import org.apache.royale.community.inspiretree.vos.ConfigDOM;
    }

	/**
	 * @externs
	 */
	COMPILE::JS
	public class InspireTreeDOM{
		/**
		 * <inject_script>
		 * //Without sass:
		 * //var link = document.createElement("link");
         * //link.setAttribute("rel", "stylesheet");
         * //link.setAttribute("type", "text/css");
         * //link.setAttribute("href", "inspire-tree/inspire-tree-dark.min.css");
         * //document.head.appendChild(link);
		 * 
		 * //var link = document.createElement("link");
         * //link.setAttribute("rel", "stylesheet");
         * //link.setAttribute("type", "text/css");
         * //link.setAttribute("href", "inspire-tree/inspire-tree-light-jewel-blue.css");
         * //document.head.appendChild(link);
		 * 
		 * // FIX: Direct insertion in the html template because it does not load in time. [todo]
		 * 
		 * //var script = document.createElement("script");
		 * //	//script.setAttribute("src", "https://cdn.jsdelivr.net/npm/lodash@4.17.21/lodash.min.js");
		 * //script.setAttribute("src", "inspire-tree/lodash.min.js");
		 * //document.head.appendChild(script);
		 * 
		 * var link = document.createElement("link");
         * link.setAttribute("rel", "stylesheet");
         * link.setAttribute("type", "text/css");
         * link.setAttribute("href", "inspire-tree/inspire-tree-custom.css");
         * document.head.appendChild(link);
		 * 
		 * var script = document.createElement("script");
		 * script.setAttribute("src", "inspire-tree/inspire-tree-dom-royale.js");
		 * document.head.appendChild(script);
		 * 
		 * </inject_script>
		*/
        public function InspireTreeDOM(tree:InspireTree, opts:ConfigDOM=null){
		}
        public var config:ConfigDOM;

		/**
		 * Get a tree instance based on an ID.
		 *
		 * @category DOM
		 * @param {string} id Tree ID.
		 * @return {InspireTree} Tree instance.
		 */
		public static function getTreeById(id:String):InspireTree{ return null; }
	}
	
	
}