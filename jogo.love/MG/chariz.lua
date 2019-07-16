require("MG/free_fall")
require("MG/util")

local Chzrd = {}
Chzrd.__index = Chzrd
local image_charV = love.graphics.newImage("MG/graphics/5d.png")

function newChzrd(numChzrd, rChar)
  
  local a = {}
  --src3 = love.audio.newSource("sounds/acertou.wav", "static")
  a.numChzrd = numChzrd
  a.rChar = rChar
  a.chzrd = nil
  
  return setmetatable(a, Chzrd)
  
end

function Chzrd:initBall(index)
  self.chzrd[index] = newFreeFall(0.1, 0.0, math.random(0 + self.rChar, 800 - self.rChar), 
    0.0, 600.0, 0.001, self.rChar)
end

function Chzrd:initAllChzrd()
  self.chzrd = {}
  for index = 1, self.numChzrd do
    self.initBall(self, index)
  end
end

function Chzrd:updateChzrd()
  local lose = false
  for index = 1, self.numChzrd do
    self.chzrd[index]:update()
    if (self.chzrd[index]:isEnding()) then
      lose = true
    end
  end
  return lose
end

function Chzrd:checkClickChzrd(x, y)
  
  local points = 0
  
  for index = 1, self.numChzrd do
    if (checkMousePosIn(x, y, self.chzrd[index]:getX(), self.chzrd[index]:getY(), 
        self.rChar) == true) then
      self.initBall(self, index)
      --src3:play()
      --src3:stop() 
      points = points + 1
    end
  end
  
  return points
end

function Chzrd:IncNumChzrd()
  self.numChzrd = self.numChzrd + 1
  self.initBall(self, self.numChzrd)
end

function Chzrd:reinit()
    self.numChzrd = 3
    self.initAllChzrd(self)
end

function Chzrd:drawChzrd()
  for index = 1, self.numChzrd do
    love.graphics.draw(image_charV, self.chzrd[index]:getX(), self.chzrd[index]:getY(), self.rChar)
  end
end

return Chzrd