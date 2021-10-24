package
{
	COMPILE::JS
    {
        import InspireTree;
        import com.proj.example.inspiretree.vos.ConfigDOM;
    }

	/**
	 * @externs
	 */
	COMPILE::JS
	public class InspireTreeDOM{
		/**
		 * <inject_script>
		 * 
		 * var link = document.createElement("link");
         * link.setAttribute("rel", "stylesheet");
         * link.setAttribute("type", "text/css");
         * link.setAttribute("href", "js/inspire-tree-dark.min.css");
         * document.head.appendChild(link);
		 * 
		 * var link = document.createElement("link");
         * link.setAttribute("rel", "stylesheet");
         * link.setAttribute("type", "text/css");
         * link.setAttribute("href", "js/inspire-tree-light.css");
         * document.head.appendChild(link);
		 * 
		 * var script = document.createElement("script");
		 * script.setAttribute("src", "js/inspire-tree-dom.js");
		 * document.head.appendChild(script);
		 * 
		 * </inject_script>
		*/
        public function InspireTreeDOM(tree:InspireTree, opts:ConfigDOM=null){
		}

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