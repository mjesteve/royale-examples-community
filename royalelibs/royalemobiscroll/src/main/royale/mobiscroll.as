package
{

	/**
	 * @externs
	 */
	COMPILE::JS
	public class mobiscroll{

		/**
		 * <inject_script>
		 * var script = document.createElement("script");
		 * script.setAttribute("src", "mobiscroll/js/mobiscroll.javascript.min.js");
		 * document.head.appendChild(script);
		 * var link = document.createElement("link");
         * link.setAttribute("rel", "stylesheet");
         * link.setAttribute("type", "text/css");
         * link.setAttribute("href", "mobiscroll/css/mobiscroll.javascript.min.css");
         * document.head.appendChild(link);
		 * </inject_script>
		*/
        public function mobiscroll(){
		}
		
		public static function init(dom:Element=null,theme:Object=null, opts:Object=null):Object { return null; }
		/**
		 * Creates an Multidatecalendar instance, and returns an echartsInstance. You shall not initialize multiple Multidatecalendar instances on a single container.
		 * @param dom HTMLDivElement|HTMLCanvasElement
		 * @param theme Object|string
		 * @return multidatecalendar
		 */
		public static function setOptions(e:Object,theme:Object=null):Object
		{
		return null;
		}
		// public static function datepicker(e:Object):Object
		// {
		// return null;
		// }


	}
}