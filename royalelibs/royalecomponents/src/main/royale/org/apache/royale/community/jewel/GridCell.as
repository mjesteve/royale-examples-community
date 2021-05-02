package org.apache.royale.community.jewel
{
	import org.apache.royale.jewel.GridCell;

	/**
	 *  The GridCell class is the inmediate container in a Grid Layout
	 *  to host grid cell content.
	 *  
	 *  @langversion 3.0
	 *  @playerversion Flash 10.2
	 *  @playerversion AIR 2.6
	 *  @productversion Royale 0.9.4
	 */
	public class GridCell extends org.apache.royale.jewel.GridCell
	{
		/**
		 *  constructor.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.4
		 */
		public function GridCell()
		{
			super();
		}

		public function setProperties(vis:Boolean = false, dN:Number=1, dD:Number=1, tN:Number=1, tD:Number=1, pN:Number=1, pD:Number=1):void
		{
			if(!vis){
				dD = tD = pD = 1;
				dN = tN = pN = 1;
			}
			wideScreenDenominator = dD;
			wideScreenNumerator = dN;
			desktopDenominator = dD;
			desktopNumerator = dN;
			tabletDenominator = tD;
			tabletNumerator = tN;
			phoneDenominator = pD;
			phoneNumerator = pN;
			visible = vis;
		}

	}
}