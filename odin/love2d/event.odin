package love2d

import "core:c"
import "core:fmt"

quit_event_flag: bool

EventData :: struct
{
	type: EventType, 
	key: KeyConstant,
	scancode: Scancode,
	//joystick = null;
	//direction = JoystickHat.Centered;
	//gamepadButton = GamepadButton.A;
	//gamepadAxis = GamepadAxis.LeftX;
	text: string,
	flag: bool,
	fx, fy, fz, fw, fp: f32,
	idx, idy, lid: i32,
}

newEventData :: proc (t: EventType) -> EventData
{
	return EventData {
		type = t,
		key = KeyConstant.Unknown,
		scancode = Scancode.Unknow,
		//joystick = null,
		//direction = JoystickHat.Centered,
		//gamepadButton = GamepadButton.A,
		//gamepadAxis = GamepadAxis.LeftX,
		//text = null,
		flag = false,
		fx = 0,
		fy = 0,
		fz = 0,
		fw = 0,
		fp = 0,
		idx = 0,
		idy = 0,
		lid = 0,
	}
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
	list: ^LinkedList,

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
}

//KeyPressed: proc (key: KeyConstant, scancode: Scancode, repeat: bool),
//KeyReleased: proc (key: KeyConstant , scancode: Scancode),
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

//LowMemory: proc (),
//Quit: proc (),

eq_ptr: ^EventQueue

eq_KeyPressed :: proc (eq: ^EventQueue, key: KeyConstant, scancode: Scancode, repeat: bool)
{
	node := new(Node)
	node.data = newEventData(EventType.KeyPressed)
	node.data.key = key
	node.data.scancode = scancode
	node.data.flag = repeat
	
	list_insert(eq.list, node)
}

eq_KeyReleased :: proc (eq: ^EventQueue, key: KeyConstant, scancode: Scancode)
{
	node := new(Node)
	node.data = newEventData(EventType.KeyReleased)
	node.data.key = key
	node.data.scancode = scancode

	list_insert(eq.list, node)
}

eq_MousePressed :: proc (eq: ^EventQueue, x, y: f32, button: i32, touch: bool)
{
	node := new(Node)
	node.data.fx = x
	node.data.fy = y
	node.data.idx = button
	node.data.flag = touch

	list_insert(eq.list, node)
}

eq_MouseReleased :: proc (eq: ^EventQueue, x, y: f32, button: i32, touch: bool)
{
	node := new(Node)
	node.data.fx = x
	node.data.fy = y
	node.data.idx = button
	node.data.flag = touch

	list_insert(eq.list, node)
}

eq_Quit :: proc (eq: ^EventQueue)
{
	node := new(Node)
	node.data = newEventData(EventType.Quit)

        list_insert(eq.list, node)
}

eq_getScrollValue :: proc (eq: ^EventQueue) -> (i32, i32)
{
	x, y : i32 = 0, 0
	return x, y
}

eq_HandleScene :: proc (eq: ^EventQueue, scene: Scene)
{
	for 0 < eq.list.count {
		e := eq.list.head.data
		#partial switch e.type {
			case EventType.Unknow:
			case EventType.Quit:
				scene.invokeQuit()
				EventQuit()
			case:
		}

		list_pop_head(eq.list)
	}

	eq_Destroy(eq)
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

	switch eq.event_type
	{
	case WRAP_KEY:
		key := cast(KeyConstant)eq.enum1
		code := cast(Scancode)eq.enum2
		repeat := eq.bool
		down_or_up := eq.down_or_up
		if down_or_up {
			eq_KeyPressed(eq, key, code, repeat)
		} else {
			eq_KeyReleased(eq, key, code)
		}
	case WRAP_MOUSE_BUTTON:
		/*x := cast(f32)eq.bool
		y := cast(f32)eq.bool
		idx := cast(i32)eq.bool
		touch := cast(bool)eq.bool
		down_or_up := cast(bool)eq.down_or_up
		if down_or_up {
			eq_MousePressed(eq, x, y, idx, touch)
		} else {
			eq_MouseReleased(eq, x, y, idx, touch)
		}*/
	case WRAP_MOUSE_MOTION:
	case WRAP_MOUSE_WHEEL:

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
		eq_Quit(eq)
	case WRAP_UNKNOW:
	}

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

	eq.idx = cast(i32)out_idx
	eq.enum1 = cast(i32)out_enum1
	eq.enum2 = cast(i32)out_enum2

	eq.str = cast(WrapString)out_str

	eq.int4 = cast(Int4)out_int4

	eq.float4 = cast(Float4)out_float4

	eq.float_value = cast(f32)out_float_value

	eq.joystick = cast(Joystick)out_joystick

	if eq.has_event {
		eq_Handle(eq)
	}

	return eq.has_event
}

newEventQueue :: proc () -> ^EventQueue
{
	eq: ^EventQueue = new(EventQueue)
	eq.list = new(LinkedList)
	return eq
}

EventGetScrollValue :: proc () -> (i32, i32)
{
	return eq_getScrollValue(eq_ptr)
}

EventHandleScene :: proc (scene: Scene)
{
	eq_HandleScene(eq_ptr, scene)
}

EventPoll :: proc () -> bool
{
	eq_ptr = newEventQueue()

	status: bool = true

	for status {
		status = eq_PollOrWait(eq_ptr, true)
	}

	return status
}

EventWait :: proc ()
{
	eq_ptr = newEventQueue()
	eq_PollOrWait(eq_ptr, true)
}
