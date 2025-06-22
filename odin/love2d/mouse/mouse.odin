package mouse

import love2d_dll ".."
import "core:c"

rememberButtonCount :: 32
lastButtonDown:=make([]bool, rememberButtonCount)
currentButtonDown:=make([]bool, rememberButtonCount)

previousX, previousY: c.float
scrollX, scrollY: c.int

init :: proc () -> love2d_dll.bool4 {
	return love2d_dll.open_love_mouse()
}

step :: proc () {
	for i := 0; i < rememberButtonCount; i += 1 {
		lastButtonDown[i] = currentButtonDown[i]
		currentButtonDown[i] = isDown(i)
	}
}

setPreviousPosition :: proc (x, y: c.float) {
	previousX = x
	previousY = y

}

getX_double:: proc () -> c.double {
	out_x: c.double
	love2d_dll.mouse_getX(&out_x);
	return out_x
}

getX :: proc () -> c.float{
	return cast(c.float)getX_double()
}

getY_double :: proc () -> c.double {
	out_y: c.double
	love2d_dll.mouse_getY(&out_y);
	return out_y
}

getY :: proc () -> c.float {
	return cast(c.float)getY_double()
}

setScrollX :: proc (value: c.int) {
	scrollX = value
}

setScrollY :: proc (value: c.int) {
	scrollY = value
}

isDown :: proc (button_idx: int) -> bool { 
	out_result: love2d_dll.bool4 = 0
	love2d_dll.mouse_isDown(c.int(button_idx + 1), &out_result);
	return cast(bool)out_result;
}
