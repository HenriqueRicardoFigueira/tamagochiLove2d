local class = require("class")
local Sprite = class:derive("Sprite")


function Sprite:new()
    self.animations = {}
end

function Sprite:animate(anim_name)
    -- body
end

function Sprite:update(dt)
    -- body
end

function Sprite:draw()
    -- body
end

return Sprite