package main

import "love2d"

draw :: proc ()
{
	love2d.GraphicsPrint("Hello World", 400, 300)
}

main :: proc ()
{
	scene: love2d.Scene = { draw = draw }
	love2d.boot(&scene)
}
