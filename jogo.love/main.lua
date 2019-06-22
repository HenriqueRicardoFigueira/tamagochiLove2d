local imageFile
local Spr = require("src/sprite")
local Anim = require("src/animation")
local Evt = require("src/events")
local suit = require 'suit'
local Player = require("src/player")
local Pet = require("src/pet")
local p1 = Pet("gayarados")

-- criação de botão
local slider = {value = 1, max = 2}

-- configuração pra animação
--        Anim(xoffset, yoffset, w, h, collumn_size, num_frames, fps)   
local charp = Anim(120, 0, 120, 80, 5, 5, 3)
local charv = Anim(0, 160, 120, 80, 5, 5, 3)
local charc = Anim(0, 240, 120, 80, 5, 5, 3)
local ss  

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    image_char = love.graphics.newImage("graphics/char.png")
    ss = Spr(image_char, 160, 124, 400, 400, 3, 3)
    ss:add_animation("charizard", charp)
    ss:add_animation("charizardV", charv)
    ss:add_animation("charizardC", charc)
    ss:animate("charizard")
end

function love.update(dt)
    if dt > 0.035 then return end

    ss:update(dt)

    if suit.Button("Alimentar", 50, 50, 80, 80).hit then
        p1:toFeed()
        ss:animate("charizardC")
    end

    if suit.Button("Brincar", 150, 50, 80, 80).hit then
        p1:toPlay()
        ss:animate("charizardV")
    end
end

function love.draw()
    suit.draw()
    suit.Label(p1.hunger, {align="left"}, 100, 150, 200, 30)   
    suit.Label(p1.happy, {align="left"}, 200, 150, 200, 30)
    suit.Label(p1.energy, {align="left"}, 250, 150, 200, 30)
    ss:draw()
end

