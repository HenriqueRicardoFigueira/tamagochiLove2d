
local imageFile
local currentFrame = 1
local suit = require 'suit'
local Player = require("src/player")
local Pet = require("src/pet")
local p1 = Pet("gayarados")
-- criação de botão




-- configuração pra animação
local fps = 5
local frame = 1
local anim_timer = 1 / fps
local num_frames = 4
local xoffset
local frames = {}

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    imageFile = love.graphics.newImage("graphics/char.png")
    -- frames[1] = love.graphics.newQuad(0,0,42,39, imageFile:getDimensions())
    -- frames[1] = love.graphics.newQuad(0,42,42,48, imageFile:getDimensions())
    eve_sprite = love.graphics.newQuad(0, 160, 124, 80, imageFile:getDimensions())

    activeFrame = frames[currentFrame]

end

function love.update(dt)
    if dt > 0.035 then return end
    anim_timer = anim_timer - dt
    if anim_timer <= 0 then
        anim_timer = 1 / fps
        frame = frame + 1
        if frame > num_frames then frame = 1 end
        xoffset = 124 * frame
        eve_sprite:setViewport(xoffset, 160, 124, 80)
    end

    if suit.Button("Alimentar", 50, 50, 80, 80).hit then
        p1:toFeed()
    end
    if suit.Button("Brincar", 150, 50, 80, 80).hit then
        p1:toPlay()
    end

end

function love.draw()
    love.graphics.setBackgroundColor(154, 245, 237, 0.5)
    love.graphics.draw(imageFile, eve_sprite, 25, 200, 0, 5, 5)
    suit.draw()
    suit.Label(p1.hunger, {align="left"}, 100, 150, 200, 30)   
    suit.Label(p1.energy, {align="left"}, 200, 150, 200, 30)
end

