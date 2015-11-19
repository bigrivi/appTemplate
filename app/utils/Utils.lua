----------------------------------------------------------------
-- APP 级别的工具
-- author andy.sun
-- created by 2015/09/6
-----------------------------------------------------------------


local M = clover.class()
local Consts = import "..constants.Consts"

function M:ctor()
	
	self.dispatcher = {}
	
	self.injector = {}
	
end 

----
-- 弹出新窗口
----

function M:createPopUp(moduleIdOrView,modal,opts)
	modal = modal or true
	self.dispatcher:dispatchEvent(clover.Event(Consts.POP_UP_ADD),{ module = moduleIdOrView,modal = modal,params = opts})
end 

---
-- 置顶
---
function M:frontPopUp(moduleIdOrView)
	self.dispatcher:dispatchEvent(clover.Event(Consts.POP_UP_FRONT),moduleIdOrView)
end 

----
-- 删除一个弹窗
----
function M:removePopUp(moduleIdOrView)
	self.dispatcher:dispatchEvent(clover.Event(Consts.POP_UP_REMOVE),{window=moduleIdOrView})
end

----
-- 删除当前所有弹窗
----
function M:removeAllPopUp()
	self.dispatcher:dispatchEvent(clover.Event(Consts.POP_UP_REMOVE_ALL))
end 

----
-- 锁屏
----
function M:lockScreen()
	self.dispatcher:dispatchEvent(clover.Event(Consts.LOCK_SCREEN))
end 


----
-- 屏幕解锁
----
function M:unLockScreen()
	self.dispatcher:dispatchEvent(clover.Event(Consts.UN_LOCK_SCREEN))
end

----
-- 场景跳转
----
function M:switchScene(name,opts,transition)
	transition = transition or "none"
	self.dispatcher:dispatchEvent(clover.Event(Consts.SWITCH_SCENE),{name=name,initOption = opts,transition = transition})
end 


return M
