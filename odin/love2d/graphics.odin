package love2d

GraphicsInit :: proc () -> bool
{
	status := graphics_open_love_graphics()
	ShaderInit()
	return cast(bool)status
}

GraphicsReset :: proc ()
{
	graphics_reset()
}

GraphicsPresent :: proc  ()
{
	graphics_present()
}

GraphicsOrigin :: proc ()
{
	graphics_origin()
}

GraphicsClear_rgba :: proc (r, g, b, a: f32)
{
	graphics_clear_rgba(r, g, b, a, 0, 0, 0, 0)
}

GraphicsClear :: proc {GraphicsClear_rgba}

GraphicsPrint_text :: proc (text: cstring)
{
	GraphicsPrint_default([]cstring{text}, []Float4{Colorf{1.00, 1.00, 1.00, 1.00}}, 1, 0, 0)
}

GraphicsPrint_text_xy :: proc (text: cstring, x, y: f32)
{
	GraphicsPrint_default([]cstring{text}, []Float4{Colorf{1.00, 1.00, 1.00, 1.00}}, 1, x, y)
}

GraphicsPrint_default:: proc (textList: []cstring, colorList: []Float4, length: i32, x, y: f32)
{
	graphics_print(&textList[0], &colorList[0], length, x, y, 0, 1, 1, 0, 0, 0, 0)
}

GraphicsPrint :: proc {GraphicsPrint_default, GraphicsPrint_text, GraphicsPrint_text_xy}

GraphicsPrintf :: proc ()
{
	/*text: []love2d_dll.pchar = "test"
	color: []love2d_dll.Float4 = {1.00, 1.00, 1.00, 1.00}
	length: c.int = 4
	align: c.int = 0
	x, y, angle, wrap: c.float = 0, 0, 0, 0
	sx, sy, ox, oy, kx, ky: c.float = 0, 0, 0, 0, 0
	love2d_dll.graphics_printf(text, color, length, x, y, wrap, align, sx, sy, ox, oy, kx, ky)*/
}

GraphicsCircle :: proc (mode_type: cstring, x, y, radius: f32, points: i32)
{
	graphics_circle(1, x, y, radius, points)
}

GraphicsSetColor :: proc (r, g, b, a: f32)
{
	graphics_setColor(r, g, b, a)
}

GraphicsSetBackgroundColor :: proc (r, g, b, a: f32)
{
	graphics_setBackgroundColor(r, g, b, a)
}

GraphicsGetBackgroundColor :: proc () -> (f32, f32, f32, f32)
{
	out_r, out_g, out_b, out_a: f32
	graphics_getBackgroundColor(&out_r, &out_g, &out_b, &out_a)
	return out_r, out_g, out_b, out_a
}

GraphicsIsActive :: proc () -> bool
{
	out_result: bool4
	graphics_isActive(&out_result)
	return cast(bool)out_result
}
