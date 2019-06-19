local class = require("src/class")
local Pet = class:derive("Pet")

function Pet:new(name)
    self.name = name
    self.health = 100
    self.hunger = 100
    self.happy = 100
    self.sleeping = false
    self.tired = false
    self.dirty = false
    self.dead = false
    self.sad = false
    self.hungry = false
end

function Pet:isdead()
    if self.health == 0 then
        return true
    else 
        return false
    end
end

return Pet