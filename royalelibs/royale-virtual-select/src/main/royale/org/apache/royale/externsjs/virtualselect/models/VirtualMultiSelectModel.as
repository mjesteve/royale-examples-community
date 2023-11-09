package org.apache.royale.externsjs.virtualselect.models
{    
    import org.apache.royale.externsjs.virtualselect.supportClass.Utils;
    import org.apache.royale.core.IMultiSelectionModel;
    import org.apache.royale.externsjs.virtualselect.supportClass.IVirtualMultiSelectModel;

    public class VirtualMultiSelectModel extends VirtualSelectCoreModel implements IVirtualMultiSelectModel, IMultiSelectionModel
    {
        public function VirtualMultiSelectModel(){
            super();
        }

        override protected function syncDataProvider():void{
            
            if(_dataProvider && _selectedValues)
                syncFromValues();
            else if (!_dataProvider)
                selectedValues = null;
        }
        
        private var _selectedIndices:Array;
        /**
         * Get selected selectedIndices.
         */
        public function get selectedIndices():Array
        {
            return _selectedIndices;
        }
        public function set selectedIndices(value:Array):void
        {
			if (value == _selectedIndices) return;

			_selectedIndices = value;
            if(selectedIndices != value){
                if( !value || value.length == 0 || !dataProvider || dataProvider.length == 0 )
                {
                    _selectedItems = null;
                    _selectedValues = null;
                }
                else{
                    syncFromIndices();
                }
            }
			dispatchEvent(new Event("selectedItemsChanged"));
			dispatchEvent(new Event("selectedIndicesChanged"));
			dispatchEvent(new Event("selectedValuesChanged"));
        }
        private var _selectedItems:Array;
        /**
         * Get selected selectedItems.
         */
        public function get selectedItems():Array{ 
            if(_jsInstance){
                // this.multiple || fullDetails ? selectedOptions : selectedOptions[0];
                // Para que recuperemos el item completo, con el atributo index, fullDetails debe ser true.
                var arsel:Array = _jsInstance.getSelectedOptions({fullDetails: true, keepSelectionOrder: true});
                if( arsel && arsel.length > 0)
                {
                    _selectedItems = arsel;
                    //Aquí es mas efectivo un bucle local
                    //_selectedIndices = Utils.getSimpleArrayFromField(arsel,'index');
                    //_selectedValues = Utils.getSimpleArrayFromField(arsel,_configOption.valueKey);
                    var ln:int = arsel.length;
                    _selectedIndices = new Array();
                    _selectedValues = new Array();
                    for(var i:int=0; i<ln; i++)
                    {
                        var item:Object = arsel[i];
                        _selectedIndices.push( int(item['index']) );
                        _selectedValues.push( item[_configOption.valueKey] );
                    }
                }
                else{
                    _selectedItems = null;
                    _selectedIndices = null;
                    _selectedValues = null;
                }
            }
            return _selectedItems; 
        }
        public function set selectedItems(value:Array):void
        { 
            if(selectedItems == value) return;
            
            if( value == null)
                selectedValues = null;
            else {
                var arvalue:Array = Utils.getSimpleArrayFromField(value,_configOption.valueKey);
                if( !arvalue || arvalue.length==0 ){
                    _selectedItems = null;
                    _selectedIndices = null;
                }
                selectedValues = arvalue;
            }
        }
        private var _selectedValues:Array;
        /**
         * Get selected selectedValues.
         */
        public function get selectedValues():Array
        {
            if(_jsInstance)
            {
                _selectedValues = _jsInstance.selectedValues;
            }
            return _selectedValues;
        }
        public function set selectedValues(value:Array):void
        {
            if(_selectedValues == value) return;
            
            //jsInstance.reset();

            // Hay métodos que solo funcionan si son llamados desde el Element y no desde la Instancia del control
            // https://github.com/sa-si-dev/virtual-select/blob/c3eb001e2af339c9dff538e84f89da426ac9afe6/src/virtual-select.js#L866
            //jsInstance.$ele.setValue(value);
            if(selectedValues != value)                
                _jsInstance.setValueMethod(value,false);

            if( !selectedItems || selectedValues == null )
                _selectedIndices = null;
            else
                _selectedValues = value;
            var evt:Event = new Event("selectionChanged");
            evt.bubbles = true;
            dispatchEvent(evt);
        }

		private function syncFromIndices():void
		{
            var items:Array = [];
            var itemsVal:Array = [];
            for (var i:int = 0; i < _selectedIndices.length; i++)
            {
                if(_dataProvider[i]['index'] == _selectedIndices[i])
                {
                    items.push(_dataProvider[i]);
                    itemsVal.push(_dataProvider[i][_configOption.valueKey]);
                }
            }
            _selectedItems = items;
            _selectedValues = itemsVal;
		}

		private function syncFromValues():void
		{
            var items:Array = [];
            var itemsIdx:Array = [];
            var itemsVal:Array = [];
            var ln:int = _dataProvider.length;
            for (var i:int = 0; i < _selectedValues.length; i++)
            {
                var exist:Boolean=false;
                for (var x:int =0; x < ln; x++)
                {
                    if(_dataProvider[x][_configOption.valueKey] == _selectedValues[i])
                    {
                        items.push(_dataProvider[x]);
                        itemsIdx.push(_dataProvider[x]['index']);
                        exist = true;
                        break;
                    }
                }
                if( exist )
                    itemsVal.push(_selectedValues[i]);
            }
            _selectedIndices = itemsIdx;
            _selectedItems = items;
            if(_selectedValues.length != itemsVal.length)
                _selectedValues = itemsVal;
		}
    }
}