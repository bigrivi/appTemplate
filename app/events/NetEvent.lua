-- import
local class = require "clover.language.class"
local Event = clover.Event
-- class
local M = class(Event)

--- Event: create
M.CONNECTED                = "connecter"
M.CLOSE		               = "close"
M.RECEIVE_CODE             = "receive_code"

---
-- Event's constructor.
-- @param eventType (option)The type of event.
function M:ctor(eventType)
    Event:ctor(eventType)
	self.type = eventType
end


return M