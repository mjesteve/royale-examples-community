package org.apache.royale.community.vos
{
    [Bindable]
    public class TabBarGroupButtonVO
    {
        //import org.apache.royale.collections.IArrayList;
        import org.apache.royale.collections.ArrayList;

        public var label:String;
        public var hash:String;
        public var icon:String;
        [ArrayElementType("org.apache.royale.community.vos.TabBarGroupButtonVO")]
        public var subButtonBar:ArrayList;

        public function TabBarGroupButtonVO(label:String="", hash:String = null, icon:String = null, subButtonBar:ArrayList=null)
        {
            this.label = label;
            this.hash = hash;
            this.subButtonBar = subButtonBar;
            this.icon = icon;
        }
    }
}
