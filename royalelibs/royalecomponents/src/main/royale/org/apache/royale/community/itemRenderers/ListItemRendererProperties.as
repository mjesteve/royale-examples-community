package org.apache.royale.community.itemRenderers
{
	import org.apache.royale.jewel.itemRenderers.ListItemRenderer;
	import org.apache.royale.community.beads.IPropertiesBead

	public class ListItemRendererProperties extends ListItemRenderer
	{

		public function ListItemRendererProperties()
		{
			super();
		}

        private var _properties:Object;
        public function get properties():Object
        {
            return _properties;
        }
        public function set properties(value:Object):void
        {
            _properties = value;
        }
		protected var _propertiesItBead:IPropertiesBead;
		
		public function get propertiesItBead():IPropertiesBead {
			if(!_propertiesItBead) {
				_propertiesItBead = itemRendererOwnerView.host.getBeadByType(IPropertiesBead) as IPropertiesBead;
			}
			return _propertiesItBead;
		}

		 override public function set data(value:Object):void{
			if(propertiesItBead && propertiesItBead.propertiesIt)
				properties = propertiesItBead.propertiesIt;
			 super.data = value;
		 }
		
	}
}
