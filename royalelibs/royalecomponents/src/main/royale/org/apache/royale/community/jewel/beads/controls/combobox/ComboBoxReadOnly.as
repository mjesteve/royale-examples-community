package org.apache.royale.community.jewel.beads.controls.combobox
{
	COMPILE::JS
	{
	import org.apache.royale.core.HTMLElementWrapper;
	import org.apache.royale.core.UIBase;
	import org.apache.royale.jewel.beads.views.ComboBoxView;
	}
	import org.apache.royale.core.IUIBase;
	import org.apache.royale.community.beads.ReadOnly;
	
	/**
	 *  The ComboBoxReadOnly bead class is a specialty ReadOnly bead that can be used to lock a Jewel ComboBox.
	 *  
	 *  Based on the ComboBoxDisabled bead for the Jewel ComboBox control.
	 * 
	 *  @langversion 3.0
	 *  @playerversion Flash 10.2
	 *  @playerversion AIR 2.6
	 *  @productversion Royale 0.9.6
	 */
	public class ComboBoxReadOnly extends ReadOnly
	{
		/**
		 *  constructor.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.6
		 */
		public function ComboBoxReadOnly()
		{
		}

		COMPILE::JS
		protected var lastTextInputElementTabVal:String = null;
		COMPILE::JS
		protected var lastButtonElementTabVal:String = null;

		override protected function updateHost():void
		{
			COMPILE::JS
			{
			var view:ComboBoxView = (_strand as UIBase).view as ComboBoxView;

			if (view) {
				var pos:HTMLElement = (_strand as IUIBase).positioner;
				
				if(!initialized)
				{
					initialized = true;
					lastElementTabVal = (_strand as HTMLElementWrapper).element.getAttribute("tabindex");
					lastTextInputElementTabVal = view.textinput.element.getAttribute("tabindex");
					lastButtonElementTabVal = view.button.element.getAttribute("tabindex");
				}
				
                if(readOnly) {
					setDisableAndTabIndex(pos, true);
					setDisableAndTabIndex(view.textinput.positioner, true);
					setDisableAndTabIndex(view.textinput.element);
					setDisableAndTabIndex(view.button.positioner, true);
					setDisableAndTabIndex(view.button.element);
				} else {
					removeDisableAndTabIndex(pos, true);
					removeDisableAndTabIndex(view.textinput.positioner, true);
					removeDisableAndTabIndex(view.textinput.element, false, lastTextInputElementTabVal);
					removeDisableAndTabIndex(view.button.positioner, true);
					removeDisableAndTabIndex(view.button.element, false, lastButtonElementTabVal);
				}
            }
			}
		}
	}
}
