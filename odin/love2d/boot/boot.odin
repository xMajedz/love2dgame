package boot

import "../common"
import "../scene"
import "../timer"
import "../window"
import "../graphics"
import "../event"
import "../mouse"

import "core:fmt"

initFlag: bool = false

Config :: struct {
	WindowWidth: int,
	WindowHeight: int,
	WindowTitle: cstring,
	WindowBorderless: bool,
	WindowResizable: bool,
	WindowMinWidth : int,
	WindowMinHeight: int,
	WindowFullscreenType: common.FullscreenType,
	WindowFullscreen: bool,
	WindowVsync: bool,
	WindowMSAA: int,
	WindowDisplay: int,
	WindowCentered: bool,
	WindowHighDPI: bool,
	WindowX, WindowY: int,
	DefaultRandomSeed: int,
}

newConfig :: proc() -> Config {
	return Config {
		WindowTitle = "No Title",
		WindowWidth = 800,
		WindowHeight = 600,
		WindowFullscreenType = common.FullscreenType.Desktop,
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
	}
}

init :: proc(config: Config) {
	if initFlag == false {
		initFlag = true
		cfg := config
		if (config == Config{}) {
			cfg = newConfig()
		}

		//mathf.init()

		//filesystem.init("")

		timer.init()
		event.init()
		//keyboard.init()
		//joystick.init()
		mouse.init()
		//touch.init()
		//sound.init()

		//audio.init()
		//font.init()
		//image.init()
		//video.init()
		window.init()
		graphics.init()
		//special.init()

		if cfg.WindowTitle != "" {
			window.setTitle(cfg.WindowTitle)
		}
		
		settings: window.Settings = window.newSettings()
                settings.FullscreenType = cfg.WindowFullscreenType
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
                if cfg.WindowX != 0 { settings.X = cfg.WindowX }
                if cfg.WindowY != 0 { settings.Y = cfg.WindowY }
                window.setMode(cfg.WindowWidth, cfg.WindowHeight, settings)

                //filesystem.setSource(environment.currentDirectory);
	}
}

stepConfig :: struct {
	genScene: proc () -> scene.Scene,
}

genScene :: proc () -> scene.Scene {
	return scene.Scene {}
}

step_Scene :: proc (scene: scene.Scene) {
	mouse.setPreviousPosition(mouse.getX(), mouse.getY())
	box := event.newQueueBox()
	for event.poll(box) {}

	timer.step()
	mouse.step()
	//keyboard.step()
	//joystick.step()
	//FPScounter.step()

	scrollX, scrollY := box.getScrollValue()
	mouse.setScrollX(scrollX)
	mouse.setScrollY(scrollY)

	box.sceneHandleEvent(scene)
}

step_config :: proc (config: stepConfig) {
	cfg := config
	cfg.genScene = genScene
	step_Scene(cfg.genScene())
}

step_default :: proc () {
	step_Scene(scene.new())
}

step :: proc {step_default, step_config, step_Scene}

should_quit :: proc () -> bool {
	return event.quitFlag
}

quit :: proc () {
	event.quitFlag = true
}

loop :: proc (config: Config, scene: scene.Scene) {
	scene.invokeLoad()
	timer.step()

	for !should_quit() {
		step(scene)

		scene.invokeUpdate(timer.getDelta())

		if graphics.isActive() {
			r, g, b, a := graphics.getBackgroundColor()
			graphics.clear(r, g, b, a)
			graphics.origin()
			scene.invokeDraw()
			graphics.present()
			
		}

		if timer.isLimitMaxFPS() {
			timer.sleepByMaxFPS()
		} else {
			timer.sleep(0.001)
		}
	}
}

run_default :: proc (config: Config, scene: scene.Scene) {
	init(config)
	loop(config, scene)
}

run_missing_bootconfig :: proc (scene: scene.Scene) {
	config: Config = newConfig()
	init(config)
	loop(config, scene)
}

run :: proc {run_default, run_missing_bootconfig}

