/*var script = document.createElement("script");
script.setAttribute("src", "resources/fullcalendar/main.js");
document.head.appendChild(script);

var link = document.createElement("link");
link.setAttribute("rel", "stylesheet");
link.setAttribute("href", "resources/fullcalendar/main.css");
document.head.appendChild(link);
*/
function getCalendar(el, overrideOptions)
{
    return new FullCalendar.Calendar(el, overrideOptions);
    //calendar.render();
}