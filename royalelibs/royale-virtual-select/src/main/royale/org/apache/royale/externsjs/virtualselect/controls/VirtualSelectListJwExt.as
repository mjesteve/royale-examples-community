package org.apache.royale.externsjs.virtualselect.controls
{

	import org.apache.royale.externsjs.virtualselect.supportClass.virtualSelectOptionsClass;

	public class VirtualSelectListJwExt extends VirtualSelectJwExt
    {
        /**
         *  Constructor.
         */
        public function VirtualSelectListJwExt()
		{
			super();
            typeControl = 'list';
		}

        override public function get fixInitConfig():virtualSelectOptionsClass
        {
            if(super.fixInitConfig){
                _fixInitConfig.keepAlwaysOpen = true;
                _fixInitConfig.zIndex = 1;
                _fixInitConfig.optionsCount = 8;
                _fixInitConfig.dropboxWrapper = 'self';
                _fixInitConfig.searchPlaceholderText = " ... 🔎︎";
            }
            return _fixInitConfig;
        }
	}
}