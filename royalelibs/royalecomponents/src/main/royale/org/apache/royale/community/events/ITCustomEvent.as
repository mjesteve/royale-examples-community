package org.apache.royale.community.events
{
	import org.apache.royale.events.Event;

	public class ITCustomEvent extends Event
    {
        public function ITCustomEvent(type:String, idx:int = -1, itemGen:Object=null)
        {
			super(type, true, true);
            this.idx = idx;
            this.itemGen = itemGen;
		}
        public var idx:int = -1;
        public var itemGen:Object;
    }
}
