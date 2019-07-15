require("MG/chariz")
require("MG/free_fall")
require("MG/util")
--
local lose = false
local nextLevel = 5
local points = 0
local chzrd = nil
local class = require("src/class")
local Minigame = class:derive("Minigame")

function Minigame:new()
  --red = 100/255
  --green = 252/255
  --blue = 180/255
  --alpha = 80/100
  --background = love.graphics.newImage("MG/graphics/fundo.png")
  --love.graphics.draw(background)
  --love.graphics.setBackgroundColor( red, green, blue, alpha)
  love.window.setTitle("Queda Livre do Charizard")
  
  chzrd = newChzrd(3, 30)
  chzrd:initAllChzrd()
  
end

function Minigame:update()
  x , y = love.mouse.getPosition( )
  Minigame:mousepressed(x, y, button, istouch)
  lose = chzrd:updateChzrd()
end

function Minigame:mousepressed(x, y, button, istouch)
  points = points + chzrd:checkClickChzrd(x, y, points, nextLevel)
  
    if (points == nextLevel) then
      chzrd:IncNumChzrd()
      nextLevel = nextLevel + 10
    end
  
  if (lose == true) then
    chzrd:reinit() 
    lose = false
    points = 0
  end
end


function Minigame:draw()
  --Minigame:update()
  for i = 0, love.graphics.getWidth() / background:getWidth() do
    for j = 0, love.graphics.getHeight() / background:getHeight() do
        love.graphics.draw(background, i * background:getWidth(), j * background:getHeight())
    end
  end
  if (lose == false) then
    chzrd:drawChzrd()
  else
    love.graphics.print("FIM DE JOGO", 350, 300)
  end
  
  
  love.graphics.print("PONTOS: " .. points, 700, 400)
end
return  Minigame