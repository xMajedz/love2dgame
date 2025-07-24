package love2d

WindowSettings :: struct
{
	WindowFullscreenType: FullscreenType,

	Fullscreen: bool,
	Borderless: bool,
	Resizable: bool,
	MinWidth: int,
	MinHeight: int,
	Vsync: bool,
	MSAA: int,
	Display: int,
	Centered: bool,
	HighDPI: bool,
	X: int,
	Y: int,
}

WindowModeSettings :: struct {
	width, height: i32,
	Fullscreen: i32,

	WindowFullscreenType: bool4,

	Vsync: bool4,
	MSAA: i32,
	Depth: i32,
	Stencil: bool4,
	Resizable: bool4,
	MinWidth: i32,
	MinHeight: i32,
	Centered: bool4,
	Borderless: bool4,
	Display: i32,
	HighDPI: bool4,
	RefreshRate: f64,
	UsePosition: bool4,
	X: i32,
	Y: i32,
}

WindowInit :: proc () -> bool
{
	return cast(bool)windows_open_love_window()
}

WindowSetTitle :: proc (title: cstring)
{
	windows_setTitle(title)
}

WindowSetMode :: proc (width, height: int, settings: WindowSettings) -> bool
{
	mode := WindowModeSettings {
		width = cast(i32)width,
		height = cast(i32)height,
		Fullscreen = cast(i32)settings.Fullscreen,
		WindowFullscreenType = cast(bool4)settings.WindowFullscreenType,
		Vsync = cast(bool4)settings.Vsync,
		MSAA = cast(i32)settings.MSAA,
		Depth = 1,
		Stencil = 1,
		Resizable = cast(bool4)settings.Resizable,
		MinWidth = cast(i32)settings.MinWidth,
		MinHeight = cast(i32)settings.MinHeight,
		Centered = cast(bool4)settings.Centered,
		Borderless = cast(bool4)settings.Borderless,
		Display = cast(i32)settings.Display,
		HighDPI = cast(bool4)settings.HighDPI,
		RefreshRate = 60,
		UsePosition = 0,
		X = cast(i32)settings.X,
		Y = cast(i32)settings.Y,
	}

	result := windows_setMode_w_h_setting(
		mode.width, mode.height,
		mode.Fullscreen,
		mode.WindowFullscreenType,
		mode.Vsync,
		mode.MSAA,
		mode.Depth,
		mode.Stencil,
		mode.Resizable,
		mode.MinWidth, mode.MinHeight,
		mode.Borderless,
		mode.Centered,
		mode.Display,
		mode.HighDPI,
		mode.RefreshRate,
		mode.UsePosition,
		mode.X, mode.Y
	) 

	return cast(bool)result
}
