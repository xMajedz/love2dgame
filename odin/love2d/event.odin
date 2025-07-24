package love2d

import "core:c"

quit_event_flag: bool

EventData :: struct
{
	type: EventType, 
	key: KeyConstant,
	scancode: Scancode,
	text: cstring,
	flag: bool,
	fx, fy, fz, fw, fp: f32,
	idx, idy, lid: i32,

	joystick: Joystick,
	direction: JoystickHat,
	gamepadButton: GamepadButton,
	gamepadAxis: GamepadAxis,
}

EventInit :: proc () -> bool
{
	quit_event_flag = false
	return cast(bool)event_open_love_event()
}

EventQuit :: proc ()
{
	quit_event_flag = true
}

EventQueue :: struct
{
	list: ^LinkedList(EventData),

	has_event, down_or_up, bool: bool,

	event_type: WrapEventType,

	idx, enum1, enum2: i32,
	string: WrapString,
	int4: Int4,
	float4: Float4,
	float_value: f32,
	joystick: Joystick,
	str: WrapString,
	joystick_ptr: i32,

	scroll_x, scroll_y: i32,
}

//MousePressed: proc (x, y: f32, button: i32, touch: bool),
//MouseReleased: proc (x, y: f32, button: i32, touch: bool),
//MouseFocus: proc (focus: bool),
//MouseMoved: proc (x, y, dx, dy: f32, touch: bool),
//WheelMoved: proc (x, y: i32),
//JoystickPressed: proc (Joystick joystick, int button),
//JoystickReleased: proc (Joystick joystick, int button),
//JoystickAxis: proc (Joystick joystick, float axis, float value),
//JoystickHat: proc (Joystick joystick, int hat, JoystickHat direction),
//JoystickGamepadPressed: proc (Joystick joystick, GamepadButton button),
//JoystickGamepadReleased: proc (Joystick joystick, GamepadButton button),
//JoystickGamepadAxis: proc (Joystick joystick, GamepadAxis axis, float value),
//JoystickAdded: proc (Joystick joystick),
//JoystickRemoved: proc (Joystick joystick),
//TouchPressed: proc (id: c.long, x, y, dx, dy, pressure: f32),
//TouchReleased: proc (id: c.long, x, y, dx, dy, pressure: f32),
//TouchMoved: proc (id: c.long, x, y, dx, dy, pressure: f32),
//TextEditing: proc (text: string, start,  end: i32),
//TextInput: proc (text: string),
//WindowFocus: proc (focus: bool),
//WindowVisible: proc (visible: bool),
//WindowResize: proc (w, h: i32),
//DirectoryDropped: proc (path: string),
//FileDropped: proc (filePath: string),

eq_ptr: ^EventQueue

eq_GetScrollValue :: proc (eq: ^EventQueue) -> (i32, i32)
{
	return eq.scroll_x, eq.scroll_y
}

eq_HandleScene :: proc (eq: ^EventQueue, scene: ^Scene)
{
	defer eq_Destroy(eq)

	for 0 < eq.list.count {
		e: EventData = eq.list.head.data
		switch e.type {
		case EventType.KeyPressed:
			SceneInvokeKeyPressed(scene, e.key, e.scancode, e.flag)
		case EventType.KeyReleased:
			SceneInvokeKeyReleased(scene, e.key, e.scancode)
		case EventType.MouseMoved:
			SceneInvokeMouseMoved(scene)
		case EventType.MousePressed:
			SceneInvokeMousePressed(scene)
		case EventType.MouseReleased:
			SceneInvokeMouseReleased(scene)
		case EventType.MouseFocus:
			SceneInvokeMouseFocus(scene)
		case EventType.WheelMoved:
			SceneInvokeWheelMoved(scene)
		case EventType.JoystickPressed:
			SceneInvokeJoystickPressed(scene)
		case EventType.JoystickReleased:
			SceneInvokeJoystickReleased(scene)
		case EventType.JoystickAxis:
			SceneInvokeJoystickAxis(scene)
		case EventType.JoystickHat:
			SceneInvokeJoystickHat(scene)
		case EventType.JoystickGamepadPressed:
			SceneInvokeJoystickGamepadPressed(scene)
		case EventType.JoystickGamepadReleased:
			SceneInvokeJoystickGamepadReleased(scene)
		case EventType.JoystickGamepadAxis:
			SceneInvokeJoystickGamepadAxis(scene)
		case EventType.JoystickAdded:
			SceneInvokeJoystickAdded(scene)
		case EventType.JoystickRemoved:
			SceneInvokeJoystickRemoved(scene)
		case EventType.TouchMoved:
			SceneInvokeTouchMoved(scene)
		case EventType.TouchPressed:
			SceneInvokeTouchPressed(scene)
		case EventType.TouchReleased:
			SceneInvokeTouchReleased(scene)
		case EventType.TextEditing:
			SceneInvokeTextEditing(scene)
		case EventType.TextInput:
			SceneInvokeTextInput(scene)
		case EventType.WindowFocus:
			SceneInvokeWindowFocus(scene)
		case EventType.WindowVisible:
			SceneInvokeWindowVisible(scene)
		case EventType.WindowResize:
			SceneInvokeWindowResize(scene)
		case EventType.DirectoryDropped:
			SceneInvokeDirectoryDropped(scene)
		case EventType.FileDropped:
			SceneInvokeFileDropped(scene)
		case EventType.LowMemory:
			SceneInvokeLowMemory(scene)
		case EventType.Quit:
			SceneInvokeQuit(scene)
			EventQuit()
		case EventType.Unknow:
		}

		list_pop_head(eq.list)
	}
}

eq_Destroy :: proc (eq: ^EventQueue)
{
	free(eq.list)
	free(eq)
	eq_ptr = nil
}

eq_Handle :: proc (eq: ^EventQueue)
{
	using WrapEventType

	ed: EventData

	switch eq.event_type
	{
	case WRAP_KEY:
		if eq.down_or_up {
			ed.type = EventType.KeyPressed
			ed.key = cast(KeyConstant)eq.enum1
			ed.scancode = cast(Scancode)eq.enum2
			ed.flag = eq.bool
	
		} else {
			ed.type = EventType.KeyReleased
			ed.key = cast(KeyConstant)eq.enum1
			ed.scancode = cast(Scancode)eq.enum2
		}
	case WRAP_MOUSE_BUTTON:
		if eq.down_or_up {
			ed.type = EventType.MousePressed
			ed.fx = eq.float4.(Vector4f).x
			ed.fy = eq.float4.(Vector4f).y
			ed.idx = eq.idx
			ed.flag = eq.bool
		} else {
			ed.type = EventType.MouseReleased
			ed.fx = eq.float4.(Vector4f).x
			ed.fy = eq.float4.(Vector4f).y
			ed.idx = eq.idx
			ed.flag = eq.bool
		}
	case WRAP_MOUSE_MOTION:
		ed.type = EventType.MouseMoved
		ed.fx = eq.float4.(Vector4f).x
		ed.fy = eq.float4.(Vector4f).y
		ed.fz = eq.float4.(Vector4f).z
		ed.fw = eq.float4.(Vector4f).w
		ed.flag = eq.bool
	case WRAP_MOUSE_WHEEL:
		eq.scroll_x = eq.int4.(Vector4i).x
		eq.scroll_y = eq.int4.(Vector4i).y
		ed.type = EventType.MouseMoved
		ed.idx = eq.int4.(Vector4i).x
		ed.idy = eq.int4.(Vector4i).y
		ed.flag = eq.bool
	case WRAP_TOUCH_MOVED:
	case WRAP_TOUCH_PRESSED:
	case WRAP_TOUCH_RELEASED:

	case WRAP_JOYSTICK_BUTTON:
	case WRAP_JOYSTICK_AXIS_MOTION:
	case WRAP_JOYSTICK_HAT_MOTION:
	case WRAP_JOYSTICK_CONTROLLER_BUTTON:
	case WRAP_JOYSTICK_CONTROLLER_AXIS_MOTION:
	case WRAP_JOYSTICK_DEVICE_ADDED_OR_REMOVED:

	case WRAP_TEXTINPUT:
	case WRAP_TEXTEDITING:

	case WRAP_WINDOW_VISIBLE:
	case WRAP_WINDOW_ENTER_OR_LEAVE:
	case WRAP_WINDOW_SHOWN_OR_HIDDEN:
	case WRAP_WINDOW_RESIZED:

	case WRAP_FILE_DROPPED:
	case WRAP_DIRECTORY_DROPPED:

	case WRAP_LOWMEMORY:
	case WRAP_QUIT:
		ed.type = EventType.Quit
	case WRAP_UNKNOW:
	}

	list_insert(eq.list, ed)
}

eq_PollOrWait :: proc (eq: ^EventQueue, poll_or_wait: bool) -> bool
{
	out_has_event, out_down_or_up, out_bool: bool4
	out_event_type, out_idx, out_enum1, out_enum2: i32
	out_string: WrapString
	out_int4: Int4
	out_float4: Float4 
	out_float_value: f32 
	out_joystick: Joystick
	out_str: WrapString
	out_joystick_ptr: i32

	if poll_or_wait {
		event_poll(
			&out_has_event,
			&out_event_type,
			&out_down_or_up,
			&out_bool,
			&out_idx,
			&out_enum1,
			&out_enum2,
			&out_str,
			&out_int4,
			&out_float4,
			&out_float_value,
			&out_joystick
		)
	} else {
		event_wait(
			&out_has_event,
			&out_event_type,
			&out_down_or_up,
			&out_bool,
			&out_idx,
			&out_enum1,
			&out_enum2,
			&out_str,
			&out_int4,
			&out_float4,
			&out_float_value,
			&out_joystick
		)
	}

	eq.has_event = cast(bool)out_has_event
	eq.down_or_up = cast(bool)out_down_or_up
	eq.bool = cast(bool)out_bool

	eq.event_type = cast(WrapEventType)out_event_type

	eq.idx = out_idx
	eq.enum1 = out_enum1
	eq.enum2 = out_enum2
	eq.str = out_str
	eq.int4 = out_int4
	eq.float4 = out_float4
	eq.float_value = out_float_value
	eq.joystick = out_joystick

	if eq.has_event {
		eq_Handle(eq)
	}

	return eq.has_event
}

newEventQueue :: proc () -> ^EventQueue
{
	eq: ^EventQueue = new(EventQueue)
	eq.list = new(LinkedList(EventData))
	return eq
}

EventGetScrollValue :: proc () -> (i32, i32)
{
	return eq_GetScrollValue(eq_ptr)
}

EventHandleScene :: proc (scene: ^Scene)
{
	eq_HandleScene(eq_ptr, scene)
}

EventPoll :: proc ()
{
	eq_ptr = newEventQueue()

	for eq_PollOrWait(eq_ptr, true) {}
}

EventWait :: proc ()
{
	eq_ptr = newEventQueue()
	eq_PollOrWait(eq_ptr, true)
}
