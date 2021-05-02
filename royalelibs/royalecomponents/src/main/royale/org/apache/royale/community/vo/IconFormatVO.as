package org.apache.royale.community.vo
{

    [Bindable]
    public class IconFormatVO
    {
        public const PROV_FONTAWESOME:String = "fontawesome";
        public const PROV_MATERIALS:String = "materials";
        public const PROV_IMAGE:String = "image";

        public const VERSION4_FONTAWESOME:String = "4";
        public const VERSION5_FONTAWESOME:String = "5";

        public const STYLE_REGULAR:String = "r";
        public const STYLE_BRANS:String = "b";
        public const STYLE_SOLID:String = "s";
        public const STYLE_DUOTONE:String = "d";
        public const STYLE_LIGHT:String = "l";
                
        public var fontProvider:String = "fontawesome"; 
        public var textIcon:String = "";                //Nombre identificativo del icono
        public var versionPack:String = "5";            //Para fontawesome: 4 | 5
        public var styleIcon:String = "d";              //Para fontawesome: r (Regular) b (Brans) s (Solid) d (Duotone) l (Light)
        public var colorIcon:String = "";

        public function IconFormatVO(){}
    }
}
