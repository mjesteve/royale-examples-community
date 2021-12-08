package org.apache.royale.community.inspiretree.supportClasses
{
    public interface IInspireTree
    {
        function isInitialized():Boolean;
        function prepareTreeDataFromArray(dpArray:Array):Array;
        function reCreateViewTree(onlyView:Boolean=false):void;
        function get jsTree():InspireTree;
        function set jsTree(value:InspireTree):void;
        function get jsTreeDOM():InspireTreeDOM;
        function set jsTreeDOM(value:InspireTreeDOM):void;
        function get uid():String;
        function set uid(value:String):void;
    }
}