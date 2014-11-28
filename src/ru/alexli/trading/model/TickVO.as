package ru.alexli.trading.model
{
	import flash.utils.ByteArray;
	
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
			
			time = ba.readDouble();
			bid = ba.readDouble();
			ask = ba.readDouble();
			last = ba.readDouble();
			volume = ba.readDouble();
		}
	}
}