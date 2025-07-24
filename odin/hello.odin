package main

import "love2d"

draw :: proc ()
{
	love2d.GraphicsPrint("Hello World", 400, 300)
}

main :: proc ()
{
	love2d.draw = draw
	love2d.Boot(love2d.GenScene())
}
