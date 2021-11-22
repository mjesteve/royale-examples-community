package org.apache.royale.community.vos
{
	
	[Bindable]
	public class PermissVO
	{
		public var idobj:int = -1;
		public var desobj:String = "";
		public var idxacc:int = -1;
		public var desacc:String = "";
		public var checked:uint = 0;
		public var enabled:uint = 1;
		public var icon:String = "";

		public function PermissVO(idobj:int = -1, desobj:String = "", idxacc:int = -1, desacc:String = "", checked:uint = 0, enabled:uint = 1,icon:String="")
		{
			this.idobj = idobj;
			this.desobj = desobj;
			this.idxacc = idxacc;
			this.desacc = desacc;
			this.checked = checked;
			this.enabled = enabled;
			this.icon = icon;
		}
		
	}
}