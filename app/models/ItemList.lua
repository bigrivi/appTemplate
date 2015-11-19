local EventDispatcher = require "clover.event.EventDispatcher"
local Collection = require "clover.core.Collection"
local M = clover.class(Collection)
local Item = import ".Item"
function M:ctor()
	self.dispatcher = {}
	self.list = {}
	M.__super.ctor(self,Item,{comparator = function(a,b)
		return a.amount<b.amount
	end})
end 

function M:refreshList(list)
	for _,itemInfo in ipairs(list) do
		self:add(Item({
			config_id	= itemInfo.u_item_id,
			amount		= itemInfo.u_item_num 
		}))
	end 
end 



return M