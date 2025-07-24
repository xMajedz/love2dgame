package love2d

keyPressed: proc ()
keyReleased: proc ()
mouseMoved:  proc ()
mousePressed: proc ()
mouseReleased: proc ()
mouseFocus: proc ()
wheelMoved: proc ()
joystickPressed: proc ()
joystickReleased: proc ()
joystickAxis: proc ()
joystickHat: proc ()
joystickGamepadPressed: proc ()
joystickGamepadReleased: proc ()
joystickGamepadAxis: proc ()
joystickAdded: proc ()
joystickRemoved: proc ()
touchMoved: proc ()
touchPressed: proc ()
touchReleased: proc ()
textEditing: proc ()
textInput: proc ()
windowFocus: proc ()
windowVisible: proc ()
windowResize: proc ()
directoryDropped: proc ()
fileDropped: proc ()
lowMemory: proc ()
quit: proc ()

load: proc ()
update: proc (dt: f32)
draw: proc ()

invoke_param :: proc ($T: typeid, p: proc(param: T), param: T)
{
	if p != nil { p(param) }
}

invoke_no_param :: proc (p: proc())
{
	if p != nil { p() }
}

invoke :: proc {invoke_no_param, invoke_param}

Scene :: struct
{
	keyPressed: type_of(keyPressed),
	keyReleased: proc (),
	mouseMoved: proc (),
	mousePressed: proc (),
	mouseReleased: proc (),
	mouseFocus: proc (),
	wheelMoved: proc (),
	joystickPressed: proc (),
	joystickReleased: proc (),
	joystickAxis: proc (),
	joystickHat: proc (),
	joystickGamepadPressed: proc (),
	joystickGamepadReleased: proc (),
	joystickGamepadAxis: proc (),
	joystickAdded: proc (),
	joystickRemoved: proc (),
	touchMoved: proc (),
	touchPressed: proc (),
	touchReleased: proc (),
	textEditng: proc (),
	textInput: proc (),
	windowFocus: proc (),
	windowVisible: proc (),
	windowResize: proc (),
	directoryDropped: proc (),
	fileDropped: proc (),
	quit: proc (),
	lowMemory: proc (),
	load: proc (),
	update: proc (dt: f32),
	draw: proc (),

	invokeLoad: proc (),
	invokeUpdate: proc (dt: f32),
	invokeDraw: proc (),
	invokeQuit: proc (),
}

NoScene :: Scene {}

RefScene: ^Scene

NewScene :: proc() -> ^Scene
{
	RefScene.keyPressed = keyPressed
	RefScene.keyReleased = keyReleased
	RefScene.mouseMoved = mouseMoved
	RefScene.mousePressed = mousePressed
	RefScene.mouseReleased = mouseReleased
	RefScene.mouseFocus = mouseFocus
	RefScene.wheelMoved = wheelMoved
	RefScene.joystickPressed = joystickPressed
	RefScene.joystickReleased = joystickReleased
	RefScene.joystickAxis = joystickAxis
	RefScene.joystickHat = joystickHat
	RefScene.joystickGamepadPressed = joystickGamepadPressed
	RefScene.joystickGamepadReleased = joystickGamepadReleased
	RefScene.joystickGamepadAxis = joystickGamepadAxis
	RefScene.joystickAdded = joystickAdded
	RefScene.joystickRemoved = joystickRemoved
	RefScene.touchMoved = touchMoved
	RefScene.touchPressed = touchPressed
	RefScene.touchReleased = touchReleased
	RefScene.textEditng = textEditing
	RefScene.textInput = textInput
	RefScene.windowFocus = windowFocus
	RefScene.windowVisible = windowVisible
	RefScene.windowResize = windowResize
	RefScene.directoryDropped = directoryDropped
	RefScene.fileDropped = fileDropped
	RefScene.quit = quit
	RefScene.lowMemory = lowMemory
	RefScene.load = load
	RefScene.update = update
	RefScene.draw = draw

	RefScene.invokeLoad = proc () { invoke(load) }
	RefScene.invokeUpdate = proc (dt: f32) { invoke(f32, update, dt) }
	RefScene.invokeDraw = proc () { invoke(draw) }
	RefScene.invokeQuit = proc () { invoke(quit) }

	return RefScene
}

GenScene :: proc() -> Scene
{
	return Scene {
		keyPressed = keyPressed,
		keyReleased = keyReleased,
		mouseMoved = mouseMoved,
		mousePressed = mousePressed,
		mouseReleased = mouseReleased,
		mouseFocus = mouseFocus,
		wheelMoved = wheelMoved,
		joystickPressed = joystickPressed,
		joystickReleased = joystickReleased,
		joystickAxis = joystickAxis,
		joystickHat = joystickHat,
		joystickGamepadPressed = joystickGamepadPressed,
		joystickGamepadReleased = joystickGamepadReleased,
		joystickGamepadAxis = joystickGamepadAxis,
		joystickAdded = joystickAdded,
		joystickRemoved = joystickRemoved,
		touchMoved = touchMoved,
		touchPressed = touchPressed,
		touchReleased = touchReleased,
		textEditng = textEditing,
		textInput = textInput,
		windowFocus = windowFocus,
		windowVisible = windowVisible,
		windowResize = windowResize,
		directoryDropped = directoryDropped,
		fileDropped = fileDropped,
		quit = quit,
		lowMemory = lowMemory,
		load = load,
		update = update,
		draw = draw,

		invokeLoad = proc () { invoke(load) },
		invokeUpdate = proc (dt: f32) { invoke(f32, update, dt) },
		invokeDraw = proc () { invoke(draw) },
		invokeQuit = proc () { invoke(quit) }
	}
}
