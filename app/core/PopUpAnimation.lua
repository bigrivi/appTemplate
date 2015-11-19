
local M = {}

local TIME = 0.3

function M.fadeScaleIn(target,params)
	params = params or {}
	target:setCascadeOpacityEnabled(true)
	target:setOpacity(0)
	local sec = params.time or TIME
	local ease = params.ease or cc.EaseBackOut
	local scale = params.scale or 0.1
	target:setScale(scale)
	local scaleAction = ease:create(cc.ScaleTo:create(sec,1,1))
	local anim = cc.Spawn:create(cc.FadeIn:create(sec),scaleAction)
	local fadeIn = cc.Sequence:create(anim,cc.CallFunc:create(function()
		if params.cb then
			params.cb()
		end 
	end))
	target:runAction(fadeIn)
end 

function M.fadeScaleOut(target,params)
	params = params or {}
	local sec = params.time or TIME
	local ease = params.ease or cc.EaseBackIn
	local scale = params.scale or 0.1
	local scaleAction = ease:create(cc.ScaleTo:create(sec,scale,scale))
	local anim = cc.Spawn:create(cc.FadeIn:create(sec),scaleAction)
	local fadeOut = cc.Sequence:create(anim,cc.CallFunc:create(function()
		if params.cb then
			params.cb()
		end 
	end))
	target:runAction(fadeOut)
end 


function M.scaleIn(target,params)
	params = params or {}
	local sec = params.time or TIME
	local ease = params.ease or cc.EaseBackOut
	local scale = params.scale or 0.1
	target:setScale(scale)
	local scaleAction = ease:create(cc.ScaleTo:create(sec,1,1))
	local anim = cc.Spawn:create(scaleAction)
	local fadeIn = cc.Sequence:create(anim,cc.CallFunc:create(function()
		if params.cb then
			params.cb()
		end 
	end))
	target:runAction(fadeIn)
end 


function M.scaleOut(target,params)
	params = params or {}
	local sec = params.time or TIME
	local ease = params.ease or cc.EaseBackIn
	local scale = params.scale or 0.1
	local scaleAction = ease:create(cc.ScaleTo:create(sec,scale,scale))
	local anim = cc.Spawn:create(scaleAction)
	local fadeOut = cc.Sequence:create(anim,cc.CallFunc:create(function()
		if params.cb then
			params.cb()
		end 
	end))
	target:runAction(fadeOut)
end 

function M.fromTop(target,params)
	params = params or {}
	local targetX,targetY = target:getPosition()
	target:setPositionY(display.top+target:getContentSize().height)
	local sec = params.time or TIME
	local ease = params.ease or cc.EaseBackInOut
	local moveAction = ease:create(cc.MoveTo:create(sec,cc.p(targetX,targetY)))
	local sequence = cc.Sequence:create(moveAction,cc.CallFunc:create(function()
		if params.cb then
			params.cb()
		end 
	end))
	target:runAction(sequence)
end 

function M.fromBottom(target,params)
	params = params or {}
	local targetX,targetY = target:getPosition()
	target:setPositionY(display.bottom-target:getContentSize().height)
	local sec = params.time or TIME
	local ease = params.ease or cc.EaseBackInOut
	local moveAction = ease:create(cc.MoveTo:create(sec,cc.p(targetX,targetY)))
	local sequence = cc.Sequence:create(moveAction,cc.CallFunc:create(function()
		if params.cb then
			params.cb()
		end 
	end))
	target:runAction(sequence)
end 

function M.toBottom(target,params)
	params = params or {}
	local targetX,targetY = target:getPosition()
	targetY = display.bottom-target:getContentSize().height
	local sec = params.time or TIME
	local ease = params.ease or cc.EaseBackInOut
	local moveAction = ease:create(cc.MoveTo:create(sec,cc.p(targetX,targetY)))
	local sequence = cc.Sequence:create(moveAction,cc.CallFunc:create(function()
		if params.cb then
			params.cb()
		end 
	end))
	target:runAction(sequence)
end 

function M.toTop(target,params)
	params = params or {}
	local targetX,targetY = target:getPosition()
	targetY = display.top+target:getContentSize().height
	local sec = params.time or TIME
	local ease = params.ease or cc.EaseBackInOut
	local moveAction = ease:create(cc.MoveTo:create(sec,cc.p(targetX,targetY)))
	local sequence = cc.Sequence:create(moveAction,cc.CallFunc:create(function()
		if params.cb then
			params.cb()
		end 
	end))
	target:runAction(sequence)
end 


function M.fadeIn(target,params)
	params = params or {}
	target:setCascadeOpacityEnabled(true)
	target:setOpacity(0)
	local sec = params.time or TIME
	local fadeIn = cc.Sequence:create(cc.FadeIn:create(sec),cc.CallFunc:create(function()
		if params.cb then
			params.cb()
		end 
	end))
	target:runAction(fadeIn)
end 

function M.fadeOut(target,params)
	params = params or {}
	local sec = params.time or TIME
	local fadeOut = cc.Sequence:create(cc.FadeOut:create(sec),cc.CallFunc:create(function()
		if params.cb then
			params.cb()
		end 
	end))
	target:runAction(fadeOut)
end 

return M



