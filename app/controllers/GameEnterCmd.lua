local class = clover.class
local logger = clover.Logger()
local NetEvent = import("..events.NetEvent")
local Consts = import "..constants.Consts"

local M = class()


function M:ctor()
	self.netServer = {}
	self.dispatcher = {}
	self.apiService = {}
end 

function M:execute(event)
	logger:info("user "..event.data.playerId.." enter game")
	self.apiService:startGame(event.data.playerId,handler(self,self.handlerStartGame))
end 

function M:handlerStartGame(data)
	logger:info("game start "..data)
	--enter default scene
	--self.dispatcher:dispatchEvent(clover.Event(AppConstants.SWITCH_SCENE),{name = "Main"})
	self.dispatcher:dispatchEvent(clover.Event(Consts.Command.TEST_MESSAGE))
	
end 

return M