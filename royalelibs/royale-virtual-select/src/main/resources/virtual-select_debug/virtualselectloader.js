
var link_virtualselect = document.createElement("link");
link_virtualselect.setAttribute("rel", "stylesheet");
link_virtualselect.setAttribute("type", "text/css");
link_virtualselect.setAttribute("href", "./virtual-select/virtual-select.min.css");
document.head.appendChild(link_virtualselect);
   
var script_virtualselect = document.createElement("script");
script_virtualselect.setAttribute("src", "./virtual-select/virtual-select.min.js");
document.head.appendChild(script_virtualselect);
  
window.addEventListener('load', function() 
{   
    var link_virtualselect = document.createElement("link");
    link_virtualselect.setAttribute("rel", "stylesheet");
    link_virtualselect.setAttribute("type", "text/css");
    link_virtualselect.setAttribute("href", "./virtual-select/tooltip.min.css");
    document.head.appendChild(link_virtualselect);
   
    var script_virtualselect = document.createElement("script");
    script_virtualselect.setAttribute("src", "./virtual-select/tooltip.min.js");
    document.head.appendChild(script_virtualselect);
});
