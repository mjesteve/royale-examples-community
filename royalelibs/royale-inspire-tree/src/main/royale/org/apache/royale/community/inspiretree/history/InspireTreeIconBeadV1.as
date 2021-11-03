package org.apache.royale.community.inspiretree.history
{

	/**
	 *  @langversion 3.0
	 *  @playerversion Flash 10.2
	 *  @playerversion AIR 2.6
	 *  @productversion Royale 0.9.8
	 */
	import org.apache.royale.core.IBead;
    import org.apache.royale.core.IBeadModel;
	import org.apache.royale.core.IStrand;
	import org.apache.royale.core.Strand;
    import org.apache.royale.events.Event;
    import org.apache.royale.events.IEventDispatcher;
    import org.apache.royale.community.inspiretree.beads.models.InspireTreeModel;
    import org.apache.royale.community.inspiretree.IInspireTree;
    import org.apache.royale.core.StyledUIBase;
    import org.apache.royale.community.inspiretree.vos.ItemTreeNode;
    import org.apache.royale.utils.Timer;

    COMPILE::JS
	public class InspireTreeIconBeadV1  extends Strand implements IBead
	{
		/**
		 *  constructor
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.7
		 */

		public function InspireTreeIconBeadV1()
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
			(_strand as IEventDispatcher).addEventListener("onCreationComplete", init);
		}

		private var _icon:String = "default";
		public function get icon():String
		{
			return _icon;
		}
        [Inspectable(category="General", enumeration="default,custom,customClasses,none")]
		/**
		 * icon property: tree should have parent and child icons or not
		 * default,custom,customClasses,none
		 */
		public function set icon(value:String):void
		{
			_icon = value;
		}

		/**
		 * Control Tree
		 */


		private var _parentIcon:String = "";
		public function get parentIcon():String{ return _parentIcon; }
		public function set parentIcon(value:String):void{
			_parentIcon = value;

		}
		private var _parentOpenIcon:String = "";
		public function get parentOpenIcon():String{ return _parentOpenIcon; }
		public function set parentOpenIcon(value:String):void{
			_parentOpenIcon = value;

		}

		private var _childIcon:String = "";
		public function get childIcon():String{ return _childIcon; }
		public function set childIcon(value:String):void{
			_childIcon = value;
		}

		private function init(event:Event):void
		{
			if(_icon=="default")
			{

			}
			else if(_icon=="none")
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

			else if(_icon=="customClasses")
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
			else if(_icon=="custom")
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

					/* //way 1 to modify  previous approach //overlaping the current images
 					var arrCssElem3:NodeList = document.querySelectorAll('.icon-file-empty');
					for each(var cssElem3:Element in arrCssElem3)
					{
						if(cssElem3.style != null)
						{
							cssElem3.style.backgroundImage = "url('assets/inspiretree/"+childIcon+"')"; //paper.png
							cssElem3.style.backgroundRepeat = "no-repeat";
							cssElem3.style.backgroundSize= "20px 20px";
							cssElem3.style.backgroundPosition= "30px 10px";
						}
					}*/
				}

			}



		}




	}

    COMPILE::SWF
	public class InspireTreeIconBead
	{
    }
}
