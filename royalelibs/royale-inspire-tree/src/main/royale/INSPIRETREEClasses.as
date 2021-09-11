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
		}
	}
}

