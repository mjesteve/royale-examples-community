package org.apache.royale.community.jewel.beads.controls.tristatecheckbox
{
	COMPILE::JS
	{
	import org.apache.royale.community.jewel.TriStateCheckBox;
	import org.apache.royale.core.IBead;
	import org.apache.royale.core.IStrand;
	}

	/**
	 * The TriStateCheckBoxState bead allows to set a custom value for each state.
	 */
    COMPILE::JS
	public class TriStateCheckBoxState implements IBead
	{

		public function TriStateCheckBoxState()
		{
		}

		/**
		 *  @copy org.apache.royale.core.IBead#strand
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.6
		 *  @royaleignorecoercion HTMLInputElement
		 *  @royaleignorecoercion org.apache.royale.core.UIBase;
		 */
		public function set strand(value:IStrand):void
		{
			var hostBase:TriStateCheckBox = value as TriStateCheckBox;

			var oldstateval:String = hostBase.state;
			var newstateval:String = hostBase.state;

			if( indeterminateValue != "" && hostBase.STATE_INDETERMINATE != indeterminateValue ){
				if(oldstateval == hostBase.STATE_INDETERMINATE)
					newstateval = indeterminateValue;
				hostBase.STATE_INDETERMINATE = indeterminateValue;
			}

			if( uncheckedValue != "" && hostBase.STATE_UNCHECKED != uncheckedValue ){
				if(oldstateval == hostBase.STATE_UNCHECKED)
					newstateval = uncheckedValue;
				hostBase.STATE_UNCHECKED = uncheckedValue;
			}

			if( checkedValue != "" && hostBase.STATE_CHECKED != checkedValue ){
				if(oldstateval == hostBase.STATE_CHECKED)
					newstateval = checkedValue;
				hostBase.STATE_CHECKED = checkedValue;
			}

			if(oldstateval != newstateval)
				hostBase.state = newstateval;
		}

		public var indeterminateValue:String= "";
		public var uncheckedValue:String= "";
		public var checkedValue:String= "";

	}

    COMPILE::SWF
	public class TriStateCheckBoxState
	{

		public function TriStateCheckBoxState()
		{
		}
	}
}
