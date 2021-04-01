package org.apache.royale.community.jewel.beads.controls
{
	import org.apache.royale.jewel.Label;
	import org.apache.royale.events.MouseEvent;
	import org.apache.royale.jewel.beads.controls.Badge;

	[Event(name="click", type="org.apache.royale.events.MouseEvent")]

	/**
	 *  The Badge class provides a small status descriptors for UI elements.
	 *
	 *  A Badge is an onscreen notification element consists of a small circle,
     *  typically containing a number or other characters, that appears in
     *  proximity to another object
	 *
	 *  The BadgeOnClick class is a Badge extension that dispatches the MouseClick Event.
	 *
	 *  @langversion 3.0
	 *  @playerversion Flash 10.2
	 *  @playerversion AIR 2.6
	 *  @productversion Royale 0.9.6
	 */
	public class BadgeOnClick extends org.apache.royale.jewel.beads.controls.Badge
	{
		/**
		 *  constructor.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.6
		 */
		public function BadgeOnClick()
		{
			super();
		}
		/**
		 * used to create the badge ui element
		 * that will be a Label
		 */
		override protected function createBadge():Label
		{
			var tmpbadge:Label = super.createBadge();

			tmpbadge.addEventListener("click", function():void{
				dispatchEvent(new MouseEvent("click"));
			});
			return tmpbadge;
		}

	}

}
