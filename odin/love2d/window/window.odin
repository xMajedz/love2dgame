package window

import "../common"
import "core:c"
import love2d_dll ".."

Settings :: struct {
	FullscreenType: common.FullscreenType,
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

ModeSettings :: struct {
	width, height: c.int,
	Fullscreen: c.int,
	FullscreenType: love2d_dll.bool4,
	Vsync: love2d_dll.bool4,
	MSAA: c.int,
	Depth: c.int,
	Stencil: love2d_dll.bool4,
	Resizable: love2d_dll.bool4,
	MinWidth: c.int,
	MinHeight: c.int,
	Centered: love2d_dll.bool4,
	Borderless: love2d_dll.bool4,
	Display: c.int,
	HighDPI: love2d_dll.bool4,
	RefreshRate: c.double,
	UsePosition: love2d_dll.bool4,
	X: c.int,
	Y: c.int,
}

newSettings :: proc () -> Settings {
	return Settings {}
}

init :: proc () -> love2d_dll.bool4 {
	return love2d_dll.windows_open_love_window()
}

setTitle :: proc (title: cstring) {
	love2d_dll.windows_setTitle(title)
}

setMode :: proc (width, height: int, settings: Settings) -> love2d_dll.bool4 {
	mode := ModeSettings {
		width = cast(c.int)width,
		height = cast(c.int)height,
		Fullscreen = cast(c.int)settings.Fullscreen,
		FullscreenType = cast(love2d_dll.bool4)settings.FullscreenType,
		Vsync = cast(love2d_dll.bool4)settings.Vsync,
		MSAA = cast(c.int)settings.MSAA,
		Depth = 1,
		Stencil = 1,
		Resizable = cast(love2d_dll.bool4)settings.Resizable,
		MinWidth = cast(c.int)settings.MinWidth,
		MinHeight = cast(c.int)settings.MinHeight,
		Centered = cast(love2d_dll.bool4)settings.Centered,
		Borderless = cast(love2d_dll.bool4)settings.Borderless,
		Display = cast(c.int)settings.Display,
		HighDPI = cast(love2d_dll.bool4)settings.HighDPI,
		RefreshRate = 60,
		UsePosition = 0,
		X = cast(c.int)settings.X,
		Y = cast(c.int)settings.Y,
	}
	return love2d_dll.windows_setMode_w_h_setting(
		mode.width, mode.height,
		mode.Fullscreen,
		mode.FullscreenType,
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
}
