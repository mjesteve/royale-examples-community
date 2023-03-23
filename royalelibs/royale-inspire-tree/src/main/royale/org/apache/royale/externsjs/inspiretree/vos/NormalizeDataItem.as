package org.apache.royale.externsjs.inspiretree.vos
{
    
    public class NormalizeDataItem
    {
        public var data:Object;
        public var checked:Boolean;
        public var indeterminate:Boolean;
        public var marked:Boolean;
        public var enabled:Boolean;
        [ArrayElementType("org.apache.royale.externsjs.inspiretree.vos.NormalizeDataItem")]
        public var children:Array;

        public function NormalizeDataItem(item:Object=null){
            data = item ? item:new Object;
            checked = false;
            marked = false;
            enabled = true;
            indeterminate = false;
        }

    }

}