package org.apache.royale.community.vo
{
    [Bindable]
    public class PillItemVO
    {
        public var label:String;
        public var text:String;
        public var nameProperty:String;
        public var valueReset:Object;

        public function PillItemVO(plabel:String="", ptext:String="", pnameProperty:String="", pvalueReset:Object="")
        {
            this.label = plabel;
            this.text = ptext;
            this.nameProperty = pnameProperty;
            this.valueReset = pvalueReset;
        }
    }
}
