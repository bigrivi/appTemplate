local class = clover.class
local View = clover.View
local UIModuleView = import "....core.UIModuleView"
local M = class(UIModuleView)
local Consts = import "....constants.Consts"

function M:ctor()
	M.__super.ctor(self)
end 

function M:init()
	M.__super.init(self)
	--[[
	self:bindEvents({
		["touch Button_Close"] = "onCloseHandler",
		["touch Button_Close1"] = "onCloseHandler",
	}) 
	]]--
end 




function M:destroy()
	dump("destroy")
end 

return M 
