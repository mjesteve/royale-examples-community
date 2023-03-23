package org.apache.royale.community.jewel.supportClasses
{
    import org.apache.royale.core.IComboBox;

    /**
     *  The IComboBox interface is implemented by any component that supports being
     *  a "ComboBox" with reset button
     *
     *  @langversion 3.0
     *  @playerversion Flash 10.2
     *  @playerversion AIR 2.6
     *  @productversion Royale 0.9.10
     */
    public interface IStrandWithResetButton extends IComboBox
    {
        function get withResetButton():Boolean;
        function set withResetButton(value:Boolean):void;
    }
}

