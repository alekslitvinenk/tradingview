package ru.alexli.trading.events
{
	import flash.events.Event;
	
	import ru.alexli.trading.model.TickVO;
	
	public class TickEvent extends Event
	{
		public static const TICK:String = "tick";
		
		public var tick:TickVO;
		
		public function TickEvent(type:String, tick:TickVO = null)
		{
			this.tick = tick;
			
			super(type, false, false);
		}
		
		override public function clone():Event
		{
			return new TickEvent(TICK, tick);
		}
	}
}