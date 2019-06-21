local class = require("src/class")
local Pet = class:derive("Pet")

function Pet:new(name)
    self.name = name
    self.health = 100
    self.hunger = 100
    self.happy = 100
    self.energy = 100
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

function Pet:toFeed()
    if self.hunger > 0 then
        self.hunger = self.hunger - 10
    end
end

function Pet:toPlay()
    if self.energy > 10 then
        self.energy = self.energy - 10
        self.happy = self.happy + 10
    end
end

return Pet