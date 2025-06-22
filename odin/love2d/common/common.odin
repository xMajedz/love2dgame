package common

import love2d_dll ".."

FullscreenType :: enum {
	Execlusive,
	Desktop,
}

getVersion :: proc() -> cstring {
	using love2d_dll
	out_str: WrapString
	common_getVersion(&out_str)
	return out_str.data^
}

getVersionCodeName :: proc() -> cstring {
	using love2d_dll
	out_str: WrapString
	common_getVersionCodeName(&out_str)
	return out_str.data^
}
