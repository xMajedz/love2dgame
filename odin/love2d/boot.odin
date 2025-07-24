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

bootInit :: proc(config: Config)
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

bootStepScene :: proc (scene: ^Scene)
{
	MouseSetPreviousPosition(MouseGetX(), MouseGetY())

	EventPoll()

	TimerStep()

	MouseSetScroll(EventGetScrollValue())

	EventHandleScene(scene)
}

bootStepNoScene :: proc ()
{
	scene: Scene = NoScene
	bootStepScene(&scene)
}

bootStep :: proc {bootStepNoScene, bootStepScene}

bootShouldQuit :: proc () -> bool
{
	return quit_event_flag
}

bootQuit :: proc ()
{
	EventQuit()
}

bootShutdown :: proc ()
{
	MathClose()
}

bootLoop :: proc (config: Config, scene: ^Scene)
{
	SceneInvokeLoad(scene)

	for !bootShouldQuit() {
		bootStep(scene)

		SceneInvokeUpdate(scene, TimerGetDelta())

		if GraphicsIsActive() {
			GraphicsClear(GraphicsGetBackgroundColor())
			GraphicsOrigin()

			SceneInvokeDraw(scene)

			GraphicsPresent()
			
		}

		if TimerIsLimitMaxFPS() {
			TimerSleepByMaxFPS()
		} else {
			TimerSleep(0.001)
		}
	}

	bootShutdown()
}

bootDefault :: proc (config: Config, scene: ^Scene)
{
	bootInit(config)
	bootLoop(config, scene)
}

bootScene :: proc (scene: ^Scene)
{
	bootDefault(DefaultConfig, scene)
}

boot :: proc {bootDefault, bootScene}
