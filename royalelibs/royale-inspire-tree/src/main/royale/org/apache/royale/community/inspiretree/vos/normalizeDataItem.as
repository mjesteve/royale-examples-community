package org.apache.royale.community.inspiretree.vos
{
    
    public class normalizeDataItem
    {
        public var data:Object;
        public var checked:Boolean;
        public var marked:Boolean;
        public var enabled:Boolean;

        public function normalizeDataItem(item:Object){
            data = item;
            checked = false;
            marked = false;
            enabled = true;
        }

    }

}