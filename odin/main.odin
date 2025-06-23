package main

import "love2d/boot"
import "love2d/graphics"
import math "love2d/mathf"
import love "love2d/scene"

import "core:fmt"

w, h, x, y, xpos, ypos, xvel, yvel, radius, gravity: f32	
points: i32

main :: proc () {
	love.load = proc () {
		w, h = 1600, 900
		xpos, ypos = 800, 450
		xvel, yvel = 200, 200
		gravity = 1E3
		radius = 100
		points = 32
	}
	
	love.update = proc (dt: f32) {
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
	
	love.draw = proc () {
		graphics.setBackgroundColor(math.colorFromBytes(9, 9, 9, 255))
		graphics.setColor(math.colorFromBytes(230, 41, 55, 255))
		graphics.circle("fill", xpos, ypos, radius, points)
	}

	config := boot.Config {
		WindowTitle = "tsoding ball",
		WindowWidth = 1600,
		WindowHeight = 900,
	}

	boot.run(config, love.new())
}
