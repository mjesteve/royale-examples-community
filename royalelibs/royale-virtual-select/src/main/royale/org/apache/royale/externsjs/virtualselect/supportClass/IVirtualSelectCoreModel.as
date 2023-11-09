package org.apache.royale.externsjs.virtualselect.supportClass
{
    import org.apache.royale.core.IHasDataProvider;

    //todo - wip

    public interface IVirtualSelectCoreModel extends IHasDataProvider
    {
        function get jsInstance():VirtualSelect;
        function set jsInstance(value:VirtualSelect):void;
        function get typeControl():String;
        function set typeControl(value:String):void;
        function get configOption():virtualSelectOptions;
        function set configOption(value:virtualSelectOptions):void;
        function get autoOptionsCount():Boolean;
        function set autoOptionsCount(value:Boolean):void;
        function get classNamesLabelRenderer():String;
        function set classNamesLabelRenderer(value:String):void;
        function get disabledOptions():Array;
        function set disabledOptions(value:Array):void;
        function get rawDataProvider():Array;
    }
}