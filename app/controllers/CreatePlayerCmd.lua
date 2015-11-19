local class = clover.class
local logger = clover.Logger()
local NetEvent = import("..events.NetEvent")

local M = class()


function M:ctor()
	self.netServer = {}
	self.userModel = {}
	self.playerModel = {}
	self.apiService = {}
end 

function M:execute(event)
	logger:info("user "..event.data.name.." CreatePlayer")
	self.apiService:createPlayer(event.data.index,event.data.name,event.data.uid,handler(self,self.handlerCreate))
end 

function M:handlerCreate()
	logger:info("create player success")
end 

return M