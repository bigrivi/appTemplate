local SceneAnimation = {}

--无动作
function SceneAnimation.none(currentScene,nextScene,params)
	local current = coroutine.running()
	clover.Executors.setTimeOut(function()
		coroutine.resume(current)
	end,0.1)
	
end 

--淡入淡出
function SceneAnimation.fade(currentScene,nextScene,params)
	params = params or {}
	local current = coroutine.running()
	local sec = params.sec or 0.5
	currentScene:setCascadeOpacityEnabled(true)
	currentScene:setOpacity(255)
	nextScene:setCascadeOpacityEnabled(true)
	nextScene:setOpacity(0)
	local fadeIn = cc.Sequence:create(cc.FadeIn:create(sec),cc.CallFunc:create(function()
		coroutine.resume(current)
	end))
	local fadeOut = cc.FadeOut:create(sec)
	nextScene:runAction(fadeIn)
	currentScene:runAction(fadeOut)
end 

function SceneAnimation.fadeColor(currentScene,nextScene,params)
	params = params or {}
	local current = coroutine.running()
	local sec = params.sec or 0.5
	local color = params.color or cc.c3b(0,0,0)
	local layer = cc.LayerColor:create(color)
	layer:setOpacity(0)
	nextScene:setVisible(false)
	currentScene:getParent():addChild(layer,1)
	local action = cc.Sequence:create(
		cc.FadeIn:create(sec/2),
		cc.CallFunc:create(function()
			currentScene:setVisible(false)
			nextScene:setLocalZOrder(currentScene:getParent():getLocalZOrder() )
			nextScene:setVisible(true)
		end),
		cc.FadeOut:create(sec/2),
		cc.CallFunc:create(function()
			coroutine.resume(current)
		end)
	)
	layer:runAction(action)
end 



--创建一个从右推入顶出旧场景的过渡动画
function SceneAnimation.slideFromR(currentScene,nextScene,params)
	params = params or {}
	local current = coroutine.running()
	local sec = params.sec or 0.3
	nextScene:setPosition(cc.p(nextScene:getPositionX()+display.width,nextScene:getPositionY()))
	local actionIn = cc.Sequence:create(cc.EaseOut:create(cc.MoveBy:create(sec,cc.p(-display.width,0)),2),cc.CallFunc:create(function()
		coroutine.resume(current)
	end))
	local actionOut =cc.EaseOut:create(cc.MoveBy:create(sec,cc.p(-display.width,0)),2)
	nextScene:runAction(actionIn)
	currentScene:runAction(actionOut)
end 



--创建一个从左推入并顶出旧场景的过渡动画
function SceneAnimation.slideFromL(currentScene,nextScene,params)
	params = params or {}
	local current = coroutine.running()
	local sec = params.sec or 0.3
	nextScene:setPosition(cc.p(nextScene:getPositionX()-display.width,nextScene:getPositionY()))
	local actionIn = cc.Sequence:create(cc.EaseOut:create(cc.MoveBy:create(sec,cc.p(display.width,0)),2),cc.CallFunc:create(function()
		coroutine.resume(current)
	end))
	local actionOut =cc.EaseOut:create(cc.MoveBy:create(sec,cc.p(display.width,0)),2)
	nextScene:runAction(actionIn)
	currentScene:runAction(actionOut)
end 

--创建一个从顶部推入并顶出旧场景的过渡动画
function SceneAnimation.slideFromT(currentScene,nextScene,params)
	params = params or {}
	local current = coroutine.running()
	local sec = params.sec or 0.3
	nextScene:setPosition(cc.p(nextScene:getPositionX(),nextScene:getPositionY()+display.height))
	local actionIn = cc.Sequence:create(cc.EaseOut:create(cc.MoveBy:create(sec,cc.p(0,-display.height)),2),cc.CallFunc:create(function()
		coroutine.resume(current)
	end))
	local actionOut =cc.EaseOut:create(cc.MoveBy:create(sec,cc.p(0,-display.height)),2)
	nextScene:runAction(actionIn)
	currentScene:runAction(actionOut)
end 

--创建一个从底部推入并顶出旧场景的过渡动画
function SceneAnimation.slideFromB(currentScene,nextScene,params)
	params = params or {}
	local current = coroutine.running()
	local sec = params.sec or 0.3
	nextScene:setPosition(cc.p(nextScene:getPositionX(),nextScene:getPositionY()-display.height))
	local actionIn = cc.Sequence:create(cc.EaseOut:create(cc.MoveBy:create(sec,cc.p(0,display.height)),2),cc.CallFunc:create(function()
		coroutine.resume(current)
	end))
	local actionOut =cc.EaseOut:create(cc.MoveBy:create(sec,cc.p(0,display.height)),2)
	nextScene:runAction(actionIn)
	currentScene:runAction(actionOut)
end 


--左右翻转
function SceneAnimation.flipX(currentScene,nextScene,params)
	params = params or {}
	local current = coroutine.running()
	local sec = params.sec or 0.5
	nextScene:setVisible(false)
	local inAction = cc.Sequence:create(
		cc.DelayTime:create(sec/2),
		cc.Show:create(),
		cc.OrbitCamera:create(sec/2, 1, 0, 90, -90, 0, 0),
		cc.CallFunc:create(function()
			coroutine.resume(current)
		end)
	)
	local outAction = cc.Sequence:create(
		cc.OrbitCamera:create(sec/2, 1, 0, 0, -90, 0, 0),
		cc.Hide:create(),
		cc.DelayTime:create(sec/2)
	)
	
	nextScene:runAction(inAction)
	currentScene:runAction(outAction)
end

--上下翻转
function SceneAnimation.flipY(currentScene,nextScene,params)
	params = params or {}
	local current = coroutine.running()
	local sec = params.sec or 0.5
	nextScene:setVisible(false)
	local inAction = cc.Sequence:create(
		cc.DelayTime:create(sec/2),
		cc.Show:create(),
		cc.OrbitCamera:create(sec/2, 1, 0, 90, -90 ,90, 0),
		cc.CallFunc:create(function()
			coroutine.resume(current)
		end)
	)
	local outAction = cc.Sequence:create(
		cc.OrbitCamera:create(sec/2, 1, 0, 0, 90, -90, 0),
		cc.Hide:create(),
		cc.DelayTime:create(sec/2)
	)
	
	nextScene:runAction(inAction)
	currentScene:runAction(outAction)
end


--创建一个从右边推入覆盖的过渡动画
function SceneAnimation.moveFromR(currentScene,nextScene,params)
	params = params or {}
	local current = coroutine.running()
	local sec = params.sec or 0.3
	nextScene:setPosition(cc.p(nextScene:getPositionX()+display.width,nextScene:getPositionY()))
	local actionIn = cc.Sequence:create(cc.EaseOut:create(cc.MoveBy:create(sec,cc.p(-display.width,0)),2),cc.CallFunc:create(function()
		coroutine.resume(current)
	end))
	nextScene:runAction(actionIn)
end 


--创建一个从左边推入覆盖的过渡动画
function SceneAnimation.moveFromL(currentScene,nextScene,params)
	params = params or {}
	local current = coroutine.running()
	local sec = params.sec or 0.3
	nextScene:setPosition(cc.p(nextScene:getPositionX()-display.width,nextScene:getPositionY()))
	local actionIn = cc.Sequence:create(cc.EaseOut:create(cc.MoveBy:create(sec,cc.p(display.width,0)),2),cc.CallFunc:create(function()
		coroutine.resume(current)
	end))
	nextScene:runAction(actionIn)
end 


--创建一个从顶部推入覆盖的过渡动画
function SceneAnimation.moveFromT(currentScene,nextScene,params)
	params = params or {}
	local current = coroutine.running()
	local sec = params.sec or 0.3
	nextScene:setPosition(cc.p(nextScene:getPositionX(),nextScene:getPositionY()+display.height))
	local actionIn = cc.Sequence:create(cc.EaseOut:create(cc.MoveBy:create(sec,cc.p(0,-display.height)),2),cc.CallFunc:create(function()
		coroutine.resume(current)
	end))
	nextScene:runAction(actionIn)
end 

--创建一个从底部推入覆盖的过渡动画
function SceneAnimation.moveFromB(currentScene,nextScene,params)
	params = params or {}
	local current = coroutine.running()
	local sec = params.sec or 0.3
	nextScene:setPosition(cc.p(nextScene:getPositionX(),nextScene:getPositionY()-display.height))
	local actionIn = cc.Sequence:create(cc.EaseOut:create(cc.MoveBy:create(sec,cc.p(0,display.height)),2),cc.CallFunc:create(function()
		coroutine.resume(current)
	end))
	nextScene:runAction(actionIn)
end

--创建一个旋转缩放的过渡动画
function SceneAnimation.rotoZoom(currentScene,nextScene,params)
	params = params or {}
	local current = coroutine.running()
	local sec = params.sec or 0.3
	currentScene:setScale(1)
	nextScene:setScale(0)
	local actionOut  = cc.Sequence:create(
		cc.Spawn:create( cc.ScaleTo:create(sec/2, 0),
            cc.RotateBy:create(sec/2, 360 * 2)),
		cc.DelayTime:create(sec/2)
	)
	currentScene:runAction(actionOut)
	local actionIn = cc.Sequence:create(
		cc.DelayTime:create(sec/2),
		cc.Spawn:create( cc.ScaleTo:create(sec/2, 1),
        cc.RotateBy:create(sec/2, -360 * 2))
	)
	actionIn = cc.Sequence:create(actionIn,cc.CallFunc:create(function()
		coroutine.resume(current)
	end))
	nextScene:runAction(actionIn)
end

--创建一个放缩交替的过渡动画
function SceneAnimation.shrinkGrow(currentScene,nextScene,params)
	params = params or {}
	local current = coroutine.running()
	local sec = params.sec or 0.3
	currentScene:setScale(1)
	nextScene:setScale(0)
	local actionOut  = cc.ScaleTo:create(sec/2, 0)
	
	currentScene:runAction(actionOut)
	local actionIn = cc.ScaleTo:create(sec/2, 1)
	actionIn = cc.Sequence:create(actionIn,cc.CallFunc:create(function()
		coroutine.resume(current)
	end))
	nextScene:runAction(actionIn)
end

function SceneAnimation.flipAngular(currentScene,nextScene,params)
	params = params or {}
	local current = coroutine.running()
	local sec = params.sec or 0.5
	nextScene:setVisible(false)
	local inAction = cc.Sequence:create(
		cc.DelayTime:create(sec/2),
		cc.Show:create(),
		cc.OrbitCamera:create(sec/2, 1, 0, 90, -90, -45, 0),
		cc.CallFunc:create(function()
			coroutine.resume(current)
		end)
	)
	local outAction = cc.Sequence:create(
		cc.OrbitCamera:create(sec/2, 1, 0, 0, -90, 45, 0),
		cc.Hide:create(),
		cc.DelayTime:create(sec/2)
	)
	
	nextScene:runAction(inAction)
	currentScene:runAction(outAction)
end
return SceneAnimation
