package org.apache.royale.externsjs.virtualselect.supportClass
{
    
    /**
     * @typedef {object} virtualSelectOptions

    * @typedef {object} virtualSelectOption
    * @property {(string|number)} value - Value of the option
    * @property {(string|number)} label - Display text of the option
    * @property {(string|number)} [description] - Text to show along with label
    * @property {(string|string[])} [alias] - Alternative labels to use on search. Array of string or
    * comma separated string.
    * @property {any} [customData] - Any custom data to store with the options and it would be available
    * with getSelectedOptions() result.
    * @property {virtualSelectOption[]} [options] - List of options for option group
    */

	COMPILE::JS
    public class virtualSelectOption
    {
        
        public function virtualSelectOption(){}
        
        public var value:String;
        public var label:String;
        public var description:String;
        public var alias:Object;
        public var customData:Object;
        public var options:Array;
    }
}