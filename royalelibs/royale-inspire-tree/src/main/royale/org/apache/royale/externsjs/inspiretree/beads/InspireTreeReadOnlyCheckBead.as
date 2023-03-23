package org.apache.royale.externsjs.inspiretree.beads
{

	/**
	 *  @langversion 3.0
	 *  @playerversion Flash 10.2
	 *  @playerversion AIR 2.6
	 *  @productversion Royale 0.9.8
	 */
	COMPILE::JS{
	import org.apache.royale.core.IBead;
	import org.apache.royale.core.IStrand;
	import org.apache.royale.core.Strand;
    import org.apache.royale.events.IEventDispatcher;
    import org.apache.royale.externsjs.inspiretree.beads.models.InspireTreeModel;
    import org.apache.royale.utils.sendStrandEvent;
    import org.apache.royale.events.ValueEvent;
    import org.apache.royale.events.Event;
    import org.apache.royale.core.IStyledUIBase;
    import org.apache.royale.core.IStrandWithModel;
	}
    /**
     * Simulates the Read-Only state in checkboxes.
     * This implementation modifies 'z-index:-1', adding the CSS class 'readonly' to the component,
     * to make checkboxes inaccessible.
     * Depends on specific CSS selector: .inspire-tree.readonly input[type="checkbox"]
     */
    COMPILE::JS
	public class InspireTreeReadOnlyCheckBead  extends Strand implements IBead
	{
		/**
		 *  constructor
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.7
		 */

		public function InspireTreeReadOnlyCheckBead()
		{
			super();
		}
		protected var lastElementZIndexVal:String = null;
		protected var initialized:Boolean = false;

        private var _strand:IStrand;

		/**
		 *  @copy org.apache.royale.core.IBead#strand
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.4
		 */
        public function get strand():IStrand
        {
            return _strand;
        }
		/**
		 *  @copy org.apache.royale.core.IBead#strand
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.4
		 */
		public function set strand(value:IStrand):void
		{
            _strand = value;
			(_strand as IEventDispatcher).addEventListener("initComplete", init);
		}

		private function init(event:Event):void
		{
			(_strand as IEventDispatcher).removeEventListener("initComplete", init);

			var treeModel:InspireTreeModel = ((_strand as IStrandWithModel).model as InspireTreeModel);
			treeModel.addEventListener("checkboxModeChanged", updateHost);

			updateHost();
		}

		private var _readOnly:Boolean = false;
        /**
		 *  A boolean flag to enable or disable the host control.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.4
		 */
        public function get readOnly():Boolean
        {
            return _readOnly;
        }
        public function set readOnly(value:Boolean):void
        {
			var lro:Boolean = _readOnly;
			_readOnly = value;
			updateHost();
			if(_strand && value != lro)
				sendStrandEvent(_strand, new ValueEvent("readonlyChange", _readOnly));
        }

		[Bindable]
		private function updateHost(event:Event = null):void
		{
			if(!strand)
				return;

            //If it is the first time it is executed and readOnly=false, the process does not need to be performed.
            if(!initialized && !readOnly)
                return;

            initialized = true;

            var checkboxMode:Boolean =((_strand as IStrandWithModel).model as InspireTreeModel).checkboxMode;
            if(!checkboxMode)
                return;

            var existClass:Boolean = (_strand as IStyledUIBase).containsClass('readonly') ? true : false;
            if(!readOnly && existClass)
                (_strand as IStyledUIBase).removeClass('readonly');
            else if(readOnly && !existClass)
                (_strand as IStyledUIBase).addClass('readonly');

		}

	}

    COMPILE::SWF
	public class InspireTreeReadOnlyCheckBead
	{
    }
}

