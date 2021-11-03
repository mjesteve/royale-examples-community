package org.apache.royale.community.inspiretree.vos
{
   
   //import org.apache.royale.community.inspiretree.DragAndDropConfig;

    public class ConfigDOM
    {
        public function ConfigDOM(){}

        /**
         * An Element, selector, or jQuery object.
         */
        public var target:HTMLElement;
         /**
         * DragAndDropConfig {
         *      enabled - Enable drag and drop support. Default: false
         *      validateOn - Use dragstart or dragover to determine when "target" nodes are validated. Default: dragstart.
         *      validate - (TreeNode dragNode, TreeNode targetNode) - Custom target node validation.
         * }
         */
        public var dragAndDrop:Boolean;        
        /**
         * Automatically triggers "Load More" links on scroll. Used with deferrals.
         */
        public var autoLoadMore:Boolean;
        /**
         * Only render nodes as the user clicks to display more.
         */
        public var deferredRendering:Boolean;
        /**
         * Height (in pixels) of your nodes. Used with deferrals, if pagination.limit not provided.
         */
        public var nodeHeight:Number;
        /**
         * Show checkbox inputs.
         */
        public var showCheckboxes:Boolean;
       
        public var dragTargets:Array;
        /**
         * Define a tab index for the tree container (used for key nav).
         */
        public var tabindex:Number;
    }

}