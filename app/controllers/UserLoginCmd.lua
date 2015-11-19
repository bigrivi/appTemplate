local class = clover.class
local logger = clover.Logger()
local Consts = import "..constants.Consts"

local M = class()


function M:ctor()
	--ibject 
	self.netServer = {}
	self.userModel = {}
	self.userPlayerList = {}
	self.dispatcher = {}
	self.apiService = {}
end 

function M:execute(event)
	logger:info("user "..event.data.name.." login")
	self.apiService:login(event.data.name,event.data.password,handler(self,self.handlerLogin))
end 

function M:handlerLogin(code,data)
	local uid = data.u_user_id
	local playerList = data.arr_player_info
	self.userModel:set("user_id",uid)
	self.userPlayerList:refreshList(playerList)
	logger:info("login success uid=>%d",uid)
	--local playerList = self.playerModel:getPlayerList()
	--dump(#playerList)
	local playerCount = self.userPlayerList:length()
	logger:info("num of players %d",playerCount)
	--playerCount = 0
	if playerCount>0 then
		local player = self.userPlayerList:selected(1)
		self.injector:mapValue("playerInfo",player)
		local usePlayerId = player:get("player_id")
		self.dispatcher:dispatchEvent(clover.Event(Consts.Command.ENTER_GAME),{playerId = usePlayerId})
	else
		self.dispatcher:dispatchEvent(clover.Event(Consts.Command.CREATE_PLAYER),{index = 1,name='clover6',uid = uid})
	end 
end 

return M