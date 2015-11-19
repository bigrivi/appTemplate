local EventDispatcher = require "clover.event.EventDispatcher"
local Collection = require "clover.core.Collection"
local M = clover.class(Collection)
local PlayerModel = import ".PlayerModel"
function M:ctor()
	self.dispatcher = {}
	self.injector = {}
	self.usePlayerIndex = 0
	M.__super.ctor(self,PlayerModel)
end 

function M:refreshList(playerListPB)
	for i,v in ipairs(playerListPB) do
		local model = PlayerModel()
		model:refresh(v)
		self:add(model)
	end 
end 


function M:selected(index)
	self.usePlayerIndex = index
	local player = self:at(self.usePlayerIndex)
	self.injector:mapValue("playerModel",player)
	return player
end 

function M:currentPlayer()
	return self:at(self.usePlayerIndex)
end 

return M