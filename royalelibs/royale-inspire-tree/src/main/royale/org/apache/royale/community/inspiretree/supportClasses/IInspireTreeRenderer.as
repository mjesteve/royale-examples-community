package org.apache.royale.community.inspiretree.supportClasses
{
    import org.apache.royale.core.IBead;

    public interface IInspireTreeRenderer extends IBead
    {

       function prepareRenderer(node:Object):Object;
    }
}