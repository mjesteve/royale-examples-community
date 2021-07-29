package org.apache.royale.community.jscalendar.events
{
	import org.apache.royale.events.Event;
	import org.apache.royale.events.EventDispatcher;

	//import mx.modules.IModuleInfo;

	public class SharedEvent extends Event {

		public static const ADD_SELECTEDDAY:String = 'addselday';
		public static const DEL_SELECTEDDAY:String = 'delselday';


		public function SharedEvent(type :String, itemShared:Object = null, bubbles:Boolean=true, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			itemSend = itemShared;
		}

		public var itemSend:Object;
	}
}
