local class = require("src/class")
local Pet = class:derive("Pet")
math.randomseed(os.time())
function Pet:new(name)
    self.name = name
    self.health = 100
    self.hunger = 0
    self.happy = 0
    self.energy = 100
    self.state = {
        sleeping = false,
        tired = false,
        dirty = false,
        dead = false,
        sad = false,
        hungry = false
    }
end

function Pet:isdead() 
    if self.health < 1 then 
        return true 
    end 
end

function Pet:toFeed()
    if self.hunger >= 0 then
        self.hunger = self.hunger - math.random()
        self.energy = self.energy - math.random()
    end
end

function Pet:toPlay()
    if self.energy > 10 then
        self.energy = self.energy - math.random()
        self.happy = self.happy + math.random()
    end
end

function Pet:tired() if self.energy < 30 then self.state.tired = true end end

function Pet:degree()
    if self.health > 0 then self.health = self.health - 0.001 end
    if self.health > 0 and self.hunger < 100 then self.hunger = self.hunger + 0.1 end
    if self.happy > 0 then self.happy = self.happy - 0.01 end
    if self.energy > 0 then self.energy = self.energy - 0.01 end
    if self.hunger >= 100 and self.health > 0 then self.health = self.health - 1 end
   -- print("envelheceu")
   -- print(self.health)
   -- print(self.happy)

end

return Pet
