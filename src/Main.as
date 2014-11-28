package
{
	import flash.display.Sprite;
	
	import ru.alexli.trading.App;
	
	[SWF(frameRate="32", width="800", height="600", backgroundColor="#FFFFFF")]
	public class Main extends Sprite
	{
		public function Main()
		{
			addChild(App.instance);
		}
	}
}