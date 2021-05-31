package org.apache.royale.community.jscalendar.vo
{

    [Bindable]
    public class DateItemDescribeVO
    {
        public var anyo:Number;
		public var mes:Number;
		public var dia:Number;
		public var date:Date;
		public var selDates:Array;

        public function DateItemDescribeVO(date:Date=null,item:*=null,sDt:Array=null)
		{
			if(date){
				this.date = date;
				this.anyo = date.fullYear;
				this.mes = date.month;
				this.dia = date.date;
				this.selDates = sDt;
			}else 			
			if(item){
				this.anyo = item.anyo;
				this.mes = item.mes;
				this.dia = item.dia;
				this.selDates = item.sDt;
			}

        }
    }
}
