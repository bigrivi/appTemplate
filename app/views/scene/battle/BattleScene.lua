local SceneBase = import "....core.SceneBase"
local AvatarView = import "...components.AvatarView"
local BattleScene = clover.class(SceneBase)
local Consts = import "....constants.Consts"


function BattleScene:onCreate()
	dump(self.viewOption)
	BattleScene.__super.onCreate(self.el)
   -- add play button
    local playButton = cc.MenuItemImage:create("PlayButton.png", "PlayButton.png")
        :onClicked(function()
			self.utils:switchScene(Consts.Scene.MAIN,{},"fadeColor")
			--self.utils:createPopUp( self.modules.difficultySelection,true,{a=150})
        end)
	local bg = display.newSprite("pipo-battlebg010.jpg")
	bg:setAnchorPoint(cc.p(0.5,0.5)):move(display.cx, display.cy)
	bg:addTo(self.el)
    cc.Menu:create(playButton)
        :move(display.cx, display.cy)
        :addTo(self.el)
	
	
	local drawNode = cc.DrawNode:create()
	drawNode:setAnchorPoint(cc.p(0,0))
    drawNode:drawSolidRect(cc.p(-25,-25), cc.p(50,50), cc.c4f(1,1,0,1))
	
	--drawNode:drawLine(cc.p(0,0), cc.p(20, 50),cc.c4f(1,1,1,1) )
	--drawNode:drawLine(cc.p(20,50), cc.p(30, 150),cc.c4f(0,1,1,1) )
	drawNode:setCascadeOpacityEnabled(true)
	--drawNode:move(200,200):addTo(self)
	--clover.utils.DrawUtil.drawPath(drawNode,{cc.p(0,0), cc.p(20, 50),cc.p(30, 150),cc.p(300, 250)},cc.c4f(1,0,1,1))
	
	local tween = clover.Tween
	local box = { scale = 1 ,rotation = 0,opacity = 0 }
	local function onUpdate()
		--dump(music.volume)
		drawNode:setRotation(box.rotation)
		drawNode:setScaleX(box.scale)
		drawNode:setScaleY(box.scale)
		drawNode:setOpacity(box.opacity)
	end 
	
	local function onStart()
		dump("start")
	end
	
	local function onComplete()
		dump("complete")
	end
	
	--local musicTween = tween.new(box,1, {scale = 2,opacity = 255,rotation=360,onUpdate = onUpdate,onStart = onStart,onComplete = onComplete,yoyo = true},tween.easing.inOutBack)
	--musicTween:start()
	
	--clover.Executors.setTimeOut(function()
		--musicTween:stop()
	--end,1)
	
	--clover.Executors.setTimeOut(function()
		---musicTween:resume()
	--end,2)
	--self:addBoxs()
end





function BattleScene:onStart()
	
end 



function BattleScene:onCleanup_()
	
end 
return BattleScene
