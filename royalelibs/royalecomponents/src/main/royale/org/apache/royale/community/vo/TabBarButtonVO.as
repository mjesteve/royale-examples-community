package org.apache.royale.community.vo
{
    [Bindable]
    public class TabBarButtonVO
    {
        public var label:String;
        public var hash:String;
        public var icon:String;
        public var uid:int;

        public function TabBarButtonVO(label:String="", hash:String="", icon:String = null, uid:int = 0)
        {
            this.label = label;
            this.hash = hash;
            this.icon = icon;
            this.uid = uid;
        }
    }
}
