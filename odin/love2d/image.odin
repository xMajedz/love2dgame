package love2d

ImageInit :: proc () -> bool
{
	return cast(bool)image_open_love_image()
}
