local M = clover.class()
local logger = clover.Logger()

function M:ctor()
	--inject
	self.dispatcher = {}
	self.userModel = {}
	self.playerModel = {}
	self.itemModel = {}
	self.itemList = {}
	self.playerInfo = {}
end 


function M:execute(evt)
	local data = evt.data
	local code = data.code
	local msgName = data.msgName
	local msgData = data.msgData
	logger:info("async message [0x%x] %s",code,msgName)
	if msgData then
		if msgName == "SyncResResponse" then
			-- 刷新资源
			self.userModel:refreshResorce(msgData.res)
		elseif msgName == "SyncPlayerParamResponse" then
			self.playerInfo:refreshPlayerParam(msgData.player_param)
		elseif msgName == "SyncItemResponse" then
			self.itemList:refreshList(msgData.arr_item_list)
			logger:info("new item %d",#msgData.arr_item_list)
		elseif msgName == "SyncChatResponse" then
			logger:info("new chat message")
			print(tostring(msgData.chat_info))
		end
	end 

end

return M