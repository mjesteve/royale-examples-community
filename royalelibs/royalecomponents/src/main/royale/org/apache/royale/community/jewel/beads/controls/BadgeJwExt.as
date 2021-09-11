package org.apache.royale.community.jewel.beads.controls
{
	import org.apache.royale.jewel.beads.controls.Badge;
	
	/**
	 *  The Badge class provides a small status descriptors for UI elements.
	 *
	 *  A Badge is an onscreen notification element consists of a small circle, 
     *  typically containing a number or other characters, that appears in 
     *  proximity to another object
	 *  
	 * 	In this extension the 'html' property has been added
	 * 
	 *  @langversion 3.0
	 *  @playerversion Flash 10.2
	 *  @playerversion AIR 2.6
	 *  @productversion Royale 0.9.6
	 */
	public class BadgeJwExt extends Badge
	{
		/**
		 *  constructor.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.6
		 */
		public function BadgeJwExt()
		{
			super();
		}

		private var _html:String = '';
		/**
		 *  The current value of the Badge that appers inside the circle.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.6
		 */
		[Bindable]
		public function get html():String
		{
			return _html;
		}
		public function set html(value:String):void
		{
			_html = value;
			badge.html = _html;
			badge.visible = html == '' ? false : true;
		}

	}
}
