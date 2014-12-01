package ru.alexli.trading.model
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	public class TickVO
	{
		public var time:Number;
		public var bid:Number;
		public var ask:Number;
		public var last:Number;
		public var volume:Number;
		
		public function TickVO(ba:ByteArray = null)
		{
			if(ba)
			{
				readBytes(ba);
			}
		}
		
		public function readBytes(ba:ByteArray):void
		{
			ba.position = 0;
			
			ba.endian = Endian.LITTLE_ENDIAN;
			
			time = ba.readInt() * 1000;
			ba.readInt();
			
			bid = ba.readDouble();
			ask = ba.readDouble();
			last = ba.readDouble();
			volume = ba.readDouble();
		}
	}
}