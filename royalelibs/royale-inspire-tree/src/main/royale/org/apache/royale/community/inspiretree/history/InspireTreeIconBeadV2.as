package org.apache.royale.community.inspiretree.history
{

	/**
	 *  @langversion 3.0
	 *  @playerversion Flash 10.2
	 *  @playerversion AIR 2.6
	 *  @productversion Royale 0.9.8
	 */
	import org.apache.royale.core.IBead;
	import org.apache.royale.core.IStrand;
	import org.apache.royale.core.Strand;
    import org.apache.royale.core.StyledUIBase;

    COMPILE::JS
	public class InspireTreeIconBeadV2  extends Strand implements IBead
	{
		/**
		 *  constructor
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.7
		 */

		public function InspireTreeIconBeadV2()
		{
			super();
		}
        private var _strand:IStrand;

		/**
		 *  @copy org.apache.royale.core.IBead#strand
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.4
		 */
        public function get strand():IStrand
        {
            return _strand;
        }
		/**
		 *  @copy org.apache.royale.core.IBead#strand
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.4
		 */
		public function set strand(value:IStrand):void
		{
            _strand = value;
			updateHost( true );
		}

		private var _typeIconsSet:String = "default";
		public function get typeIconsSet():String
		{
			return _typeIconsSet;
		}
        [Inspectable(category="General", enumeration="default,custom,customClasses,none")]
		/**
		 * typeIconsSet property: tree should have parent and child icons or not
		 * default,custom,customClasses,none
		 */
		public function set typeIconsSet(value:String):void
		{
			_typeIconsSet = value;
		}

		private var _parentIcon:String = "";
		public function get parentIcon():String{ return _parentIcon; }
		public function set parentIcon(value:String):void
		{
			if(_parentIcon != value)
			{
				_parentIcon = value;
				updateHost();
			}

		}
		private var _parentOpenIcon:String = "";
		public function get parentOpenIcon():String{ return _parentOpenIcon; }
		public function set parentOpenIcon(value:String):void
		{
			if(_parentOpenIcon != value)
			{
				_parentOpenIcon = value;
				updateHost();
			}

		}

		private var _parentSelectedIcon:String = "";
		public function get parentSelectedIcon():String{ return _parentSelectedIcon; }
		public function set parentSelectedIcon(value:String):void
		{
			if(_parentSelectedIcon != value)
			{
				_parentSelectedIcon = value;
				updateHost();
			}

		}
		private var _parentOpenSelectedIcon:String = "";
		public function get parentOpenSelectedIcon():String{ return _parentOpenSelectedIcon; }
		public function set parentOpenSelectedIcon(value:String):void
		{
			if(_parentOpenSelectedIcon != value)
			{
				_parentOpenSelectedIcon = value;
				updateHost();
			}

		}

		private var _childIcon:String = "";
		public function get childIcon():String{ return _childIcon; }
		public function set childIcon(value:String):void
		{
			if(_childIcon != value)
			{
				_childIcon = value;
				updateHost();
			}
		}
		private var _childSelectedIcon:String = "";
		public function get childSelectedIcon():String{ return _childSelectedIcon; }
		public function set childSelectedIcon(value:String):void
		{
			if(_childSelectedIcon != value)
			{
				_childSelectedIcon = value;
				updateHost();
			}
		}

		private var _minusIcon:String = "";
		public function get minusIcon():String{ return _minusIcon; }
		public function set minusIcon(value:String):void
		{
			if(_minusIcon != value)
			{
				_minusIcon = value;
				updateHost();
			}

		}

		private var _plusIcon:String = "";
		public function get plusIcon():String{ return _plusIcon; }
		public function set plusIcon(value:String):void
		{
			if(_plusIcon != value)
			{
				_plusIcon = value;
				updateHost();
			}

		}

		private function updateHost( init:Boolean = false):void
		{
			if(!strand)
				return;

			var hostelement:Element = (_strand as StyledUIBase).element;
			var noneCSS:String;
			var editCSS:Element;

			if(_typeIconsSet == "none")
			{
				noneCSS = ".inspire-tree.InspireTreeNoneClass .icon-folder::before {background-image: url();}";
				noneCSS+= ".inspire-tree.InspireTreeNoneClass .icon-folder-open::before {background-image: url();} ";
				noneCSS+= ".inspire-tree.InspireTreeNoneClass .icon-file-empty::before {background-image: url();}  ";
				noneCSS+= ".inspire-tree.InspireTreeNoneClass .selected > .title-wrap .icon-folder::before {background-image: url();} ";
				noneCSS+= ".inspire-tree.InspireTreeNoneClass .selected > .title-wrap .icon-folder-open::before { background-image: url();} ";
				noneCSS+= ".inspire-tree.InspireTreeNoneClass .selected > .title-wrap .icon-file-empty::before {background-image: url();} ";

				editCSS = document.createElement('style')
				editCSS.innerHTML = noneCSS;
				document.body.appendChild(editCSS);

				hostelement.classList.add("InspireTreeNoneClass");
				return;
			}
			else if(_typeIconsSet == "custom")
			{
				noneCSS = ".inspire-tree.InspireTreeMycustomClasses .selected > .title-wrap .icon-file-empty::before {background-image: url('"+_childSelectedIcon+"');} ";

				if(_parentIcon){
					noneCSS+= ".inspire-tree.InspireTreeMycustomClasses .icon-folder::before {background-image: url('"+_parentIcon+"');} ";
				}

				if(_parentOpenIcon){
					noneCSS+= ".inspire-tree.InspireTreeMycustomClasses .icon-folder-open::before {background-image: url('"+_parentOpenIcon+"');} ";
				}

				if(_parentSelectedIcon){
					noneCSS+= ".inspire-tree.InspireTreeMycustomClasses .selected > .title-wrap .icon-folder::before {background-image: url('"+_parentSelectedIcon+"');} ";
				}

				if(_parentOpenSelectedIcon){
					noneCSS+= ".inspire-tree.InspireTreeMycustomClasses .selected > .title-wrap .icon-folder-open::before { background-image: url('"+_parentOpenSelectedIcon+"');} ";
				}

				if(_childIcon){
					noneCSS+= ".inspire-tree.InspireTreeMycustomClasses .icon-file-empty::before {background-image: url('"+_childIcon+"');}  ";
				}

				if(_childSelectedIcon){
					noneCSS+= ".inspire-tree.InspireTreeMycustomClasses .selected > .title-wrap .icon-folder-open::before { background-image: url('"+_childSelectedIcon+"');} ";
				}

				if(_minusIcon){
					noneCSS+= ".inspire-tree.InspireTreeMycustomClasses  .icon-collapse::before{ background-image: url('"+_minusIcon+"');} ";
				}

				if(_plusIcon){
					noneCSS+= ".inspire-tree.InspireTreeMycustomClasses .icon-expand::before{ background-image: url('"+_plusIcon+"');} ";
				}
				editCSS = document.createElement('style')
				editCSS.innerHTML = noneCSS;
				document.body.appendChild(editCSS);

				hostelement.classList.add("InspireTreeMycustomClasses");
				return;
			}

			var existClass:Boolean;

			existClass = hostelement.classList.hasOwnProperty(_parentIcon) ? true : false;
			if(_parentIcon){
				if(!existClass)
					hostelement.classList.add(_parentIcon);
			}
			else if(existClass){
				hostelement.classList.remove(_parentIcon);
			}

			existClass = hostelement.classList.hasOwnProperty(_parentOpenIcon) ? true : false;
			if(_parentOpenIcon){
				if(!existClass)
					hostelement.classList.add(_parentOpenIcon);
			}else if(existClass){
				hostelement.classList.remove(_parentOpenIcon);
			}

			existClass = hostelement.classList.hasOwnProperty(_parentSelectedIcon) ? true : false;
			if(_parentSelectedIcon){
				if(!existClass)
					hostelement.classList.add(_parentSelectedIcon);
			}else if(existClass){
				hostelement.classList.remove(_parentSelectedIcon);
			}

			existClass = hostelement.classList.hasOwnProperty(_parentOpenSelectedIcon) ? true : false;
			if(_parentOpenSelectedIcon){
				if(!existClass)
					hostelement.classList.add(_parentOpenSelectedIcon);
			}else if(existClass){
				hostelement.classList.remove(_parentOpenSelectedIcon);
			}

			existClass = hostelement.classList.hasOwnProperty(_childIcon) ? true : false;
			if(_childIcon){
				if(!existClass)
					hostelement.classList.add(_childIcon);
			}else if(existClass){
				hostelement.classList.remove(_childIcon);
			}

			existClass = hostelement.classList.hasOwnProperty(_childSelectedIcon) ? true : false;
			if(_childSelectedIcon){
				if(!hostelement.classList.hasOwnProperty(_childSelectedIcon))
					hostelement.classList.add(_childSelectedIcon);
			}else if(hostelement.classList.hasOwnProperty(_childSelectedIcon)){
				hostelement.classList.remove(_childSelectedIcon);
			}

			existClass = hostelement.classList.hasOwnProperty(_minusIcon) ? true : false;
			if(_minusIcon){
				if(!existClass)
					hostelement.classList.add(_minusIcon);
			}else if(existClass){
				hostelement.classList.remove(_minusIcon);
			}

			existClass = hostelement.classList.hasOwnProperty(_plusIcon) ? true : false;
			if(_plusIcon){
				if(!existClass)
					hostelement.classList.add(_plusIcon);
			}else if(existClass){
				hostelement.classList.remove(_plusIcon);
			}

		}
/*
		private function init2(event:Event):void
		{
			if(_typeIconsSet=="default")
			{

			}
			else if(_typeIconsSet=="none")
			{
				var editCSS = document.createElement('style')
				editCSS.innerHTML = ".inspire-tree .icon-folder::before { background-image: url(); }";
				document.body.appendChild(editCSS);

				var editCSS2 = document.createElement('style')
				editCSS2.innerHTML = ".inspire-tree .icon-folder-open::before { background-image: url(); }";
				document.body.appendChild(editCSS2);

				var editCSS3 = document.createElement('style')
				editCSS3.innerHTML = ".inspire-tree .icon-file-empty::before { background-image: url(); }";
				document.body.appendChild(editCSS3);

			}

			else if(_typeIconsSet=="customClasses")
			{
				if(parentIcon!="")
				{

					var arrCssElem3:NodeList = document.querySelectorAll('.icon-folder');
					for each(var cssElem3:Element in arrCssElem3)
					{
						if(cssElem3.style != null)
						{
							var st:String = "title icon "+parentIcon;
							cssElem3.className = st;

						}
					}
				}
				if(parentOpenIcon!="")
				{
					var arrCssElem3:NodeList = document.querySelectorAll('.icon-folder-open');
					for each(var cssElem3:Element in arrCssElem3)
					{
						if(cssElem3.style != null)
						{
							var st:String = "title icon "+parentOpenIcon;
							cssElem3.className = st;

						}
					}
				}

				if(childIcon!="")
				{

					var arrCssElem3:NodeList = document.querySelectorAll('.icon-file-empty');
					for each(var cssElem3:Element in arrCssElem3)
					{
						if(cssElem3.style != null)
						{

							var st:String = "title icon "+childIcon;
							cssElem3.className = st;

						}
					}

				}
			}
			else if(_typeIconsSet=="custom")
			{
				if(parentIcon!="")
				{
					var editCSS = document.createElement('style')
					editCSS.innerHTML = ".inspire-tree .icon-folder::before { background-image: url('assets/inspiretree/"+parentIcon+"'); background-repeat:no-repeat; background-size:15px 15px;  }";
					document.body.appendChild(editCSS);

				}
				if(parentOpenIcon!="")
				{
					var editCSS = document.createElement('style')
					editCSS.innerHTML = ".inspire-tree .icon-folder-open::before { background-image: url('assets/inspiretree/"+parentOpenIcon+"'); background-repeat:no-repeat; background-size:15px 15px; }";
					document.body.appendChild(editCSS);

				}
				if(childIcon!="")
				{
					//way 2 to modify styles //overriding the current images
					var editCSS = document.createElement('style')
					editCSS.innerHTML = ".inspire-tree .icon-file-empty::before { background-image: url('assets/inspiretree/"+childIcon+"'); background-repeat:no-repeat; background-size:15px 15px; }";
					document.body.appendChild(editCSS);

					//way 1 to modify  previous approach //overlaping the current images
 					//var arrCssElem3:NodeList = document.querySelectorAll('.icon-file-empty');
					//for each(var cssElem3:Element in arrCssElem3)
					//{
					//	if(cssElem3.style != null)
					//	{
					//		cssElem3.style.backgroundImage = "url('assets/inspiretree/"+childIcon+"')"; //paper.png
					//		cssElem3.style.backgroundRepeat = "no-repeat";
					//		cssElem3.style.backgroundSize= "20px 20px";
					//		cssElem3.style.backgroundPosition= "30px 10px";
					//	}
					//}
				}

			}

		}
*/

	}

    COMPILE::SWF
	public class InspireTreeIconBead
	{
    }
}
