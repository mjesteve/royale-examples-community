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
package org.apache.royale.community.vos
{
    import org.apache.royale.collections.IArrayList;
    
    [Bindable]
    public class NavigationLinkVO
    {
        public var label:String;
        public var hash:String;
        public var icon:String;
        public var img:String;
        public var disabled:Boolean;
        
        //for collapsible example
        public var subMenu:IArrayList;
        public var open:Boolean;
        public var selectedChild:NavigationLinkVO;

        public function NavigationLinkVO(label:String, hash:String, icon:String = null, img:String = null, disabled:Boolean = false)
        {
            this.label = label;
            this.hash = hash;
            this.icon = icon;
            this.img = img;
            this.disabled = disabled;
        }
    }
}