
local Model = require "clover.core.Model"

local M = clover.class(Model)
M.idAttribute = "player_id"

function M:ctor(defaults)
	if defaults == nil then
		defaults = {
			player_id = 0,
			user_id   = 0,
			player_name   = "",
			strict   = 0,
			vip_lv   = 0,
			lv   = 0,
			config_id   = 0,
			power   = 0,
			pk_lv   = 0
		}
	end 
	M.__super.ctor(self,defaults)
	self.dispatcher = {}
end 

function M:refresh(infoPB)
	self:set(
		{
			player_id = infoPB.u_player_id,
			user_id   = infoPB.u_user_id,
			player_name   = infoPB.s_player_name,
			strict   = infoPB.u_strict,
			vip_lv   = infoPB.u_vip_lv,
			lv   = infoPB.u_lv,
			config_id   = infoPB.u_config_id,
			power   = infoPB.u_power,
			pk_lv   = infoPB.u_pk_lv,
		}
	)
end 

function M:refreshPlayerParam(paramPB)
	self:set(
		{
			hp = paramPB.u_hp,
			mp   = paramPB.u_mp,
			atk   = paramPB.u_atk,
			ini   = paramPB.u_ini,
			def   = paramPB.u_def,
			mr   = paramPB.u_mr,
			dex   = paramPB.u_dex,
			agi   = paramPB.u_agi,
			point   = paramPB.u_point,
		}
	)
end 

return M