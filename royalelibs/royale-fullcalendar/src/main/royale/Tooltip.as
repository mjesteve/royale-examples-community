package
{
	/**
	 * @externs
	 */
    COMPILE::JS
    public class Tooltip
    {
        /**
         * <inject_script>
         * // Popper.js (v2) https://github.com/floating-ui/floating-ui?utm_source=cdnjs&utm_medium=cdnjs_link&utm_campaign=cdnjs_library
         * // https://cdnjs.com/libraries/popper.js
         * // https://www.npmjs.com/package/@popperjs/core?utm_source=cdnjs&utm_medium=cdnjs_link&utm_campaign=cdnjs_library
         * // https://cdnjs.com/libraries/tooltip.js
         * // 
         * //https://github.com/opencollective/popper.js/blob/master/docs/_includes/tooltip-documentation.md
         * 
         * var linkfullcal = document.createElement("link"); linkfullcal.setAttribute("rel", "stylesheet"); linkfullcal.setAttribute("type", "text/css");
         * linkfullcal.setAttribute("href", "@fullcalendar/lib/popper-tooltip.css");
         * document.head.appendChild(linkfullcal);
         *    
         * var scriptfullcal = document.createElement("script");
         * scriptfullcal.setAttribute("src", "https://unpkg.com/popper.js@1.16.1/dist/umd/popper.min.js");
         * // scriptfullcal.setAttribute("src", "@fullcalendar/lib/popper.min.js");
         * document.head.appendChild(scriptfullcal);
         *      
         * scriptfullcal = document.createElement("script");
         * scriptfullcal.setAttribute("src", "https://unpkg.com/tooltip.js@1.3.3/dist/umd/tooltip.min.js");
         * // scriptfullcal.setAttribute("src", "@fullcalendar/lib/tooltip.min.js");
         * document.head.appendChild(scriptfullcal);
         * 
         * </inject_script>
        */
        public function Tooltip(reference:HTMLElement, options:Object){

        }
        //
         // Create a new Tooltip.js instance
         // @class Tooltip
         // @param {HTMLElement} reference - The DOM node used as reference of the tooltip (it can be a jQuery element).
         // @param {Object} options
            // @param {String} options.placement='top'
            //      Placement of the popper accepted values: `top(-start, -end), right(-start, -end), bottom(-start, -end),
            //      left(-start, -end)`
            // @param {String} [options.arrowSelector='.tooltip-arrow, .tooltip__arrow'] - className used to locate the DOM arrow element in the tooltip.
            // @param {String} [options.innerSelector='.tooltip-inner, .tooltip__inner'] - className used to locate the DOM inner element in the tooltip.
            // @param {HTMLElement|String|false} options.container=false - Append the tooltip to a specific element.
            // @param {Number|Object} options.delay=0
            //      Delay showing and hiding the tooltip (ms) - does not apply to manual trigger type.
            //      If a number is supplied, delay is applied to both hide/show.
            //      Object structure is: `{ show: 500, hide: 100 }`
            // @param {Boolean} options.html=false - Insert HTML into the tooltip. If false, the content will inserted with `textContent`.
            // @param {String} [options.template='<div class="tooltip" role="tooltip"><div class="tooltip-arrow"></div><div class="tooltip-inner"></div></div>']
            //      Base HTML to used when creating the tooltip.
            //      The tooltip's `title` will be injected into the `.tooltip-inner` or `.tooltip__inner`.
            //      `.tooltip-arrow` or `.tooltip__arrow` will become the tooltip's arrow.
            //      The outermost wrapper element should have the `.tooltip` class.
            // @param {String|HTMLElement|TitleFunction} options.title='' - Default title value if `title` attribute isn't present.
            // @param {String} [options.trigger='hover focus']
            //      How tooltip is triggered - click, hover, focus, manual.
            //      You may pass multiple triggers; separate them with a space. `manual` cannot be combined with any other trigger.
            // @param {Boolean} options.closeOnClickOutside=false - Close a popper on click outside of the popper and reference element. This has effect only when options.trigger is 'click'.
            // @param {String|HTMLElement} options.boundariesElement
            //      The element used as boundaries for the tooltip. For more information refer to Popper.js'
            //      [boundariesElement docs](https://popper.js.org/popper-documentation.html)
            // @param {Number|String} options.offset=0 - Offset of the tooltip relative to its reference. For more information refer to Popper.js'
            //      [offset docs](https://popper.js.org/popper-documentation.html)
            // @param {Object} options.popperOptions={} - Popper options, will be passed directly to popper instance. For more information refer to Popper.js'
            //      [options docs](https://popper.js.org/popper-documentation.html)

        // @return {Object} instance - The generated tooltip instance
        //
        public function _isOpen():Boolean{
            return null;
        }
        public function show():void{}
        public function hide():void{}
        public function dispose():void{}
        public function toggle():void{}
        public function updateTitleContent(title:Object):void{}

    }
    
}
