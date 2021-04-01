package org.apache.royale.community.jewel.beads
{
	import org.apache.royale.core.IStrand;
	import org.apache.royale.core.StyledUIBase;
	import org.apache.royale.debugging.throwError;
	import org.apache.royale.jewel.Group;
	import org.apache.royale.utils.css.addDynamicSelector;
	import org.apache.royale.jewel.beads.controls.image.ClipImage;
	
	/**
	 *  The HorizontalListScroll bead is a specialty bead that can be used with
	 *  Jewel List control and gives horizontal scroll to the list

	 *  @langversion 3.0
	 *  @playerversion Flash 10.2
	 *  @playerversion AIR 2.6
	 *  @productversion Royale 0.10.0
	 */
	public class ClipImageJwExt extends org.apache.royale.jewel.beads.controls.image.ClipImage
	{
		public static const INSET_SHAPE:String = "inset";
		public static const CIRCLE_SHAPE:String = "circle";
		public static const ELLIPSE_SHAPE:String = "ellipse";
		public static const POLYGON_SHAPE:String = "polygon";
		/**
		 *  constructor.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.10.0
		 */
		public function ClipImageJwExt()
		{
		}

		private var _shape:String;
		/**
		 * the shape for the clip. values can be "inset", "circle", "ellipse", "polygon"
		 */
		override public function get shape():String
		{
			return _shape;
		}
		override public function set shape(value:String):void
		{
			_shape = value;
			createClipShape(ruleName);

            borderShape = new Group();
            borderShape.className = ruleName + ' ' + className;
            borderShape.width = host.width;
            borderShape.minWidth = host.width;
            borderShape.height = host.height;
            borderShape.minHeight = host.height;

            host.parent.addElementAt(borderShape, host.parent.getElementIndex(host), false);
            
            COMPILE::JS
            {
            if (borderColor) borderShape.element.style.backgroundColor = borderColor;
            host.width = host.width - border*2;
            host.element.style.position = "absolute";
            host.element.style.height="auto";//host.height = host.height - border*2;
            host.minWidth = borderShape.minWidth - border*2;
            host.minHeight = borderShape.minHeight - border*2;
            }
        
            borderShape.addElement(host);
            createClipShape(ruleName, true);
		}

        public var className:String="";

		private var points_str:String;
		private var _points:Array;
		/**
		 * Only for POLYGON shapes
		 * An Array of x and y points used in POLYGON shapes. Minimun 3 points
		 * If you want just 3 points add them in the following way: [x1, y1, x2, y2, x3, y3]
		 */

		private var host:StyledUIBase;
		/**
		 *  @copy org.apache.royale.core.IBead#strand
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.10.0
		 */
		override public function set strand(value:IStrand):void
		{
			host = value as StyledUIBase;

			ruleName = "clipPath-" + ((new Date()).getTime() + "-" + Math.floor(Math.random()*1000));
			ruleName2 = "clipPathFrame-" + ((new Date()).getTime() + "-" + Math.floor(Math.random()*1000));

			host.addClass(ruleName);
			host.addClass(ruleName2)
		}

		private var inset_str:String;
		private var _inset:Array;
		/**
		 * Only for INSET shapes
		 * An Array of 4 values used in INSET shapes to limit the inset shape
		 */
		override public function get inset():Array {
			return _inset;
		}
		override public function set inset(value:Array):void {
			inset_str = "";
			_inset = value;
			_inset.forEach(processInsetValues);
		}
		private function processInsetValues(element:*, index:Number, arr:Array):void {
			if(arr.length == 4)
				inset_str += element + units + " ";
			else
				throwError("ClipImageJwExt INSET values must have four.")
        }
		
		private var rounds_str:String;
		private var _rounds:Array;
		/**
		 * Only for INSET shapes
		 * An Array of 4 values used in INSET shapes to round the corners between inset values
		 */
		override public function get rounds():Array {
			return _rounds;
		}
		override public function set rounds(value:Array):void {
			rounds_str = "round ";
			_rounds = value;
			_rounds.forEach(processRoundsValues);
		}
		private function processRoundsValues(element:*, index:Number, arr:Array):void {
			rounds_str += element + units + " ";
        }

		
		private var _visible:Boolean = true;
		/**
		 * the border color
		 */
		public function get visible():Boolean {
			return _visible;
		}
		public function set visible(value:Boolean):void {
			_visible = value;
			borderShape.visible = value;
		}

		private var borderShape:Group;
		private var ruleName:String;
		private var ruleName2:String;
		private var selectors:String;

		override protected function createClipShape(ruleName:String, before:Boolean = false):void
		{
			selectors = "";

			if(shape == CIRCLE_SHAPE)
			{
				if(radius==-1){
					selectors += "clip-path: " + shape + "();"
					addDynamicSelector("." + ruleName2, "left: 50%; transform: translateX(-50%) translateY(-50%); top: 50%;");
				}else{
					selectors += "clip-path: " + shape + "(" + radius + units + " at " + x + units + " "+ y + units + ");";
				}
			}
			else if(shape == POLYGON_SHAPE)
			{
				selectors += "clip-path: " + shape + "(" + points_str +  ");";
			}
			else if(shape == ELLIPSE_SHAPE)
			{
				selectors += "clip-path: " + shape + "(" + radius + units + " " + bradius + units + " at " + x + units + " "+ y + units + ");";
			}
			else if(shape == INSET_SHAPE)
			{
				selectors += "clip-path: " + shape + "(" + inset_str + rounds_str + ");";
			}

			addDynamicSelector("." + ruleName, selectors);
		}
	}
}
