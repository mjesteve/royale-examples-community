package org.apache.royale.community.jewel.beads.controls.tristatecheckbox
{
	import org.apache.royale.core.Bead;
	import org.apache.royale.core.IStrand;
	import org.apache.royale.events.Event;
	import org.apache.royale.events.IEventDispatcher;
	import org.apache.royale.community.jewel.TriStateCheckBox;


	public class TriStateCheckBoxLabelState_v0 extends Bead
	{

		public function TriStateCheckBoxLabelState_v0()
		{
		}

		/**
		 *  @copy org.apache.royale.core.IBead#strand
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.6
		 *  @royaleignorecoercion org.apache.royale.events.IEventDispatcher;
		 */
		override public function set strand(value:IStrand):void
		{
			_strand = value;
			listenOnStrand("change", textLabelChangeHandler);
			listenOnStrand(Event.COMPLETE, textLabelChangeHandler);
			//listenOnStrand("valueCommit", textLabelChangeHandler);
			//listenOnStrand("clickCommit", textLabelChangeHandler);
		}

		private function get hostBase():TriStateCheckBox
		{
			return _strand as TriStateCheckBox;
		}

		protected function textLabelChangeHandler(event:Event):void
		{
			if(event.type == Event.COMPLETE)
				IEventDispatcher(_strand).removeEventListener(Event.COMPLETE, textLabelChangeHandler);
			updateHost();
		}

		private var _lastText:String;
		protected function updateHost():void
		{
			if (!hostBase)
				return;
			switch(hostBase.state)
			{
				case hostBase.STATE_INDETERMINATE:
					_lastText = _indeterminateText;
					break;
				case hostBase.STATE_UNCHECKED:
					_lastText = _uncheckedText;
					break;
				case hostBase.STATE_CHECKED:
					_lastText = _checkedText;
					break;
				default:
					break;
			}
			if(_lastText != hostBase.text)
				hostBase.text = _lastText;

        }

		private var _indeterminateText:String;
		public function get indeterminateText():String { return _indeterminateText; }
		public function set indeterminateText(value:String):void
		{
			_indeterminateText = value;

			if(!hostBase)
				return;
			if(hostBase.state == hostBase.STATE_INDETERMINATE)
				hostBase.text = value;
		}

		private var _uncheckedText:String;
		public function get uncheckedText():String { return _uncheckedText; }
		public function set uncheckedText(value:String):void
		{
			_uncheckedText = value;

			if(!hostBase)
				return;
			if(hostBase.state == hostBase.STATE_UNCHECKED)
				hostBase.text = value;
		}

		private var _checkedText:String;
		public function get checkedText():String { return _checkedText; }
		public function set checkedText(value:String):void
		{
			_checkedText = value;

			if(!hostBase)
				return;
			if(hostBase.state == hostBase.STATE_CHECKED)
				hostBase.text = value;
		}

	}
}
