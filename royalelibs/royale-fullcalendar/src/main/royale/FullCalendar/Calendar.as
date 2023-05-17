package FullCalendar
{
	/**
	 * @externs
	 */
    COMPILE::JS
    public class Calendar
    {
        
		  public function Calendar(el:Element,optionOverrides:Object=null){ }
      
      public function gotoDate(dt:Object):void{ }

      public function getOption(name:String):Object{ return null;}

      public function setOption(name:String, val:Object):void{}
      
      public function render():void{ }

      public function updateSize():void{}

      public function next():void{}

      public function addEvent(eventInput: Object, sourceInput:Object=null):void{};

      public function unselect():void{}
    }
}
