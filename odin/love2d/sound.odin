package love2d

SoundInit :: proc () -> bool
{
	return cast(bool)sound_luaopen_love_sound()
}
