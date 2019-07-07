require("chariz")

local lose = false
local nextLevel = 5
local points = 0
local chrzd = nil

function love.load()
  red = 100/255
  green = 252/255
  blue = 180/255
  alpha = 80/100
  background = love.graphics.newImage("/graphics/fundo.png")
  --love.graphics.draw(background)
  --love.graphics.setBackgroundColor( red, green, blue, alpha)
  love.window.setTitle("Queda Livre do Charizard")
  
  chrzd = newChrzd(3, 30)
  chrzd:initAllChrzd()
  
end

function love.update()
  lose = chrzd:updateChrzd()
end

function love.mousepressed(x, y, button, istouch)
  points = points + chrzd:checkClickChrzd(x, y, points, nextLevel)
  
    if (points == nextLevel) then
      chrzd:IncNumChrzd()
      nextLevel = nextLevel + 10
    end
  
  if (lose == true) then
    chrzd:reinit() 
    lose = false
    points = 0
  end
end


function love.draw()
  for i = 0, love.graphics.getWidth() / background:getWidth() do
    for j = 0, love.graphics.getHeight() / background:getHeight() do
        love.graphics.draw(background, i * background:getWidth(), j * background:getHeight())
    end
  end
  if (lose == false) then
    chrzd:drawChrzd()
  else
    love.graphics.print("FIM DE JOGO", 350, 300)
  end
  
  
  love.graphics.print("PONTOS: " .. points, 700, 400)
end