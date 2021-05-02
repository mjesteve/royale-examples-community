package org.apache.royale.community.views
{

	import org.apache.royale.events.EventDispatcher;

	//import mx.utils.ObjectProxy;
	
	[Bindable]// (event="UpdateEvent")]
	public class BindingTest extends EventDispatcher
	{
		//[Bindable]
		public var _idref:Array; // = new ObjectProxy(pairsObj);
		[Bindable(event="idrefUpdate")]
		public function get idref():Array{ return _idref; }
		public function set idref(value:Array):void{ _idref = value;
        	dispatchEvent(new Event("idrefUpdate"));
		}
		
		[Bindable]
		public var test:String="";
		/*[Bindable (event="testUpdate")]
		public function get test():String{ return _test; }
		public function set test(value:String):void{
			_test = value; 
        	dispatchEvent(new Event("testUpdate"));
		}*/
		

		public function BindingTest():void{

			idref = [0,1,2];	

		}

  		public function UpdateData():void
		{
			var nodes:Array = [0,1,2];
			var idrefTemp:Array = [];
			for each(var node:int in nodes)
			{
				var ref:String = node +"";
				ref = ref.toLowerCase();
				var text:String = node + "";
				if (idref[ref])
					text = idref[ref];
				text += "A";
				idrefTemp[ref] = text;
			}
			idref = idrefTemp;
			test = idref[0];
        	//dispatchEvent(new Event("UpdateEvent"));
		}

		public function getRef(ref:String="",outDefault:Boolean = true):String
		{
			var paramref:String = ref.toLowerCase();
			var res:String=paramref;
				
			if(idref[paramref]){
				res = idref[paramref];
			}else{
				if(!outDefault){
					res = null;
					return res;
				}
			}
			return res;
		}

    }
}