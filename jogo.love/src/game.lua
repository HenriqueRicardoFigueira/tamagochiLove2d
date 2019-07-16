-- import classes
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
local data = {}
local load = {}
local dead = {"gayarados", tostring(0), tostring(100), tostring(100), tostring(0)}

-- configuração pra animação
--        Anim(xoffset, yoffset, w, h, collumn_size, num_frames, fps)   
local charp = Anim(130, 0, 134, 84, 6, 6, 3)
local charv = Anim(123, 95, 134, 84, 6, 6, 4)
local charc = Anim(123, 190, 134, 87, 6, 6, 4)
local charm = Anim(123, 290, 134, 87, 6, 6, 4)
Gaming = false
local outgamin = false
-- minigaming.new()
function Game:new()
    -- minigami 
    -- som
    src4 = love.audio.newSource("sounds/ambient.wav", "static")
    src10 = love.audio.newSource("sounds/diedie.wav","static")
    background = love.graphics.newImage("graphics/bg.png")
    love.graphics.setDefaultFilter('nearest', 'nearest')
    -- imagens 
    image_charV = love.graphics.newImage("graphics/emorreu.png")
    bar1 = love.graphics.newImage("graphics/bar_1.png")
    bar2 = love.graphics.newImage("graphics/bar_2.png")
    -- criando arquivo de save
    if not love.filesystem.getInfo('save.lua') then
        love.filesystem.newFile('save.lua')
        love.filesystem.write('save.lua', "")
    else
        p13 = love.filesystem.read('save.lua')
        for i in string.gmatch(p13, "%S+") do
            table.insert(load, tostring(i))
            print(i)
        end

        p1.name = load[1]
        p1.happy = tonumber(load[2])
        p1.energy = tonumber(load[3])
        p1.health = tonumber(load[4])
        p1.hunger = tonumber(load[5])
        love.filesystem.write('save.lua', " ")
    end
    print(love.filesystem.getSaveDirectory())

    -- barras
    bHunger1 = ui_bar(bar1, 600, 80, math.rad(0), 0.1, 0.1, 100, 100)
    bHunger2 = ui_bar(bar2, 600, 80, math.rad(0), 0.1, 0.1, 100, 100)
    bHappy1 = ui_bar(bar1, 600, 110, math.rad(0), 0.1, 0.1, 100, 100)
    bHappy2 = ui_bar(bar2, 600, 110, math.rad(0), 0.0, 0.1, 100, 100)
    bEnergy1 = ui_bar(bar1, 600, 50, math.rad(0), 0.1, 0.1, 100, 100)
    bEnergy2 = ui_bar(bar2, 600, 50, math.rad(0), 0.1, 0.1, 100, 100)
    bHealth1 = ui_bar(bar1, 600, 20, math.rad(0), 0.1, 0.1, 100, 100)
    bHealth2 = ui_bar(bar2, 600, 20, math.rad(0), 0.1, 0.1, 100, 100)

    -- sprite
    --      (spriteX, w, h, x, y, sx, sy)
    ssV = Spr(image_charV, 134, 84, 400, 400, 3, 3)

    -- animações
    ssV:add_animation("charizardC", charc)
    ssV:add_animation("char", charp)
    ssV:add_animation("charizardV", charv)
    ssV:add_animation("charizardM", charm)
    ssV:animate("char")

    -- fonts
    font = love.graphics.newFont("fonts/fonteNova.otf", 20)

end

function Game:update(dt)
    -- morreu
    if p1:isdead() then 
        ssV:animate("charizardM")
        src4:stop()
        src10:play() 
    end
    -- desce status
    p1:degree()
    if dt > 0.035 then return end
    if Gaming == false then
        if sound == true then src4:play() end
        -- update sprite
        ssV:update(dt)
        bHealth2:upScale((p1.health / 1000))
        bHunger2:upScale((p1.hunger / 1000))
        bEnergy2:upScale((p1.energy / 1000))
        bHappy2:upScale((p1.happy / 1000))

        -- criação de botões e actions (CRIAR CLASSE PARA GERAR)
        -- salvando estado
        if suit.Button("Sair", 50, 10, 100, 30).hit then
            if not p1:isdead() then
                table.insert(data, tostring(p1.name))
                table.insert(data, tostring(p1.happy))
                table.insert(data, tostring(p1.energy))
                table.insert(data, tostring(p1.health))
                table.insert(data, tostring(p1.hunger))

                for i = 1, #data do
                    love.filesystem.append('save.lua', data[i])
                    love.filesystem.append('save.lua', "\n")
                end
            end
            for i = 1, #dead do
                love.filesystem.append('save.lua', dead[i])
                love.filesystem.append('save.lua', "\n")
            end
            love.event.quit(0)
            
        end

        if suit.Button("Alimentar", 50, 50, 80, 80).hit then
            if p1:isdead() then return end
            p1:toFeed()
            bHunger2:upScale((p1.hunger / 1000))
            bEnergy2:upScale((p1.energy / 1000))
            ssV:animate("charizardC")
        end

        if suit.Button("Brincar", 150, 50, 80, 80).hit then
            if p1:isdead() then return end
            if p1.energy > 10 then
                if sound == true then src4:stop() end
                p1:toPlay()
                bHappy2:upScale((p1.happy / 1000))
                bEnergy2:upScale((p1.energy / 1000))
                ssV:animate("charizardV")
                Gaming = true
                minigaming.new()
            else
                return
            end
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
            love.graphics.draw(background, i * background:getWidth(),
                               j * background:getHeight())
        end
    end
    bHunger1:draw()
    bHunger2:draw()
    bHappy1:draw()
    bHappy2:draw()
    bEnergy1:draw()
    bEnergy2:draw()
    bHealth1:draw()
    bHealth2:draw()

    -- desenha os botões
    suit:draw()

    -- desenha sprite
    ssV:draw()

    -- nomes dos status
    love.graphics.print("FOME", 450, 75)
    love.graphics.print("FELICIDADE", 450, 105)
    love.graphics.print("ENERGIA", 450, 45)
    love.graphics.print("VIDA", 450, 15)
end

function Game:draw()
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
