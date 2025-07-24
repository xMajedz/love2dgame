package love2d

CommonGetVersion :: proc() -> cstring
{
	out_str: WrapString
	common_getVersion(&out_str)
	return out_str.data^
}

CommonGetVersionCodeName :: proc() -> cstring
{
	out_str: WrapString
	common_getVersionCodeName(&out_str)
	return out_str.data^
}
