package love2d

Scene :: struct
{
	keyPressed: proc (key: KeyConstant, code: Scancode, repeat: bool),
	keyReleased: proc (key: KeyConstant, code: Scancode),
	mouseMoved:  proc (),
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
	textEditing: proc (),
	textInput: proc (),
	windowFocus: proc (),
	windowVisible: proc (),
	windowResize: proc (),
	directoryDropped: proc (),
	fileDropped: proc (),
	lowMemory: proc (),
	quit: proc (),

	load: proc (),
	update: proc (dt: f32),
	draw: proc (),
}

NoScene :: Scene {}

SceneInvokeKeyPressed :: proc (scene: ^Scene, key: KeyConstant, code: Scancode, repeat: bool)
{
	if scene != nil && scene.keyPressed != nil { scene.keyPressed(key, code, repeat) }
}

SceneInvokeKeyReleased :: proc (scene: ^Scene, key: KeyConstant, code: Scancode)
{
	if scene != nil && scene.keyReleased != nil { scene.keyReleased(key, code) }
}

SceneInvokeMouseMoved ::  proc (scene: ^Scene)
{
	if scene != nil && scene.mouseMoved != nil { scene.mouseMoved() }
}

SceneInvokeMousePressed :: proc (scene: ^Scene)
{
	if scene != nil && scene.mousePressed != nil { scene.mousePressed() }
}

SceneInvokeMouseReleased :: proc (scene: ^Scene)
{
	if scene != nil && scene.mouseReleased != nil { scene.mouseReleased() }
}

SceneInvokeMouseFocus :: proc (scene: ^Scene)
{
	if scene != nil && scene.mouseFocus != nil { scene.mouseFocus() }
}

SceneInvokeWheelMoved :: proc (scene: ^Scene)
{
	if scene != nil && scene.wheelMoved != nil { scene.wheelMoved() }
}

SceneInvokeJoystickPressed :: proc (scene: ^Scene)
{
}

SceneInvokeJoystickReleased :: proc (scene: ^Scene)
{
}

SceneInvokeJoystickAxis :: proc (scene: ^Scene)
{
}

SceneInvokeJoystickHat :: proc (scene: ^Scene)
{
}

SceneInvokeJoystickGamepadPressed :: proc (scene: ^Scene)
{
}

SceneInvokeJoystickGamepadReleased :: proc (scene: ^Scene)
{
}

SceneInvokeJoystickGamepadAxis :: proc (scene: ^Scene)
{
}

SceneInvokeJoystickAdded :: proc (scene: ^Scene)
{
}

SceneInvokeJoystickRemoved :: proc (scene: ^Scene)
{
}

SceneInvokeTouchMoved :: proc (scene: ^Scene)
{
}

SceneInvokeTouchPressed :: proc (scene: ^Scene)
{
}

SceneInvokeTouchReleased :: proc (scene: ^Scene)
{
}

SceneInvokeTextEditing :: proc (scene: ^Scene)
{
}

SceneInvokeTextInput :: proc (scene: ^Scene)
{
}

SceneInvokeWindowFocus :: proc (scene: ^Scene)
{
}

SceneInvokeWindowVisible :: proc (scene: ^Scene)
{
}

SceneInvokeWindowResize :: proc (scene: ^Scene)
{
}

SceneInvokeDirectoryDropped :: proc (scene: ^Scene)
{
}

SceneInvokeFileDropped :: proc (scene: ^Scene)
{
}

SceneInvokeLowMemory :: proc (scene: ^Scene)
{
}

SceneInvokeQuit :: proc (scene: ^Scene)
{
	if scene != nil && scene.quit != nil { scene.quit() }
}
	
SceneInvokeLoad :: proc (scene: ^Scene)
{
	if scene != nil && scene.load != nil { scene.load() }
}

SceneInvokeUpdate :: proc (scene: ^Scene, dt: f32)
{
	if scene != nil && scene.update != nil { scene.update(dt) }
}

SceneInvokeDraw :: proc (scene: ^Scene)
{
	if scene != nil && scene.draw != nil { scene.draw() }
}
