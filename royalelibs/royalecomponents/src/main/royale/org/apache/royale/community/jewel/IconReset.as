package org.apache.royale.community.jewel
{
    import org.apache.royale.icons.FontAwesomeIcon;

    public class IconReset extends FontAwesomeIcon
    {
        public function IconReset()
        {
            super(); 
            className="button-reset";
        }
        /**
         * update font awesome style.
         */
        override public function setUpClassName():void
        {
            addClass('fa-' + FontAwesome5IconType.ERASER);
            //addClass('fa-' + FontAwesomeIcon.SIZE_LG);
            if(v == 5)
                addClass('fa' + FontAwesomeIcon.DUOTONE);
            else
                addClass('fa');
        }


    }
}