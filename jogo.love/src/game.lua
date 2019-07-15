--import classes
local Spr = require("src/sprite")
local Anim = require("src/animation")
local Evt = require("src/events")
local suit = require 'suit'
local Player = require("src/player")
local Pet = require("src/pet")
local p1 = Pet("gayarados")
local ui_bar = require("src/bars")
local class = require("src/class")
local minigaming = require("MG/minigame")
local Game = class:derive("Game")

-- configuração pra animação
--        Anim(xoffset, yoffset, w, h, collumn_size, num_frames, fps)   
local charp = Anim(130, 0, 134, 84, 6, 6, 3)
local charv = Anim(123, 95, 134, 84, 6, 6, 4)
local charc = Anim(123, 190, 134, 87, 6, 6, 4)
Gaming = false 
local outgamin = false
--minigaming.new()
function Game:new()
    --minigami 
    
    background = love.graphics.newImage("graphics/bg.png")
    love.graphics.setDefaultFilter('nearest', 'nearest') 
    -- imagens 
    image_charV = love.graphics.newImage("graphics/versaomelhor.png")
    bar1 = love.graphics.newImage("graphics/bar_1.png")
    bar2 = love.graphics.newImage("graphics/bar_2.png")

    -- barras
    bHunger1 = ui_bar(bar1, 600, 50, math.rad(0), 0.1, 0.1, 100, 100)
    bHunger2 = ui_bar(bar2, 600, 50, math.rad(0), 0.1, 0.1, 100, 100)
    bHappy1 = ui_bar(bar1, 600, 80, math.rad(0), 0.1, 0.1, 100, 100)
    bHappy2 = ui_bar(bar2, 600, 80, math.rad(0), 0.0, 0.1, 100, 100)
    bEnergy1 = ui_bar(bar1, 600, 20, math.rad(0), 0.1, 0.1, 100, 100)
    bEnergy2 = ui_bar(bar2, 600, 20, math.rad(0), 0.1, 0.1, 100, 100)

    -- sprite
    --      (spriteX, w, h, x, y, sx, sy)
    ssV = Spr(image_charV, 134, 84, 400, 400, 3, 3)

    -- animações
    ssV:add_animation("charizardC", charc)
    ssV:add_animation("char", charp)
    ssV:add_animation("charizardV", charv)
    ssV:animate("char")

    -- fonts
    font = love.graphics.newFont("fonts/fonteNova.otf", 20)
    
end

function Game:update(dt)
    p1:degree()
    if dt > 0.035 then return end
    if Gaming == false then
    -- update sprite
        ssV:update(dt)

        -- criação de botões e actions (CRIAR CLASSE PARA GERAR)
        if suit.Button("Alimentar", 50, 50, 80, 80).hit then
            p1:toFeed()
            bHunger2:upScale((p1.hunger / 1000))
            bEnergy2:upScale((p1.energy / 1000))
            ssV:animate("charizardC")
        end

        if suit.Button("Brincar", 150, 50, 80, 80).hit then
            p1:toPlay()
            bHappy2:upScale((p1.happy / 1000))
            bEnergy2:upScale((p1.energy / 1000))
            ssV:animate("charizardV")
            Gaming = true
            minigaming.new()

        end
    end

end
function Game:Mini(...)
    minigaming.update()
    minigaming.draw()
    p1:toPlay()
end

function Game:Normal(...)
    
    for i = 0, love.graphics.getWidth() / background:getWidth() do
        for j = 0, love.graphics.getHeight() / background:getHeight() do
            love.graphics.draw(background, i * background:getWidth(), j * background:getHeight())
        end
    end
    bHunger1:draw()
    bHunger2:draw()
    bHappy1:draw()
    bHappy2:draw()
    bEnergy1:draw()
    bEnergy2:draw()

    -- desenha os botões
    suit:draw()

    -- desenha sprite
    ssV:draw()

    -- nomes dos status
    love.graphics.print("FOME", 450, 45)
    love.graphics.print("FELICIDADE", 450, 75)
    love.graphics.print("ENERGIA", 450, 15)
end

function Game:draw(...)
    -- desenha barras de status
--    p1.degree()
    if Gaming == true then
        Game:Mini()
        outgamin = true
    else
        if outgamin == true then 
            background = love.graphics.newImage("graphics/bg.png")
            outgamin = false
        end
        Game:Normal()
    end
       
        
        
  
end

return Game