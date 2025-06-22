package graphics

import  love2d_dll ".."
import "../shader"
import "core:fmt"

init :: proc () -> love2d_dll.bool4 {
	status := love2d_dll.graphics_open_love_graphics()
	shader.init()
	return status
}

reset :: proc  () {
	love2d_dll.graphics_reset()
}

present :: proc  () {
	love2d_dll.graphics_present()
}

origin :: proc () {
	love2d_dll.graphics_origin()
}

clear :: proc (r, g, b, a: f32) {
	love2d_dll.graphics_clear_rgba(r, g, b, a, 0, 0, 0, 0)
}

print :: proc () {
	color: []love2d_dll.Float4
	text: []love2d_dll.pchar
	love2d_dll.graphics_print(text, color, 4, 2, 2, 45, 1, 1, 1, 1, 1, 1)
}

printf :: proc () {
	color: []love2d_dll.Float4
	text: []love2d_dll.pchar
	//love2d_dll.graphics_printf(text, color, 4, 2, 2, 45, 1, 1, 1, 1, 1, 1)
}

circle :: proc (mode_type: cstring, x, y, radius: f32, points: i32) {
	love2d_dll.graphics_circle(1, x, y, radius, points)
}

setColor :: proc (r, g, b, a: f32) {
	love2d_dll.graphics_setColor(r, g, b, a)
}

setBackgroundColor :: proc (r, g, b, a: f32) {
	love2d_dll.graphics_setBackgroundColor(r, g, b, a)
}

getBackgroundColor :: proc () -> (f32, f32, f32, f32) {
	out_r, out_g, out_b, out_a: f32
	love2d_dll.graphics_getBackgroundColor(&out_r, &out_g, &out_b, &out_a)
	return out_r, out_g, out_b, out_a
}

isActive :: proc () -> bool {
	out_result: love2d_dll.bool4
	love2d_dll.graphics_isActive(&out_result)
	return cast(bool)out_result
}
