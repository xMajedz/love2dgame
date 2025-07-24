package love2d

import "core:c"

when ODIN_OS == .Linux do foreign import wrap_love_dll "love.so"

Object :: distinct rawptr
RandomGenerator :: distinct rawptr
Joystick :: distinct rawptr

Quad :: struct
{
	ptr: ^Quad,
	release: proc (rawptr),
	retain: proc (rawptr),

	viewport: struct { x, y, w, h: c.double },
}

ImageData :: struct
{
	ptr: ^ImageData,
	release: proc (rawptr),
	retain: proc (rawptr),

	pixel: Pixel,
}

@(link_prefix="wrap_love_dll_")
foreign wrap_love_dll
{
	common_getVersion :: proc (out_str: ^WrapString) ---
	common_getVersionCodeName :: proc (out_str: ^WrapString) ---
	last_error :: proc (out_errormsg: ^WrapString) ---

	font_open_love_font :: proc () -> bool4  ---

	filesystem_open_love_filesystem :: proc () -> bool4 --- 
	filesystem_init :: proc (arg0: cstring) -> bool4 ---

	keyboard_open_love_keyboard :: proc () -> bool4 ---
	joystick_open_love_joystick :: proc () -> bool4 ---
	touch_open_love_touch :: proc () -> bool4 ---
	sound_luaopen_love_sound :: proc () -> bool4 ---

	audio_open_love_audio :: proc () -> bool4 ---
	image_open_love_image :: proc () -> bool4 ---
	video_open_love_video :: proc () -> bool4 ---
	system_open_love_system_module :: proc () -> bool4 ---

	timer_open_timer :: proc () -> bool4 ---
	timer_step :: proc () ---
	timer_getDelta :: proc (out_delta: ^c.float) ---
	timer_getFPS :: proc (out_fps: ^c.float) ---
	timer_getAverageDelta :: proc (out_averageDelta: ^c.float) ---
	timer_sleep :: proc (t: c.float) ---
	timer_getTime :: proc (out_time: ^c.double) ---

	open_love_math :: proc() -> bool4 ---
	//Float2* pointsList, int pointsList_lenght, float **out_triArray, int *out_triCount
	math_triangulate :: proc(
		pointsList: ^Float2,
		pointsList_length: c.int,
		out_triArray:^(^c.float),
		out_triCount: ^c.int
	) -> bool4 ---
	//Float2* pointsList, int pointsList_lenght, bool4 *out_result
	math_isConvex :: proc(pointsList: ^Float2, pointsList_length: c.int, out_result: ^bool4) ---
	math_gammaToLinear :: proc(gamma: c.float, out_liner: ^c.float) ---
	math_linearToGamma :: proc(liner: c.float, out_gamma: ^c.float) ---
	math_noise_1 :: proc(x: c.float, out_result: ^c.float) ---
	math_noise_2 :: proc(x, y: c.float, out_result: ^c.float) ---
	math_noise_3 :: proc(x, y, z: c.float, out_result: ^c.float) ---
	math_noise_4 :: proc(x, y, z, w: c.float, out_result: ^c.float) ---

	math_newRandomGenerator :: proc (out_rg: ^RandomGenerator) -> bool4 ---
	type_RandomGenerator_random :: proc (rg: RandomGenerator, out_result: ^c.double) ---
	type_RandomGenerator_randomNormal :: proc (rg: RandomGenerator, stddve, mean: f64, out_result: ^f64) ---
	type_RandomGenerator_setSeed  :: proc (rg: RandomGenerator, low, high: c.uint) -> bool4 ---
	type_RandomGenerator_getSeed  :: proc (rg: RandomGenerator, out_low, out_high: ^c.uint) ---
	type_RandomGenerator_setState :: proc (rg: RandomGenerator, state: ^cstring) -> bool4 ---
	type_RandomGenerator_getState :: proc (rg: RandomGenerator, out_str: ^WrapString) ---

	graphics_open_love_graphics :: proc() -> bool4 ---
	//ImageDataBase **imageDataList, bool4* compressedTypeList, int imageDataListLength, bool4 flagMipmaps, bool4 flagLinear, love::graphics::Image** out_image
	graphics_newImage_data :: proc() -> bool4 ---
	//double x, double y, double w, double h, double sw, double sh, Quad** out_quad
	graphics_newQuad :: proc(x, y, w, h, sw, sh: c.double, out_quad: ^^Quad) ---
	//Rasterizer *rasterizer, love::graphics::Font** out_font
	graphics_newFont :: proc() -> bool4 ---
	//Texture *texture, int maxSprites, int usage_type, love::graphics::SpriteBatch** out_spriteBatch
	graphics_newSpriteBatch :: proc() -> bool4 ---
	//Texture *texture, int buffer, ParticleSystem** out_particleSystem
	graphics_newParticleSystem :: proc() -> bool4 ---
	//int width, int height, int texture_type, int format_type, bool4 readable, int msaa, float dpiscale, int mipmaps, love::graphics::Canvas** out_canvas
	graphics_newCanvas :: proc() -> bool4 ---
	//const char* vertexCodeStr, const char* pixelCodeStr, Shader** out_shader
	graphics_newShader :: proc() -> bool4 ---
	//pChar vfName[], int* vfType, int* vfComponentCount, int vfLen, bool4 useData, void *data, int dataSizeOrCount, int drawMode_type, int usage_type, Mesh** out_mesh
	graphics_newMesh_custom :: proc () -> bool4 ---
	//Float2 pos[], Float2 uv[], Float4 color[], int vertexCount, int drawMode_type, int usage_type, Mesh** out_mesh
	graphics_newMesh_specifiedVertices :: proc() -> bool4 ---
	//int count, int drawMode_type, int usage_type, Mesh** out_mesh
	graphics_newMesh_count :: proc() -> bool4 ---
	//love::graphics::Font *font, pChar coloredStringText[], Float4 coloredStringColor[], int coloredStringLength, Text** out_text
	graphics_newText :: proc() -> bool4 ---
	//VideoStream *videoStream, float dpiScale, graphics::Video** out_video
	graphics_newVideo :: proc() -> bool4 ---
	graphics_origin :: proc() ---
	graphics_reset :: proc() ---
	graphics_isActive :: proc(out_result: ^bool4) ---
	graphics_clear_rgba :: proc(
		r, g, b, a, stencil: c.float,
		enable_stencil: bool4,
		depth: c.float,
		enable_depth: bool4
	) -> bool4 ---
	graphics_present :: proc() ---
	graphics_print :: proc(
		coloredStringListStr: ^cstring,
		coloredStringListColor: ^Float4,
		coloredStringListLength: c.int,
		x, y, angle: c.float,
		sx, sy, ox, oy, kx, ky: c.float
	) -> bool4 ---
	graphics_printf :: proc(
		coloredStringListStr: []cstring,
		coloredStringListColor: []Float4,
		coloredStringListLength: c.int,
		x, y, wrap: c.float,
		align_type: c.int,
		angle, sx, sy, ox, oy, kx, ky: c.float
	) -> bool4 ---
	graphics_circle :: proc (mode_type: c.int, x, y, radius: c.float, points: c.int) -> bool4 ---
	graphics_setBackgroundColor :: proc (r, g, b, a: c.float) ---
	graphics_getBackgroundColor :: proc (out_r, out_g, out_b, out_a: ^c.float) ---
	graphics_setColor :: proc (r, g, b, a: c.float) ---
	graphics_setDefaultShaderCode :: proc (str_arr: []cstring) ---

	windows_open_love_window :: proc () -> bool4 ---
	windows_getDisplayCount :: proc (out_count: ^int) -> bool4 ---
	windows_getDisplayName :: proc (displayindex: int, out_name: ^WrapString) -> bool4 ---
	windows_setMode_w_h :: proc (width, height: int) -> bool4 ---
	windows_setMode_w_h_setting :: proc (
		width, height: c.int,
		fullscreen: bool4,
		fstype: c.int,
		vsync: bool4,
		msaa: c.int,
		depth: c.int,
		stencil: bool4,
		resizable: bool4,
		minwidth, minheight: c.int,
		borderless: bool4,
		centered: bool4,
		display: c.int,
		highdpi: bool4,
		refreshrate: c.double,
		useposition: bool4,
		x, y: c.int
	) -> bool4 ---
	windows_getMode :: proc (
		out_width, out_height: ^c.int,
		out_fullscreen: ^bool4,
		out_fstype: ^c.int,
		out_vsync: ^bool4,
		out_msaa: ^c.int,
		out_depth: ^c.int,
		out_stencil: ^bool4,
		out_resizable: ^bool4,
		out_minwidth, out_minheight: ^c.int,
		out_borderless: ^bool4,
		out_centered: ^bool4,
		out_display: ^c.int,
		out_highdpi: ^bool4,
		out_refreshrate: ^c.double,
		out_useposition: ^bool4,
		out_x, out_y: ^c.int
	) -> bool4 ---
	//Int2*** out_modes,
	windows_getFullscreenModes :: proc (
		displayindex: c.int,
		out_modes: ^(^(^(Int2))),
		out_modes_length: ^c.int
	) ---
	windows_setFullscreen :: proc (fullscreen: bool4, fstype: c.int, out_success: ^bool4) ---
	windows_getFullscreen :: proc (out_fullscreen: ^bool4, out_fstype: ^c.int) ---
	windows_isOpen :: proc (out_isopen: ^bool4) ---
	windows_close :: proc () ---
	windows_getDesktopDimensions :: proc (displayindex: c.int, out_width, out_height: ^c.int) ---
	windows_setPosition :: proc (x, y, displayindex: c.int) ---
	windows_getPosition :: proc (out_x, out_y, out_displayindex: ^c.int) ---

	windows_setIcon :: proc (i: ^ImageData, out_success: ^bool4) ---
	windows_getIcon :: proc (out_imagedata: ^^ImageData) ---

	windows_setDisplaySleepEnabled :: proc (enable: bool4) ---
	windows_isDisplaySleepEnabled :: proc (out_enable: ^bool4) ---
	windows_setTitle :: proc (titleStr: cstring) ---
	windows_getTitle :: proc (out_title: ^WrapString) ---
	windows_hasFocus :: proc (out_result: ^bool4) ---
	windows_hasMouseFocus :: proc (out_result: ^bool4) ---
	windows_isVisible :: proc (out_result: ^bool4) ---
	windows_getDPIScale :: proc (out_result: ^c.double) ---
	windows_toPixels :: proc (value: c.double, out_result: ^c.double) ---
	windows_fromPixels :: proc (pixelvalue: c.double, out_result: ^c.double) ---
	windows_minimize :: proc () ---
	windows_maximize :: proc () ---
	windows_isMaximized :: proc (out_result: ^bool4) ---
	windows_showMessageBox :: proc (
		title, message: cstring,
		type: c.int,
		attachToWindow: bool4,
		out_result: ^bool4
	) ---
	windows_showMessageBox_list :: proc (
		title, message: cstring,
		buttons: ^cstring,
		buttonsLength, enterButtonIndex, escapebuttonIndex, type: c.int,
		attachToWindow: bool4,
		out_index_returned: ^c.int
	) ---
	windows_requestAttention :: proc (continuous: bool4) ---
	windows_windowToPixelCoords :: proc (out_x, out_y: ^c.double) ---
	windows_pixelToWindowCoords :: proc (x, y: ^c.double) ---

	open_love_mouse :: proc () -> bool4 ---
	//mouse_getSystemCursor :: proc (int sysctype, mouse::Cursor** out_cursor) -> bool4 ---
	//mouse_setCursor :: proc (mouse::Cursor *cursor) ---
	//mouse_getCursor :: proc (mouse::Cursor** out_cursor) ---
	mouse_isCursorSupported :: proc (out_result: ^bool4) ---
	mouse_getX :: proc (out_x: ^c.double) ---
	mouse_getY :: proc (out_y: ^c.double) ---
	mouse_getPosition :: proc (out_x, out_y: ^c.double) ---
	mouse_setX :: proc (x: c.double) ---
	mouse_setY :: proc (y: c.double) ---
	mouse_setPosition :: proc (x, y: c.double) ---
	mouse_isDown :: proc (buttonIndex: c.int, out_result: ^bool4) ---
	mouse_setVisible :: proc (visible: bool4) ---
	mouse_isVisible :: proc (out_result: ^bool4) ---
	mouse_setGrabbed :: proc (grabbed: bool4) ---
	mouse_isGrabbed :: proc (out_result: ^bool4) ---
	mouse_setRelativeMode :: proc (enable: bool4, out_result: ^bool4) ---
	mouse_getRelativeMode :: proc (out_result: ^bool4) ---

	event_open_love_event :: proc () -> bool4 ---
	event_poll :: proc (
		out_hasEvent: ^bool4,
		out_event_type: ^i32,
		out_down_or_up: ^bool4,
		out_bool: ^bool4,
		out_idx: ^c.int,
		out_enum1_type: ^i32,
		out_enum2_type: ^i32,
		out_str: ^WrapString,
		out_int4: ^Int4,
		out_float4: ^Float4,
		out_float_value: ^f32,
		out_joystick: ^Joystick
	) ---
	event_wait :: proc (
		out_hasEvent: ^bool4,
		out_event_type: ^i32,
		out_down_or_up: ^bool4,
		out_bool: ^bool4,
		out_idx: ^i32,
		out_enum1_type: ^i32,
		out_enum2_type: ^i32,
		out_str: ^WrapString,
		out_int4: ^Int4,
		out_float4: ^Float4,
		out_float_value: ^f32,
		out_joystick: ^Joystick
	) ---

	delete_WrapString :: proc(ws: ^WrapString) ---
	delete_WrapSequenceString :: proc(wss: ^WrapSequenceString) ---

	delete :: proc (ptr: rawptr) ---
	delete_array :: proc (ptr: rawptr) ---

	retain_obj :: proc (ptr: rawptr) ---
	release_obj :: proc (ptr: rawptr) ---
}

retain :: proc (ptr: rawptr)
{
	retain_obj(ptr)
}

release :: proc (ptr: rawptr)
{
	release_obj(ptr)
}

newRandomGenerator :: proc () -> RandomGenerator
{
	out_rg: RandomGenerator = nil
	math_newRandomGenerator(&out_rg)
	return out_rg
}
