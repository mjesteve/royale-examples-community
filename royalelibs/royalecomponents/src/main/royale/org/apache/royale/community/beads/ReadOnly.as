package org.apache.royale.community.beads
{
	COMPILE::JS
	{
	import org.apache.royale.core.HTMLElementWrapper;
	import org.apache.royale.core.IUIBase;
	}
	import org.apache.royale.core.DispatcherBead;
	import org.apache.royale.core.IStrand;
	import org.apache.royale.events.ValueEvent;
	import org.apache.royale.utils.sendStrandEvent;
	
	/**
	 *  The ReadOnly bead class is a specialty bead that can be used to read-only a Jewel control.
	 *  
	 *  @langversion 3.0
	 *  @playerversion Flash 10.2
	 *  @playerversion AIR 2.6
	 *  @productversion Royale 0.9.4
	 */
	public class ReadOnly extends DispatcherBead
	{
		/**
		 *  constructor.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.8
		 */
		public function ReadOnly()
		{
		}

		COMPILE::JS
		protected var lastElementTabVal:String = null;

		protected var initialized:Boolean = false;

		private var _readonly:Boolean = true;
        /**
		 *  A boolean flag to enable or disable the host control.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.4
		 */
		[Bindable]
        public function get readOnly():Boolean
        {
            return _readonly;
        }
        public function set readOnly(value:Boolean):void
        {
			if(value != _readonly)
			{
				_readonly = value;
				COMPILE::JS
				{
				if(_strand)
				{
					updateHost();
					sendStrandEvent(_strand, new ValueEvent("readonlyChange", readOnly));
				}
				}
			}
        }

		/**
		 *  @copy org.apache.royale.core.IBead#strand
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.4
		 *  @royaleignorecoercion HTMLInputElement
		 */
		override public function set strand(value:IStrand):void
		{
			super.strand = value;
			updateHost();
		}

		protected function updateHost():void
		{
			COMPILE::JS
			{
			var elem:HTMLElement = (_strand as HTMLElementWrapper).element;
			var pos:HTMLElement = (_strand as IUIBase).positioner;
			
			if(!initialized){
				initialized = true;
            	lastElementTabVal = elem.getAttribute("tabindex");
			}
			
			if(_readonly) {
				setDisableAndTabIndex(pos, true);
				setDisableAndTabIndex(elem);
			} else {
				removeDisableAndTabIndex(pos, true);
				removeDisableAndTabIndex(elem, false, lastElementTabVal);
			}
			}
		}

		COMPILE::JS
		protected function setDisableAndTabIndex(o:HTMLElement, positioner:Boolean = false):void
		{
			o.setAttribute("read-only", "");
			o.style.pointerEvents = 'none';
			//o.style.cursor = 'none';
			if(!positioner)
				o.tabIndex = -1;
		}

		COMPILE::JS
		protected function removeDisableAndTabIndex(o:*, positioner:Boolean = false, lastTabVal:String = null):void
		{
			o.removeAttribute("read-only");
			o.style.pointerEvents = '';
			o.style.cursor = 'auto';
			if(!positioner)
				o.tabIndex = (lastTabVal == null) ? null : lastTabVal;
		}
	}
}
