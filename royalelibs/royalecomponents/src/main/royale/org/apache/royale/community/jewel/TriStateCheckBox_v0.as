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

    import org.apache.royale.community.jewel.supportClasses.ISelectableWithIndeterminacy;
    import org.apache.royale.core.ITextButton;
    import org.apache.royale.jewel.supportClasses.IInputButton;
    import org.apache.royale.jewel.supportClasses.button.SelectableButtonBase;
    import org.apache.royale.events.MouseEvent;
    import org.apache.royale.events.Event;

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
     *  The Jewel Ext TriStateCheckBox is an extension of the Jewel CheckBox control that adds a third "indeterminate" state.
     *
     *  When a user clicks or touches this control or its associated text, the TriStateCheckBox changes.
     *  its state from unchecked to checked or, from checked to indeterminate or, from indeterminate to unchecked.
     *  The state of the control is no longer binary: unchecked, checked, and indeterminate.
     *
     *
     *  @langversion 3.0
     *  @playerversion Flash 10.2
     *  @playerversion AIR 2.6
     *  @productversion Royale 0.9.4
     */
    public class TriStateCheckBox_v0 extends SelectableButtonBase implements ISelectableWithIndeterminacy, IInputButton, ITextButton
    {
        /**
         *  Constructor.
         *
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion Royale 0.9.4
         */
		public function TriStateCheckBox_v0()
		{
			super();

            typeNames = "jewel checkbox";

            addEventListener("beadsAdded", beadsAddedHandler);
        }

        private var isInitialized:Boolean = false;
        private var stateInit:String="init";

        private function beadsAddedHandler(event:Event):void
        {
			removeEventListener("beadsAdded", beadsAddedHandler);

            isInitialized = true;

            if( stateInit == "init" )
                stateInit = STATE_UNCHECKED;
            state = stateInit;

            dispatchEvent(new Event(Event.COMPLETE));
        }

        private var _rejectedVersion:Boolean;
        public function set rejectedVersion(value:Boolean):void
        {
            _rejectedVersion = value;
            if(value)
            {
                toggleClass("rejected",true);
            }
        }

        [Bindable("change")]
		override public function get selected():Boolean
		{
            COMPILE::SWF
            {
			return IToggleButtonModel(model).selected;
            }
            COMPILE::JS
            {
                return input.checked && !input.indeterminate;
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
                if(value)
                    state = STATE_CHECKED;
                else{
                    state = STATE_UNCHECKED;
                }
            }
		}

        [Bindable("change")]
		public function get indeterminate():Boolean
		{
            COMPILE::SWF
            {
			    return false;
            }
            COMPILE::JS
            {
                return input.indeterminate;
            }
		}
        /**
         *  @private
         */
		public function set indeterminate(value:Boolean):void
		{
            COMPILE::JS
            {
                if(value)
                    state = STATE_INDETERMINATE;
                else{
                    //next state
                    state = STATE_UNCHECKED;
                }
            }
		}

        private var _STATE_UNCHECKED:String = "0";
        public function get STATE_UNCHECKED():String{ return _STATE_UNCHECKED; }
        public function set STATE_UNCHECKED(value:String):void{ _STATE_UNCHECKED = value; }
        private var _STATE_CHECKED:String = "1";
        public function get STATE_CHECKED():String{ return _STATE_CHECKED; }
        public function set STATE_CHECKED(value:String):void{ _STATE_CHECKED = value; }
        private var _STATE_INDETERMINATE:String = "-1";
        public function get STATE_INDETERMINATE():String{ return _STATE_INDETERMINATE; }
        public function set STATE_INDETERMINATE(value:String):void{ _STATE_INDETERMINATE = value; }

        private var _state:String;
        /**
         *
         * Component state: checked - unchecked - indeterminate
         */
        public function get state():String
        {
            if( !isInitialized )
                return stateInit;
            else
                return _state;
        }
        [Bindable("change")]
        /*[Inspectable(category="General", enumeration="stateChecked,stateUnchecked,stateIndeterminate")]*/
        public function set state(value:String):void
        {

            if( !isInitialized )
            {
                stateInit = value;
                return;
            }

            if(_state == value)
                return;

            COMPILE::SWF
            {
                if(value == STATE_CHECKED)
                    _state = STATE_UNCHECKED;
                else
                    _state = STATE_CHECKED;
            }
            COMPILE::JS{
                _state = value;
            }

            applyState(value);

            if(!isInitialized)
                return;

            if(!isClickCommit)
                dispatchEvent(new Event("valueCommit"));
            else
                dispatchEvent(new Event("clickCommit"));

            dispatchEvent(new Event(Event.CHANGE));
        }

        protected function applyState(value:String):void
        {
            COMPILE::SWF
            {
            switch(value) {
                case STATE_UNCHECKED:
                    input.checked = false;
                    break;
                case STATE_CHECKED:
                    input.checked = true;
                    break;
            }
            }
            COMPILE::JS
            {
            switch(value) {
                case STATE_INDETERMINATE:
                    input.indeterminate = true;
                    input.checked = false;
                    break;
                case STATE_UNCHECKED:
                    if(input.indeterminate)
                        input.indeterminate = false;
                    input.checked = false;
                    break;
                case STATE_CHECKED:
                    if(input.indeterminate)
                        input.indeterminate = false;
                    input.checked = true;
                    break;
            }
            }

        }

        private var isClickCommit:Boolean = false;
        /*
            Internal Change. Sequence: deselected/unchecked, selected/checked and indeterminate
        */
        protected function changeState():void
        {
            isClickCommit = true;

            if(_state == STATE_INDETERMINATE)
                state = STATE_UNCHECKED;
            else if( _state == STATE_CHECKED)
                state = STATE_INDETERMINATE;
            else
                state = STATE_CHECKED;

            isClickCommit = false;
        }
        /**
         * Test. Debug all dispatched events
         */
        /*override public function dispatchEvent(event:Event):Boolean {
            trace("********** TriStateCheckBox: ", event.type);
            return super.dispatchEvent(event);
        }*/

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
         * @return true, if the component is in "state" indeterminate
         */
        public function isIndeterminate():Boolean
        {
            return state == STATE_INDETERMINATE ? true:false;
        }

        /**
         *  The string used as a label for the TriStateCheckBox.
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
         *  The value associated with the TriStateCheckBox.
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
        private var _input:HTMLInputElement;
        public function get input():HTMLInputElement{ return _input; }
        public function set input(value:HTMLInputElement):void{ _input = value; }

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
