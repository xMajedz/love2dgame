package main

import "love2d"

w, h, x, y, xpos, ypos, xvel, yvel, radius, gravity: f32	
points: i32
load :: proc ()
{
	w, h = 1600, 900
	xpos, ypos = 800, 450
	xvel, yvel = 200, 200
	gravity = 1E3
	radius = 100
	points = 32
}

update :: proc (dt: f32)
{
	yvel = yvel + gravity * dt
	x = xpos + xvel * dt
	if x + radius > w || x - radius < 0 {
		xvel = xvel * -1.00
	} else {
		xpos = x
	}
	y = ypos + yvel * dt
	if y + radius > h || y - radius < 0 {
		yvel = yvel * -1.00
	} else {
		ypos = y
	}
}

draw :: proc ()
{
	love2d.GraphicsSetBackgroundColor(love2d.MathColorFromBytes(9, 9, 9, 255))
	love2d.GraphicsSetColor(love2d.MathColorFromBytes(230, 41, 55, 255))
	love2d.GraphicsCircle("fill", xpos, ypos, radius, points)
}

main :: proc ()
{
	love2d.load = load
	love2d.update = update
	love2d.draw = draw

	config := love2d.Config {
		WindowTitle = "tsoding ball",
		WindowWidth = 1600,
		WindowHeight = 900,
	}


	love2d.Boot(config, love2d.GenScene())
}
