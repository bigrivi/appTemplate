local AvatarView = class("AvatarView", function()
    return display.newNode()
end)
AvatarView.WALK_SPEED = 350
AvatarView.SCALE = 0.5


function AvatarView:ctor()
	self.direction = "right"
end 

function AvatarView:crateAvatar(cache)
	--local skeletonNode = sp.SkeletonAnimation:create("spine/goblins.json", "spine/goblins.atlas", 0.6)
	--dump(self.cache)
	local skeletonNode = sp.SkeletonAnimation:createWithData(cache)
	skeletonNode:setScale(self.SCALE)
	skeletonNode:setSkin("goblin")
	--local node = skeletonNode:getNodeForSlot("head")
	--local bishou = display.newSprite("spine/spear.png")
	--node:addChild(bishou)
	skeletonNode:setAttachment("right hand item","dagger")
	--skeletonNode:changeAttachment("right hand item","images/bishou","spine/ebolin.atlas")
	self:addChild(skeletonNode)
	skeletonNode:setDebugBonesEnabled(true)
	skeletonNode:registerSpineEventHandler(function (event)
    -- print(string.format("[spine] %d start: %s", 
                              --event.trackIndex,
                             -- event.animation))
	  end, sp.EventType.ANIMATION_START)

	  skeletonNode:registerSpineEventHandler(function (event)
		 -- print(string.format("[spine] %d end:", 
									--event.trackIndex))
	  end, sp.EventType.ANIMATION_END)
		
	  skeletonNode:registerSpineEventHandler(function (event)
		 -- print(string.format("[spine] %d complete: %d", 
								  --event.trackIndex, 
								  --event.loopCount))
	  end, sp.EventType.ANIMATION_COMPLETE)

	  skeletonNode:registerSpineEventHandler(function (event)
		 -- print(string.format("[spine] %d event: %s, %d, %f, %s", 
								  --event.trackIndex,
								 -- event.eventData.name,
								 -- event.eventData.intValue,
								  --event.eventData.floatValue,
								 -- event.eventData.stringValue)) 
	  end, sp.EventType.ANIMATION_EVENT)
	 -- skeletonNode:setMix("walk", "jump", 0.2)
	  --skeletonNode:setMix("walk", "idle", 0.2)
	  skeletonNode:setMix("idle", "walk", 0.2)
	  --skeletonNode:setMix("jump", "run", 0.2)
	  skeletonNode:setAnimation(0, "walk", true)
	  --skeletonNode:setAnimation(0, "walk", true)
	  --skeletonNode:addAnimation(0, "jump", false, 3)
	 -- skeletonNode:addAnimation(0, "run", false)
	  --skeletonNode:addAnimation(0, "idle", true)
	  self.skeletonNode = skeletonNode
end 

function AvatarView:walkTo(x,y)
	self:stopAllActions()
	local nowX = self:getPositionX()
	local nowY = self:getPositionY()
	local distance = cc.pGetDistance(cc.p(nowX,nowY),cc.p(x,y))
	local sec = distance/self.WALK_SPEED
	self.skeletonNode:setAnimation(0, "run", true)
	self:moveTo({time = sec,x=x,y=y,onComplete = function()
		self.skeletonNode:setAnimation(0, "idle", true)
	end})
	if x>nowX and self.direction~="right" then
		self.direction = "right"
		self.skeletonNode:setScaleX(self.SCALE)
	elseif x<nowX and self.direction~="left" then
		self.direction = "left"
		self.skeletonNode:setScaleX(-self.SCALE)
	end
end 

return AvatarView
