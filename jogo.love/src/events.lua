local class = require("src/class")

local Events = class:derive("Events")

function Events:new(event_must_exist)
    self.handlers = {}
    self.event_must_exist = (event_must_exist == nill) or event_must_exist
end

local function index_of(evt_tbl, callback)
    if(evt_tbl == nil or callback == nil) then return -1 end
    
    for i = 1, #evt_tbl do
        if evt_tbl[i] == callback then return i end
    end
    return -1
end

function Events:add(type)
    assert(self.handlers[type] == nill, "Event already exists")
    self.handlers[type] = {}
end

function Events:remove(type)
    self.handlers[type] = nil
end

function Events:hook(type, callback)
    
    assert(type(callback) == "function", "callback parameter must be a function")

    if self.event_must_exist then
        assert(self.handlers[type] ~= nill, "Event of type does not exists")
    
    elseif(self.handlers[type] == nil) then
        self:add(type)
    end
    
    assert(index_of(self.handlers[type], callback) == -1, "callback has already been register")

    local tbl = self.handlers[type]
    tbl[#tbl + 1] = callback
end

function Events:unhook(type, callback)
    assert(type(callback) == "function", "callback parameter must be a function")
    if self.handlers[type] == nil then return end
    local index = index_of(self.handlers[type], callback)
    if index > -1 then
        table.remove(self.handlers[type], index)
    end
end

function Events:invoke(type, ...)
    assert(self.handlers[type] ~= nill, "Event of type does not exists")  
    local tbl = self.handlers[type] 
    for i = 1, #tbl do
        tbl[i](...)
    end
end

return Events