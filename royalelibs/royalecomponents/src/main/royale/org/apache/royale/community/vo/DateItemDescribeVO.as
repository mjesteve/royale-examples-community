package org.apache.royale.community.vo
{

    [Bindable]
    public class DateItemDescribeVO
    {
        public var year:Number;
		public var month:Number;
		public var day:Number;
		public var date:Date;
		public var selDates:Array;

        public function DateItemDescribeVO(date:Date=null,item:*=null,arSel:Array=null)
		{
			if(date){
				this.date = date;
				this.year = date.fullYear;
				this.month = date.month;
				this.day = date.date;
				this.selDates = arSel;
			}else
			if(item){
				this.year = item.year;
				this.month = item.month;
				this.day = item.day;
				this.selDates = item.arSel;
			}
        }
    }
}
