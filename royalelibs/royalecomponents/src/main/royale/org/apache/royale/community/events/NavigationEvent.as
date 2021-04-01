package org.apache.royale.community.events
{
	import org.apache.royale.events.Event;
	import org.apache.royale.community.vo.NavigationLinkVO;

	public class NavigationEvent extends Event
    {

        public static const CHANGEVIEW:String = "changeView";

        public function NavigationEvent(type:String, targetCall:Object=null, newNav:NavigationLinkVO = null, oldNav:NavigationLinkVO = null)
        {
			super(type, true, true);
            if(targetCall)
                targetViewPopup = targetCall;
            lastNavSelected = oldNav;
            newNavSelected = newNav;
		}

        public var targetViewPopup:Object;
        public var lastNavSelected:NavigationLinkVO;
        public var newNavSelected:NavigationLinkVO;

    }
    

}
