----------------------------------------------------------------
-- 场景切换
-- author andy.sun
-- created by 2015/07/20
-----------------------------------------------------------------

local class = clover.class
local View = clover.View
local Consts = import "..constants.Consts"
local logger = clover.Logger()
local SceneAnimation = import ".SceneAnimation"
local SceneBase = import ".SceneBase"

local M = class(View)

function M:ctor()
	self.__super.ctor(self)
	self.config = {}
end 

function M:init()
	self.dispatcher:addEventListener(Consts.SWITCH_SCENE,handler(self,self.onSwitchScene))
end 


function M:onSwitchScene(event)
	if self.transitioning then
		return
	end 
	assert(event.data.name,"scene name is null!")
	logger:info("Switch Scene to %s",event.data.name)
	if self.currentScene then
		self.currentScene:onStop()
	end 
	--load scene res
	logger:info("start load scene %s res ...",event.data.name)
	logger:info("scene %s res load complete",event.data.name)
	
	self.nextScene = self:createScene(event.data)
	self.nextScene:onOpen()
	self.el:addChild(self.nextScene.el)
	self.transitioning = true
	local transition = event.data.transition
	transition = transition or "none"
	--run scene switch animation 
	--执行携程
	local doSwitch = function()
        SceneAnimation[transition](self.currentScene and self.currentScene.el or cc.Node:create(),self.nextScene.el,{sec = 0.5})
		coroutine.yield()
		if self.currentScene then
			self.currentScene:onClose()
			self.currentScene:remove()
		end 
		self.currentScene = self.nextScene
		self.currentScene:onStart()
		self.el:onTouch(function(evt)
			self.currentScene:onTouch(evt)
		end,false,true)
		self.injector:mapValue("currentScene",self.currentScene)
		self.transitioning = false
    end
	local co = coroutine.create(function()
        local status, msg = pcall(doSwitch, __G__TRACKBACK__)
        if not status then
            error(msg)
        end
    end);
	coroutine.resume(co)
end 

function M:createScene(params)
	assert(params.name,"Invalid Scene Name")
	local sceneName = params.name
	local initOption = params.initOption
	local sceneConfig = self.config.scenes[sceneName]
	local sceneCls
	sceneCls = sceneConfig.viewClass
	if sceneCls == nil then
		sceneCls = SceneBase
	end 
	local node = cc.Node:create()
	node:setContentSize(display.size)
	node:setAnchorPoint(cc.p(0.5,0.5))
	node:setPosition(cc.p(display.cx,display.cy))
	local scene = self.facade:createView(sceneCls,node,{name = sceneName,initOption =initOption })
	return scene
end 


function M:onRemove()
	
end 



return M