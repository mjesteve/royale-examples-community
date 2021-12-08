////////////////////////////////////////////////////////////////////////////////
//
//  Licensed to the Apache Software Foundation (ASF) under one or more
//  contributor license agreements.  See the NOTICE file distributed with
//  this work for additional information regarding copyright ownership.
//  The ASF licenses this file to You under the Apache License, Version 2.0
//  (the "License"); you may not use this file except in compliance with
//  the License.  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
////////////////////////////////////////////////////////////////////////////////
package
{
    
    /**
     *  @private
     *  This class is used to link additional classes into jewel.swc
     *  beyond those that are found by dependecy analysis starting
     *  from the classes specified in manifest.xml.
     * 
     *  If the class need to be used in MXML please add only to manifest.xml
     */
    internal class ComponentsClasses
    {
        // Add here classes for all platforms
        // import package.ClassName; ClassName;

        // Add here classes for the JS platform
        // COMPILE::JS
	    // {
        // import package.ClassName; ClassName;
        // }
        
        // Add here classes for the SWF platform
        // COMPILE::SWF
	    // {
        // import package.ClassName; ClassName;
        // }
        
        import org.apache.royale.community.controls.ComboBoxJwExt; ComboBoxJwExt;
        import org.apache.royale.community.controls.VirtualComboBoxJwExt; VirtualComboBoxJwExt;

        import org.apache.royale.community.jewel.beads.models.ComboBoxModelJwExt; ComboBoxModelJwExt;
        import org.apache.royale.community.jewel.beads.models.ComboBoxByFieldModel; ComboBoxByFieldModel;
        import org.apache.royale.community.beads.models.ISelectionByFieldModel;ISelectionByFieldModel;
        import org.apache.royale.community.jewel.beads.controllers.ComboBoxControllerJwExt; ComboBoxControllerJwExt;
        import org.apache.royale.community.itemRenderers.LabelTruncateItemRenderer;LabelTruncateItemRenderer;
        //Temporal
        import org.apache.royale.community.jewel.beads.controls.combobox.SearchFilterJwExt; SearchFilterJwExt;

        import org.apache.royale.community.controls.ListJwExt; ListJwExt;
        import org.apache.royale.community.jewel.beads.views.ListViewJwExt; ListViewJwExt;
        import org.apache.royale.community.jewel.beads.controllers.ListSingleSelectionMouseControllerJwExt; ListSingleSelectionMouseControllerJwExt;
        import org.apache.royale.community.jewel.beads.models.ArrayListSelectionModelJwExt; ArrayListSelectionModelJwExt;
        import org.apache.royale.community.jewel.beads.itemRenderers.ListItemRendererPropertiesBead; ListItemRendererPropertiesBead;
        import org.apache.royale.community.itemRenderers.ListItemRendererProperties; ListItemRendererProperties;

        import org.apache.royale.community.jewel.beads.controls.datagrid.SearchFilterForDataGrid; SearchFilterForDataGrid;

        import org.apache.royale.community.beads.models.PageNavigatorButtonBarModel;PageNavigatorButtonBarModel;
        import org.apache.royale.community.jewel.beads.controls.list.PageNavigatorList; PageNavigatorList;
        import org.apache.royale.community.vo.PageNavigatorButtonBarVO;PageNavigatorButtonBarVO;

        import org.apache.royale.community.beads.controls.tricheckbox.TriCheckBoxLabelByValue;TriCheckBoxLabelByValue;
        import org.apache.royale.community.jewel.beads.ClipImageJwExt;ClipImageJwExt;
        import org.apache.royale.community.jewel.beads.controls.DisabledToolTip; DisabledToolTip;
        import org.apache.royale.community.jewel.beads.layouts.ResponsiveResizeListener; ResponsiveResizeListener;
        import org.apache.royale.community.jewel.GridCell; GridCell;

        import org.apache.royale.community.itemRenderers.PillsListWithLabelItemRenderer; PillsListWithLabelItemRenderer;
        import org.apache.royale.community.events.ITCustomEvent; ITCustomEvent;
        import org.apache.royale.community.vo.PillItemVO; PillItemVO;
        import org.apache.royale.community.jewel.beads.controls.BadgeJwExt; BadgeJwExt;
        import org.apache.royale.community.jewel.beads.controls.BadgeWithMouseClickJwExt; BadgeWithMouseClickJwExt;
        import org.apache.royale.community.beads.ReadOnly; ReadOnly;

        import org.apache.royale.community.events.NavigationEvent; NavigationEvent;
        import org.apache.royale.community.controls.LabelFormWithButtonBar; LabelFormWithButtonBar;

        import org.apache.royale.community.jewel.TriStateCheckBox; TriStateCheckBox;
        import org.apache.royale.community.jewel.beads.controls.tristatecheckbox.TriStateCheckBoxLabelState; TriStateCheckBoxLabelState;
        import org.apache.royale.community.jewel.beads.controls.tristatecheckbox.TriStateCheckBoxStatesValues; TriStateCheckBoxStatesValues;
        import org.apache.royale.community.jewel.beads.controls.combobox.ComboBoxRequireSelection; ComboBoxRequireSelection;
        import org.apache.royale.community.jewel.beads.controls.combobox.ComboBoxReadOnly; ComboBoxReadOnly;
        import org.apache.royale.community.jewel.supportClasses.ISelectableWithIndeterminacy; ISelectableWithIndeterminacy;
    }
}