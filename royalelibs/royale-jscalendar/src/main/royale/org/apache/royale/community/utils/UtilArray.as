package org.apache.royale.community.utils
{

	public class UtilArray {
/*
		public static function GetItemIndexPlusNew(A:Object,campos:Array,valores:Array,tipos:Array=null,
												   conSegundo:Boolean=false,returnIndex:Boolean=true,comparaciones:Array=null):Object{

			var res:Object=null;
			if(returnIndex){
				res = new Object
				res.item = null
				res.index = -1
			}
			var esvalornulo:Boolean;
			var det:uint=0;

			if(!A)return res;

			var lenarray:int=A.length-1;
			var i:int;
			var lencampos:int = campos.length;
			var x:int;

			if(comparaciones==null)
				comparaciones = new Array;
			if(tipos==null)
				tipos = new Array;

			var lencomp:int = comparaciones.length;
			var lentipos:int = tipos.length;

			if(lencampos!=lencomp){
				for(i=0;i<=lencampos;i++){
					if(lencomp==0){
						comparaciones.push("==")
					}else{
						if(i>=lencampos){
							comparaciones.push("==")
						}
					}
				}
			}
			if(lencampos!=lentipos){
				for(i=0;i<lencampos;i++){
					if(lentipos==0){
						tipos.push("STRING")
					}else{
						if(i>=lentipos){
							tipos.push("STRING")
						}
					}
				}
			}

			var itemIsObject:Boolean = (lencampos == 1 && ( campos[0] == null || campos[0] == '') )?false:true;

			for (i=0; i<=lenarray;i++)
			{
				det = 0
				for(x=0; x<lencampos;x++)
				{
					var valueAField:Object = null;
					if(itemIsObject)
					{
						valueAField = A[i][campos[x]];
					}else{
						valueAField = A[i];
					}
					esvalornulo = (Nz(valores[x],"*").toString()=="*");

					if(esvalornulo){							
						if(MontaComparacion(Nz(valueAField,"*").toString(),"*",comparaciones[x],tipos[x],conSegundo))
							det +=1;
					}else{
						if (Nz(valueAField,"*").toString()!="*"){
							if(MontaComparacion(valores[x],valueAField,comparaciones[x],tipos[x],conSegundo))
								det+=1;
						}
					}
				}
				if(det==lencampos){
					if(returnIndex){
						res = new Object
						res.item = A[i];
						res.index = i;
						return res;
					}else{
						return A[i];
					}
				}
			}

			return res;
		}
*/
	}
}
