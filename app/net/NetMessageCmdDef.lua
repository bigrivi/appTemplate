NetMessageCmdDef = NetMessageCmdDef or {}

NetMessageCmdDef.MSG_REG = 0x101	--注册协议
NetMessageCmdDef.MSG_LOGIN = 0x201	--登录协议
NetMessageCmdDef.MSG_CREATE_PLAYER = 0x202	--创角协议
NetMessageCmdDef.MSG_START_GAME = 0x203	--开始游戏协议
NetMessageCmdDef.MSG_SYNC_VALID_CODE = 0x301	--验证码协议
NetMessageCmdDef.MSG_SYNC_RES = 0x302	--资源协议
NetMessageCmdDef.MSG_SYNC_PLAYER_INFO = 0x303	--玩家信息协议
NetMessageCmdDef.MSG_SYNC_PLAYER_PARAM = 0x304	--玩家参数协议
NetMessageCmdDef.MSG_SYNC_ITEM = 0x305	--同步物品协议
NetMessageCmdDef.MSG_SYNC_SKILL = 0x306	--同步技能协议
NetMessageCmdDef.MSG_SYNC_MAIL = 0x307	--同步邮件协议
NetMessageCmdDef.MSG_SYNC_FRIEND = 0x308	--同步好友协议
NetMessageCmdDef.MSG_SYNC_CHAT = 0x309	--同步聊天协议
NetMessageCmdDef.MSG_SYNC_EQUIP = 0x310	--同步装备信息
NetMessageCmdDef.MSG_SYNC_COSPLAY = 0x311	--同步时装信息
NetMessageCmdDef.MSG_SYNC_HERO = 0x312	--同步英雄信息
NetMessageCmdDef.MSG_ITEM_USE = 0x401	--使用物品协议
NetMessageCmdDef.MSG_MAIL_SEND = 0x501	--发送邮件协议
NetMessageCmdDef.MSG_MAIL_DEL = 0x502	--删除邮件协议
NetMessageCmdDef.MSG_CHAT = 0x601	--聊天
NetMessageCmdDef.MSG_CHAT_TO = 0x602	--私聊
NetMessageCmdDef.MSG_FRIEND_ADD = 0x701	--添加好友
NetMessageCmdDef.MSG_FRIEND_SURE_ADD = 0x702	--是否同意添加好友
NetMessageCmdDef.MSG_FRIEND_DEL = 0x703	--删除好友
NetMessageCmdDef.MSG_SHOP_BUY = 0x801	--购买协议
NetMessageCmdDef.MSG_SKILL_STUDY = 0x1001	--技能学习协议
NetMessageCmdDef.MSG_SKILL_LV_UP = 0x1002	--技能升级协议
NetMessageCmdDef.MSG_LEVEL_UP = 0x1101	--升级协议
NetMessageCmdDef.MSG_FIGHT_START = 0x1201	--战斗开始请求协议
NetMessageCmdDef.MSG_EQUIP_WEAR = 0x1301	--装备穿戴协议
NetMessageCmdDef.MSG_EQUIP_TAKE_OFF = 0x1302	--装备卸除协议
NetMessageCmdDef.MSG_EQUIP_STRENGTH = 0x1303	--装备强化协议
NetMessageCmdDef.MSG_EQUIP_GROUP = 0x1304	--装备合成协议
NetMessageCmdDef.MSG_EQUIP_SLOT_STRENGTH = 0x1305	--装备槽强化协议
NetMessageCmdDef.MSG_EQUIP_GEM_WEAR = 0x1306	--宝石镶嵌协议
NetMessageCmdDef.MSG_EQUIP_GEM_TAKE_OFF = 0x1307	--宝石卸除协议
NetMessageCmdDef.MSG_EQUIP_GEM_FORGE = 0x1308	--宝石锻造协议
NetMessageCmdDef.MSG_COS_WEAR = 0x1401	--装扮穿戴协议
NetMessageCmdDef.MSG_COS_TAKE_OFF = 0x1402	--装扮卸除协议
NetMessageCmdDef.MSG_HERO_STAR_UP = 0x1501	--英雄升星协议
NetMessageCmdDef.MSG_HERO_LV_UP = 0x1502	--英雄升级协议

import(".proto.gs_main")
import(".proto.gs_common")
import(".proto.msg_reg")
import(".proto.msg_login")
import(".proto.msg_sync")
import(".proto.msg_item")
import(".proto.msg_mail")
import(".proto.msg_chat")
import(".proto.msg_friend")
import(".proto.msg_shop")
import(".proto.msg_skill")
import(".proto.msg_level")
import(".proto.msg_fight")
import(".proto.msg_equip")
import(".proto.msg_cosplay")
import(".proto.msg_hero")

-- 映射每个消息对应的proto文件
NetMessagePackage = NetMessagePackage or {}
for c, v in pairs(proto) do
    for c2,v2 in pairs(v) do
        NetMessagePackage[c2] = c;
    end
end
        