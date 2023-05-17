package org.apache.royale.community.jewel.beads.controls
{
	import org.apache.royale.core.DispatcherBead;
	import org.apache.royale.core.IBead;
	import org.apache.royale.core.IParentIUIBase;
	import org.apache.royale.core.IPopUpHost;
	import org.apache.royale.core.IStrand;
	import org.apache.royale.core.IToolTipBead;
	import org.apache.royale.core.IUIBase;
	import org.apache.royale.events.Event;
	import org.apache.royale.events.IEventDispatcher;
	import org.apache.royale.events.MouseEvent;
	import org.apache.royale.geom.Point;
	import org.apache.royale.utils.OSUtils;
	import org.apache.royale.utils.PointUtils;
	import org.apache.royale.utils.UIUtils;
	import org.apache.royale.jewel.Image;
	import org.apache.royale.html.beads.ErrorImage;

	/**
	 *  The ImageToolTip class is a specialty bead that can be used with
	 *  any control. The bead floats a image over a control if
     *  the user hovers over the control with a mouse.
	 *
	 *  @langversion 3.0
	 *  @playerversion Flash 10.2
	 *  @playerversion AIR 2.6
	 *  @productversion Royale 0.9.4
	 */
	public class ImageToolTip extends DispatcherBead implements IBead, IToolTipBead
	{
		/**
		 *  constructor.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.4
		 */
		public function ImageToolTip()
		{
		}

		public static const TOP:int = 10000;
		public static const BOTTOM:int = 10001;
		public static const LEFT:int = 10002;
		public static const RIGHT:int = 10003;
		public static const MIDDLE:int = 10004;

		private var _toolTip:String;
		private var tt:Image;
		private var host:IPopUpHost;
		private var _xPos:int = RIGHT;
		private var _yPos:int = BOTTOM;

		/**
		 *  The string to use as the toolTip.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.4
		 */
        [Bindable("toolTipChanged")]
		public function get toolTip():String
		{
			return _toolTip;
		}
		public function set toolTip(value:String):void
		{
            _toolTip = value;
		}

		private var _className:String;
		/**
		 *  An optional css class to add to specific tooltips for additional
		 *  styling via css.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.4
		 */
		public function get className():String
		{
			return _className;
		}
		public function set className(value:String):void
		{
			_className = value;
			if (tt) tt.className = value;
		}

		/**
		 *  Sets the tooltip y relative position to one of
		 *  LEFT, MIDDLE or RIGHT.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.4
		 */
		public function set xPos(pos:int):void
		{
			_xPos = pos;
		}

		/**
		 *  Sets the tooltip y relative position to one of
		 *  TOP, MIDDLE or BOTTOM.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.4
		 */
		public function set yPos(pos:int):void
		{
			_yPos = pos;
		}

		/**                         	
		 *  @copy org.apache.royale.core.IBead#strand
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.4
		 *  @royaleignorecoercion org.apache.royale.events.IEventDispatcher
		 */
		override public function set strand(value:IStrand):void
		{
			super.strand = value;

			//ToolTip in iOS produces a bad behaviour, used in a button and user has to do a second touch to trigger click event
			if(OSUtils.getOS() != OSUtils.IOS_OS)
			{
            	IEventDispatcher(_strand).addEventListener(MouseEvent.ROLL_OVER, rollOverHandler, false);
			}
		}

		protected function changeHandler(event:Event):void
		{
			tt.src = toolTip;
		}

		/**
		 * @private
		 * @royaleignorecoercion org.apache.royale.core.IUIBase
		 * @royaleignorecoercion org.apache.royale.events.IEventDispatcher
		 */
		protected function rollOverHandler(event:MouseEvent):void
		{
			if (!toolTip || tt)
				return;

			IEventDispatcher(_strand).addEventListener("change", changeHandler, false);
            IEventDispatcher(_strand).addEventListener(MouseEvent.ROLL_OUT, rollOutHandler, false);

            var comp:IUIBase = _strand as IUIBase;
            host = UIUtils.findPopUpHost(comp);
			if (tt) host.popUpParent.removeElement(tt);

            tt = new Image();
			tt.typeNames = "jewel tooltip";
			if (_className) tt.className = _className;
            tt.src = toolTip;
			var errBead:ErrorImage = new ErrorImage();
			tt.addBead(errBead);

			// add this before measuring or measurement is not accurate.
            host.popUpParent.addElement(tt, false); // don't trigger a layout
            var pt:Point = determinePosition();
            tt.x = pt.x;
            tt.y = pt.y;
		}

		/**
		 * @private
		 * Determines the position of the toolTip.
		 * @royaleignorecoercion org.apache.royale.core.IUIBase
		 */
		protected function determinePosition():Point
		{
			var ttWidth:Number = tt.width;
			var ttHeight:Number = tt.height;
			var comp:IUIBase = _strand as IUIBase;
			var x:Number;
			var y:Number;
			switch(_xPos){
				case LEFT:
					x = -ttWidth;
					break;
				case MIDDLE:
					x = (comp.width - ttWidth) / 2;
					break;
				case RIGHT:
					x = comp.width;
					break;
			}
			switch(_yPos){
				case TOP:
					y = -ttHeight;
					break;
				case MIDDLE:
					y = (comp.height - ttHeight) / 2;
					break;
				case BOTTOM:
					y = comp.height;
					break;
			}

			var pt:Point = new Point(x,y);
			pt = PointUtils.localToGlobal(pt, comp);

			//make sure it's not too high or to the left.
			pt.x = Math.max(pt.x,0);
			pt.y = Math.max(pt.y,0);

			var screenHeight:Number = (host.popUpParent as IParentIUIBase).height;
			// add an extra pixel for rounding errors
			var extraHeight:Number = 1 + pt.y + ttHeight - screenHeight;
			if(extraHeight > 0){
				pt.y -= extraHeight;
			}
			var screenWidth:Number = (host.popUpParent as IParentIUIBase).width;
			var extraWidth:Number = 1 + pt.x + ttWidth - screenWidth;
			if(extraWidth > 0){
				pt.x -= extraWidth;
			}
			return pt;
		}

        /**
		 * rollOutHandler
		 * @private
         */
        protected function rollOutHandler(event:MouseEvent = null):void
        {
			removeTip();
		}

		/**                         	
		 *  @copy org.apache.royale.core.IToolTipBead#removeTip()
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.7
		 *  @royaleignorecoercion org.apache.royale.events.IEventDispatcher
		 */
		public function removeTip():void {
			IEventDispatcher(_strand).removeEventListener("change", changeHandler, false);
			IEventDispatcher(_strand).removeEventListener(MouseEvent.MOUSE_OUT, rollOutHandler, false);

			if (tt) {
                host.popUpParent.removeElement(tt);
				tt = null;
			}
        }
	}
}
