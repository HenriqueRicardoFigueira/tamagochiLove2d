local imageFile
local frames = {}
local currentFrame  = 1
local Player = require("src/player")
local p1 = Player("henri")
BUTTON_HEIGHT = 64

local 
function newButton(text,fn)
	return {
		text = text,
		fn = fn,
		now = false,
		last = false
	}
end 
local buttons = {}
local font = nil

function love.update(dt)
end


function  love.load()
	font = love.graphics.newFont(32)




    table.insert(buttons, newButton(
    	"Start Game",
    	function()
		print("Starting Game")

    	end))
    table.insert(buttons, newButton(
    	"Load Game",
    	function()
    		print("Starting Game")
    	end))
    table.insert(buttons, newButton(
    	"Settings",
    	function()
    		print("Going to settigs menu")
    	end))
    table.insert(buttons, newButton(
    	"Quit",
    	function()
    		love.event.quit(0)
    	end))
end

function love.draw()
	local ww = love.graphics.getWidth()
	local wh = love.graphics.getHeight()

	local button_width = ww * (1/3) 
	local margin = 16.0
	local total_height =( BUTTON_HEIGHT + margin ) * #buttons
	local cursor_y = 0.0

	for i, button in ipairs(buttons) do




		button.last = button.now

		local bx = (ww * 0.5) - (button_width * 0.5)
		local by = (wh * 0.5) - (total_height * 0.5) + cursor_y

		local color = {0.4,0.4,0.5,1.0}
		local mx, my = love.mouse.getPosition()
		local hot = mx > bx and mx < bx + button_width and mx > by and by < by + BUTTON_HEIGHT




		if hot then
			color = {0.8,0.8,0.9,1.0}
		end

		button.now = love.mouse.isDown(1)

		if button.now and not button.last and hot then
			button.fn()
		end

		love.graphics.setColor(unpack(color))


		love.graphics.rectangle(
			"fill",
			bx,
			by,
			button_width,
			BUTTON_HEIGHT
		)

		love.graphics.setColor( 0, 0, 0, 1) -- cor da janela

		local textW = font:getWidth(button.text)
		local textH = font:getHeight(button.text)
		love.graphics.print(
			button.text,
			font,
			(ww * 0.5) - textW * 0.5,
			by + textH * 0.5
			)
		cursor_y = cursor_y + (BUTTON_HEIGHT + margin)
	end

end

