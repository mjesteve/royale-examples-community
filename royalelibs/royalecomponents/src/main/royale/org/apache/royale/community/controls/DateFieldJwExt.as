package org.apache.royale.community.controls
{
	import org.apache.royale.jewel.DateField
	import org.apache.royale.community.jewel.supportClasses.IStrandWithResetButton;

	public class DateFieldJwExt extends org.apache.royale.jewel.DateField implements IStrandWithResetButton
	{
		/**
		 *  constructor.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.4
		 */
		public function DateFieldJwExt()
		{
			super();
        }

		private var _withResetButton:Boolean = false;
		public function get withResetButton():Boolean { return _withResetButton; }
		public function set withResetButton(value:Boolean):void
		{ 
			_withResetButton = value; 
		}

	}
}
