package org.apache.royale.community.jewel
{
    COMPILE::SWF
    {
    import org.apache.royale.core.IToggleButtonModel;
    import org.apache.royale.events.MouseEvent;
    }

    COMPILE::JS
    {
    import org.apache.royale.core.WrappedHTMLElement;
    import org.apache.royale.events.Event;
    import org.apache.royale.html.util.addElementToWrapper;
    }

    import org.apache.royale.core.ITextButton;
    import org.apache.royale.jewel.supportClasses.IInputButton;
    import org.apache.royale.jewel.supportClasses.button.SelectableButtonBase;
    import org.apache.royale.events.MouseEvent;
    import org.apache.royale.events.Event;
    import org.apache.royale.community.jewel.supportClasses.ISelectableToggle;
    
    /**
     *  Dispatched when the state of the control is set by code and not by manual user intervention.
     *
     *  It will be dispatched together with the general event "change".
     * 
     *  @langversion 3.0
     *  @playerversion Flash 10.2
     *  @playerversion AIR 2.6
     *  @productversion Royale 0.9.8
     */
	[Event(name="valueCommit", type="org.apache.royale.events.Event")]
    
    /**
     *  Dispatched when the state of the control is manually set by the user by clicking on the control.
     *
     *  It will be dispatched together with the general event "change".
     * 
     *  @langversion 3.0
     *  @playerversion Flash 10.2
     *  @playerversion AIR 2.6
     *  @productversion Royale 0.9.8
     */
	[Event(name="clickCommit", type="org.apache.royale.events.Event")]
    /**
     *  The Jewel Ext ThreeCheckBox is an extension of the Jewel CheckBox control that adds a third "indeterminated" state. 
     *  
     *  When a user clicks or touches this control or its associated text, the ThreeCheckBox changes. 
     *  its state from unchecked to checked or, from checked to indeterminated or, from indeterminated to unchecked. 
     *  The state of the control is no longer binary: unchecked, checked, and indeterminated.
     * 
     * 
     *  @langversion 3.0
     *  @playerversion Flash 10.2
     *  @playerversion AIR 2.6
     *  @productversion Royale 0.9.4
     */
    public class ThreeCheckBox extends SelectableButtonBase implements ISelectableToggle, IInputButton, ITextButton
    {
        /**
         *  Constructor.
         *  
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion Royale 0.9.4
         */
		public function ThreeCheckBox()
		{
			super();

            typeNames = "jewel checkbox";
            
            addEventListener("beadsAdded", beadsAddedHandler);
        }

        private var isInitialized:Boolean = false;
        private var stateInit:String="";
        private function beadsAddedHandler(event:Event):void
        {
			removeEventListener("beadsAdded", beadsAddedHandler);

            if( stateInit != "" )
                updateState( stateInit );
            else
                updateState( STATE_UNCHECKED );

            isInitialized = true;
            dispatchEvent(new Event(Event.COMPLETE));
        }

        [Bindable("change")]
        /**
         *  <code>true</code> if the check mark is displayed, <code>false</code> otherwise.
         *  
         *  @default false
         *  
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion Royale 0.9.4
         */
		override public function get selected():Boolean
		{
            COMPILE::SWF
            {
			return IToggleButtonModel(model).selected;
            }
            COMPILE::JS
            {
            return input.checked;
            }
		}
        /**
         *  @private
         */
		override public function set selected(value:Boolean):void
		{
            COMPILE::SWF
            {
			IToggleButtonModel(model).selected = value;
            }
            COMPILE::JS
            {
            if(!isInitialized && !isClickCommit && !isValueCommit)
            {
                if( stateInit == "" || stateInit != STATE_INDETERMINATED)
                    stateInit = value ? STATE_CHECKED : STATE_UNCHECKED;
                return;
            }

            if(input.checked == value && state != STATE_INDETERMINATED)
                return;
            
            input.indeterminate = false;
            input.checked = value;
            
            if(!isClickCommit)
            {                
                _state =  value ? STATE_CHECKED : STATE_UNCHECKED;
                if(!isValueCommit)
                    dispatchEvent(new Event(Event.CHANGE));
            }

            }
		}

        [Bindable("change")]
		public function get indeterminated():Boolean
		{
            COMPILE::SWF
            {
			//return IToggleButtonModel(model).selected;
            }
            COMPILE::JS
            {
            return input.indeterminate;
            }
		}
        /**
         *  @private
         */
		public function set indeterminated(value:Boolean):void
		{
            COMPILE::SWF
            {
			//IToggleButtonModel(model).selected = value;
            }
            COMPILE::JS
            {
            if(!isInitialized && !isClickCommit && !isValueCommit)
            {
                if(value)
                    stateInit = STATE_INDETERMINATED;
                return;
            }

            if(input.indeterminate == value)
                return;

            input.indeterminate = value;

            if(!isClickCommit && value)
            {
                _state = STATE_INDETERMINATED;
                if(!isValueCommit)
                    dispatchEvent(new Event(Event.CHANGE));
            }

            }
		}

        /**
         *  The string used as a label for the ThreeCheckBox.
         *
         *  @royaleignorecoercion Text
         *  
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion Royale 0.9.4
         */
		public function get text():String
		{
            COMPILE::SWF
            {
            return IToggleButtonModel(model).text;
            }
            COMPILE::JS
            {
            return textNode ? textNode.nodeValue : "";
            }
		}
        /**
         *  @private
         */
        public function set text(value:String):void
		{
            COMPILE::SWF
            {
	        IToggleButtonModel(model).text = value;
            }
            COMPILE::JS
            {
            if(!textNode)
            {
                textNode = document.createTextNode('') as Text;
                spanLabel.appendChild(textNode);
            }
            
            textNode.nodeValue = value;
            }
		}

        /**
         *  The value associated with the ThreeCheckBox.
         * 
         *  TODO. Manage the configured value according to the 3 current states. 
         * 
         *  According to w3c ...
         *  For checkboxes, the contents of the value property do not appear in the user interface. The value property only has meaning when submitting a form. 
         *  If a checkbox is in checked state when the form is submitted, the name of the checkbox is sent along with the value of the value property 
         *  (if the checkbox is not checked, no information is sent).
         * 
         *  If we want the value property to contain a different value for each of the states we must "always" simulate a checked state for the information to be transferred.
         *  Would it be advisable to transfer this process to a Bead?
         *
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion Royale 0.9.4
         */
        public function get value():String
        {
            COMPILE::SWF
            {
            return IToggleButtonModel(model).html;
            }
            COMPILE::JS
            {
            return input.value;
            }
        }
        public function set value(newValue:String):void
        {
            COMPILE::SWF
            {
            IToggleButtonModel(model).html = newValue;
            }
            COMPILE::JS
            {
            input.value = newValue;
            }
        }

        COMPILE::JS
        /**
         *  the org.apache.royale.core.HTMLElementWrapper#element for this component
         *  added to the positioner. Is a HTMLInputElement.
         * 
         *  @royalesuppresspublicvarwarning
         */
        public var input:HTMLInputElement;

        /**
         *  the input button
         *  
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion Royale 0.9.7
         */
        COMPILE::JS
        public function get inputButton():HTMLInputElement {
            return input;
        }

        COMPILE::JS
		private var _spanLabel:HTMLSpanElement;
		/**
         *  the span for the label text
         *  
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion Royale 0.9.8
         */
		COMPILE::JS
		public function get spanLabel():HTMLSpanElement {
			return _spanLabel;
		}
		COMPILE::JS
		public function set spanLabel(value:HTMLSpanElement):void {
			_spanLabel = value;
		}
        
        COMPILE::JS
        /**
         * a Text node added to the checkbox HTMLSpanElement.
         * It's creation is deferred since Checkboxes sometimes are used without labels.
         */
        protected var textNode:Text;

        public var STATE_UNCHECKED:String = "0";
        public var STATE_CHECKED:String = "1";
        public var STATE_INDETERMINATED:String = "-1";

        private var isValueCommit:Boolean = false;

        private var _state:String;
        /**
         * 
         * Component state: checked - unchecked - indeterminate
         */
        public function get state():String{
            return _state;
        }
        [Bindable]
        public function set state(value:String):void
        {
            isValueCommit = true;

            updateState(value);

            if(!isClickCommit && isInitialized)
            {
                dispatchEvent(new Event(Event.CHANGE));
            }else{
                dispatchEvent(new Event("valueCommit"));
            }
                
            isValueCommit = false;
        }

        protected function updateState(value:String):void 
        {
            if(_state == value)
                return;

            switch(value) {
                case STATE_INDETERMINATED:
                    indeterminated = true;
                    break;
                case STATE_UNCHECKED:
                    selected = false;
                    break;
                case STATE_CHECKED:
                    selected = true;
                    break;
            }
            _state = value;
        }

        private var isClickCommit:Boolean = false;
        /*
            Internal Change. Sequence: deselected/unchecked, selected/checked and indeterminated
        */
        protected function changeState():void 
        {
            isClickCommit = true;

            if(_state == STATE_INDETERMINATED)
                updateState( STATE_UNCHECKED );
            else if( _state == STATE_CHECKED)
                updateState( STATE_INDETERMINATED );
            else
                updateState( STATE_CHECKED );
            
            dispatchEvent(new Event(Event.CHANGE));
            
            isClickCommit = false;
        }

        /**
         * 
         * The selected and indeterminate properties, in isolation, cannot provide the real value represented in the component 
         * because the input-checkbox allows a "selected" state with an "indeterminate". 
         * 
         * To know the real state of the component, the new property "state" must be interrogated. 
         * The following functions are created to retrieve it directly.
         * 
         */
        /**
         * 
         * @return true, if the component is in "state" selected
         */
        public function isChecked():Boolean
        {
            return state == STATE_CHECKED ? true:false;
        }
        /**
         * 
         * @return true, if the component is in "state" unselected
         */
        public function isUnChecked():Boolean
        {
            return state == STATE_UNCHECKED ? true:false;
        }
        /**
         * 
         * @return true, if the component is in "state" indeterminated
         */
        public function isIndeterminated():Boolean
        {
            return state == STATE_INDETERMINATED ? true:false;
        }

        /**
         * @royaleignorecoercion org.apache.royale.core.WrappedHTMLElement
         * @royaleignorecoercion HTMLInputElement
         * @royaleignorecoercion HTMLSpanElement
         */
        COMPILE::JS
        override protected function createElement():WrappedHTMLElement
        {
            input = addElementToWrapper(this,'input') as HTMLInputElement;
            input.type = 'checkbox';
            input.addEventListener(MouseEvent.CLICK, inputClick);

            spanLabel = document.createElement('span') as HTMLSpanElement;
            positioner = document.createElement('label') as WrappedHTMLElement;   
            return element;
        }
        
        private function inputClick(event:MouseEvent):void
        {
            event.stopImmediatePropagation();
			event.preventDefault();
            setTimeout(changeState,15);
        }

        COMPILE::JS
        private var _positioner:WrappedHTMLElement;
        /**
         *  @copy org.apache.royale.core.IUIBase#positioner
         *
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion Royale 0.9.4
         */
        COMPILE::JS
		override public function get positioner():WrappedHTMLElement
		{
			return _positioner;
		}
        COMPILE::JS
		override public function set positioner(value:WrappedHTMLElement):void
		{
			_positioner = value;
            _positioner.royale_wrapper = this;
			_positioner.appendChild(element);
            _positioner.appendChild(spanLabel);
		}

    }
}
