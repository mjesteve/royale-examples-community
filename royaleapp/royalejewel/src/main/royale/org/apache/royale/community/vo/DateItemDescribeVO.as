package org.apache.royale.community.vo
{

    [Bindable]
    public class DateItemDescribeVO
    {
        public var year:Number;
		public var month:Number;
		public var day:Number;
		public var date:Date;
		//public var datetxt:String;
 		//,formatOut:String="d/m/Y")
        public function DateItemDescribeVO(date:Date=null,item:*=null)
		{
			if(date){
				this.date = date;
				this.year = date.fullYear;
				this.month = date.month;
				this.day = date.date;
			}else 			
			if(item){
				this.year = item.year;
				this.month = item.month;
				this.day = item.day;
			}
        }
    }
}
