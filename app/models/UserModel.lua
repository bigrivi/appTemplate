
local Model = require "clover.core.Model"

local M = clover.class(Model)

function M:ctor(defaults)
	if defaults == nil then
		defaults = {
			diamond = 0,
			money   = 0,
			vit     = 0,
			exp     = 0,
			pk_exp  = 0,
			user_id = 0,
		}
	end 
	M.__super.ctor(self,defaults)
	self.dispatcher = {}
end 

function M:refreshResorce(resourcePB)
	self:set(
		{
			diamond	= resourcePB.u_diamond ,
			money	= resourcePB.u_money ,
			vit		= resourcePB.u_vit ,
			exp		= resourcePB.u_exp ,
			pk_exp	= resourcePB.u_pk_exp ,
		}
	)
end 



return M