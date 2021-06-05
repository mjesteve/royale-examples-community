package 
{

	/**
	 *  @private
	 *  This class is used to link additional classes into rpc.swc
	 *  beyond those that are found by dependency analysis starting
	 *  from the classes specified in manifest.xml.
	 */
	COMPILE::JS
	internal class JSCALENDARClasses
	{
		import jsCalendar; jsCalendar;
		import org.apache.royale.community.jscalendar.vo.DateItemDescribeVO; DateItemDescribeVO;
		import org.apache.royale.community.jscalendar.AnnualJSCalendar;	AnnualJSCalendar;
		import org.apache.royale.community.jscalendar.events.SharedEvent; SharedEvent;
	}
}

