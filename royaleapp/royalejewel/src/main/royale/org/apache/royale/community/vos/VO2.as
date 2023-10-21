package org.apache.royale.community.vos
{
    [Bindable]
    public class VO2
    {
        //import org.apache.royale.collections.IArrayList;
        import org.apache.royale.collections.ArrayList;

		public var codigo:String = "";
		public var displaytext:String = "";
        public var ar:Array = null;
        public var arr:ArrayList = null;

        public function VO2(codigo:String="", displaytext:String = null, ar:Array = null, arr:ArrayList=null)
        {
            this.codigo = codigo;
            this.displaytext = displaytext;
            if(ar)
            this.ar = ar;
            if(arr)
            this.arr = arr;
        }
    }
}
