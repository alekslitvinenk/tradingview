package ru.alexli.trading.model
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	import ru.alexli.fcake.utils.TimerUtil;
	import ru.alexli.fcake.utils.log.Logger;
	import ru.alexli.trading.events.TickEvent;

	[Event(name="tick", type="ru.alexli.trading.events.TickEvent")]
	public class ServiceDataProvider extends EventDispatcher
	{
		private var timer:Timer;
		
		private var stream:FileStream;
		
		private var curTime:Number;
		
		public function ServiceDataProvider()
		{
			init();
		}
		
		private function init():void
		{
			var f:File = File.desktopDirectory.resolvePath("1417435476.dat");
			
			if(f.exists)
			{
				Logger.debug("file exists");
				
				stream = new FileStream();
				stream.open(f, FileMode.READ);
				
				Logger.debug("bytes available:", stream.bytesAvailable);
				Logger.debug("bytes endian:", stream.endian);
			}
		}
		
		public function start():void
		{
			timer = TimerUtil.getTicker();
			timer.addEventListener(TimerEvent.TIMER, onTimer);
			
			dispatchEvent(new TickEvent(TickEvent.TICK, readTick()));
		}
		
		private function readTick():TickVO
		{
			var ba:ByteArray = new ByteArray();
			
			stream.readBytes(ba, 0, 40);
			
			var tick:TickVO = new TickVO(ba);
			
			if(isNaN(curTime))
			{
				curTime = tick.time;
			}
			
			return tick;
		}
		
		//events
		private function onTimer(evt:Event):void
		{
			curTime += 1000;
			
			var time:Number = 0;
			
			var tick:TickVO;
			
			while(time <= curTime)
			{
				tick = readTick();
				
				time = tick.time;
				
				dispatchEvent(new TickEvent(TickEvent.TICK, tick));
			}
		}
	}
}