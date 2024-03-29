package org.apache.royale.community.jewel.beads.controls.combobox
{
	import org.apache.royale.events.Event;
	import org.apache.royale.jewel.beads.controls.combobox.IComboBoxView;
	//import org.apache.royale.jewel.beads.controls.textinput.SearchFilterForList;
	import org.apache.royale.community.jewel.beads.controls.textinput.SearchFilterForList;
	import org.apache.royale.jewel.beads.views.ComboBoxView;
	import org.apache.royale.jewel.supportClasses.textinput.TextInputBase;
	import org.apache.royale.jewel.List;
	import org.apache.royale.events.IEventDispatcher;
	import org.apache.royale.events.MouseEvent;

	/**
	 *  The SearchFilter bead class is a specialty bead that can be used with
     *  a Jewel ComboBox to filter options as we type
	 * 
	 *  This extension is intended for local debugging
	 *
	 *  @langversion 3.0
	 *  @playerversion Flash 10.2
	 *  @playerversion AIR 2.6
	 *  @productversion Royale 0.9.8
	 */
	public class SearchFilterJwExt extends org.apache.royale.community.jewel.beads.controls.textinput.SearchFilterForList
	{
		/**
		 *  constructor.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.8
		 */
		public function SearchFilterJwExt()
		{
		}

		private var comboView:IComboBoxView;

		override protected function textInputKeyUpLogic(input:Object):void
		{
			if(!list) return;
			
			// first remove a previous selection
			if(list.selectedIndex != -1)
			{
				var tmp:String = input.text;
				list.selectedItem = null;
				input.text = tmp;
			}

            if (!comboView.popUpVisible)
                comboView.popUpVisible = true;
			
			// fill "list" with the internal list in the combobox popup
			//list = comboView.popup.view.list;
			
			applyFilter(comboView.textinput.text.toUpperCase());

			ComboBoxView(comboView).autoResizeHandler(); //as we filter the popup list will be smaller, and we want to reposition
		}

		/*override protected function selectItem(item:Object):void
		{
			// Select the item in the list if text is the same 
			// we do at the end to avoid multiple selection (if there's more than one matches)
			// in that case, select the first one in the list
			// if(item != null)
			// 	list.selectedItem = item;
		}*/

		override protected function onBeadsAdded(event:Event):void{
			listenOnStrand('dismissPopUp', removeListListeners);
			listenOnStrand('popUpOpened', popUpOpenedHandler);
			listenOnStrand('popUpClosed', popUpClosedHandler);

			comboView = event.target.view as IComboBoxView;
            if (comboView)
			{
                var _textInput:TextInputBase = comboView.textinput as TextInputBase;
                if (_textInput) {
					COMPILE::JS
					{
                    _textInput.element.addEventListener('focus', onInputFocus);
                    }
            	}
            }
		}

		override protected function onInputFocus(event:Event):void{
            //if (!comboView.popUpVisible)
            //    comboView.popUpVisible = true;
			
			if (!comboView.popUpVisible)
                 IEventDispatcher((comboView as IComboBoxView).textinput).dispatchEvent(new Event(MouseEvent.CLICK));
           
        
		}

		protected function popUpOpenedHandler():void {
			// fill "list" with the internal list in the combobox popup
			list = comboView.popup.view.list;
		}

		protected function popUpClosedHandler():void {
			list = null;
		}

		public override function set list(value:List):void
        {
            super.list = value;
        }

	}
}
