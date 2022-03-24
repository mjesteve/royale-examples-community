package
{

	/**
	 *  @private
	 *  This class is used to link additional classes into rpc.swc
	 *  beyond those that are found by dependency analysis starting
	 *  from the classes specified in manifest.xml.
	 */
	internal class INSPIRETREEClasses
	{
		COMPILE::JS
		{
			import InspireTree; InspireTree;
			import InspireTreeDOM; InspireTreeDOM;
	        import TreeNode; TreeNode;
			import TreeNodes; TreeNodes;

			import org.apache.royale.community.inspiretree.vos.ItemTreeNode; ItemTreeNode;
			import org.apache.royale.community.inspiretree.vos.ConfigDOM; ConfigDOM;
			import org.apache.royale.community.inspiretree.vos.OptionsTree; OptionsTree;
			import org.apache.royale.community.inspiretree.supportClasses.IInspireTree; IInspireTree;
		}
	}
}

