package ru.alexli.trading.view
{
	import flash.display.Graphics;
	
	import ru.alexli.fcake.view.AbstractVisualObject;
	import ru.alexli.trading.App;
	import ru.alexli.trading.events.TickEvent;
	import ru.alexli.trading.view.candle.CandleItemView;
	
	public class ChartView extends AbstractVisualObject
	{
		private var app:App = App.instance;
		
		private var candle:CandleItemView;
		
		public function ChartView()
		{
			super();
		}
		
		override protected function init():void
		{
			addChild(candle = new CandleItemView());
			
			var g:Graphics = this.graphics;
			g.lineStyle(1, 0x999999);
			g.lineTo(800, 0);
			
			app.service.addEventListener(TickEvent.TICK, onTickEvent);
			
			super.init();
		}
		
		//events
		private function onTickEvent(evt:TickEvent):void
		{
			candle.data = evt.tick;
		}
	}
}