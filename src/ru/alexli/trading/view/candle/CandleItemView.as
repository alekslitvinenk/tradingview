package ru.alexli.trading.view.candle
{
	import flash.display.Graphics;
	import flash.display.Shape;
	
	import ru.alexli.fcake.view.AbstractItemRenderer;
	import ru.alexli.trading.model.TickVO;
	
	public class CandleItemView extends AbstractItemRenderer
	{
		private var high:Number;
		private var low:Number;
		private var open:Number;
		private var close:Number;
		
		private var shadow:Shape;
		private var candle:Shape;
		
		public function CandleItemView(data:Object=null)
		{
			super(data);
		}
		
		override protected function init():void
		{
			addChild(shadow = new Shape());
			addChild(candle = new Shape());
			
			super.init();
		}
		
		override protected function commitData():void
		{
			var tick:TickVO = _data as TickVO;
			
			if(tick)
			{
				if(isNaN(open))
				{
					open = close = high = low = tick.ask;
				}else
				{
					close 	= tick.ask;
					high 	= (close > high) ? close : high; 
					low 	= (close < low) ? close : low; 
				}
			}
			
			draw();
		}
		
		private function draw():void
		{
			var h:Number = (open - high) * 100000;
			var l:Number  = (open - low) * 100000;
			var o:Number = 0;
			var c:Number = (open - close) * 100000;
			
			var s:Graphics = shadow.graphics;
			s.clear();
			s.lineStyle(1);
			s.moveTo(5, h);
			s.lineTo(5, l);
			
			var color:uint = (c <= o) ? 0x00FF00 : 0xFF0000;
			
			var g:Graphics = candle.graphics;
			g.clear();
			g.lineStyle(1);
			g.beginFill(color);
			g.drawRect(0, o, 10, c);
			g.endFill();
		}
	}
}