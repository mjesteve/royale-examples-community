package
{

	/**
	 * @externs
	 */
	COMPILE::JS
	public class Calendar{

		/**
		 * <inject_script>
		 * //script.setAttribute("src", "https://unpkg.com/js-year-calendar@latest/dist/js-year-calendar.min.js");1.0.2
		 * //script.setAttribute("src", "https://unpkg.com/js-year-calendar@2.0.0-alpha.2/dist/js-year-calendar.js");
		 * 
		 * var script = document.createElement("script");
		 * script.setAttribute("src", "js-year-calendar/js-year-calendar.js");
		 * document.head.appendChild(script);
		 * 
		 * var link = document.createElement("link");
         * link.setAttribute("rel", "stylesheet");
         * link.setAttribute("type", "text/css");
         * link.setAttribute("href", "js-year-calendar/js-year-calendar.css");
         * document.head.appendChild(link);
		 * 
         * //link.setAttribute("href", "https://unpkg.com/js-year-calendar@2.0.0-alpha.2/dist/js-year-calendar.css");
		 * </inject_script>
		*/
        public function Calendar(){
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
 */

	}
}