package org.apache.royale.community.events
{
	import org.apache.royale.events.Event;

    /**
     * Test.
     * Copy of org.apache.royale.textLayout.events.ContextMenuEvent
     */
	public class ContextMenuEvent extends Event {

		public static const MENU_ITEM_SELECT:String = "menuItemSelect";
		public static const MENU_SELECT:String = "menuSelect";

		public function ContextMenuEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false) {
			super(type, bubbles, cancelable);
		}

		public var _contextMenuOwner:Object;
		public function get contextMenuOwner():Object {
			return _contextMenuOwner;
		}
		public function set contextMenuOwner(value:Object):void {
			_contextMenuOwner = value;
		}

		public var _mouseTarget:Object;
		public function get mouseTarget():Object {
			return _mouseTarget;
		}
		public function set mouseTarget(value:Object):void {
			_mouseTarget = value;
		}
	}
}
