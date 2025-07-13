local imageData, data, w, h
function love.load ()
	w, h = love.graphics.getDimensions()
	--[[
	data = ""
	for i = 1, w do 
		for j = 1, h do
			data = data .. "0x0A"
		end
	end
	imageData = love.image.newImageData(w, h, data)
	]]
end

function love.update (dt)

end

function love.draw ()
	--love.graphics.draw(imageData)

end
