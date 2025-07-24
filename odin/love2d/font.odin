package love2d

FontInit :: proc () -> bool
{
	return cast(bool)font_open_love_font()
}
