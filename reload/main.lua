local w, h, xpos, ypos, xvel, yvel, gravity, radius

local state = {}

function state.reload(previous_state)
	state = previous_state
	love.load()
end

function state.r()
	dofile(arg[1] .. "main.lua").reload(state)
end

function love.load()
	w, h = love.graphics.getDimensions()
	
	state.xpos = state.xpos or w/2
	state.ypos = state.ypos or h/2

	state.xvel = state.xvel or 200
	state.yvel = state.yvel or 200

	gravity = 1E3
	radius = 100
end

function love.update(dt)
	state.yvel = state.yvel + gravity * dt
	local x = state.xpos + state.xvel * dt
	if x + radius > w or x - radius < 0 then
		state.xvel = state.xvel * -1.00
	else
		state.xpos = x
	end
	local y = state.ypos + state.yvel * dt
	if y + radius > h or y - radius < 0 then
		state.yvel = state.yvel * -1.00
	else
		state.ypos = y
	end
end

function love.draw()
	love.graphics.setBackgroundColor(love.math.colorFromBytes(9, 9, 9, 255))
	love.graphics.setColor(love.math.colorFromBytes(255, 255, 255, 255))
	love.graphics.circle("fill", state.xpos, state.ypos, radius)
end

function love.keypressed(key)
	key = state[key] and state[key]()
end

return state
