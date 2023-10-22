package org.apache.royale.community.views.draganddrop.supportClasses
{
	import org.apache.royale.collections.Sort;
	import org.apache.royale.collections.ArrayListView;
	import org.apache.royale.collections.ArrayList;
	import mx.utils.ObjectUtil;

	public class ArrayUtilExt
	{
        
        public static function mergeArrays(...arrays):Array {
            var result:Array = [];
            for(var i:int=0;i<arrays.length;i++){
                result = result.concat(arrays[i]);
            }
            return result;
        }

        public static function clone(source:Array):Array
        {
            if(!source)
                return null;
            else
                return cloneObject(source) as Array;
        }

		public static function cloneObject(source:Object):*{
			/*With mx.utils.ByteArray:
			var myBA:ByteArray = new ByteArray();
			myBA.writeObject(source);
			myBA.position = 0;
			return(myBA.readObject());*/
			
			return ObjectUtil.clone(source);
		}

		public static function inArray( needle:*, haystack:Array ):Boolean{
			var itemIndex:int = haystack.indexOf( needle );
			return ( itemIndex < 0 ) ? false : true;
		}
	}
}

