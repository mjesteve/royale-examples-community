package org.apache.royale.externsjs.virtualselect.models
{    
    import org.apache.royale.core.ISelectionModel;
    import org.apache.royale.externsjs.virtualselect.supportClass.IVirtualSelectModel;

    public class VirtualSelectModel extends VirtualSelectCoreModel implements IVirtualSelectModel, ISelectionModel
    {

        public function VirtualSelectModel(){
            super();
        }

        override protected function syncDataProvider():void{
            
            if(_dataProvider && _selectedValue)
                syncFromValue();
            else if (!_dataProvider)
                selectedValue = null;
        }
        
        protected var _selectedIndex:int = -1;
        /**
         * Get selected selectedIndex.
         */
        public function get selectedIndex():int
        {
            if(selectedItem)
                _selectedIndex = _selectedItem.index;
            else
                _selectedIndex = -1;
            return _selectedIndex;
        }
        public function set selectedIndex(value:int):void
        {
            if(selectedIndex == value) return;

            if( value == -1 )
                selectedValue = null;
            else{
                var ln:int = dataProvider.length;
                var varvalue:Object = null;
                for(var i:int=0; i<ln; i++)
                {
                    var item:Object = _dataProvider[i];
                    if(int(item['index']) == value)
                        varvalue = item[_configOption.valueKey];
                }
                if( varvalue == null ){
                    _selectedIndex = -1;
                    _selectedItem = null;
                }
                selectedValue = varvalue;
            }
        }
        private var _selectedItem:Object;
        /**
         * Get selected selectedItem.
         */
        public function get selectedItem():Object
        { 
            if(_jsInstance){
                // this.multiple || fullDetails ? selectedOptions : selectedOptions[0];
                // Para que recuperemos el item completo, con el atributo index, fullDetails debe ser true.
                var arsel:Array = _jsInstance.getSelectedOptions({fullDetails: true, keepSelectionOrder: false});
                if( arsel && arsel.length > 0 && arsel[0])
                {
                    _selectedItem = arsel[0];
                    _selectedIndex = int(_selectedItem['index']);
                    _selectedValue = _selectedItem[_configOption.valueKey];
                }
                else{
                    _selectedItem = null;
                    _selectedIndex = -1;
                    _selectedValue = null;
                }
            }
            return _selectedItem;
        }
        public function set selectedItem(value:Object):void
        { 
            if(selectedItem == value) return;
        
            if( value == null)
                selectedValue = null;
            else {
                var varvalue:Object = value[_configOption.valueKey];
                if( varvalue == null){
                    _selectedIndex = -1;
                    _selectedItem = null;
                }
                selectedValue = varvalue;
            }
        }
        /**
         * Diferente al 'selectedValue' de configOptions.
         * Valor seleccionado en el componente.
         */
        private var _selectedValue:Object;
        public function get selectedValue():Object{ 
            if(_jsInstance)
            {
                _selectedValue = _jsInstance.$ele.value;
            }
            return _selectedValue;
        }
        public function set selectedValue(value:Object):void
        { 
            if(_selectedValue == value) return;
            
            //if(_jsInstance && _selectedValue)
            //    jsInstance.reset();

            // Hay métodos que solo funcionan si son llamados desde el Element y no desde la Instancia del control
            // https://github.com/sa-si-dev/virtual-select/blob/c3eb001e2af339c9dff538e84f89da426ac9afe6/src/virtual-select.js#L866
            //jsInstance.$ele.setValue(value);
            if(selectedValue != value)                
                _jsInstance.setValueMethod(value,false);

            if( !selectedItem || selectedValue == null )
                _selectedIndex = -1;
            else
                _selectedValue = value;
            var evt:Event = new Event("selectionChanged");
            evt.bubbles = true;
            dispatchEvent(evt);
        }

		private function syncFromValue():void
		{
            var item:Object = null;
            var itemIdx:int = -1;
            var itemVal:Object = null;
            var ln:int = _dataProvider.length;
            for (var i:int = 0; i < ln; i++)
            {
                if(_dataProvider[i][_configOption.valueKey] == _selectedValue)
                {
                    item = _dataProvider[i];
                    itemIdx = _dataProvider[i]['index'];
                    break;
                }
            }
            if( item == null )
                itemVal = null;
            _selectedIndex = itemIdx;
            _selectedItem = item;
		}
    }
}