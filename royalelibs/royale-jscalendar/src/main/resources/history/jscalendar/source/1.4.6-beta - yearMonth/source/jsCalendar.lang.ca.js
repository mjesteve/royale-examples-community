/*
 * jsCalendar language extension v1.4.6-beta
 * Add Catalan Language support
 * Translators: Anton Stasyuk (antonstsk@github), Quentin PAGÈS (ensag-dev@github), M.José Esteve (mjesteve@github)
 */

// We love anonymous functions
(function(){

    // Get library
    var jsCalendar = window.jsCalendar;

    // If jsCalendar is not loaded
    if (typeof jsCalendar === 'undefined') {
        // If there is no language to load array
        if (typeof window.jsCalendar_language2load === 'undefined') {
            window.jsCalendar_language2load = [];
        }
        // Wrapper to add language to load list
        jsCalendar = {
            addLanguage : function (language) {
                // Add language to load list
                window.jsCalendar_language2load.push(language);
            }
        };
    }

    // Add a new language
    jsCalendar.addLanguage({
        // Language code
        code : 'ca',
        // Months of the year
        months : [
            'Gener',
            'Febrer',
            'Març',
            'Abril',
            'Maig',
            'Juny',
            'Juliol',
            'Agost',
            'Setembre',
            'Octubre',
            'Novembre',
            'Desembre'
        ],
        // Days of the week
        days : [
            'Diumenge',
            'Dilluns',
            'Dimarts',
            'Dimecres',
            'Dijous',
            'Divendres',
            'Dissabte'
        ],
        // Short days of the week
        weekdaysShort : [
            // EDIT HERE THE DAYS ~~~~~~~~~~~~~~~
            'Dg',
            'Dl',
            'Dt',
            'Dc',
            'Dj',
            'Dv',
            'Ds'
            // STOP EDIT ~~~~~~~~~~~~~~~~~~~~~~~~
        ],
        // Min-Short days of the week
        weekdaysMin : [
            // EDIT HERE THE DAYS ~~~~~~~~~~~~~~~
            'Dg',
            'Dl',
            'Dt',
            'Dc',
            'Dj',
            'Dv',
            'Ds'
            // STOP EDIT ~~~~~~~~~~~~~~~~~~~~~~~~
        ],
        // First Day Week
        firstDayOfTheWeek : 2,
    });

})();
