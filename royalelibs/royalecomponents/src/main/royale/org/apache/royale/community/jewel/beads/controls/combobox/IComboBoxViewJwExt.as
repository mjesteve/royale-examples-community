package org.apache.royale.community.jewel.beads.controls.combobox
{
    import org.apache.royale.jewel.beads.controls.combobox.IComboBoxView;
    import org.apache.royale.community.jewel.IconReset;
    
	/**
	 *  The IComboBoxView interface provides the protocol for any bead that
	 *  creates the visual parts for a org.apache.royale.jewel.ComboBox control.
	 *  
	 *  @langversion 3.0
	 *  @playerversion Flash 10.2
	 *  @playerversion AIR 2.6
	 *  @productversion Royale 0.9.4
	 */
	public interface IComboBoxViewJwExt extends IComboBoxView
	{
		/**
		 *  The sub-component used for the button to reset combobox.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.4
		 */
		function get resetButton():IconReset;
	}
}
