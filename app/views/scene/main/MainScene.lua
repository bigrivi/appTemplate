local SceneBase = import "....core.SceneBase"
local AvatarView = import "...components.AvatarView"
local Box = import ".Box"
local class = clover.class

local MainScene = class(SceneBase)

local Consts = import "....constants.Consts"
local ModuleConfig = import "....config.Modules"

function MainScene:onCreate()
	MainScene.__super.onCreate(self.el)
   -- add play button
    local playButton = cc.MenuItemImage:create("PlayButton.png", "PlayButton.png")
        :onClicked(function()
			self.utils:switchScene(Consts.Scene.BATTLE,{xx = 1050},"slideFromR")
			--self.utils:createPopUp( ModuleConfig.difficultySelection,true,{a=150})
        end)
	local bg = display.newSprite("pipo-battlebg002.jpg")
	bg:setAnchorPoint(cc.p(0.5,0.5)):move(display.cx, display.cy)
	bg:addTo(self.el)
    cc.Menu:create(playButton)
        :move(150, 150)
        :addTo(self.el)
	--local node = clover.utils.DisplayObjectUtil.createNode("ui/DifficultySelectionView.csb")
	--node:addTo(self.el)
	
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

function MainScene:addBoxs()
	for i=1,1 do
		local box = Box()
		local rndX = clover.utils.NumberUtil.randomIntegerWithinRange(100,display.width)
		local rndY = clover.utils.NumberUtil.randomIntegerWithinRange(100,display.height)
		rndX = 100
		rndY = 100
		box:setPosition(cc.p(rndX,rndY))
		
		
		self.el:addChild(box)
		

	end 
end 



return MainScene
