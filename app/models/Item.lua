
local Model = require "clover.core.Model"

local M = clover.class(Model)
M.idAttribute = "config_id"

function M:ctor(defaults)
	if defaults == nil then
		defaults = {
			config_id = 0,
			amount   = 0
		}
	end 
	M.__super.ctor(self,defaults)
	self.dispatcher = {}
end 

return M