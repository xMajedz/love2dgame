package love2d

AudioInit :: proc () -> bool
{
	return cast(bool)audio_open_love_audio()
}
