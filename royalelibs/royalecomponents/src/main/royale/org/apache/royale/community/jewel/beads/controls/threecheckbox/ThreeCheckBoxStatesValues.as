package org.apache.royale.community.jewel.beads.controls.threecheckbox
{
	import org.apache.royale.core.IBead;
	import org.apache.royale.core.IStrand;
	import org.apache.royale.community.jewel.ThreeCheckBox;

	
	public class ThreeCheckBoxStatesValues implements IBead
	{
		
		public function ThreeCheckBoxStatesValues()
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
			var hostBase:ThreeCheckBox = value as ThreeCheckBox;
			
			var oldstateval:String = hostBase.state;
			var newstateval:String = hostBase.state;

			if( indeterminatedValue != "" && hostBase.STATE_INDETERMINATED != indeterminatedValue ){
				if(oldstateval == hostBase.STATE_INDETERMINATED)
					newstateval = indeterminatedValue;
				hostBase.STATE_INDETERMINATED = indeterminatedValue;
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

		public var indeterminatedValue:String= "";
		public var uncheckedValue:String= "";
		public var checkedValue:String= "";
		
	}
}
