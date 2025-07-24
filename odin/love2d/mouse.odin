package love2d

import "core:fmt"

previousX, previousY: f32
scrollX, scrollY: i32 

MouseInit :: proc () -> bool
{
	return cast(bool)open_love_mouse()
}

MouseSetPreviousPosition :: proc (x, y: f32)
{
	previousX = x
	previousY = y

}

MouseGetX_double:: proc () -> f64
{
	out_x: f64
	mouse_getX(&out_x)
	return out_x
}

MouseGetX :: proc () -> f32
{
	return cast(f32)MouseGetX_double()
}

MouseGetY_double :: proc () -> f64
{
	out_y: f64
	mouse_getY(&out_y)
	return out_y
}

MouseGetY :: proc () -> f32
{
	return cast(f32)MouseGetY_double()
}

MouseSetScroll :: proc (valueX, valueY: i32)
{
	scrollX = valueX
	scrollY = valueY
}

MouseSetScrollX :: proc (value: i32)
{
	scrollX = value
}

MouseSetScrollY :: proc (value: i32)
{
	scrollY = value
}

MouseIsDown :: proc (button_idx: int) -> bool
{ 
	out_result: bool4 = 0
	mouse_isDown(i32(button_idx + 1), &out_result)
	return cast(bool)out_result
}
