package org.apache.royale.community.views.draganddrop.vos
{
	import org.apache.royale.collections.ArrayList;

	[Bindable]
	public class CTypeLink
	{
		public function CTypeLink(idx:int,horarios:ArrayList)
		{
            this.idx = idx;
            this.horarios = horarios;
		}
		
		public var idx:int = -1;
        [ArrayElementType("org.apache.royale.community.views.draganddrop.vos.CTypeDragDropDisplay")]
		public var horarios:ArrayList = new ArrayList;
	}
}