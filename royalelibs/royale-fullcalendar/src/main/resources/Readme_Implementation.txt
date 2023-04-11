Test A) FullCalendar (Year view Plugin)
- FullCalendar 4.3.1
- Plugin fullcalendar-yearview 

    * En un html directo funciona ok.
    Con la diferencia de que si pongo los scripts directamente en el html
    puedo utilizar el evento 'DOMContentLoaded' para crear el componente, PERO
    si los scripts los incluímos al estilo @extern Royale, con document.head.Add(xxx),
    éste evento se lanza antes de que JS haya cargado la clase FullCalendar y da error.
    Utilizando la carga secuencial de los scripts: Tras la carga de core/main.js, evento onload,
    se cargan los demás scripts, y utilizando el evento " ... document.addEventListener('load',) ..."
    tambien funciona (no funciona con el 'DOMContentLoaded')

    * Desde una vista mxml... 
      -> Si la creación se incluye en un evento onInit, no funciona, porque FullCalendar no está definido.
      -> Si la creación se realiza después de que se cargue completamente la aplicación, por ejemplo en un onClick, sí 
         que funciona.

    Fix corregidos en el plugin (en la compilación js, NO EN LOS .ts):
    - Texto traducido para "year" en varios idiomas (locales_all.js)
    - Establecer el locale de "moment" cuando se crea la vista. (/dist/main.js)
    - WIP - Selección incorrecta (/dist/@fullcalendar/interaction/main.js)

        Evento 'dateClick' se lanza cuando seleccionamos un solo día, sólo un click.
        El Evento 'select' se lanza antes de 'dateClick' si se hace un sólo click.
        El Evento 'select' es el único que se lanza cuando la selección es múltiple, resultado de arrastrar el ratón
        con el boton izq. presionado.

Test B) FullCalendar oficial version
- FullCalendar 6.5.1
- view "multiMonthYear"

    * En un html directo funciona ok.
    * En la vista mxml...
      --> Si la creación se realiza antes de que la carga de la aplicación se haya realizado completamente, no podemos
          utilizar "new FullCalendar.Calendar(el,op)" porque da error de "no definido" PERO sí se puede utilizar
          "new FullCalendar['Calendar'](el,op)"
      --> 
