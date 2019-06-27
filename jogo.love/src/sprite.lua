local class = require("src/class")
local Sprite = class:derive("Sprite")
local Anim = require("src/animation")
local Vector2 = require("src/vector2")

function Sprite:new(spriteX, w, h, x, y, sx, sy)
    self.w = w
    self.h = h
    self.x = x
    self.y = y
    self.scale = Vector2(sx or 1, sy or 1)
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
    love.graphics.draw(self.spriteX, self.quad, self.x , self.y, 0, self.scale.x, self.scale.y, self.w / 2, self.h / 2)
end

return Sprite