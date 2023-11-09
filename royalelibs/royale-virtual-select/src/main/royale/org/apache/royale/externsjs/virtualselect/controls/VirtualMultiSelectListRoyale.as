package org.apache.royale.externsjs.virtualselect.controls
{
	import org.apache.royale.externsjs.virtualselect.supportClass.virtualSelectOptions;

	public class VirtualMultiSelectListRoyale extends VirtualMultiSelectRoyale
    {
        /**
         *  Constructor.
         */
        public function VirtualMultiSelectListRoyale()
		{
			super();
            typeControl = 'list';
		}

        override public function get fixInitConfig():virtualSelectOptions
        {
            if(super.fixInitConfig){
                _fixInitConfig.keepAlwaysOpen = true;
                _fixInitConfig.zIndex = 1;
                _fixInitConfig.optionsCount = 8;
                _fixInitConfig.dropboxWrapper = 'self';
                _fixInitConfig.hideSelectDisplayOnKeepAlwaysOpen = true;
            }
            return _fixInitConfig;
        }
	}
}