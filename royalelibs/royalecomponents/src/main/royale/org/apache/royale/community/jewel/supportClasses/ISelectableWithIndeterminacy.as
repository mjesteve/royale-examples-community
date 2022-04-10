package org.apache.royale.community.jewel.supportClasses
{
    import org.apache.royale.core.ISelectable;

    /**
     *  The ISelectableWithIndeterminacy interface is a marker interface for indicating a class has three states by two property: 
     *  selected property (inherited from ISelectable) and indeterminate property.
     *  
     *  @langversion 3.0
     *  @playerversion Flash 10.2
     *  @playerversion AIR 2.6
     *  @productversion Royale 0.9.8
     */
	public interface ISelectableWithIndeterminacy extends ISelectable
	{
        /**
         *  <code>true</code> if the item is indeterminate.
         * 
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion Royale 0.0
         */
		function get indeterminate():Boolean;
		function set indeterminate(value:Boolean):void;
        
	}
}
