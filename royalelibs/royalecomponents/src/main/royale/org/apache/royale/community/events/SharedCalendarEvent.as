package org.apache.royale.community.events
{
	import org.apache.royale.events.Event;

	//import mx.modules.IModuleInfo;

	public class SharedCalendarEvent extends Event {

		public static const ADD_SELECTEDDAY:String = 'addselday';
		public static const DEL_SELECTEDDAY:String = 'delselday';


		public function SharedCalendarEvent(type :String, itemShared:Object = null, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			itemSend = itemShared;
		}

		public var itemSend:Object;
	}
}
