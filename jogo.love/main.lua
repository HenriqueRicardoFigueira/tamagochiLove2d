-- import de classes
local g = require("src/game")
local s = require("suit")
local gameStatus = "menu"
local menu = require("src/menu")
 x = s.new()

function love.load()
    game = g()
    menu:load()
    background = love.graphics.newImage("graphics/bg.png")
end

function love.update(dt)
    game:update(dt)
    
    --x:Label("xxxxxxx", 1, 1, 50, 50)
   gameStatus = menu:checkGoing()
    if gameStatus == "start" then
        gameStatus = "game"
    end


end

function love.draw()
    love.graphics.draw(background);
    --love.graphics.setBackgroundColor(255, 0, 0)
    --love.graphics.print(gameStatus, 400, 80)
    --x:draw()
    if gameStatus == "menu" then menu:draw() end

    if gameStatus == "game" then game:draw() end
end

