package org.apache.royale.community.vo
{
    [Bindable]
    public class PageNavigatorButtonBarVO
    {
        public var label:String;
        public var icon:String;
        public var valuePage:int;
        public var selected:Boolean;

        public function PageNavigatorButtonBarVO(parlabel:String, parvaluePage:int,paricon:String = null, parselected:Boolean = false)
        {
            label = parlabel;
            valuePage = parvaluePage;
            selected = parselected;
            icon = paricon;
        }
    }
}
