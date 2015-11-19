local class = clover.class
local View = clover.View

local Consts = import "..constants.Consts"

local M = class(View)

function M:ctor()
	M.__super.ctor(self)
	self.utils = {}
	self.config = {}
end 

function M:init()
	self.btnClose = self:getItem("Button_Close")
	if self.btnClose then
		self.btnClose:onClicked(handler(self,self.onCloseHandler))
	end 
end 

function M:onCloseHandler()
	self.utils:removePopUp(self.el)
end  


return M
