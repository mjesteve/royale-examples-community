package org.apache.royale.community.jewel.beads.controls.combobox
{
	import org.apache.royale.core.IBead;
	import org.apache.royale.core.IStrand;
	import org.apache.royale.events.Event;
	import org.apache.royale.jewel.ComboBox;
	
	/**
	 *  The ComboBoxRequireSelection bead is a specialty bead that can be used with
	 *  any Jewel ComboBox control to force a data item always be selected in the control
	 *  
	 *  Based on the RequireSelection bead for the Jewel DropDownList control.
	 * 
	 *  @langversion 3.0
	 *  @playerversion Flash 10.2
	 *  @playerversion AIR 2.6
	 *  @productversion Royale 0.9.4
	 */
	public class ComboBoxRequireSelection implements IBead
	{
		/**
		 *  constructor.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.4
		 */
		public function ComboBoxRequireSelection()
		{
		}
		
		private var hostCb:ComboBox;
		
		/**
		 *  @copy org.apache.royale.core.IBead#strand
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.4
		 *  @royaleignorecoercion org.apache.royale.events.IEventDispatcher
		 */
		public function set strand(value:IStrand):void
		{
			hostCb = value as ComboBox;
			hostCb.addEventListener('selectionChanged', selectionChangeHandler);
			hostCb.addEventListener('dataProviderChanged', selectionChangeHandler);

			if(needUpdate)
			{
				needUpdate = false;
				updateRequiredSelection();
			}
		}

		private var needUpdate:Boolean = false;

		/**
         *  @private
         *  Storage for the requireSelection property.
         */
        private var _requireSelection:Boolean = false;

        /**
         *  If <code>true</code>, a data item must always be selected in the control.
         *  If the value is <code>true</code>, the <code>selectedIndex</code> property 
         *  is always set to a value between 0 and (<code>dataProvider.length</code> - 1).
         * 
         * <p>The default value is <code>false</code> for most subclasses, except TabBar. In that case, the default is <code>true</code>.</p>
         *
         *  @default false
         *  
         *  @langversion 3.0
         *  @playerversion Flash 10
         *  @playerversion AIR 1.5
         *  @productversion Flex 4
         */
        public function get requireSelection():Boolean
        {
            return _requireSelection;
        }

        /**
         *  @private
         */
        public function set requireSelection(value:Boolean):void
        {
            if (value != _requireSelection)
            {
                _requireSelection = value;
				updateRequiredSelection();
            }
        }

		private function updateRequiredSelection():void {
			if(hostCb) {
				forceSelection();
			} else {
				needUpdate = true;
			}
		}

		private function selectionChangeHandler(event:Event):void
		{
			forceSelection();
		}

		private function forceSelection():void
		{
			if(_requireSelection && (hostCb.selectedIndex == -1 || !hostCb.selectedItem))
			{
				if (!hostCb.dataProvider || hostCb.dataProvider.length == 0)
				{
					return;
				}

				hostCb.selectedIndex = 0;
			}	
		}
	}
}
