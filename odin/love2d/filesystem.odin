package love2d

FilesystemInit :: proc () -> bool
{
	status: bool = cast(bool)filesystem_open_love_filesystem()
	filesystem_init("")
	return cast(bool)status
}
