-- import de classes
local g = require("src/game")
local s = require("suit")
local gameStatus = "menu"
--local menu = require("src/menu")
 x = s.new()
local suit = require ('suit')
Start = false --cond1
Load = false --cond2
Settings = false --cond3
Menu = true --cond4
cond = 0
function setOther(cond)
    if cond == 1 then
        Start = true -- TRUE
        Load = false --cond2
        Settings = false --cond3
        Menu = false --cond4
    elseif cond == 2 then
        Start = false --cond1
        Load = true --TRUE
        Settings = false --cond3
        Menu = false --cond4
    elseif cond == 3 then
        Start = false --cond1
        Load = false --cond2
        Settings = true --TRUE
        Menu = false --cond4
    elseif cond == 4 then
        Start = false --cond1
        Load = false --cond2
        Settings = false --cond3
        Menu = true --TRUE
    end
end

function love.load()
    game = g()
    --menu:load()
    background = love.graphics.newImage("graphics/bg.png")
end

--function love.update(dt)
--    game:update(dt)
    
    --x:Label("xxxxxxx", 1, 1, 50, 50)
--   gameStatus = menu:checkGoing()
--    if gameStatus == "start" then
--        gameStatus = "game"
--    end


--end

function love.update(dt)
    -- Put a button on the screen. If hit, show a message.
    if suit.Button("Start Game", 100,100, 300,30).hit then 
        setOther(1) 
        Menu = false
        print(Start)        
    end
    
    
    if suit.Button("Load", 100,140, 300,30).hit then setOther(2) end
    if suit.Button("Settings", 100,180, 300,30).hit then setOther(3) end
    if suit.Button("Quit", 100,220, 300,30).hit then setOther(4) end

end

function love.draw()
    if Menu == true then
        suit.draw()
    elseif Load == true then
        game:draw()
    elseif Settings == true then
        print("settings")
    elseif Quit == true then
        love.event.quit(0)
    elseif Start == true then
        game:draw()
    end

    
end


function love.gaming()
    game:draw()
end

