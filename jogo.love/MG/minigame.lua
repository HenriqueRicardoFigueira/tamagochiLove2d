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
local suito = require ('suit')

function Minigame:new()
  src3 = love.audio.newSource("sounds/acertou.wav", "static")
  --red = 100/255
  --green = 252/255
  --blue = 180/255
  --alpha = 80/100
  --suito.reinit()
  src1 = love.audio.newSource("sounds/minigame.wav", "static")
 
  src1:setVolume(0.9) -- 90% of ordinary volume
  src1:setPitch(0.5) -- one octave lower
  src3:setVolume(0.9) -- 90% of ordinary volume
  src3:setPitch(0.5)

  --soundData = love.sound.newSoundData("sounds/minigame.wav", 'static')
  background = love.graphics.newImage("MG/graphics/fundo.png")
  width = background:getWidth()
  height = background:getHeight()

  --love.graphics.setBackgroundColor( red, green, blue, alpha)
  love.window.setTitle("Queda Livre do Charizard")
  
  chzrd = newChzrd(3, 30)
  chzrd:initAllChzrd()
  
end

function Minigame:update()
  x , y = love.mouse.getPosition( )
  Minigame:mousepressed(x, y, button, istouch)
  lose = chzrd:updateChzrd()
  if sound == true then
    src1:play()
  end
  if suito.Button("Sair", 50,50, 100,30).hit then 
    if sound == true then
      src1:stop()
    end
    Gaming = false 
    


  end
end

function Minigame:mousepressed(x, y, button, istouch)
  points = points + chzrd:checkClickChzrd(x, y, points, nextLevel)
  src3:play()
  
    if (points == nextLevel) then
      chzrd:IncNumChzrd()
      nextLevel = nextLevel + 10
    end
  
  if (lose == true) then
    chzrd:reinit() 
    lose = false
    points = 0
  end
  src3:stop()
end


function Minigame:draw()
  --Minigame:update()
  
  for i = 0, love.graphics.getWidth() / background:getWidth() do
    for j = 0, love.graphics.getHeight() / background:getHeight() do
        love.graphics.draw(background, i * background:getWidth(), j * background:getHeight())
        --love.graphics.draw(background,100, 100, math.rad(0), 1, 1, width / 2, height / 2)
    end
  end
  if (lose == false) then
    chzrd:drawChzrd()
  else

    
    love.graphics.print("FIM DE JOGO", 350, 300)
 
  end
  
  suito.draw()
  love.graphics.print("PONTOS: " .. points, 700, 400)
end
return  Minigame