package org.apache.royale.community.vos
{
    [Bindable]
    public class VO1
    {
        //import org.apache.royale.collections.IArrayList;
        import org.apache.royale.collections.ArrayList;

		public var codigo:String = "";
		public var displaytext:String = "";
        public var ar:Array = new Array();
        public var arr:ArrayList = new ArrayList();

        public var codb:Boolean = false;
        public var fecha:Date = new Date(0,0,0);
        public var fn:Function = new Function;
        public var cls:VO2 = new VO2();

        public function VO1(codigo:String="", displaytext:String = null)
        {
            this.codigo = codigo;
            this.displaytext = displaytext;
        }
    }
}
