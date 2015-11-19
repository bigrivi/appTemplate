local class = clover.class
local logger = clover.Logger("StartUpCmd")
local NetEvent = import("..events.NetEvent")

local M = class()


function M:ctor()
	self.apiService = {}
end 

function M:execute(event)
	logger:info("user "..event.data.name.." reg")
	self.apiService:reg(event.data.name,event.data.password,handler(self,self.handlerReg))
end 

function M:handlerReg(data)
	logger:info("reg success"..data)
end 

return M