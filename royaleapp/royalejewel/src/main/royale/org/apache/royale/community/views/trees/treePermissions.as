package org.apache.royale.community.views.trees
{
	//import org.apache.royale.collections.ArrayListView;
    import org.apache.royale.events.Event;
	import org.apache.royale.collections.ArrayList;
    import org.apache.royale.community.inspiretree.controls.InspireTreeBasicControl;
	import org.apache.royale.community.models.UsersPermissions;
	import org.apache.royale.community.vos.PermissVO;
	import org.apache.royale.community.inspiretree.beads.InspireTreeCheckBoxModeBead;
	import org.apache.royale.core.IBead;

	public class treePermissions extends InspireTreeBasicControl
	{
		/**
		 * Constructor
		 */
		public function treePermissions(){
			super();						
			addEventListener("beadsAdded", beadsAddedHandler);
			//addEventListener("initComplete", setData);
		}
		
       	protected function beadsAddedHandler(event:Event):void
        {
			removeEventListener("beadsAdded", beadsAddedHandler);
			labelFunctionChild = itemToLabelChild;
			labelFunctionParent = itemToLabelParent;
			boundField = "idobj";			
			allowDragAndDrop = false;
			
			var _checkBoxBead:IBead = getBeadByType(InspireTreeCheckBoxModeBead);
            //var _checkBoxBead:InspireTreeCheckBoxModeBead = loadBeadFromValuesManager(InspireTreeCheckBoxModeBead, "IBeadCheckBox", this) as InspireTreeCheckBoxModeBead;
			if(_checkBoxBead)
			{
				(_checkBoxBead as InspireTreeCheckBoxModeBead).checkedIsSelected = false;
			}
			setData();
		}
		private function setData(event:Event = null):void
		{
			//Filter permissions - Test codigo=0
			dataProvider = getUsersPermiss();
		}

		public function itemToLabelParent(item:Object):String
		{
			if(!item)
				return '';
			var localItem:PermissVO = item as PermissVO;
			return localItem.idobj+" - "+localItem.desobj;
		}

		public function itemToLabelChild(item:Object):String
		{
			if(!item)
				return '';
			var localItem:PermissVO = item as PermissVO;
			return localItem.desacc;
		}

		public function itemChildChecked(item:Object):Boolean
		{
			if(!item)
				return false;
			var localItem:PermissVO = item as PermissVO;
			return localItem.checked == 1 ? true : false;
		}

		private var dpUsersPermiss:UsersPermissions = new UsersPermissions();

		private function getUsersPermiss(docu:int = -1):ArrayList
		{
			/*var ar:ArrayListView = new ArrayListView(dpUsersPermiss);
			ar.filterFunction = function(item:PermissVO):Boolean
			{
				if(item.idobj == docu) //&& item.idobj<3))
					return true;
				else
					return false;
			}
			ar.refresh();
			return ar.toArray();*/
			return new UsersPermissions(docu);
		}

	}
}