local imageFile
local Anim = require("src/animation")
local suit = require 'suit'
local Player = require("src/player")
local Pet = require("src/pet")
local p1 = Pet("gayarados")

-- criação de botão
local slider = {value = 1, max = 2}

-- configuração pra animação
local a = Anim(0, 160, 124, 80, 6, 4, 1)

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    imageFile = love.graphics.newImage("graphics/char.png")
    sprite = love.graphics.newQuad(0, 160, 124, 80, imageFile:getDimensions())
end

function love.update(dt)
    if dt > 0.035 then return end

    a:update(dt, sprite)

    if suit.Button("Alimentar", 50, 50, 80, 80).hit then
        p1:toFeed()
    end

    if suit.Button("Brincar", 150, 50, 80, 80).hit then
        p1:toPlay()
    end
end

function love.draw()
    --love.graphics.setBackgroundColor(154, 245, 237, 0.5)
    love.graphics.draw(imageFile, sprite, 25, 200, 0, 5, 5)
    suit.draw()
    suit.Label(p1.hunger, {align="left"}, 100, 150, 200, 30)   
    suit.Label(p1.happy, {align="left"}, 200, 150, 200, 30)
    suit.Label(p1.energy, {align="left"}, 250, 150, 200, 30)
end

