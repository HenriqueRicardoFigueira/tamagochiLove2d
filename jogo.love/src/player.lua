local class = require("src/class")
local Player = class:derive("Player")

function Player:new(name)
    self.name = name
end

return Player