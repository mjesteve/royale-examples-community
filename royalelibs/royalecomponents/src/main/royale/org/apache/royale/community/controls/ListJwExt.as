package org.apache.royale.community.controls
{
	import org.apache.royale.jewel.supportClasses.scrollbar.ScrollingViewport;
	import org.apache.royale.jewel.List
	import org.apache.royale.community.jewel.beads.views.ListViewJwExt;

	public class ListJwExt extends org.apache.royale.jewel.List
	{
		/**
		 *  constructor.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.4
		 */
		public function ListJwExt()
		{
			super();
        }

		public function get scrollViewport():ScrollingViewport
		{
			return (view as ListViewJwExt).scrollViewport;
		}

	}
}
