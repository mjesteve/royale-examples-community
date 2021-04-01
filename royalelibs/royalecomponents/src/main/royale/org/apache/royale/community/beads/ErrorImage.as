package org.apache.royale.community.beads {

    import org.apache.royale.core.IBead;
    import org.apache.royale.core.IStrand;
    import org.apache.royale.events.Event;

	COMPILE::JS {
		import org.apache.royale.core.WrappedHTMLElement;
	}
    import org.apache.royale.core.IRenderedObject;

    public class ErrorImage implements IBead {

        protected var _strand:IStrand;

        public function ErrorImage() {
            super();
        }

        /**
         *  @copy org.apache.royale.core.IBead#strand
         *
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion Royale 0.9.8
         */
        public function set strand(value:IStrand):void {
            _strand = value;
	        COMPILE::JS {
                (_strand as IRenderedObject).element.addEventListener('error', errorHandler);
            }
        }

        private var _src:String = "assets/no-image.svg";

        public function get src():String {
            return _src;
        }

        public function set src(value:String):void {
            _src = value;
        }

		COMPILE::JS
        protected function errorHandler(event:Event):void 
        {
            if(hostElement is HTMLImageElement)
            {
                var imgEle:HTMLImageElement = hostElement as HTMLImageElement;
                if (imgEle.src != _src)
                {
                    imgEle.src = _src;
                }
            }              
            else if(hostElement is HTMLInputElement){
                var inputEle:HTMLInputElement = hostElement as HTMLInputElement;
                if (inputEle.src != _src)
                {
                    inputEle.src = _src;
                }
            }else{            
                var imgObj:Object = hostElement as Object;
                if (imgObj.src != _src)
                {
                    imgObj.src = _src;
                }
            }
        }
        
		COMPILE::JS
		protected function get hostElement():WrappedHTMLElement
		{
			return (_strand as IRenderedObject).element;
		}


    }
}
