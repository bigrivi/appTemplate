 
local M = clover.class()

function M:ctor()
	self.netServer = {}
	self.userModel = {}
	self.playerModel = {}
	self.dispatcher = {}
end 

------ user service start -------

function M:login(name,password,callback)
	local request = proto.msg_login.LoginRequest()
	request.s_user_name = name  
	request.s_user_password = password 
	self.netServer:send(NetMessageCmdDef.MSG_LOGIN,request,callback)
end 


function M:reg(name,password,callback)	
	local request = proto.msg_reg.RegRequest()
	request.s_user_name = name  
	request.s_user_password = password 
	self.code = NetMessageCmdDef.MSG_REG
	self.netServer:send(NetMessageCmdDef.MSG_REG,request,callback)
end 


function M:createPlayer(index,name,uid,callback)
	local request = proto.msg_login.CreatePlayerRequest()
	request.u_player_index = index  
	request.s_player_name = name  
	request.u_user_id = uid 
	self.netServer:send(NetMessageCmdDef.MSG_CREATE_PLAYER,request,callback)
end 


function M:startGame(playerId,callback)
	local request = proto.msg_login.StartGameRequest()
	request.u_player_id = playerId  
	self.netServer:send(NetMessageCmdDef.MSG_START_GAME,request,callback)
end 



function M:buyItem(shopId,itemId,itemNum,callback)
	local request = proto.msg_shop.ShopBuyRequest()
	request.u_shop_id = shopId  
	request.u_item_id = itemId  
	request.u_item_num = itemNum 
	self.netServer:send(NetMessageCmdDef.MSG_SHOP_BUY,request,callback)
end 



function M:useItem(itemId,itemNum,callback)
	local request = proto.msg_item.ItemUseRequest()
	request.u_item_id = itemId  
	request.u_item_num =  itemNum
	self.netServer:send(NetMessageCmdDef.MSG_ITEM_USE,request,callback)
end 


function M:doLevelUp(callback)
	self.netServer:send(NetMessageCmdDef.MSG_LEVEL_UP,nil,callback)
end 

------ user service end  -------


------ hero service start -------

function M:heroStarUp(heroId,callback)
	local request = proto.msg_hero.HeroStarUpRequest()
	request.u_hero_id = heroId  
	self.netServer:send(NetMessageCmdDef.MSG_HERO_STAR_UP,request,callback)
end 

function M:heroLvUp(heroId,lvNum,callback)
	local request = proto.msg_hero.HeroStarUpRequest()
	request.u_hero_id = heroId  
	request.u_lv_num = lvNum
	self.netServer:send(NetMessageCmdDef.MSG_HERO_LV_UP,request,callback)
end 

------ hero service end -------

------ chat service start -------

--public chat
function M:chat(content,channeltype,callback)
	local request = proto.msg_chat.ChatRequest()
	request.s_content = content  
	request.u_channeltype = channeltype
	self.netServer:send(NetMessageCmdDef.MSG_CHAT,request,callback)
end 

--private chat
function M:chatTo(content,recverId,callback)
	local request = proto.msg_chat.ChatRequest()
	request.s_content = content  
	request.u_recver_id = recverId
	self.netServer:send(NetMessageCmdDef.MSG_CHAT_TO,request,callback)
end 
------ chat service end -------

------ friend service start -------

function M:addFriend(targetId,callback)
	local request = proto.msg_friend.FriendAddRequest()
	request.u_player_id = targetId
	self.netServer:send(NetMessageCmdDef.MSG_FRIEND_ADD,request,callback)
end 

function M:agreeFriendAdd(targetId,typeId,callback)
	local request = proto.msg_friend.FriendSureAddRequest()
	request.u_player_id = targetId
	request.u_type = typeId
	self.netServer:send(NetMessageCmdDef.MSG_FRIEND_SURE_ADD,request,callback)
end 

function M:delFriend(targetId,callback)
	local request = proto.msg_friend.FriendDelRequest()
	request.u_player_id = targetId
	self.netServer:send(NetMessageCmdDef.MSG_FRIEND_DEL,request,callback)
end 

------ friend service end -------

------ mail service start -------

function M:sendMail(recverId,mailInfo,callback)
	local request = proto.msg_mail.MailSendRequest()
	request.u_recver_id = recverId
	request.mail_info = mailInfo
	self.netServer:send(NetMessageCmdDef.MSG_MAIL_SEND,request,callback)
end 

function M:delMail(mailID,callback)
	local request = proto.msg_mail.MailDelRequest()
	request.u_mail_id = mailID
	self.netServer:send(NetMessageCmdDef.MSG_MAIL_DEL,request,callback)
end 

------ mail service end -------

------ skill service start -------

function M:skillStudy(skillID,callback)
	local request = proto.msg_skill.SkillStudyRequest()
	request.u_skill_id = skillID
	self.netServer:send(NetMessageCmdDef.MSG_SKILL_STUDY,request,callback)
end 

function M:skillLvUp(skillID,num,callback)
	local request = proto.msg_skill.SkillLvUpRequest()
	request.u_skill_id = skillID
	request.u_lv_num = num
	self.netServer:send(NetMessageCmdDef.MSG_SKILL_STUDY,request,callback)
end 

------ skill service end -------

------ fight service start -------

------ fight service end  -------


------ cos service start -------

function M:cosWear(cosId,callback)
	local request = proto.msg_cosplay.CosWearRequest()
	request.u_cos_id = cosId
	self.netServer:send(NetMessageCmdDef.MSG_COS_WEAR,request,callback)
end 

function M:cosTakeOff(cosType,callback)
	local request = proto.msg_cosplay.CosTakeOffRequest()
	request.u_cos_type = cosType
	self.netServer:send(NetMessageCmdDef.MSG_COS_TAKE_OFF,request,callback)
end 

------ cos service end  -------


------ equip service start -------

---装备穿戴
function M:equipWear(equipId,callback)
	local request = proto.msg_equip.EquipWearRequest()
	request.u_equip_id = equipId  
	self.netServer:send(NetMessageCmdDef.MSG_EQUIP_WEAR,request,callback)
end 

---装备卸除
function M:equipTakeOff(slotId,callback)
	local request = proto.msg_equip.EquipTakeOffRequest()
	request.u_slot_id = slotId  
	self.netServer:send(NetMessageCmdDef.MSG_EQUIP_TAKE_OFF,request,callback)
end 

---装备强化
function M:equipWear(typeId,equipId,gemId,callback)
	local request = proto.msg_equip.EquipStrengthRequest()
	request.u_type = typeId  
	request.u_equip_id = equipId  
	request.u_protect_gem_id = gemId  
	self.netServer:send(NetMessageCmdDef.MSG_EQUIP_STRENGTH,request,callback)
end 

---装备合成
function M:equipGroup(typeId,equip_id_list,gem_id,callback)
	local request = proto.msg_equip.EquipGroupRequest()
	request.u_type = typeId  
	for _, equipId in ipairs(equip_id_list) do
 		request.arr_equip_id_list:append(equipId)
	end
	request.u_protect_gem_id = gem_id  
	self.netServer:send(NetMessageCmdDef.MSG_EQUIP_GROUP,request,callback)
end 

---装备槽强化
function M:equipSlotStrength(typeId,slotId,callback)
	local request = proto.msg_equip.EquipSlotStrengthRequest()
	request.u_type = typeId 
	request.u_slot_id = slotId  
	self.netServer:send(NetMessageCmdDef.MSG_EQUIP_SLOT_STRENGTH,request,callback)
end 

---宝石镶嵌
function M:equipGemWear(gemId,slotId,callback)
	local request = proto.msg_equip.EquipGemWearRequest()
	request.u_gem_id = gemId  
	request.u_slot_id = slotId
	self.netServer:send(NetMessageCmdDef.MSG_EQUIP_GEM_WEAR,request,callback)
end 

---宝石卸除
function M:equipGemTakeOff(gemType,slotId,callback)
	local request = proto.msg_equip.EquipGemTakeOffRequest()
	request.u_gem_type = gemType  
	request.u_slot_id = slotId  
	self.netServer:send(NetMessageCmdDef.MSG_EQUIP_GEM_TAKE_OFF,request,callback)
end 


---宝石锻造
function M:equipGemForge(typeId,gemId,protectGemId,callback)
	local request = proto.msg_equip.EquipGemForgeRequest()
	request.u_type = typeId  
	request.u_gem_id = gemId  
	request.u_protect_gem_id = protectGemId 
	self.netServer:send(NetMessageCmdDef.MSG_EQUIP_GEM_FORGE,request,callback)
end 

------ equip service end  -------


return M
