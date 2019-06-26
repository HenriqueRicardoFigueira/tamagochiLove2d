local class = require("src/class")
local Vector2 = require("src/vector2")
local Bars = class:derive("Bars")

function Bars:new( image, x, y, angle, sx, sy, ox, oy)
    self.image = image
    self.x = x
    self.y = y
    self.angle = angle or math.rad(0)
    self.sx = sx
    self.sy = sy
    self.ox = ox
    self.oy = oy
end

function Bars:upScale(x)
    self.sx = x
end
function Bars:draw()
    love.graphics.draw(self.image, self.x, self.y, self.angle, self.sx, self.sy, self.ox, self.oy)
end

return Bars