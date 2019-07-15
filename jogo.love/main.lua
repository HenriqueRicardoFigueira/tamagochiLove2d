-- import de classes
local g = require("src/game")
local s = require("suit")
local gameStatus = "menu"
 x = s.new()
local suit = require ('suit')
Start = false --cond1
Load = false --cond2
Settings = false --cond3
Menu = true --cond4
miniG = false -- cond5
cond = 0

function setOther(cond)
    if cond == 1 then
        Start = true -- TRUE
        Load = false --cond2
        Settings = false --cond3
        Menu = false --cond4
        miniG = false -- cond5
    elseif cond == 2 then
        Start = false --cond1
        Load = true --TRUE
        Settings = false --cond3
        Menu = false --cond4
        miniG = false -- cond5
    elseif cond == 3 then
        Start = false --cond1
        Load = false --cond2
        Settings = true --TRUE
        Menu = false --cond4
        miniG = false -- cond5
    elseif cond == 4 then
        Start = false --cond1
        Load = false --cond2
        Settings = false --cond3
        Menu = true --TRUE
        miniG = false -- cond5
        backgroundo = love.graphics.newImage("MG/graphics/fundo.png")
    elseif cond == 5 then
        Start = false --cond1
        Load = false --cond2
        Settings = false --cond3
        Menu = false --cond4
        miniG = true -- true
        miniGame:new()
    end
end

function love.load()
    
    
    --menu:load()
    background = love.graphics.newImage("graphics/bg.png")
    backgroundo = love.graphics.newImage("MG/graphics/fundo.png")
end

function love.update(dt)
   -- Put a button on the screen. If hit, show a message.
    if Menu == true then
        if suit.Button("Start Game", 100,100, 300,30).hit then setOther(1) 
            game = g()
            game:update(dt)
        end
        if suit.Button("Load", 100,140, 300,30).hit then setOther(2) end
        if suit.Button("Settings", 100,180, 300,30).hit then setOther(3) end
        if suit.Button("Quit", 100,220, 300,30).hit then setOther(4) end

    else
        game:update(dt)
    end

end


function love.draw()
    if Menu == true then
        for i = 0, love.graphics.getWidth() / backgroundo:getWidth() do
            for j = 0, love.graphics.getHeight() / backgroundo:getHeight() do
                love.graphics.draw(backgroundo, i * backgroundo:getWidth(), j * backgroundo:getHeight())
                --love.graphics.draw(background,100, 100, math.rad(0), 1, 1, width / 2, height / 2)
            end
          end
        suit.draw()
    elseif Load == true then
        game:draw()
    elseif Settings == true then
        print("settings")
    elseif Quit == true then
        love.event.quit(0)
    elseif Start == true then
        love.gaming()
    elseif miniG == true then
        miniGame:draw()   
       --print("minigame nao conectado")
    end

    
end

function love.gaming()
    game:draw()
end

