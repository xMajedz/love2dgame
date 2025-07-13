local w, h, xpos, ypos, xvel, yvel, gravity, radius

function love.load()
	w, h = love.graphics.getDimensions()
	xpos, ypos = w/2, h/2
	xvel, yvel = 200, 200
	gravity = 1E3
	radius = 100
end

function love.update(dt)
	yvel = yvel + gravity * dt
	local x = xpos + xvel * dt
	if x + radius > w or x - radius < 0 then
		xvel = xvel * -1.00
	else
		xpos = x
	end
	local y = ypos + yvel * dt
	if y + radius > h or y - radius < 0 then
		yvel = yvel * -1.00
	else
		ypos = y
	end
end

function love.draw()
	love.graphics.setBackgroundColor(9/255, 9/255, 9/255, 255/255)
	love.graphics.setColor(230/255, 41/255, 55/255, 255/255)
	love.graphics.circle("fill", xpos, ypos, radius)
end
