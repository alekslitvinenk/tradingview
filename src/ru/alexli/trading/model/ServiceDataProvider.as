package ru.alexli.trading.model
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	import flash.utils.Timer;
	
	import ru.alexli.fcake.utils.TimerUtil;

	public class ServiceDataProvider
	{
		private var timer:Timer;
		
		private var stream:FileStream;
		
		public function ServiceDataProvider()
		{
			init();
		}
		
		private function init():void
		{
			var f:File = File.desktopDirectory.resolvePath("test.dat");
			
			if(f.exists)
			{
				trace("file exists");
				
				stream = new FileStream();
				stream.open(f, FileMode.READ);
				
				trace("bytes available:", stream.bytesAvailable);
				trace("bytes endian:", stream.endian);
			}
			
			timer = TimerUtil.getTicker();
			timer.addEventListener(TimerEvent.TIMER, onTimer);
		}
		
		//events
		private function onTimer(evt:Event):void
		{
			var ba:ByteArray = new ByteArray();
			
			stream.readBytes(ba, 0, 40);
			
			var tick:TickVO = new TickVO(ba);
			
			trace("timer: ", tick.bid);
		}
	}
}