local Npc = import ".auto.Npc"
local Scene = import ".auto.Scene"
local Item = import ".auto.Item"
local Level = import ".auto.Level"
local Shop = import ".auto.Shop"
local Gem = import ".auto.Gem"
local Skill = import ".auto.Skill"
local Setting = import ".auto.Setting"
local EquipSlot = import ".auto.EquipSlot"
local Equip = import ".auto.Equip"

local Data = import ".Data"
local MainScene = import "..views.scene.main.MainScene"
local BattleScene = import "..views.scene.battle.BattleScene"

local config = {
	debug = true,
	server_host = "192.168.15.19",
	server_port = 9002,
	scenes = {
		Main = {
			bg 	= "pipo-battlebg001.jpg",
			farbg = "pipo-battlebg_farbg.jpg",
			viewClass = MainScene,
			width = 1280,
			height = 480,
		},
		Battle = {
			bg = "pipo-battlebg007.jpg",
			farbg = "pipo-battlebg007_farbg.jpg",
			viewClass = BattleScene,
			width = 1280,
			height = 480,
		},
	}
}

config.npc = Data(Npc)
config.scene = Data(Scene)
config.item = Data(Item)
config.level = Data(Level)
config.shop = Data(Shop)
config.gem = Data(Gem)
config.skill = Data(Skill)
config.setting = Data(Setting)
config.equipSlot = Data(EquipSlot)
config.equip = Data(Equip)

return config

