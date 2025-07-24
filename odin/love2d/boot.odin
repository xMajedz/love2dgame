package love2d

boot_init_flag: bool = false

Config :: struct
{
	WindowWidth: int,
	WindowHeight: int,
	WindowTitle: cstring,
	WindowBorderless: bool,
	WindowResizable: bool,
	WindowMinWidth : int,
	WindowMinHeight: int,
	WindowFullscreenType: FullscreenType,
	WindowFullscreen: bool,
	WindowVsync: bool,
	WindowMSAA: int,
	WindowDisplay: int,
	WindowCentered: bool,
	WindowHighDPI: bool,
	WindowX, WindowY: int,
	DefaultRandomSeed: int,
}

NoConfig :: Config {}

DefaultConfig :: Config {
	WindowTitle = "Untitiled",
	WindowWidth = 800,
	WindowHeight = 600,
	WindowFullscreenType = FullscreenType.Desktop,
	WindowFullscreen = false,
	WindowBorderless = false,
	WindowResizable = false,
	WindowMinWidth = 1,
	WindowMinHeight = 1,
	WindowVsync = true,
	WindowMSAA = 0,
	WindowDisplay = 1,
	WindowCentered = true,
	WindowHighDPI = false,
	DefaultRandomSeed = 0,
}

newConfig :: proc() -> Config {
	return DefaultConfig
}

BootInit :: proc(config: Config)
{
	if !boot_init_flag {
		cfg := config
		if cfg == NoConfig {
			cfg = DefaultConfig
		}

		MathInit(cfg.DefaultRandomSeed)

		FilesystemInit()

		TimerInit()
		EventInit()
		KeyboardInit()
		JoystickInit()
		MouseInit()
		TouchInit()
		//SoundInit()

		AudioInit()
		FontInit()
		ImageInit()
		VideoInit()
		WindowInit()
		GraphicsInit()
		SystemInit()

		WindowSetTitle(cfg.WindowTitle)
		
		settings: WindowSettings

		settings.WindowFullscreenType = cfg.WindowFullscreenType

		settings.Fullscreen = cfg.WindowFullscreen
		settings.Vsync = cfg.WindowVsync
		settings.MSAA = cfg.WindowMSAA
		settings.Resizable = cfg.WindowResizable
		settings.MinWidth = cfg.WindowMinWidth
		settings.MinHeight = cfg.WindowMinHeight
		settings.Borderless = cfg.WindowBorderless
		settings.Centered = cfg.WindowCentered
		settings.Display = cfg.WindowDisplay
		settings.HighDPI = cfg.WindowHighDPI

		settings.X = cfg.WindowX
		settings.Y = cfg.WindowY

		WindowSetMode(cfg.WindowWidth, cfg.WindowHeight, settings)

		boot_init_flag = true
	}
}


genScene :: proc () -> Scene
{
	return Scene {}
}

stepConfig :: struct
{
	genScene: type_of(genScene),
}

BootStepScene :: proc (scene: Scene)
{
	MouseSetPreviousPosition(MouseGetX(), MouseGetY())

	EventPoll()

	TimerStep()
	MouseStep()
	//KeyboardStep()
	//JoystickStep()
	//FPScounterStep()

	MouseSetScroll(EventGetScrollValue())

	EventHandleScene(scene)
}

BootStepConfig :: proc (config: stepConfig)
{
	cfg := config
	cfg.genScene = genScene
	BootStepScene(cfg.genScene())
}

BootStepDefault :: proc ()
{
	BootStepScene(NoScene)
}

BootStep :: proc {BootStepDefault, BootStepConfig, BootStepScene}

BootShouldQuit :: proc () -> bool
{
	return quit_event_flag
}

BootQuit :: proc ()
{
	EventQuit()
}

BootShutdown :: proc ()
{
	MathClose()
}

BootLoop :: proc (config: Config, scene: Scene)
{
	scene.invokeLoad()

	TimerStep()

	for !BootShouldQuit() {
		BootStep(scene)

		scene.invokeUpdate(TimerGetDelta())

		if GraphicsIsActive() {
			GraphicsClear(GraphicsGetBackgroundColor())
			GraphicsOrigin()

			scene.invokeDraw()

			GraphicsPresent()
			
		}

		if TimerIsLimitMaxFPS() {
			TimerSleepByMaxFPS()
		} else {
			TimerSleep(0.001)
		}
	}

	BootShutdown()
}

BootDefault :: proc (config: Config, scene: Scene)
{
	BootInit(config)
	BootLoop(config, scene)
}

BootScene :: proc (scene: Scene)
{
	config: Config = newConfig()
	BootDefault(config, scene)
}

Boot :: proc {BootDefault, BootScene}
