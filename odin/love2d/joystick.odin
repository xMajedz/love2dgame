package love2d

JoystickInit :: proc () -> bool
{
	return cast(bool)joystick_open_love_joystick()
}
