-- import de classes
local g = require("src/game")


function love.load()
   game = g()
end

function love.update(dt)
   game:update(dt)
end

function love.draw()
    game:draw()
end

