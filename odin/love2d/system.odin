package love2d

SystemInit :: proc () -> bool
{
	return cast(bool)system_open_love_system_module()
}
