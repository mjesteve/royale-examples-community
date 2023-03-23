package org.apache.royale.externsjs.inspiretree.supportClasses
{
    public interface IInspireTree
    {
        function isInitialized():Boolean;
        function prepareTreeDataFromArray(flatArrayIn:Array):Array; //return 2 elements: 0:treeData (jsTree), 1:treeNormalizedData
        function reCreateViewTree(onlyView:Boolean=false):void;
        function updateDataViewTree(reload:Boolean=true):void;
        function get jsTree():InspireTree;
        function set jsTree(value:InspireTree):void;
        function get jsTreeDOM():InspireTreeDOM;
        function set jsTreeDOM(value:InspireTreeDOM):void;
        function get uid():String;
        function set uid(value:String):void;
    }
}