package love2d

TouchInit :: proc () -> bool
{
	return cast(bool)touch_open_love_touch()
}
