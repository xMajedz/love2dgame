package scene

import ".."
import "core:fmt"

Tuple :: struct($First, $Second: typeid) { first: First, second: Second }

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

Scene :: struct {
	KeyPressed: type_of(keyPressed),
	KeyReleased: proc (),
	MouseMoved: proc (),
	MousePressed: proc (),
	MouseReleased: proc (),
	MouseFocus: proc (),
	WheelMoved: proc (),
	JoystickPressed: proc (),
	JoystickReleased: proc (),
	JoystickAxis: proc (),
	JoystickHat: proc (),
	JoystickGamepadPressed: proc (),
	JoystickGamepadReleased: proc (),
	JoystickGamepadAxis: proc (),
	JoystickAdded: proc (),
	JoystickRemoved: proc (),
	TouchMoved: proc (),
	TouchPressed: proc (),
	TouchReleased: proc (),
	TextEditn: proc (),
	TextInput: proc (),
	WindowFocus: proc (),
	WindowVisible: proc (),
	WindowResize: proc (),
	DirectoryDropped: proc (),
	FileDropped: proc (),
	Quit: proc (),
	LowMemory: proc (),
	Load: proc (),
	Update: proc (dt: f32),
	Draw: proc (),

	invokeLoad: proc (),
	invokeUpdate: proc (dt: f32),
	invokeDraw: proc (),
	invokeQuit: proc (),
}

invoke_param :: proc ($T: typeid, p: proc(param: T), param: T) {
	if p != nil { p(param) }
}

invoke_no_param :: proc (p: proc()) {
	if p != nil { p() }
}

invoke :: proc {invoke_no_param, invoke_param}

new :: proc() -> Scene {
	return Scene {
		KeyPressed = keyPressed,
		KeyReleased = keyReleased,
		MouseMoved = mouseMoved,
		MousePressed = mousePressed,
		MouseReleased = mouseReleased,
		MouseFocus = mouseFocus,
		WheelMoved = wheelMoved,
		JoystickPressed = joystickPressed,
		JoystickReleased = joystickReleased,
		JoystickAxis = joystickAxis,
		JoystickHat = joystickHat,
		JoystickGamepadPressed = joystickGamepadPressed,
		JoystickGamepadReleased = joystickGamepadReleased,
		JoystickGamepadAxis = joystickGamepadAxis,
		JoystickAdded = joystickAdded,
		JoystickRemoved = joystickRemoved,
		TouchMoved = touchMoved,
		TouchPressed = touchPressed,
		TouchReleased = touchReleased,
		TextEditn = textEditing,
		TextInput = textInput,
		WindowFocus = windowFocus,
		WindowVisible = windowVisible,
		WindowResize = windowResize,
		DirectoryDropped = directoryDropped,
		FileDropped = fileDropped,
		Quit = quit,
		LowMemory = lowMemory,
		Load = load,
		Update = update,
		Draw = draw,

		invokeLoad = proc () { invoke(load) },
		invokeUpdate = proc (dt: f32) { invoke(f32, update, dt) },
		invokeDraw = proc () { invoke(draw) },

		invokeQuit = proc () { invoke(quit) }
	}
}
