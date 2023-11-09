package org.apache.royale.community.jewel.beads.views
{
	COMPILE::JS
	{
	import org.apache.royale.geom.Point;
	import org.apache.royale.jewel.supportClasses.ResponsiveSizes;
	import org.apache.royale.jewel.supportClasses.util.positionInsideBoundingClientRect;
	import org.apache.royale.utils.PointUtils;
	}
	import org.apache.royale.core.BeadViewBase;
	import org.apache.royale.core.IComboBoxModel;
	import org.apache.royale.core.IItemRendererProvider;
	import org.apache.royale.core.ILayoutChild;
	import org.apache.royale.core.IParent;
	import org.apache.royale.core.IPopUp;
	import org.apache.royale.core.IStrand;
	import org.apache.royale.core.IStrandWithModel;
	import org.apache.royale.core.IUIBase;
	import org.apache.royale.core.ValuesManager;
	import org.apache.royale.events.Event;
	import org.apache.royale.html.util.getLabelFromData;
	import org.apache.royale.jewel.Button;
	import org.apache.royale.jewel.ComboBox;
	import org.apache.royale.jewel.IconTextInput;
	import org.apache.royale.jewel.List;
	import org.apache.royale.jewel.beads.models.IJewelSelectionModel;
	import org.apache.royale.jewel.beads.views.ComboBoxPopUpView;
	import org.apache.royale.jewel.supportClasses.combobox.ComboBoxPopUp;
	import org.apache.royale.jewel.supportClasses.textinput.TextInputBase;
	import org.apache.royale.utils.UIUtils;
	import org.apache.royale.utils.sendStrandEvent;
	import org.apache.royale.community.jewel.IconReset;
	import org.apache.royale.community.jewel.beads.controls.combobox.IComboBoxViewJwExt;
	import org.apache.royale.community.jewel.supportClasses.IStrandWithResetButton;
	/**
	 *  The ComboBoxView class creates the visual elements of the org.apache.royale.jewel.ComboBox
	 *  component. The job of the view bead is to put together the parts of the ComboBox such as the TextInput
	 *  control and org.apache.royale.jewel.Button to trigger the pop-up.
	 *
	 *  @viewbead
	 *  @langversion 3.0
	 *  @playerversion Flash 10.2
	 *  @playerversion AIR 2.6
	 *  @productversion Royale 0.9.4
	 */
	public class ComboBoxViewJwExt extends BeadViewBase implements IComboBoxViewJwExt
	{
		public function ComboBoxViewJwExt()
		{
			super();
		}

		private var _textinput:IconTextInput;
		/**
		 *  The TextInput component of the ComboBox.
		 *
		 *  @copy org.apache.royale.jewel.beads.controls.combobox.IComboBoxViewJwExt#textinput
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.4
		 */
		public function get textinput():TextInputBase
		{
			return _textinput;
		}

		private var _button:Button;
		/**
		 *  The Button component of the ComboBox.
		 *
		 *  @copy org.apache.royale.jewel.beads.controls.combobox.IComboBoxView#button
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.4
		 */
		public function get button():IUIBase
		{
			return _button;
		}

		protected var _resetbutton:IconReset;
		/**
		 *  The Button component of the ComboBox.
		 *
		 *  @copy org.apache.royale.jewel.beads.controls.combobox.IComboBoxViewJwExt#resetButton
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.10
		 */

		public function get resetButton():IconReset
		{
			return _resetbutton;
		}

		private var combobox:IStrandWithResetButton;
		private var _comboPopUp:ComboBoxPopUp;
		protected var _list:List;

		/**
		 *  The pop-up list component of the ComboBox.
		 *
		 *  @copy org.apache.royale.jewel.beads.controls.combobox.IComboBoxView#popup
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.4
		 */
		public function get popup():IPopUp
		{
			return _comboPopUp;
		}

		/**
		 * @private
		 * @royaleignorecoercion org.apache.royale.events.IEventDispatcher
		 * @royaleignorecoercion org.apache.royale.core.StyledUIBase
		 */
		override public function set strand(value:IStrand):void
		{
			super.strand = value;
			combobox = value as IStrandWithResetButton;

			_textinput = new IconTextInput();
			_button = new Button();
        	_button.tabIndex = -1;
			_button.text = '\u25BC';

			if( combobox.withResetButton )
			{
				_resetbutton = new IconReset();
				_textinput.icon = _resetbutton;
				_textinput.rightPosition=true;
			}

			initSize();

			var parent:IParent = host as ComboBox;
			parent.addElement(_textinput);			
			parent.addElement(_button);

			model = (value as IStrandWithModel).model as IComboBoxModel;

			if (model is IJewelSelectionModel) {
				//do this here as well as in the controller,
				//to cover possible variation in the order of bead instantiation
				//this avoids the need to redispatch new event clones at the component level in the controller
                IJewelSelectionModel(model).dispatcher = host;
				host.addEventListener("selectionChanged", handleItemChange);
				host.addEventListener("dataProviderChanged", itemChangeAction);
			}else{
				model.addEventListener("selectionChanged", handleItemChange);
				model.addEventListener("dataProviderChanged", itemChangeAction);
			}
            COMPILE::JS{
				//remove text or text incomplete
				host.element.addEventListener('blur', handleTextInputFocusOut);
			}
		}

        private function handleTextInputFocusOut(event:Event):void
        {
			//verify selected value is not null
			//real selection? ¿text in _textInput?
			var displaytext:String = getLabelFromData(model, model.selectedItem);
			if( _textinput.input.value != displaytext )
				_textinput.text = "";
        }

		protected var model:IComboBoxModel;

		private var _popUpClass:Class;
		/**
		 *  Returns whether or not the pop-up is visible.
		 *
		 *  @copy org.apache.royale.jewel.beads.controls.combobox.IComboBoxView#popUpVisible
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.4
		 */
		public function get popUpVisible():Boolean
		{
			return _comboPopUp != null;
		}
		/**
		 * @royaleignorecoercion org.apache.royale.core.IComboBoxModel
		 * @royaleignorecoercion org.apache.royale.core.IUIBase
		 * @royaleignorecoercion org.apache.royale.core.IItemRendererProvider
		 * @royaleignorecoercion org.apache.royale.jewel.supportClasses.combobox.ComboBoxPopUp
		 * @royaleignorecoercion org.apache.royale.jewel.beads.views.ComboBoxPopUpView
		 */
		public function set popUpVisible(value:Boolean):void
		{
			if (value) {
				if (_comboPopUp == null) {
                    if(!_popUpClass)
                    {
                        _popUpClass = ValuesManager.valuesImpl.getValue(host, "iPopUp") as Class;
                    }

                    _comboPopUp = new _popUpClass() as ComboBoxPopUp;
					_comboPopUp.addBead((host as ComboBox).presentationModel);
					_comboPopUp.model = model;

					// if  user defines item render for combo must be pased to popup list

					// priority goes to instance itemRenderer
					if((combobox as IItemRendererProvider).itemRenderer)
					{
						_comboPopUp.itemRenderer = (combobox as IItemRendererProvider).itemRenderer;
					} else
					// second priority goes CSS defined itemRenderer
					{
						var itemRendererClass:Class = ValuesManager.valuesImpl.getValue(host, "iItemRenderer") as Class;
						if(itemRendererClass != null)
							_comboPopUp.itemRendererClass = itemRendererClass;
					}

					UIUtils.addPopUp(_comboPopUp, host);
                    // var popupHost:IPopUpHost = UIUtils.findPopUpHost(host);
                    // popupHost.popUpParent.addElement(_comboPopUp);

                    // popup is ComboBoxPopUp that fills 100% of browser window-> We want the internal List inside its view to adjust height
                    _list = (_comboPopUp.view as ComboBoxPopUpView).list;

					//popup width needs to be set before position inside bounding client to work ok
                    COMPILE::JS
                    {
					if (isNaN((host as ComboBox).percentWidth))
						_list.width = host.width;
					else
						_list.width = host.element.offsetWidth;
                    }
                    COMPILE::SWF
                    {
					_list.width = host.width;
                    }

                    COMPILE::JS
                    {
					// Fix temporary: when soft keyboard opens in ios devices browser is not resized, so popup gets under the keyboard
					// this fixes the issue on iPad for now, but we need some better and more reliable way of doing this
					// if(BrowserInfo.current().formFactor == "iPad")
					// {
					// 	var fromTop:Number = _textinput.element.getBoundingClientRect().top;
					// 	if(fromTop < 720)
					// 	{
					// 		_comboPopUp.positioner.style["padding-bottom"] =  "310px";
					// 	}
					// }

					window.addEventListener('resize', autoResizeHandler, false);
                    }

					prepareForPopUp();

					sendStrandEvent(_strand, "popUpOpened");

                    autoResizeHandler();
				}
			}
			else if(_comboPopUp != null) {
				UIUtils.removePopUp(_comboPopUp);
				COMPILE::JS
				{
				document.body.classList.remove("viewport");
				window.removeEventListener('resize', autoResizeHandler, false);
				}
				_comboPopUp = null;
				sendStrandEvent(_strand, "popUpClosed");
			}
		}

		private function prepareForPopUp():void
        {
			COMPILE::JS
			{
			//check here for non-null in case popUpVisible was toggled off before timeout runs
			if (_comboPopUp != null) {
				_comboPopUp.element.classList.add("open");
				//avoid scroll in html
				document.body.classList.add("viewport");
			}
			}
		}

		/**
		 * @private
		 */
		protected function handleItemChange(event:Event):void
		{
			itemChangeAction();
		}

		/**
		 * @private
		 * @royaleignorecoercion org.apache.royale.core.IComboBoxModel
		 */
		protected function itemChangeAction(event:Event = null):void
		{
			if(!model)
				model = (_strand as IStrandWithModel).model as IComboBoxModel;
			_textinput.text = getLabelFromData(model, model.selectedItem);
			
			validateReset();
		}

		public static const DEFAULT_BUTTON_WIDTH:Number = 38;
		public static const DEFAULT_WIDTH:Number = 200;

		/**
		 * Size the component at start up
		 *
		 * @private
		 */
		protected function initSize():void
		{
			_button.width = DEFAULT_BUTTON_WIDTH;
			/* if( combobox.withResetButton ){
				_resetbutton.positioner.style["align-items"] = "center";
				_resetbutton.positioner.style["display"] = "none";
				_resetbutton.positioner.style["height"] = "100%";
				_resetbutton.positioner.style["position"] = "absolute";
				_resetbutton.positioner.style["right"] = "5px";
			} */

			var cmb:ILayoutChild = host as ILayoutChild;

			// if no width (neither px or %), set default width
			if(cmb.isWidthSizedToContent())
				cmb.width = DEFAULT_WIDTH;

			_textinput.percentWidth = 100;
		}

		/**
		 *  Adapt the popup list to the right position taking into account
		 *  if we are in DESKTOP/TABLET screen size or in PHONE screen size
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.4
		 */
		public function autoResizeHandler(event:Event = null):void
        {
			COMPILE::JS
			{
				var outerWidth:Number = document.body.getBoundingClientRect().width;
				// handle potential scrolls offsets
				var top:Number = (window.pageYOffset || document.documentElement.scrollTop)  - (document.documentElement.clientTop || 0);

				// Desktop width size
				if(outerWidth >= ResponsiveSizes.TABLET_BREAKPOINT)
				{
					var origin:Point = new Point(0, button.y + button.height - top);
					var relocated:Point = positionInsideBoundingClientRect(host, _list, origin);
					var point:Point = PointUtils.localToGlobal(origin, host);

					// by default list appear below textinput

					// if there's no enough space below, reposition above input
					if(relocated.y < point.y)
					{
						var origin2:Point = new Point(0, button.y - _list.height - top);
						var relocated2:Point = positionInsideBoundingClientRect(host, _list, origin2);
						_list.y = relocated2.y;

						//if start to cover input...
						if(_list.y == 0)
						{
							// ... reposition to the left or to right side (so we still can see the input)
							_list.x = (relocated.x + _list.width + 1 >= outerWidth) ? relocated.x - _list.width : _list.x = relocated.x + _list.width;
						}
						else
						{
							// otherwise left in the same vertical as input
							_list.x = relocated.x;
						}
					}
					else
					{
						_list.y = relocated.y;
						_list.x = relocated.x;
					}
				}
				else
				{
					_list.positioner.style["left"] = "50%";
					_list.positioner.style["top"] = "calc(100% - 10px)";
					// _list.positioner.style["width"] = "initial";
				}
			}
		}

		private function validateReset():void
		{
			if( !combobox.withResetButton )
				return;
				
			if( !model.selectedItem){
				_resetbutton.positioner.style["display"] = "none";
				//_button.width = DEFAULT_BUTTON_WIDTH;
			}else{
				_resetbutton.positioner.style["display"] = "inherit";
				//_resetbutton.positioner.style["display"] = "flex";
				//_button.width = DEFAULT_BUTTON_WIDTH - _resetbutton.width;
			}
		}
	}
}
