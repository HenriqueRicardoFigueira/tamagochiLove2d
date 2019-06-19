local imageFile
local frames = {}
local currentFrame  = 1
local Player = require("src/player")
local p1 = Player("henri")

function  love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    imageFile = love.graphics.newImage("graphics/eveSprite.png")
    frames[1] = love.graphics.newQuad(0,0,30,30, imageFile:getDimensions())

    activeFrame = frames[currentFrame]
    
end

function love.draw()
    love.graphics.draw(imageFile, activeFrame, 25, 200, 0, 8, 8)
    love.graphics.print(p1.name)
end

