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
package org.apache.royale.community.models
{
    import org.apache.royale.collections.ArrayList;
    import org.apache.royale.community.vos.NavigationLinkVO;

    public class MainNavigationModel
    {
        private var _controlsDrawerNavigation:ArrayList = new ArrayList([
            new NavigationLinkVO("Alert", "alert_panel", MaterialIconType.WEB_ASSET),
            new NavigationLinkVO("Button", "button_panel", MaterialIconType.CROP_7_5),
            new NavigationLinkVO("CheckBox", "checkbox_panel", MaterialIconType.CHECK_BOX),
            new NavigationLinkVO("ComboBox", "combobox_panel", MaterialIconType.CREDIT_CARD),
            new NavigationLinkVO("Date Components", "datecomponents_panel", MaterialIconType.DATE_RANGE),
            new NavigationLinkVO("DropDownList", "dropdownlist_panel", MaterialIconType.CREDIT_CARD),
            new NavigationLinkVO("Forms & Validation", "form_validation_panel", MaterialIconType.ASSIGNMENT_TURNED_IN),
            new NavigationLinkVO("Icon", "miscelanea_panel", MaterialIconType.FACE),
            new NavigationLinkVO("Images", "image_panel", MaterialIconType.IMAGE),
            new NavigationLinkVO("Label", "label_panel", MaterialIconType.LABEL),
            new NavigationLinkVO("List", "list_panel", MaterialIconType.LIST_ALT),
            new NavigationLinkVO("Virtual Lists", "virtual_lists_panel", MaterialIconType.LINE_WEIGHT),
            new NavigationLinkVO("NumericStepper", "numericstepper_panel", MaterialIconType.UNFOLD_MORE),
            new NavigationLinkVO("PopUp", "popup_panel", MaterialIconType.FLIP_TO_FRONT),
            new NavigationLinkVO("ProgressBar", "progressloader_panel", MaterialIconType.AUTORENEW),
            new NavigationLinkVO("RadioButton", "radiobutton_panel", MaterialIconType.RADIO_BUTTON_CHECKED),
            new NavigationLinkVO("Slider", "slider_panel", MaterialIconType.STORAGE),
            new NavigationLinkVO("Snackbar", "snackbar_panel", MaterialIconType.VIDEO_LABEL),
            new NavigationLinkVO("Text", "text_panel", MaterialIconType.SUBJECT),
            new NavigationLinkVO("TextInput", "textinput_panel", MaterialIconType.TEXT_FIELDS),
			new NavigationLinkVO("List with ArrayListView", "advanced_list_panel", MaterialIconType.LIST_ALT)
            // new NavigationLinkVO("Menu", "menus_panel"),
            // new NavigationLinkVO("Loading", "loading_panel")
        ]);
        public function get controlsDrawerNavigation():ArrayList
        {
            return _controlsDrawerNavigation;
        }
        // Note: for disable a node add a "true" as a final param on the obejct you want. This is "false" by default
        private var _containerDrawerNavigation:ArrayList = new ArrayList([
            new NavigationLinkVO("Card", "card_panel", MaterialIconType.WEB_ASSET),
            new NavigationLinkVO("Layouts", "layouts_panel", MaterialIconType.VIEW_QUILT),
            new NavigationLinkVO("Grid", "grid_panel", MaterialIconType.GRID_ON),
            new NavigationLinkVO("ButtonBar", "buttonbar_panel", MaterialIconType.VIEW_CAROUSEL),
            new NavigationLinkVO("DataGrid", "datagrid_panel", MaterialIconType.VIEW_LIST),
            new NavigationLinkVO("Tables", "tables_panel", MaterialIconType.VIEW_COMFY),
            new NavigationLinkVO("TabBar", "tabbar_panel", MaterialIconType.TAB),
            new NavigationLinkVO("View States", "viewstates_panel", MaterialIconType.CHORME_READER_MODE),
            new NavigationLinkVO("Wizard", "wizards_panel", MaterialIconType.MOVIE_FILTER)
            // new NavigationLinkVO("Tabs", "tabs_panel")
        ]);

        public function get containerDrawerNavigation():ArrayList
        {
            return _containerDrawerNavigation;
        }
        
        
        private var _collapsibleNavExample:ArrayList;
        public function get collapsibleNavExample():ArrayList {
            if (_collapsibleNavExample) 
                return _collapsibleNavExample;
                
            var item1:NavigationLinkVO = new NavigationLinkVO("No SubMenu", "card_panel", MaterialIconType.FILTER_1);
            var item2:NavigationLinkVO = new NavigationLinkVO("With SubMenu", '$collapsible', MaterialIconType.FILTER_2);
            item2.subMenu = _containerDrawerNavigation;
            _collapsibleNavExample = new ArrayList([item1, item2]);
            
            return _collapsibleNavExample;
        }

        private var _collapsibleNavMainMenu:ArrayList;
        public function get collapsibleNavMainMenu():ArrayList {
            if (_collapsibleNavMainMenu) 
                return _collapsibleNavMainMenu;

            var armenu:Array = new Array();

            var item:NavigationLinkVO = new NavigationLinkVO("AS JS library wrappers", "$collapsible", null,"assets/javascript.svg");
            var arnav:Array = new Array();
            arnav.push(new NavigationLinkVO("Virtual Select", "virtualselect_panel",MaterialIconType.CREDIT_CARD));
            arnav.push(new NavigationLinkVO("JS Calendar", "jscalendar_panel", MaterialIconType.DATE_RANGE));
            arnav.push(new NavigationLinkVO("FullCalendar", "fullcalendar_panel","calendar_view_month"));
            item.subMenu = new ArrayList(arnav);
            armenu.push(item);

            item = new NavigationLinkVO("Jewel custom components", '$collapsible', null,"assets/jewel-only-icon.svg");
            arnav = new Array();
            arnav.push(new NavigationLinkVO("Three Check Box", "threecheckbox_panel",MaterialIconType.CHECK_BOX));
            arnav.push(new NavigationLinkVO("Basic PageNavigator", "Debug_PageNavigator_panel",MaterialIconType.LAST_PAGE));
            arnav.push(new NavigationLinkVO("Combobox extended", "Debug_ComboTODO_panel",MaterialIconType.CREDIT_CARD));
            item.subMenu = new ArrayList(arnav);
            armenu.push(item);

            item = new NavigationLinkVO("Laboratory", '$collapsible', "science");
            arnav = new Array();
            arnav.push(new NavigationLinkVO("Container Resizing", "SizeContainer_panel"));
            arnav.push(new NavigationLinkVO("Badges - Test", "Debug_Pills_panel", "mark_chat_unread"));
            item.subMenu = new ArrayList(arnav);
            armenu.push(item);

            item = new NavigationLinkVO("Laboratory - Debug", '$collapsible', "running_with_errors");
            arnav = new Array();
            arnav.push(new NavigationLinkVO("SearchFilter - ComboBox", "Debug_ComboTODO_Search_panel"));
            item.subMenu = new ArrayList(arnav);
            armenu.push(item);

            _collapsibleNavMainMenu = new ArrayList(armenu);
            
            return _collapsibleNavMainMenu;
        }

    }
}
