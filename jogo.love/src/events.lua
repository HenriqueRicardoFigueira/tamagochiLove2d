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

function Events:add(evt_type)
    assert(self.handlers[evt_type] == nill, "Event already exists")
    self.handlers[evt_type] = {}
end

function Events:remove(evt_type)
    self.handlers[evt_type] = nil
end

function Events:hook(evt_type, callback)
    
    assert(type(callback) == "function", "callback parameter must be a function")

    if self.event_must_exist then
        assert(self.handlers[evt_type] ~= nill, "Event of type does not exists")
    
    elseif(self.handlers[evt_type] == nil) then
        self:add(type)
    end
    
    assert(index_of(self.handlers[evt_type], callback) == -1, "callback has already been register")

    local tbl = self.handlers[evt_type]
    tbl[#tbl + 1] = callback
end

function Events:unhook(evt_type, callback)
    assert(type(callback) == "function", "callback parameter must be a function")
    if self.handlers[evt_type] == nil then return end
    local index = index_of(self.handlers[evt_type], callback)
    if index > -1 then
        table.remove(self.handlers[evt_type], index)
    end
end

function Events:invoke(evt_type, ...)
    assert(self.handlers[evt_type] ~= nill, "Event of type does not exists")  
    local tbl = self.handlers[evt_type] 
    for i = 1, #tbl do
        tbl[i](...)
    end
end

return Events