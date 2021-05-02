package org.apache.royale.community.vo {
    
    import org.apache.royale.community.vo.IconFormatVO;
    //import org.apache.royale.collections.IArrayList;
    import org.apache.royale.collections.ArrayList;
    
    [Bindable]
    public class NavigationLinkVO
    {
        public var label:String;
        public var hash:String;
        //public var icon:String;
        public var icon:IconFormatVO;
        public var disabled:Boolean;
        
        //for collapsible example
        //public var subMenu:IArrayList;
        [ArrayElementType("org.apache.royale.community.vo.NavigationLinkVO")]
        public var subMenu:ArrayList;
        public var open:Boolean;
        public var selectedChild:NavigationLinkVO;

        public function NavigationLinkVO(label:String, hash:String, icon:IconFormatVO = null, disabled:Boolean = false)
        {
            this.label = label;
            this.hash = hash;
            this.icon = icon;
            this.disabled = disabled;
        }        
        
    }
}