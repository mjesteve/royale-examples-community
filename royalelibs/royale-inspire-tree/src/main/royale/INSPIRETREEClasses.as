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
			
			import org.apache.royale.community.inspiretree.beads.InspireTreeCheckBoxModeBead; InspireTreeCheckBoxModeBead;
			import org.apache.royale.community.inspiretree.beads.InspireTreeEventsBead; InspireTreeEventsBead;
			import org.apache.royale.community.inspiretree.beads.InspireTreeIconBead; InspireTreeIconBead;
			import org.apache.royale.community.inspiretree.beads.InspireTreePaginateBead; InspireTreePaginateBead;
			import org.apache.royale.community.inspiretree.beads.InspireTreeReadOnlyCheckBead; InspireTreeReadOnlyCheckBead;
			
			import org.apache.royale.community.inspiretree.beads.models.InspireTreeModel; InspireTreeModel;
			
			import org.apache.royale.community.inspiretree.controls.InspireTreeBasicControl; InspireTreeBasicControl;			
			import org.apache.royale.community.inspiretree.vos.ItemTreeNode; ItemTreeNode;
			import org.apache.royale.community.inspiretree.vos.ConfigDOM; ConfigDOM;
			import org.apache.royale.community.inspiretree.vos.OptionsTree; OptionsTree;
			import org.apache.royale.community.inspiretree.supportClasses.IInspireTree; IInspireTree;
		}		
	}
}

