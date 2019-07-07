require("free_fall")
require("util")

local Chrzd = {}
Chrzd.__index = Chrzd
local image_charV = love.graphics.newImage("graphics/5d.png")
function newChrzd(numChrzd, rBall)
  
  local a = {}
  
  a.numChrzd = numChrzd
  a.rBall = rBall
  a.chrzd = nil
  
  return setmetatable(a, Chrzd)
  
end

function Chrzd:initBall(index)
  self.chrzd[index] = newFreeFall(0.1, 0.0, math.random(0 + self.rBall, 800 - self.rBall), 
    0.0, 600.0, 0.001, self.rBall)
end

function Chrzd:initAllChrzd()
  self.chrzd = {}
  for index = 1, self.numChrzd do
    self.initBall(self, index)
  end
end

function Chrzd:updateChrzd()
  local lose = false
  for index = 1, self.numChrzd do
    self.chrzd[index]:update()
    if (self.chrzd[index]:isEnding()) then
      lose = true
    end
  end
  return lose
end

function Chrzd:checkClickChrzd(x, y)
  
  local points = 0
  
  for index = 1, self.numChrzd do
    if (checkMousePosIn(x, y, self.chrzd[index]:getX(), self.chrzd[index]:getY(), 
        self.rBall) == true) then
      self.initBall(self, index)
      points = points + 1
    end
  end
  
  return points
end

function Chrzd:IncNumChrzd()
  self.numChrzd = self.numChrzd + 1
  self.initBall(self, self.numChrzd)
end

function Chrzd:reinit()
    self.numChrzd = 3
    self.initAllChrzd(self)
end

function Chrzd:drawChrzd()
  for index = 1, self.numChrzd do
    love.graphics.draw(image_charV, self.chrzd[index]:getX(), self.chrzd[index]:getY(), self.rBall)
  end
end

