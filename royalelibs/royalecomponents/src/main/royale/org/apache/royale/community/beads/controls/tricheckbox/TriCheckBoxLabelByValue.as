package org.apache.royale.community.beads.controls.tricheckbox
{
	import org.apache.royale.core.Bead;
	import org.apache.royale.core.IStrand;
	import org.apache.royale.events.Event;
	import org.apache.royale.community.controls.TriCheckBox;

	
	public class TriCheckBoxLabelByValue extends Bead
	{
		
		public function TriCheckBoxLabelByValue()
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
			//listenOnStrand("valueCommit", textLabelChangeHandler);
			updateHost();
		}
		protected function textLabelChangeHandler(event:Event):void
		{
			updateHost()
		}

		private var _lastText:String;
		protected function updateHost():void
		{
			const hostBase:TriCheckBox = _strand as TriCheckBox;
			if (!hostBase)
				return;
			
			if(!_lastText)
				_lastText = hostBase.text;
				
			switch(hostBase.state)
			{
				case hostBase.rejectedValue:
					_lastText = _rejectedText;
					break;
				case hostBase.uncheckedValue:
					_lastText = _uncheckedText;
					break;
				case hostBase.checkedValue:
					_lastText = _checkedText;
					break;			
				default:
					break;
			}

			hostBase.text = _lastText;				
        }

		private var _rejectedText:String;
		public function get rejectedText():String { return _rejectedText; }
		public function set rejectedText(value:String):void 		
		{
			_rejectedText = value;
			/*const hostBase:TriCheckBox = _strand as TriCheckBox;
			if(!hostBase)
				return;
			if(hostBase.state==hostBase.rejectedValue)
				hostBase.text = value;*/
		}

		private var _uncheckedText:String;
		public function get uncheckedText():String { return _uncheckedText; }
		public function set uncheckedText(value:String):void 		
		{
			_uncheckedText = value;
			/*
			const hostBase:TriCheckBox = _strand as TriCheckBox;
			if(!hostBase)
				return;
			if(hostBase.state==hostBase.uncheckedValue)
				hostBase.text = value;
			*/
		}

		private var _checkedText:String;
		public function get checkedText():String { return _checkedText; }
		public function set checkedText(value:String):void 		
		{
			_checkedText = value;
			/*
			const hostBase:TriCheckBox = _strand as TriCheckBox;
			if(!hostBase)
				return;
			if(hostBase.state==hostBase.checkedValue)
				hostBase.text = value;
			*/
		}
		
	}
}
