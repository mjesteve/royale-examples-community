package org.apache.royale.community.beads.models
{
    /**
     *  @langversion 3.0
     *  @playerversion Flash 10.2
     *  @playerversion AIR 2.6
     *  @productversion Royale 0.9.8
     */
    public interface ISelectionByFieldModel
    {
        function get valueField():String;
        function set valueField(value:String):void;
        function get selectedValue():Object;
        function set selectedValue(value:Object):void;
    }
}
