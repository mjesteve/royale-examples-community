package org.apache.royale.community.jewel.beads.layouts
{
    import org.apache.royale.core.Bead;
    import org.apache.royale.core.IStrand;
    import org.apache.royale.core.UIBase;
    import org.apache.royale.events.Event;
    import org.apache.royale.jewel.supportClasses.ResponsiveSizes;
    import org.apache.royale.utils.sendStrandEvent;
    import org.apache.royale.events.IEventDispatcher;

    /**
     *  The ResponsiveResizeListener class listens for browser
     *  resizing and send events when browser cross a responsive breakpoint
     *  
     *  @langversion 3.0
     *  @playerversion Flash 10.2
     *  @playerversion AIR 2.6
     *  @productversion Royale 0.9.8
     */
	public class ResponsiveResizeListener extends Bead
	{
        /**
         *  Constructor.
         *  
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion Royale 0.9.8
         */
		public function ResponsiveResizeListener()
		{
		}
		
        /**
         *  @copy org.apache.royale.core.IBead#strand
         *  
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion Royale 0.9.8
         */
        override public function set strand(value:IStrand):void
        {
            super.strand = value as UIBase;
            COMPILE::JS
            {
            window.addEventListener('resize', resizeHandler, false);
            }
            listenOnStrand("beadsAdded", beadsAddedHandler);
        }

        public function beadsAddedHandler(event:Event):void
        {
            (_strand as IEventDispatcher).removeEventListener("beadsAdded", beadsAddedHandler);
            resizeHandler();
        }

        private var _currentResponsiveSize:String;
        /**
         * the current responsive size. read only
         */
        public function get currentResponsiveSize():String
        {
        	return _currentResponsiveSize;
        }
        
        /**
         * to check only width
         */
        //private var outerWidth:Number;
        private var _currentOuterWidth:Number;
        public function get currentOuterWidth():Number{ return _currentOuterWidth; }
        private var _currentOuterHeight:Number;
        public function get currentOuterHeight():Number{ return _currentOuterHeight; }

		/**
		 *  Make the strand send events when browser is resized and cross a responsive breakpoint
		 */
        private function resizeHandler(event:Event = null):void
        {
            COMPILE::JS
            {
            
                _currentOuterHeight = document.body.getBoundingClientRect().height;
                trace(_currentOuterHeight);                
                if(currentOuterWidth == document.body.getBoundingClientRect().width)
                    return;
                _currentOuterWidth = document.body.getBoundingClientRect().width;
                trace(_currentOuterWidth);
                
                if(currentOuterWidth > ResponsiveSizes.FULL_BREAKPOINT - _offsetWidth)
                {
                    if(currentResponsiveSize != ResponsiveSizes.FULL)
                    {
                        // trace("FULL");
                        _currentResponsiveSize = ResponsiveSizes.FULL;
                        sendStrandEvent(_strand, 'fullResponsiveSize');
                        
                    }
                } else if(currentOuterWidth < ResponsiveSizes.FULL_BREAKPOINT - _offsetWidth && currentOuterWidth > ResponsiveSizes.WIDESCREEN_BREAKPOINT - _offsetWidth)
                {
                    if(currentResponsiveSize != ResponsiveSizes.WIDESCREEN)
                    {
                        // trace("WIDESCREEN");
                        _currentResponsiveSize = ResponsiveSizes.WIDESCREEN;
                        sendStrandEvent(_strand, 'widescreenResponsiveSize');
                    }
                } else if(currentOuterWidth < ResponsiveSizes.WIDESCREEN_BREAKPOINT - _offsetWidth && currentOuterWidth > ResponsiveSizes.DESKTOP_BREAKPOINT - _offsetWidth)
                {
                    if(currentResponsiveSize != ResponsiveSizes.DESKTOP)
                    {
                        // trace("DESKTOP");
                        _currentResponsiveSize = ResponsiveSizes.DESKTOP;
                        sendStrandEvent(_strand, 'desktopResponsiveSize');
                    }
                } else if(currentOuterWidth < ResponsiveSizes.DESKTOP_BREAKPOINT - _offsetWidth && currentOuterWidth > ResponsiveSizes.TABLET_BREAKPOINT - _offsetWidth)
                {
                    if(currentResponsiveSize != ResponsiveSizes.TABLET)
                    {
                        // trace("TABLET");
                        _currentResponsiveSize = ResponsiveSizes.TABLET;
                        sendStrandEvent(_strand, 'tabletResponsiveSize');
                    }
                } else if(currentOuterWidth < ResponsiveSizes.TABLET_BREAKPOINT - _offsetWidth && currentOuterWidth > ResponsiveSizes.PHONE_BREAKPOINT - _offsetWidth)
                {
                    if(currentResponsiveSize != ResponsiveSizes.PHONE)
                    {
                        // trace("PHONE");
                        _currentResponsiveSize = ResponsiveSizes.PHONE;
                        sendStrandEvent(_strand, 'phoneResponsiveSize');
                    }
                }

                sendStrandEvent(_strand, 'sizeChanged');
            }

        }
        
        private var _offsetWidth:Number = 0;
        public function get offsetWidth():Number{ return _offsetWidth; }
        public function set offsetWidth(value:Number):void 
        {
            _offsetWidth = value;
        }

	}
}
