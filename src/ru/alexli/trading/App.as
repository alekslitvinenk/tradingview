package ru.alexli.trading
{
	import flash.errors.IllegalOperationError;
	
	import ru.alexli.fcake.utils.log.LogLevel;
	import ru.alexli.fcake.utils.log.Logger;
	import ru.alexli.fcake.utils.log.TraceTarget;
	import ru.alexli.fcake.view.AbstractApp;
	import ru.alexli.trading.model.AppModel;
	import ru.alexli.trading.model.ServiceDataProvider;
	
	public class App extends AbstractApp
	{
		public var gmodel:AppModel;
		
		public var service:ServiceDataProvider;
		
		private static var canBeInstantiated:Boolean;
		
		private static var _instance:App;
		
		public static function get instance():App
		{
			if(!_instance)
			{
				canBeInstantiated = true;
				_instance = new App();
			}
			
			return _instance;
		}
		
		public function App()
		{
			if(!canBeInstantiated)
			{
				throw new IllegalOperationError("Error!");
			}
		}
		
		override protected function init():void
		{
			Logger.targets = [new TraceTarget(LogLevel.DEBUG)];
				
			gmodel = new AppModel();
			
			super.init();
		}
		
		override protected function onAppInited():void
		{
			service = new ServiceDataProvider();
		}
	}
}