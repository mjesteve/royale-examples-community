package org.apache.royale.community.controls
{
    import org.apache.royale.jewel.supportClasses.combobox.IComboBoxPresentationModel;
    import org.apache.royale.html.util.getModelByType;
    import org.apache.royale.jewel.beads.models.ComboBoxPresentationModel;

    public class ComboBoxJwExtDefs extends ComboBoxJwExt {

        private var isCreateComplete:Boolean = false;

        public function ComboBoxJwExtDefs() {
            super();
            emptyDisabled = true;
            disabled = false;
            activeTextPromp = true;

            labelField="displaytext";
            valueField="codigo";
        }

		override public function get presentationModel():IComboBoxPresentationModel
		{
			var presModel:IComboBoxPresentationModel = getModelByType(this,IComboBoxPresentationModel) as IComboBoxPresentationModel;
			if (presModel == null) {
				presModel = new ComboBoxPresentationModel();                
                presModel.rowHeight = 35;
				addBead(presModel);
			}
			return presModel;
		}

    }
}
