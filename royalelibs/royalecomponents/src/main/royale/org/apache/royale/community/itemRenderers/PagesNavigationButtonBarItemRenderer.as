package org.apache.royale.community.itemRenderers
{

	import org.apache.royale.jewel.itemRenderers.ToggleButtonBarItemRenderer;
	import org.apache.royale.jewel.beads.views.ButtonBarView;
	import org.apache.royale.community.controls.PagesNavigationButtonBar;

	public class PagesNavigationButtonBarItemRenderer extends ToggleButtonBarItemRenderer
    {

		public function PagesNavigationButtonBarItemRenderer()
		{
			super();
			selectable = true;
		}
		/*private var _data:Object;

		override public function get data():Object
		{
			return _data;
		}
		override public function set data(value:Object):void
		{
			_data = value;
			text = getLabelFromData(this, value);
			rightPosition = ((itemRendererOwnerView as ButtonBarView).buttonBar as ToggleButtonBar).rightPosition;
			if(value.icon)
			{
				var iconClass:Class = ValuesManager.valuesImpl.getValue((itemRendererOwnerView as ButtonBarView).buttonBar, "iconClass") as Class;
				var fontIcon:IIcon = new iconClass(); 
				// fontIcon.material = ((itemRendererOwnerView as ButtonBarView).buttonBar as ToggleButtonBar).material;
				fontIcon.text = value[((itemRendererOwnerView as ButtonBarView).buttonBar as ToggleButtonBar).iconField];
				icon = fontIcon;
			}
		}*/

		/**/
		override public function set data(value:Object):void
		{
            super.data = value;
			if(selectable)
            {
				selected = ((itemRendererOwnerView as ButtonBarView).buttonBar as PagesNavigationButtonBar).indexToSelect == index ? true : false;
			}else{
				selected = false;
			}
			//trace("Selected Index" + index.toString() + " : " + selected.toString());
		}

    }
}