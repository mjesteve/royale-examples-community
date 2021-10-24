package 
{

	/**
	 *  @private
	 *  This class is used to link additional classes into rpc.swc
	 *  beyond those that are found by dependency analysis starting
	 *  from the classes specified in manifest.xml.
	 */
	internal class TREEClasses
	{
		COMPILE::JS
		{
			import InspireTree; InspireTree;
			import InspireTreeDOM; InspireTreeDOM;
	        import TreeNode; TreeNode;
			import TreeNodes; TreeNodes;
			
			import com.proj.example.inspiretree.InspireTreeBasicControl; InspireTreeBasicControl;
			import com.proj.example.inspiretree.beads.InspireTreeEventsBead; InspireTreeEventsBead;
			import com.proj.example.inspiretree.vos.ItemTreeNode; ItemTreeNode;
			import com.proj.example.inspiretree.vos.ConfigDOM; ConfigDOM;
			import com.proj.example.inspiretree.vos.OptionsTree; OptionsTree;
		}
	}
}

