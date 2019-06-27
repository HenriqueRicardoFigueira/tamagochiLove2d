local imageFile
local Spr = require("src/sprite")
local Anim = require("src/animation")
local Evt = require("src/events")
local suit = require 'suit'
local Player = require("src/player")
local Pet = require("src/pet")
local p1 = Pet("gayarados")
local ui_bar = require("src/bars")

-- criação de botão
local slider = {value = 1, max = 2}

-- configuração pra animação
--        Anim(xoffset, yoffset, w, h, collumn_size, num_frames, fps)   
local charp = Anim(130, 0, 134, 84, 6, 6, 3)
local charv = Anim(123, 95, 134, 84, 6, 6, 3)
local charc = Anim(108, 240, 108, 87, 7, 7, 3)
local ssV
local b1
local b2  

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    image_charV = love.graphics.newImage("graphics/charNv.png")
    background = love.graphics.newImage("graphics/bg.png")
    bar1 = love.graphics.newImage("graphics/bar_1.png")
    bar2 = love.graphics.newImage("graphics/bar_2.png")
    --barras
    bVida1 = ui_bar(bar1, 600, 60, math.rad(0), 0.1, 0.1, 100, 100)
    bVida2 = ui_bar(bar2, 600, 60, math.rad(0), 0.1, 0.1, 100, 100)
    --      (spriteX, w, h, x, y, sx, sy)
    ssV = Spr(image_charV, 134, 84, 400, 400, 3, 3)
    ssV:add_animation("charizardV", charv)
    --ssV:add_animation("charizardC", charc)
    ssV:add_animation("char", charp)
    ssV:animate("char")
   
end

function love.update(dt)
    if dt > 0.035 then return end

    ssV:update(dt)
     

    if suit.Button("Alimentar", 50, 50, 80, 80).hit then
        p1:toFeed()
        bVida2:upScale((p1.hunger/1000))
        --ssV:animate("charizardC")
    end
    
    if suit.Button("Brincar", 150, 50, 80, 80).hit then
        p1:toPlay()
        ssV:animate("charizardV")
    end

end

function love.draw()
    love.graphics.draw(background)
    --love.graphics.draw(bar1, 600, 60, math.rad(0), 0.1, 0.1, 100, 100)
    --love.graphics.draw(bar2, 600, 60, math.rad(0), 0.06, 0.1, 100, 100)
    bVida1:draw()
    bVida2:draw() 
    suit.draw()
    ssV:draw()
    suit.Label(p1.hunger, {align="left"}, 0, 150, 200, 30)   
    suit.Label(p1.happy, {align="left"}, 200, 150, 200, 30)
    suit.Label(p1.energy, {align="left"}, 250, 150, 200, 30)
    
end

