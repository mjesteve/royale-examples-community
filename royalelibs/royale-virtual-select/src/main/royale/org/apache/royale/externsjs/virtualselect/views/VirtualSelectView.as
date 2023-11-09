package org.apache.royale.externsjs.virtualselect.views
{
    import org.apache.royale.core.BeadViewBase;
    import org.apache.royale.core.IBeadView;
    import org.apache.royale.core.IStrand;
    import org.apache.royale.utils.sendStrandEvent;
    import org.apache.royale.externsjs.virtualselect.models.VirtualSelectModel;
    import org.apache.royale.utils.observeElementSize;
    import org.apache.royale.externsjs.virtualselect.supportClass.Utils;
    import org.apache.royale.core.IStrandWithModel;
    import org.apache.royale.events.Event;
    import org.apache.royale.externsjs.virtualselect.supportClass.IVirtualSelectView;
    import org.apache.royale.externsjs.virtualselect.supportClass.IVirtualSelectCoreModel;
    import org.apache.royale.events.IEventDispatcher;
    import org.apache.royale.core.IDataProviderModel;
    import org.apache.royale.externsjs.virtualselect.supportClass.IVirtualSelectModel;
    import org.apache.royale.externsjs.virtualselect.supportClass.IVirtualMultiSelectModel;

	public class VirtualSelectView extends BeadViewBase implements IBeadView, IVirtualSelectView
	{
		/**
		 *  constructor.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.4
		 */
		public function VirtualSelectView()
		{
		}

		private var model:IVirtualSelectCoreModel;

		/**
		 *  @copy org.apache.royale.core.IBead#strand
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.4
         *  @royaleignoreimport org.apache.royale.core.WrappedHTMLElement
         *  @royaleignorecoercion org.apache.royale.core.WrappedHTMLElement
		 */
		override public function set strand(value:IStrand):void
		{
			super.strand = value;
			model =  (_strand as IStrandWithModel).model as IVirtualSelectCoreModel;
			(model as IEventDispatcher).addEventListener('configOptionChange', setConfigOptions);
			(model as IEventDispatcher).addEventListener('disabledOptionsChange', setDisabledOptions);
			//model.addEventListener('dataProviderChanged', setDataProvider);
			//if(!model.configOption.multiple){
				(model as IEventDispatcher).addEventListener('selectionChanged', selectionChangeHandler);
			//}else{
			//	model.addEventListener('selectionChanged', selectionChangeHandler);
			//}

            observeElementSize(host.element,onSizeChangeMyContainer);
            host.element.addEventListener('change', changeHandler);
            host.element.addEventListener('reset', resetHandler);
			if(model.typeControl == 'select')
			{
				host.element.addEventListener('beforeOpen', beforeOpenHandler);
				host.element.addEventListener('afterOpen', afterOpenHandler);
			}
            recreateComponent();
		}

        protected function get jsInstance():VirtualSelect{
             return model?model.jsInstance:null;
        }

        public function setConfigOptions(event:Event):void
        {
            if(jsInstance)
                recreateComponent();
        }

        protected function setDisabledOptions(event:Event):void
        {
            if(jsInstance){
                //_jsElement.setDisabledOptions(value);
                jsInstance.setDisabledOptionsMethod(model.disabledOptions);
            }
        }

        /*protected function setDataProvider(event:Event):void
        {
            if(jsInstance){
                //_jsInstance.setOptions(value);
               jsInstance.setServerOptions(model.dataProvider);
            }
        }*/

        protected function recreateComponent():void
        {
            if(jsInstance)
            {
                // Al utilizar, en set dataprovider, la función Array.concat() en vez de ObjectUtil.clone (porque tarda mucho)
                // el dataprovider interno queda unido con el asignado actualizándolo al seleccionar los items.
                // Reseteamos para anular cualquier posible selección.
                jsInstance.reset();
                jsInstance.destroy();
            }

            model.jsInstance = VirtualSelect.init(model.configOption.optsInit);
            model.jsInstance.setServerOptions( ((model as IDataProviderModel).dataProvider as Array) );
        }

        protected var localwidth:Number;
        protected function onSizeChangeMyContainer():void
        {
            if(localwidth != host.element.offsetWidth)
            {
                //trace("CHANGE WIDTH", localwidth, element.offsetWidth);
                localwidth = host.element.offsetWidth;
            }
            if(model.configOption.keepAlwaysOpen && model.autoOptionsCount )
            {
                //AutoHeight. Pendiente porque la librería no permite el cambio de opciones después de la inicialización.
                var ith:Number = Math.ceil(host.height/Number(Utils.getNumCharacters( model.configOption.optionHeight)));
                if( model.configOption.optionsCount != ith )
                {
                    model.configOption.optionsCount = ith;
                }
            }
        }

        protected function changeHandler(event:Event):void
        {
            trace('Component Change');
            //model.selectedItem = selectedItem;
            //sendStrandEvent(_strand,new Event("onChange"));
            if( event.target ){
                var item:Object = event.target.value;
                if(!model.configOption.multiple)
                {
                    (model as IVirtualSelectModel).selectedValue = event.target.value;
                }else{
                    (model as IVirtualMultiSelectModel).selectedValues = event.target.value as Array;
                }
            }
            /*if( model.typeControl == 'select' || model.configOption.hideSelectDisplayOnKeepAlwaysOpen == false)
            {
                if(event.target.innerText.toString().indexOf("Select") != -1)
                {
                    event.target.querySelector(".vscomp-toggle-button").style = "width:100% !important";
                    event.target.querySelector(".vscomp-clear-button").style = "width:0% !important";
                    event.target.querySelector(".vscomp-clear-icon").style = "width:0% !important";
                    event.target.querySelector(".vscomp-option-text").style = "width:100% !important";
                }
                else
                {
                    var domele:Element = event.target.querySelector(".vscomp-option-text") as Element;
                    if(domele) event.target.querySelector(".vscomp-option-text").style = "width:calc(100% - 322px) !important";

                     domele = event.target.querySelector(".vscomp-toggle-button") as Element;
                    if(domele) event.target.querySelector(".vscomp-toggle-button").style = "width:calc(100% - 32px) !important";
                     domele = event.target.querySelector(".vscomp-clear-button") as Element;
                    if(domele) event.target.querySelector(".vscomp-clear-button").style = "width:14px !important";
                     domele = event.target.querySelector(".vscomp-clear-icon") as Element;
                    if(domele) event.target.querySelector(".vscomp-clear-icon").style = "width:14px !important";
                }
            }*/
        }

        protected function selectionChangeHandler(event:Event):void
        {
            trace('Selection Change');
            //model.selectedItem = selectedItem;
            sendStrandEvent(_strand,new Event("onChange"));
        }
        /*protected function clickHandler(event:Event):void
        {
            dispatchEvent(new Event("onButtonClick"));
    key: "getData",
    value: function getData($ele, name, type) {
      if (!$ele) {
        return undefined;
      }

      var value = $ele ? $ele.dataset[name] : '';
      if (type === 'number') {
        value = parseFloat(value) || 0;
      } else if (value === 'true') {
        value = true;
      } else if (value === 'false') {
        value = false;
      }
      return value;
    }
        }*/

        protected function beforeOpenHandler(event:Event):void
        {
            sendStrandEvent(_strand,new Event("onBeforeOpen"));
        }

        protected function afterOpenHandler(event:Event):void
        {
            sendStrandEvent(_strand,new Event("onAfterOpen"));
        }

        protected function resetHandler(event:Event):void
        {
            sendStrandEvent(_strand,new Event("onReset"));
        }

        public function reset():void{
            jsInstance.reset();
        }
	}
}
