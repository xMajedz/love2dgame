package event

import love2d_dll ".."
import "../scene"

import "core:c"
import "core:fmt"

Scancode :: enum {
	Unknow,

	A,
	B,
	C,
	D,
	E,
	F,
	G,
	H,
	I,
	J,
	K,
	L,
	M,
	N,
	O,
	P,
	Q,
	R,
	S,
	T,
	U,
	V,
	W,
	X,
	Y,
	Z,

	Number1,
	Number2,
	Number3,
	Number4,
	Number5,
	Number6,
	Number7,
	Number8,
	Number9,
	Number0,

	Return,
	Escape,
	Backspace,
	Tab,
	Space,
	Minus,
	Equals,

	LeftBracket,
	RightBracket,

	Backslash,
	Nonushash,
	Semicolon,
	Apostrophe,
	Grave,
	Comma,
	Period,
	Slash,
	Capslock,


	F1,
	F2,
	F3,
	F4,
	F5,
	F6,
	F7,
	F8,
	F9,
	F10,
	F11,
	F12,

	PrintScreen,
	ScrollLock,
	Pause,
	Insert,
	Home,
	PageUp,
	Delete,
	End,
	PageDown,
	Right,
	Left,
	Down,
	Up,

	NumLockClear,
	KeypadDivide,
	KeypadMultiply,
	KeypadMinus,
	KeypadPlus,
	KeypadEnter,
	Keypad1,
	Keypad2,
	Keypad3,
	Keypad4,
	Keypad5,
	Keypad6,
	Keypad7,
	Keypad8,
	Keypad9,
	Keypad0,
	KeypadPeriod,

	NonusBackslash,
	Application,
	Power,

	KeypadEquals,
	F13,
	F14,
	F15,
	F16,
	F17,
	F18,
	F19,
	F20,
	F21,
	F22,
	F23,
	F24,

	Execute,
	Help,
	Menu,
	Select,
	Stop,
	Again,
	Undo,
	Cut,
	Copy,
	Paste,
	Find,
	Mute,

	VolumeUp,
	VolumeDown,
	KeypadComma,
	KeypadEqualSAS400,

	International1,
	International2,
	International3,
	International4,
	International5,
	International6,
	International7,
	International8,
	International9,
	Lang1,
	Lang2,
	Lang3,
	Lang4,
	Lang5,
	Lang6,
	Lang7,
	Lang8,
	Lang9,

	Alterase,
	Sysreq,
	Cancel,
	Clear,
	Prior,
	Return2,
	Separator,
	Out,
	Oper,
	ClearaAain,
	Crsel,
	Exsel,


	Keypad00,
	Keypad000,

	ThousandsSeparator,
	DecimalSeparator,
	CurrencyUnit,
	CurrencySubunit,

	KeypadLeftParen,
	KeypadRightParen,
	KeypadLeftBrace,
	KeypadRightBrace,
	KeypadTab,
	KeypadBackspace,

	KeypadA,
	KeypadB,
	KeypadC,
	KeypadD,
	KeypadE,
	KeypadF,

	KeypadXOR,
	KeypadPower,
	KeypadPercent,
	KeypadLess,
	KeypadGreater,
	KeypadAmpersand,
	KeypadDblampersand,
	KeypadVerticalBar,
	KeypadDblverticalBar,
	KeypadColon,
	KeypadHash,
	KeypadSpace,
	KeypadAt,
	KeypadExclam,
	KeypadMemstore,
	KeypadMemrecall,
	KeypadMemclear,
	KeypadMemadd,
	KeypadMemsubtract,
	KeypadMemmultiply,
	KeypadMemdivide,
	KeypadPlusminus,
	KeypadClear,
	KeypadClearEntry,
	KeypadBinary,
	KeypadOctal,
	KeypadDecimal,
	KeypadHexaecimal,

	LCtrl,
	LShift,
	LAlt,
	LGUI,
	RCtrl,
	RShift,
	RAlt,
	RGUI,

	Mode,

	AudioNext,
	AudioPrev,
	AudioStop,
	AudioPlay,
	AudioMute,
	MediaSelect,
	WWW,
	Mail,
	Calculator,
	Computer,
	ACSearch,
	ACHome,
	ACBack,
	ACForward,
	ACStop,
	ACRefresh,
	ACBookmarks,

	BrightnessDown,
	BrightnessUp,
	DisplaySwitch,
	KBDILLUMToggle,
	KBDILLUMDown,
	KBDILLUMUp,
	Eject,
	Sleep,

	App1,
	App2,
}
 

KeyConstant :: enum {
	Unknown,
	Return,
	Enter = Return,
	Escape,
	Backspace,
	Tab,
	Space,
	Exclaim,
	Quotedbl,
	Hash,
	Percent,
	Dollar,
	Ampersand,
	Quote,
	LeftParen,
	RightParen,
	Asterisk,
	Plus,
	Comma,
	Minus,
	Period,
	Slash,

	Number0,
	Number1,
	Number2,
	Number3,
	Number4,
	Number5,
	Number6,
	Number7,
	Number8,
	Number9,

	Colon,
	SemiColon,

	Less,
	Equals,
	Greater,
	Question,
	At,

	LeftBracket,
	Backslash,
	RightBracket,
	Caret,
	Underscore,
	Backquote,

	A,
	B,
	C,
	D,
	E,
	F,
	G,
	H,
	I,
	J,
	K,
	L,
	M,
	N,
	O,
	P,
	Q,
	R,
	S,
	T,
	U,
	V,
	W,
	X,
	Y,
	Z,

	CapsLock,

	F1,
	F2,
	F3,
	F4,
	F5,
	F6,
	F7,
	F8,
	F9,
	F10,
	F11,
	F12,

	PrintScreen,
	ScrollLock,

	Pause,
	Insert,
	Home,
	PageUp,
	Delete,
	End,
	PageDown,
	Right,
	Left,
	Down,
	Up,

	NumLockClear,
	KeypadDivide,
	KeypadMultiply,
	KeypadMinus,
	KeypadPlus,
	KeypadEnter,
	Keypad1,
	Keypad2,
	Keypad3,
	Keypad4,
	Keypad5,
	Keypad6,
	Keypad7,
	Keypad8,
	Keypad9,
	Keypad0,
	KeypadPeriod,
	KeypadComma,
	KeypadEquals,

	Application,
	Power,

	F13,
	F14,
	F15,
	F16,
	F17,
	F18,
	F19,
	F20,
	F21,
	F22,
	F23,
	F24,

	Execute,
	Help,
	Menu,
	Select,
	Stop,
	Again,
	Undo,
	Cut,
	Copy,
	Paste,
	Find,
	Mute,

	VolumeUp,
	VolumeDown,
	Alterase,

	Sysreq,
	Cancel,
	Clear,
	Prior,
	Return2,
	Separator,
	Out,
	Oper,

	ClearAgain,

	ThousandsSeparator,
	DecimalSeparator,
	CurrencyUnit,
	CurrencySubunit,

	LCtrl,
	LShift,
	LAlt,
	LGUI,
	RCtrl,
	RShift,
	RAlt,
	RGUI,

	Mode,

	AudioNext,
	AudioPrev,
	AudioStop,
	AudioPlay,
	AudioMute,
	MediaSelect,

	WWW,
	Mail,
	Calculator,
	Computer,
	AppSearch,
	AppHome,
	AppBack,
	AppForward,
	AppStop,
	AppRefresh,
	AppBookmarks,

	BrightnessDown,
	BrightnessUp,
	DisplaySwitch,
	KBDILLUMToggle,
	KBDILLUMDown,
	KBDILLUMUp,
	Eject,
	Sleep,
}

WrapType :: enum {
	WRAP_UNKNOW,

	WRAP_KEY,
	WRAP_MOUSE_BUTTON,
	WRAP_MOUSE_MOTION,
	WRAP_MOUSE_WHEEL,

	WRAP_TOUCH_MOVED,
	WRAP_TOUCH_PRESSED,
	WRAP_TOUCH_RELEASED,

	WRAP_JOYSTICK_BUTTON,
	WRAP_JOYSTICK_AXIS_MOTION,
	WRAP_JOYSTICK_HAT_MOTION,
	WRAP_JOYSTICK_CONTROLLER_BUTTON,
	WRAP_JOYSTICK_CONTROLLER_AXIS_MOTION,
	WRAP_JOYSTICK_DEVICE_ADDED_OR_REMOVED,

	WRAP_TEXTINPUT,
	WRAP_TEXTEDITING,

	WRAP_WINDOW_VISIBLE,
	WRAP_WINDOW_ENTER_OR_LEAVE,
	WRAP_WINDOW_SHOWN_OR_HIDDEN,
	WRAP_WINDOW_RESIZED,

	WRAP_FILE_DROPPED,
	WRAP_DIRECTORY_DROPPED,

	WRAP_LOWMEMORY,
	WRAP_QUIT,
}

Type :: enum {
	Unknow,
	KeyPressed,
	KeyReleased,
	MouseMoved,
	MousePressed,
	MouseReleased,
	MouseFocus,
	WheelMoved,
	JoystickPressed,
	JoystickReleased,
	JoystickAxis,
	JoystickHat,
	JoystickGamepadPressed,
	JoystickGamepadReleased,
	JoystickGamepadAxis,
	JoystickAdded,
	JoystickRemoved,
	TouchMoved,
	TouchPressed,
	TouchReleased,
	TextEditing,
	TextInput,
	WindowFocus,
	WindowVisible,
	WindowResize,
	DirectoryDropped,
	FileDropped,
	Quit,
	LowMemory,
}

Data :: struct {
	type: Type, 
	key: KeyConstant,
	scancode: Scancode,
	//joystick = null;
	//direction = JoystickHat.Centered;
	//gamepadButton = GamepadButton.A;
	//gamepadAxis = GamepadAxis.LeftX;
	text: string,
	flag: bool,
	fx, fy, fz, fw, fp: c.float,
	idx, idy, lid: c.int,
}

newData :: proc (t: Type) -> Data {
	return Data {
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

Node :: struct {
	data: Data,
	next: ^Node,
}

LinkedList :: struct {
	head: ^Node,
	tail: ^Node,
	count: int,
}

list_insert :: proc (list: ^LinkedList, node: ^Node) -> ^Node {
	if 0 < list.count {
		list.tail.next = node
		list.tail= list.tail.next
	} else {
		list.head = node
		list.tail = node
		list.tail.next = list.tail
	}
	list.count = list.count + 1
	return list.tail
}

list_pop_head :: proc (list: ^LinkedList) -> ^Node{
	list.head = list.head.next
	if list.count > 0 {
		list.count = list.count - 1
	}
	return list.head
}

list_pop_tail :: proc (list: ^LinkedList) -> ^Node{
	counter := 0
	node := list.head
	if 0 < list.count {
		for counter < list.count - 1 {
			node = node.next
			counter = counter + 1
		}
		list.tail = node
		list.count = list.count - 1
	}
	return list.tail
}

newList :: proc () -> LinkedList {	
	list := LinkedList {}
	return list
}

QueueBox :: struct {
	list: LinkedList,

	KeyPressed: proc (key: KeyConstant, scancode: Scancode, repeat: bool),
	KeyReleased: proc (key: KeyConstant , scancode: Scancode),
	
	MousePressed: proc (x, y: c.float, button: c.int, touch: bool),
	MouseReleased: proc (x, y: c.float, button: c.int, touch: bool),
	MouseFocus: proc (focus: bool),
	MouseMoved: proc (x, y, dx, dy: c.float, touch: bool),

	WheelMoved: proc (x, y: c.int),

	//JoystickPressed: proc (Joystick joystick, int button),
	//JoystickReleased: proc (Joystick joystick, int button),
	//JoystickAxis: proc (Joystick joystick, float axis, float value),
	//JoystickHat: proc (Joystick joystick, int hat, JoystickHat direction),
	//JoystickGamepadPressed: proc (Joystick joystick, GamepadButton button),
	//JoystickGamepadReleased: proc (Joystick joystick, GamepadButton button),
	//JoystickGamepadAxis: proc (Joystick joystick, GamepadAxis axis, float value),
	//JoystickAdded: proc (Joystick joystick),
	//JoystickRemoved: proc (Joystick joystick),

	TouchPressed: proc (id: c.long, x, y, dx, dy, pressure: c.float),
	TouchReleased: proc (id: c.long, x, y, dx, dy, pressure: c.float),
	TouchMoved: proc (id: c.long, x, y, dx, dy, pressure: c.float),

	TextEditing: proc (text: string, start,  end: c.int),
	TextInput: proc (text: string),

	WindowFocus: proc (focus: bool),
	WindowVisible: proc (visible: bool),
	WindowResize: proc (w, h: c.int),

	DirectoryDropped: proc (path: string),
	FileDropped: proc (filePath: string),

	LowMemory: proc (),
	Quit: proc (),

	sceneHandleEvent: proc (scene: scene.Scene) -> bool,
	getScrollValue: proc () -> (c.int, c.int),
}

list := newList()

quitFlag: bool

quit :: proc () {
	quitFlag = true
}

Point :: struct { x, y: c.float }

newQueueBox :: proc () -> QueueBox {
	KeyPressed :: proc (key: KeyConstant, scancode: Scancode, repeat: bool) {
		node := new(Node)
		node.data = newData(Type.KeyPressed)
                node.data.key = key
                node.data.scancode = scancode
                node.data.flag = repeat
		
		list_insert(&list, node)
	}

	KeyReleased :: proc (key: KeyConstant, scancode: Scancode) {
		node := new(Node)
		node.data = newData(Type.KeyReleased)
                node.data.key = key
                node.data.scancode = scancode

                list_insert(&list, node)
	}

	MousePressed :: proc (x, y: c.float, button: c.int, touch: bool) {
		node := new(Node)
		node.data.fx = x
		node.data.fy = y
		node.data.idx = button
		node.data.flag = touch
		
                list_insert(&list, node)
	}

	MouseReleased :: proc (x, y: c.float, button: c.int, touch: bool) {
		node := new(Node)
		node.data.fx = x
		node.data.fy = y
		node.data.idx = button
		node.data.flag = touch

                list_insert(&list, node)
	}

	Quit :: proc () {
		node := new(Node)
		node.data = newData(Type.Quit)

                list_insert(&list, node)
	}

	sceneHandleEvent :: proc (scene: scene.Scene) -> bool {
		has_event := 0 < list.count
		for 0 < list.count {
			e := list.head.data

			#partial switch e.type {
				case Type.Unknow:
				case Type.Quit:
					scene.invokeQuit()
					quit()
				case:
			}

			list_pop_head(&list)
		}
		return has_event
	}

	getScrollValue :: proc () -> (c.int, c.int) {
		x, y : c.int
		x, y = 0, 0
		//node := list.head
		//for node != nil {
		//	fmt.println(list.count)
		//	if node.data.type == Type.WheelMoved {
		//		x, y = node.data.idx, node.data.idy
		//	}
		///	node = node.next
		//	fmt.println(node)
		//}
		return x, y
	}

	return QueueBox {
		list = list,

		KeyPressed = KeyPressed,
		KeyReleased = KeyReleased,

		MousePressed = MousePressed,
		MouseReleased = MouseReleased,

		Quit = Quit,

		sceneHandleEvent = sceneHandleEvent,
		getScrollValue = getScrollValue,
	}
}

init :: proc () -> love2d_dll.bool4 {
	return love2d_dll.event_open_love_event()
}

poll :: proc (box: QueueBox) -> bool {
	return poll_or_wait_real(box, true)
}

wait :: proc (box: QueueBox) {
	poll_or_wait_real(box, true)
}

do_handle :: proc (
	eHandler: QueueBox,
	out_event_type: c.int,
	out_down_or_up, out_bool: love2d_dll.bool4,
	out_idx, out_enum1, out_enum2: c.int,
	out_string: love2d_dll.WrapString,
	out_int4: love2d_dll.Int4,
	out_float4: love2d_dll.Float4,
	out_float_value: c.float,
	out_joystick: love2d_dll.Joystick
	) {

	using WrapType
	event_type := cast(WrapType)out_event_type
	switch event_type {
		case WRAP_KEY:
			key := cast(KeyConstant)out_enum1
			code := cast(Scancode)out_enum1
			repeat := cast(bool)out_bool
			down_or_up := cast(bool)out_down_or_up
			if down_or_up {
				eHandler.KeyPressed(key, code, repeat)
			} else {
				eHandler.KeyReleased(key, code)
			}
		case WRAP_MOUSE_BUTTON:
			x :=cast(c.float)out_bool
			y :=cast(c.float)out_bool
			idx :=cast(c.int)out_bool
			touch := cast(bool)out_bool
			down_or_up := cast(bool)out_down_or_up
			if down_or_up {
				eHandler.MousePressed(x, y, idx, touch)
			} else {
				eHandler.MouseReleased(x, y, idx, touch)
			}
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
			eHandler.Quit()
		case WRAP_UNKNOW:
	}

}

poll_or_wait_real :: proc (eHandler: QueueBox, poll_or_wait: bool) -> bool {
	out_has_event, out_down_or_up, out_bool: love2d_dll.bool4
	out_event_type, out_idx, out_enum1, out_enum2: c.int
	out_string: love2d_dll.WrapString
	out_int4: love2d_dll.Int4
	out_float4: love2d_dll.Float4
	out_float_value: c.float
	out_joystick: love2d_dll.Joystick

	//out_str: IntPtr
	//out_joystick_ptr: Intptr

	//out_str: c.int
	out_str: love2d_dll.WrapString
	out_joystick_ptr: c.int

	if poll_or_wait {
		love2d_dll.event_poll(
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
		love2d_dll.event_wait(
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

	out_stirng := out_str
	//out_joystick := out_joystick_ptr
	has_event := cast(bool)out_has_event
	if has_event {
		do_handle(
			eHandler,
			out_event_type,
			out_down_or_up, out_bool,
			out_idx, out_enum1, out_enum2, out_string,
			out_int4, out_float4, out_float_value, out_joystick
		)
	}

	return has_event
}

