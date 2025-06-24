package graphics

import  love2d_dll ".."
import "../shader"

import "core:fmt"
import "core:c"

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

clear_rgba :: proc (r, g, b, a: f32) {
	love2d_dll.graphics_clear_rgba(r, g, b, a, 0, 0, 0, 0)
}

clear :: proc {clear_rgba}

Color :: love2d_dll.Color
Vector4 :: love2d_dll.Vector4

print_text :: proc (text: cstring) {
	print_text_xy(text, 0, 0)
}

print_text_xy :: proc (text: cstring, x, y: c.float) {
	print_default(
		[]cstring{text},
		//[]Vector4{struct #packed {r, g, b, a: c.float}{r=1.00, g=1.00, b=1.00, a=1.00}},
		//[]Color{{1.00, 1.00, 1.00, 1.00}},
		[]love2d_dll.Float4{{struct #packed {r, g, b, a: c.float}{1.00, 1.00, 1.00, 1.00}}},
		1, x, y, 0, 0, 0, 0, 0, 0, 0
	)
}

print_default:: proc (
	text: []cstring,
	//color: []Vector4,
	//color: []Color,
	color: []love2d_dll.Float4,
	length: c.int,
	x, y, angle, sx, sy, ox, oy, kx, ky: c.float
	) {
	love2d_dll.graphics_print(text[:], color[:], c.float(length), x, y, angle, sx, sy, ox, oy, kx, ky)
}

print :: proc {print_default, print_text, print_text_xy}

printf :: proc () {
	/*text: []love2d_dll.pchar = "test"
	color: []love2d_dll.Float4 = {1.00, 1.00, 1.00, 1.00}
	length: c.int = 4
	align: c.int = 0
	x, y, angle, wrap: c.float = 0, 0, 0, 0
	sx, sy, ox, oy, kx, ky: c.float = 0, 0, 0, 0, 0
	love2d_dll.graphics_printf(text, color, length, x, y, wrap, align, sx, sy, ox, oy, kx, ky)*/
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
/*
newCanvas :: proc (width, height: c.int) -> ^Canvas {
	out_canvas: pCanvas = nil
	graphics_newCanvas(
		width, height,
		type,
		format,
		readable,
		msaa,
		dpiScale,
		mipmap
		&out_canvas
	)
	return newObject(Canvas, out_canvas)
}

newMesh :: proc () {

}

newText :: proc () {

}

newVideo :: proc () {

}

newImageData :: proc (slice, mipmap, x, y, w, h: c.int) -> ^ImageData {
	out_data: pImageData = nil
	//type_Canvas_newImageData_xywh(p, slice, mipmap, x, y, w, h, &out_data)
	return newObject(ImageData, out_data)
}
*/
