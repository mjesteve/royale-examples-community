package org.apache.royale.community.jewel.beads.controls
{
    
	import org.apache.royale.core.IToolTipBead;
    import org.apache.royale.jewel.beads.controls.Disabled;

    public class DisabledToolTip extends org.apache.royale.jewel.beads.controls.Disabled
    {

		public function DisabledToolTip()
		{
			super();
		}

        private var _beadToolTip:IToolTipBead;
        public function set beadToolTip(value:IToolTipBead):void
		{
			_beadToolTip = value;
		}

		override protected function updateHost():void
		{
            super.updateHost();

			if(disabled) {
				if(_beadToolTip) {
					_beadToolTip.removeTip();
				}
			}
		}
	}

}