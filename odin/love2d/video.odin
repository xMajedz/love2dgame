package love2d

VideoInit :: proc () -> bool
{
	return cast(bool)video_open_love_video()
}
