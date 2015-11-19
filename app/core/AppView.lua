local class = clover.class
local View = clover.View

local SceneView = import ".SceneView"
local PopUpView = import ".PopUpView"
local Consts = import "..constants.Consts"

local M = class(View)

function M:ctor()
	self.__super.ctor(self)
end 


function M:render()
	self.sceneLayer = display.newLayer():addTo(self.el)
	self.uiLayer = display.newLayer():addTo(self.el)
	self.popUpLayer = display.newLayer():addTo(self.el)
	
	return self
end 

function M:init()
	self:render()
	self.facade:createView(SceneView,self.sceneLayer)
	self.facade:createView(PopUpView,self.popUpLayer)
	self.dispatcher:addEventListener(Consts.LOCK_SCREEN,handler(self,self.onScreenLock))
	self.dispatcher:addEventListener(Consts.UN_LOCK_SCREEN,handler(self,self.onScreenUnLock))
end 

--
--场景锁屏
--

function M:onScreenLock(event)
	if self.lockMask then
		return
	end 
	local size = display.size
	local color = cc.c4b(20,20,20,0)
	local layer = cc.LayerColor:create(color,size.width,size.height)
   
	local listener = cc.EventListenerTouchOneByOne:create()
	listener:setSwallowTouches(true)
	local function onTouchBegan(touch, event)
		return layer:isVisible()
	end
	listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN)
	local eventDispatcher = self.el:getEventDispatcher()
	eventDispatcher:addEventListenerWithSceneGraphPriority(listener,layer)
	self.lockMask = layer
	self.el:addChild(layer)
end 

--
--场景锁屏解锁
--
function M:onScreenUnLock(event)
	if self.lockMask then
		self.el:removeChild(self.lockMask)
		self.lockMask = nil
	end 
end 



function M:getAppView()
	return self.target
end 

return M