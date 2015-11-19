
local Box = clover.class()
Box._cocos_class = cc.DrawNode

function Box:ctor()
	self:draw()
	--self:init()
	local anim = clover.Animation(self):moveBy(300, 200, 1.1):moveBy(-300, -200, 1.1):yoyo()
	anim:play()

end

function Box:draw()
	self:setAnchorPoint(cc.p(0,0))
    self:drawSolidRect(cc.p(-25,-25), cc.p(50,50), cc.c4f(math.random(0,1), math.random(0,1), math.random(0,1), 1))
	self:setCascadeOpacityEnabled(true)
end 

function Box:init()
	local tween = clover.Tween
	local box = { scale = 1 ,rotation = 0,opacity = 0 }
	dump(self:getScale())
	local function onUpdate()
		--self:setRotation(box.rotation)
		self:setScaleX(box.scale)
		self:setScaleY(box.scale)
		--self:setOpacity(box.opacity)
	end 
	
	local function onStart()
		dump("start")
	end
	
	local function onComplete()
		dump("complete")
	end
	local rndScale = clover.utils.NumberUtil.randomIntegerWithinRange(1,2)
	rndScale = 2
	local tween = tween.new(box,1, {scale = rndScale,opacity = 255,rotation=360,onUpdate = onUpdate,onStart = onStart,onComplete = onComplete,yoyo = true,delay = 1,easing = tween.easing.inOutBack})
	tween:start()

end 


return Box