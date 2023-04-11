package
{
	/**
	 * @externs
	 */
    COMPILE::JS
    public class FullCalendar
    {
        /**
         * <inject_script>
         * 
         * var linkfullcal = document.createElement("link");
         * linkfullcal.setAttribute("rel", "stylesheet"); linkfullcal.setAttribute("type", "text/css");
         * linkfullcal.setAttribute("href", "@fullcalendar/core/main.css");
         * document.head.appendChild(linkfullcal);
         * 
         * linkfullcal = document.createElement("link"); linkfullcal.setAttribute("rel", "stylesheet"); linkfullcal.setAttribute("type", "text/css");
         * linkfullcal.setAttribute("href", "@fullcalendar/daygrid/main.css");
         * document.head.appendChild(linkfullcal);
         * 
         * linkfullcal = document.createElement("link"); linkfullcal.setAttribute("rel", "stylesheet"); linkfullcal.setAttribute("type", "text/css");
         * linkfullcal.setAttribute("href", "@fullcalendar/yearview/main.css");
         * document.head.appendChild(linkfullcal);
         *    
         * var scriptfullcal = document.createElement("script");
         * scriptfullcal.setAttribute("type", "text/javascript");
         * scriptfullcal.setAttribute("src", "moment/moment-with-locales.js");
         * document.head.appendChild(scriptfullcal);
         * 
         * scriptfullcal = document.createElement("script");
         * scriptfullcal.setAttribute("type", "text/javascript");
         * scriptfullcal.setAttribute("src", "@fullcalendar/core/main.js");
         * document.head.appendChild(scriptfullcal);
         *    
         * scriptfullcal.onload = function () {
         * 
         *      scriptfullcal = document.createElement("script");
         *      scriptfullcal.setAttribute("src", "@fullcalendar/core/locales-all.js");
         *      document.head.appendChild(scriptfullcal);
         *      
         *      scriptfullcal = document.createElement("script");
         *      scriptfullcal.setAttribute("src", "@fullcalendar/daygrid/main.js");
         *      document.head.appendChild(scriptfullcal);
         * 
         *      scriptfullcal = document.createElement("script");
         *      scriptfullcal.setAttribute("src", "@fullcalendar/interaction/main.js");
         *      document.head.appendChild(scriptfullcal);
         *      
         *      scriptfullcal = document.createElement("script");
         *      scriptfullcal.setAttribute("src", "@fullcalendar/yearview/main.js");
         *      document.head.appendChild(scriptfullcal);
         *      
         * };
         * 
         * </inject_script>
        */
        public function FullCalendar(){}
        
    }
}
