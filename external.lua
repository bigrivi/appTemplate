
local Button = ccui.Button

function Button:onClicked(callback)
    self:addTouchEventListener(
				function (sender,type)
					if type == ccui.TouchEventType.ended then
						callback()
					end
				end
		)
end


