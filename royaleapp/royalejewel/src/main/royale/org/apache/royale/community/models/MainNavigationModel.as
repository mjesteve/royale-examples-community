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
            arnav.push(new NavigationLinkVO("Inspire-Tree", "inspiretree_panel","account_tree"));
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
