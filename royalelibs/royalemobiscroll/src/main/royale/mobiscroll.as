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
		
		public static function settings(theme:String='windows',lang:String="es"):Object { return null; }
		/**
		 * Creates an Multidatecalendar instance, and returns an echartsInstance. You shall not initialize multiple Multidatecalendar instances on a single container.
		 * @param dom HTMLDivElement|HTMLCanvasElement
		 * @param theme Object|string
		 * @return multidatecalendar
		 */
		public static function setOptions(theme:String='windows',lang:String="es"):Object
		{
			return null;
		}
		// public static function datepicker(e:Object):Object
		// {
		// return null;
		// }
/*
<input id="scroller" />
mobiscroll.date('#scroller');
mobiscroll.time('#scroller');
mobiscroll.datetime('#scroller');
<div id="calendar"></div>
mobiscroll.datepicker('#calendar', {
    controls: ['calendar'],
    display: 'inline'
});
var inst = mobiscroll.date('#calendar');
inst.show(); // Call the show method
 
// Modify a setting
mobiscrollInstance.settings.readonly = true;

// Modify settings in an event
mobiscroll.scroller('#mobiscroll', {
    onBeforeShow: function (event, inst) {
        inst.settings.readonly = true;
    }
});







*/
	}
}