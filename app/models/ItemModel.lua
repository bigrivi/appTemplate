local EventDispatcher = require "clover.event.EventDispatcher"
local M = clover.class()

function M:ctor()
	self.dispatcher = {}
	self.list = {}
end 

function M:refreshList(list)
	for _,itemInfo in ipairs(list) do
		self:refreshItemInfo(itemInfo)
	end 
end 

function M:refreshItemInfo(itemInfoPB)
	local itemInfo = self.list[itemInfoPB.item_id]
	if itemInfo== nil then
		itemInfo = ItemVO()
		self.list[itemInfoPB.item_id] = itemInfo
	end 
	itemInfo.item_id = itemInfoPB.u_item_id
	itemInfo.item_num = itemInfoPB.u_item_num
	if itemInfoPB.u_item_num == 0 then --删除
		self.list[itemInfoPB.item_id] = nil
	end 
end 

function M:getItemList()
	return self.list
end 

return M