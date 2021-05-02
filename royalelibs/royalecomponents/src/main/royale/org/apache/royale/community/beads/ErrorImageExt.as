package org.apache.royale.community.beads
{

    import org.apache.royale.core.IStrand;
    import org.apache.royale.events.Event;
    import org.apache.royale.events.EventDispatcher;
    import org.apache.royale.core.IImageModel;
    import org.apache.royale.community.beads.ErrorImage;

	//[Event(name="onError", type="org.apache.royale.events.Event")]

    public class ErrorImageExt extends org.apache.royale.community.beads.ErrorImage {

        public function ErrorImageExt() {
            super();
        }

        /*
        Las propiedades se cargan antes que los Beads
        */
        private var _emptyIsError:Boolean = false;
        public function get emptyIsError():Boolean {
            return _emptyIsError;
        }
        public function set emptyIsError(value:Boolean):void {
            _emptyIsError = value;
        }
        
        private var _model:IImageModel;

        override public function set strand(value:IStrand):void {
            super.strand = value;

            if(_emptyIsError)
            {
                COMPILE::JS {
                    (_strand as EventDispatcher).addEventListener('srcChanged', srcChangedHandler);
                }
                /**
                 * Tratamiento de los valores "cadena vacía" y Null. En estos momentos, ni el modelo
                 * de los controles Image, jewel y basic, ni el del jewel ImageButton cambian el 
                 * source de la imágen asociada en estos casos.
                 * Se plantean dos posibilidades: Crear un nuevo bead para esto o implementarlo con
                 * el actual ErrorImage. Además, también se duda en el procedimiento a seguir: 
                 * Eliminar el objeto del DOM o no (Todo esto está planteado actualmente en la lista de royale dev) 
                 * 
                 * Nosotros por ahora, lo vamos a implementar en este mismo bead indicando si se desea
                 * tener en cuenta estos valores o no, con la propiedad emptyIsError.
                 * Podemos cambiar el valor en el modelo o enviarle directamente el valor al HTMLelement
                 * como hace el control Image.as ((element as HTMLImageElement).src = binaryDataAsString;)
                 * En cualquiera de los dos casos tenemos que saber, cuando cambia la url del modelo para
                 * saber si el valor ha sido "" o null y actuar en consecuencia.*/

                //Los beads de modelo se cargan después de los beads añadido en los tags.
                //Para poder añadir un listerner del cambio de url del modelo y poder actuar si es 
                //cadena vacía o nulo, lo añadiremos después de la carga de todos los beads, para ello
                // por lo tanto ...
                (_strand as EventDispatcher).addEventListener("beadsAdded", beadsAddedHandler);
            }
        }

        private function beadsAddedHandler(event:Event):void
        {
            (_strand as EventDispatcher).removeEventListener("beadsAdded", beadsAddedHandler);

            _model = _strand.getBeadByType(IImageModel) as IImageModel;
            if(_model)
                _model.addEventListener("urlChanged",srcChangedHandler);
            srcChangedHandler(null);
        }
		
        private function srcChangedHandler(event:Event):void
        {
            if(!_model)
            {
                _model = _strand.getBeadByType(IImageModel) as IImageModel;
                if(_model)
                    _model.addEventListener("urlChanged",srcChangedHandler);
            }
            /**
             * En este punto, podemos optar por modificar "de nuevo" el model.url
             * o asignarle directamente el source al elemento HTML... (Optamos por la 2a Op)
             */
            if(_model && !_model.url){         
                COMPILE::JS {
                    (hostElement as Object).src = src;                    
                }
            }
            
        }
    }
}
