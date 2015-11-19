local class = clover.class
local logger = clover.Logger()
local NetEvent = import("..events.NetEvent")
local AppView = import "..core.AppView"
local Consts = import "..constants.Consts"

local M = class()


function M:ctor(config)
	--inject 
	self.facade = {}
	self.netServer = {}
	self.dispatcher = {}
	self.utils = {}
	self.config = {}
end 

function M:execute(event)
    math.randomseed(os.time())
	logger:info("app startUp")
	if CC_SHOW_FPS then
        cc.Director:getInstance():setDisplayStats(true)
    end
	local scene = display.newScene()
	if cc.Director:getInstance():getRunningScene() then
		cc.Director:getInstance():replaceScene(scene)
	else
		display.runScene(scene)
	end
	cc.Director:getInstance():purgeCachedData()
	self.facade:createView(AppView,scene,{a=1,b=2})
	--self.netServer:connect(self.config.server_host,self.config.server_port)
	local function handleConnenced()
		logger:info("connect success")
		self.dispatcher:dispatchEvent(clover.Event(Consts.Command.LOGIN),{ name = "andy",password = "111111"})
	end 
	self.netServer:addEventListener(NetEvent.RECEIVE_CODE,handleConnenced)
	self.utils:switchScene(Consts.Scene.MAIN)
end 

return M
