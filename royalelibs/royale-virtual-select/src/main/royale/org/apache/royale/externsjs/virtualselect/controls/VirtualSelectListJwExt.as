package org.apache.royale.externsjs.virtualselect.controls
{

	import org.apache.royale.externsjs.virtualselect.supportClass.OptionsInit;

	public class VirtualSelectListJwExt extends VirtualSelectJwExt
    {
        /**
         *  Constructor.
         */
        public function VirtualSelectListJwExt()
		{
			super();
		}

        override protected function initConfig():void
        {   
            super.initConfig();
            _configOption.keepAlwaysOpen = true;
            _configOption.zIndex = 1;
            _configOption.optionsCount = -1;
            _configOption.dropboxWrapper = 'self';
            typeControl = 'list';
        }

        override public function set configOption(value:OptionsInit):void
        {
            initConfig();

            if(!value)
                return;

            value.keepAlwaysOpen = true;
            value.zIndex = 1;
            value.dropboxWrapper = 'self';
            super.configOption = value;
        }

	}
}