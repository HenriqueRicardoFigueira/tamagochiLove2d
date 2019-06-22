local class = require("src/class")
local Sprite = class:derive("Sprite")
local Anim = require("src/animation")


function Sprite:new(spriteX, w, h, x, y)
    self.w = w
    self.h = h
    self.x = x
    self.y = y
    self.spriteX = spriteX
    self.animations = {}
    self.current_anim = ""
    self.quad = love.graphics.newQuad(0, 0, w, h, spriteX:getDimensions())
end

function Sprite:animate(anim_name)
    if self.current_anim ~= anim_name and self.animations[anim_name] ~= nil then
        self.current_anim = anim_name
        self.animations[anim_name]:reset()
        self.animations[anim_name]:set(self.quad)
       
    end
end

function Sprite:add_animation(name, anim)
    self.animations[name] = anim
end

function Sprite:update(dt)
    if self.animations[self.current_anim] ~= nil then
        self.animations[self.current_anim]:update(dt, self.quad)
    end
end

function Sprite:draw()
    love.graphics.draw(self.spriteX, self.quad, self.x , self.y, 0, 1, 1, self.w / 2, self.h / 2)
end

return Sprite