package org.apache.royale.externsjs.tooltipjs
{
    
    import org.apache.royale.externsjs.popperjs.Modifiers;

    COMPILE::JS
    public class Options
    {
            // @param {String} options.placement='top'
            //      Placement of the popper accepted values: `top(-start, -end), right(-start, -end), bottom(-start, -end),
            //      left(-start, -end)`
        public var placement:String = 'top';
            // @param {String} [options.arrowSelector='.tooltip-arrow, .tooltip__arrow'] - className used to locate the DOM arrow element in the tooltip.
        public var arrowSelector:String = '.tooltip-arrow, .tooltip__arrow';
            // @param {String} [options.innerSelector='.tooltip-inner, .tooltip__inner'] - className used to locate the DOM inner element in the tooltip.
        public var innerSelector:String = '.tooltip-inner, .tooltip__inner'
            // @param {HTMLElement|String|false} options.container=false - Append the tooltip to a specific element.
        public var container:Object = false;
            // @param {Number|Object} options.delay=0
            //      Delay showing and hiding the tooltip (ms) - does not apply to manual trigger type.
            //      If a number is supplied, delay is applied to both hide/show.
            //      Object structure is: `{ show: 500, hide: 100 }`
        public var delay:Object = 0;
            // @param {Boolean} options.html=false - Insert HTML into the tooltip. If false, the content will inserted with `textContent`.
        public var html:Boolean = false;
            // @param {String} [options.template='<div class="tooltip" role="tooltip"><div class="tooltip-arrow"></div><div class="tooltip-inner"></div></div>']
            //      Base HTML to used when creating the tooltip.
            //      The tooltip's `title` will be injected into the `.tooltip-inner` or `.tooltip__inner`.
            //      `.tooltip-arrow` or `.tooltip__arrow` will become the tooltip's arrow.
            //      The outermost wrapper element should have the `.tooltip` class.
        public var template:String = '<div class="tooltip" role="tooltip"><div class="tooltip-arrow"></div><div class="tooltip-inner"></div></div>';
            // @param {String|HTMLElement|TitleFunction} options.title='' - Default title value if `title` attribute isn't present.
        public var title:* = '';
            // @param {String} [options.trigger='hover focus']
            //      How tooltip is triggered - click, hover, focus, manual.
            //      You may pass multiple triggers; separate them with a space. `manual` cannot be combined with any other trigger.
        public var trigger:String = 'hover focus';
            // @param {Boolean} options.closeOnClickOutside=false - Close a popper on click outside of the popper and reference element. 
            //                                                      This has effect only when options.trigger is 'click'.
        public var closeOnClickOutside:Boolean = false;
            // @param {String|HTMLElement} options.boundariesElement
            //      The element used as boundaries for the tooltip. For more information refer to Popper.js'
            //      [boundariesElement docs](https://popper.js.org/popper-documentation.html)
        public var boundariesElement:Object;
            // @param {Number|String} options.offset=0 - Offset of the tooltip relative to its reference. For more information refer to Popper.js'
            //      [offset docs](https://popper.js.org/popper-documentation.html)
        public var offset:String = '0';
            // @param {Object} options.popperOptions={} - Popper options, will be passed directly to popper instance. For more information refer to Popper.js'
            //      [options docs](https://popper.js.org/popper-documentation.html)
            
        public var popperOptions:Object;
        
    }
}