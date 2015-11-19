local class = clover.class
local View = clover.View
local PopUpAnimation = import ".PopUpAnimation"
local Consts = import "..constants.Consts"
local logger = clover.Logger()
local M = class(View)

function M:init()
	self.popUpMaps = {}
	--add popUp
	self.dispatcher:addEventListener(Consts.POP_UP_ADD,handler(self,self.onPopUpAdd))
	--remove popUp
	self.dispatcher:addEventListener(Consts.POP_UP_REMOVE,handler(self,self.onPopUpRemove))
	--remove all popUps
	self.dispatcher:addEventListener(Consts.POP_UP_REMOVE_ALL,handler(self,self.onPopUpRemoveAll))
	
	-- front popUp
	self.dispatcher:addEventListener(Consts.POP_UP_FRONT,handler(self,self.onPopUpFront))
end 

function M:onPopUpAdd(event)
	local moduleOrView = event.data.module
	local moduleUIView,name,viewClass,openAnim,closeAnim
	if moduleOrView["viewClass"] then --配置好的模块
		local uiPath = moduleOrView.url
		viewClass = moduleOrView.viewClass
		openAnim = moduleOrView.openAnim
		closeAnim = moduleOrView.closeAnim
		name = moduleOrView.name
		moduleUIView = clover.utils.DisplayObjectUtil.createNode(uiPath)
	else
		moduleUIView = moduleOrView
		openAnim = event.data.params.openAnim
		closeAnim = event.data.params.closeAnim
	end 
	openAnim = openAnim or "fadeScaleIn"
	closeAnim = closeAnim or "fadeScaleOut"
	local params = event.data.params
	local modal = event.data.modal
	if not self.modal and modal then
		self.modal = self:createModal()
		self.modalLayer = moduleUIView
		self.el:addChild(self.modal,0)
	end 
	self.el:addChild(moduleUIView)
	local view
	if viewClass then
		view = self.facade:createView(viewClass,moduleUIView,params)
	else
		view = moduleUIView
	end 
	self.popUpMaps[moduleUIView] = {view,name,closeAnim}
	--play anim
	if openAnim ~="custom" then
		openAnim =  PopUpAnimation[openAnim]
		openAnim(moduleUIView)
	end 
	
end 

function M:onPopUpRemove(event)
	local window = event.data.window
	if window.name  then
		window = self:getPopUpByName(window.name)
	end 
	self:removePopUp(window)
end 

function M:removePopUp(window,anim)
	anim = anim or true
	local view = self.popUpMaps[window][1]
	if self.modal and self.modalLayer == window then
		self.el:removeChild(self.modal)
		self.modal = nil
		self.modalLayer = nil
	end 	
	local moduleUIView = nil
	if view["remove"] then --is View
		moduleUIView = view.el
	else
		moduleUIView = window
	end 
	
	local function removeWindow()
		if view["remove"] then --is View
			view:remove()
		else
			self.el:removeChild(window)
		end 
		self.popUpMaps[window] = nil
	end 
	
	if not anim then
		removeWindow()
		return 
	end 
	
	local closeAnim = self:getPopUpByCloseAnim(moduleUIView)
	if closeAnim =="custom" then
		removeWindow()
		return 
	end 
	closeAnim =  PopUpAnimation[closeAnim]
	closeAnim(moduleUIView,{cb = function()
		removeWindow()
	end})
end 

function M:onPopUpFront(event)
	local window = event.data
	if window.name  then
		window = self:getPopUpByName(window.name)
	end 
	window:setLocalZOrder(self.el:getLocalZOrder() + 1)
   
end 

function M:onPopUpRemoveAll()
	local moduleViews = self.el:getChildren()
	for window,data in ipairs(moduleViews) do
		self:removePopUp(window,false)
	end 
end 


function M:getPopUpByName(name)
	for window,data in pairs(self.popUpMaps) do
		if #data>1 and data[2] == name then
			return window
		end 
	end 
	return nil
end

function M:getPopUpByCloseAnim(_window)
	for window,data in pairs(self.popUpMaps) do
		if window == _window then
			return data[3]
		end 
	end 
	return nil
end

function M:createModal()
	local size = display.size
	local color = cc.c4b(20,20,20,150)
	local layer = cc.LayerColor:create(color,size.width,size.height)
   
	local listener = cc.EventListenerTouchOneByOne:create()
	listener:setSwallowTouches(true)
	local function onTouchBegan(touch, event)
		return layer:isVisible()
	end
	listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN)
	local eventDispatcher = self.el:getEventDispatcher()
	eventDispatcher:addEventListenerWithSceneGraphPriority(listener,layer)
	return layer
end 

return M
