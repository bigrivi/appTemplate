local View = clover.View
local class = clover.class

local SceneBase = class(View)
--SceneBase._cocos_class = cc.Node

function SceneBase:ctor()
	SceneBase.__super.ctor(self)
    --self:enableNodeEvents()
    --self.name = name
	self.config = {}
	self.dispatcher = {}
	self.injector = {}
	self.modules = {}
	self.utils = {}
	self.facade = {}
	--self:ignoreAnchorPointForPosition(true)
	--self:setAnchorPoint(cc.p(0.5,0.5))
end

function SceneBase:init()
    if self.onCreate then self:onCreate() end
end 


function SceneBase:onCreate()
	
end 

function SceneBase:onOpen()
	
end 

function SceneBase:onClose()
	
end 

function SceneBase:onStart()
	
end 

function SceneBase:onStop()
		
end 

function SceneBase:destroy()

end 

function SceneBase:onTouch(evt)
	local screenX = evt.x
	local screenY = evt.y
	local sceneLoc = self.el:convertToNodeSpace(cc.p(screenX,screenY))
end 

return SceneBase
