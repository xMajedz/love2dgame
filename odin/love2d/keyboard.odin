package love2d

KeyboardInit :: proc () -> bool
{
	return cast(bool)keyboard_open_love_keyboard()
}
