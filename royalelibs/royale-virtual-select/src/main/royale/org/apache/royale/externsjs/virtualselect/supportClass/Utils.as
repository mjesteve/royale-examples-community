package org.apache.royale.externsjs.virtualselect.supportClass
{
    import org.apache.royale.reflection.registerClassAlias;
    import mx.utils.ObjectUtil;

    public class Utils
    {
		public static function getNumCharacters( content:String ):String{
			var patron:RegExp = /\d+/g;
			var resultado:String = content.match(patron).toString();
			resultado = changeCharacter(",","",resultado)
			return resultado;
		}

		public static function changeCharacter(carorigen:String,cardestino:String,str:String):String
		{
			var i:int;
			var c:String;
			var f:String="";

			for (i=0; i<=str.length-1;i++){
				c=str.substr(i,1);
				if (c==carorigen){
					if (cardestino.length>0){f=f+cardestino;}
				}else{
					f=f+c;
				}
			}
			return(f);
		}

		public static function getSimpleArrayFromField(A:Array, fields:Object, dataType:Object = null):Array
		{            
			var arRes:Array = new Array();            

			if(A == null || A.length == 0)
				return arRes;

			var lenarray:int = A.length;			
			for( var f:int = 0; f < lenarray; f++)
			{
                if(fields is Array)
                {
                    var item:Object = new Object();
                    var len:int = (fields as Array).length;
                    for(var index:int = 0; index < len; index++)
                    {
                        item[(fields as Array)[index]] = A[f][(fields as Array)[index]];
                    }
				    arRes.push(item);

                }else if (fields is String)
				    arRes.push(A[f][fields]);
			}
			return arRes;
		}
        
        /**
         * Copy an object
         * @param obj Object to copy
         * @param into (optional) Object to copy into. If null, a new object is created.
         * @return A one-level deep copy of the object or null if the argument is null
         */
        public static function shallowCopy( obj:Object, into:Object=null ):Object
        {
            if ( into == null )
            {
                into = {};
            }
            if ( obj != null )
            {
                for ( var o:* in obj )
                {
                    into[o] = obj[o];
                }
            }
            return into;
        }
        
        public static function cloneObject(source:Object):Object {
            var copy:Object = new Object();
            
            for (var prop:String in source) {
                copy[prop] = source[prop];
            }
            
            return copy;
        }
        
        public static function cloneArrayClass(objectClassName:String, objectClass:Class, source:Array):Array{
            var index:int = 0;
            var length:int = source.length;
            var copy:Array = new Array();

            for(index; index < length; index++){
                registerClassAlias(objectClassName,objectClass);
                copy.insertAt(index,ObjectUtil.copy(source[index]) as objectClass);
            }
            return copy;
        }
        
        public static function cloneArray(source:Array):Array
        {
            var index:int = 0;
            var length:int = source.length;
            var copy:Array = new Array();

            for(index; index < length; index++){
                copy.insertAt(index,ObjectUtil.copy(source[index]));
            }
            return copy;
        }

        public static function isComplexType(value:*):Boolean {
            var res:Boolean = value is Object && !(value is String) && !(value is Number) && !(value is Boolean);
            if( res && value is Date)
                res=false;
            return res;
        }

    }
}