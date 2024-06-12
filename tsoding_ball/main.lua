local w, h = love.graphics.getDimensions()
local xpos, ypos = w/2, h/2
local xvel, yvel = 200, 200
local gravity = 1E3
local radius = 100
function love.draw()
	love.graphics.setColor(255, 0, 0, 255)
	local dt = love.timer.getDelta()
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
	love.graphics.circle("fill", xpos, ypos, radius)
end
