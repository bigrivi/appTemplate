local M = 
{
	LOCK_SCREEN         = "lock_screen", --锁屏
	UN_LOCK_SCREEN      = "un_lock_screen", --解锁
	SWITCH_SCENE 		= "switch_scene",  --切换场景
	POP_UP_ADD          = "pop_up_add", --添加一个弹窗
	POP_UP_FRONT        = "pop_up_front", -- 删除一个弹窗
	POP_UP_REMOVE       = "pop_up_remove", -- 置顶弹窗
	POP_UP_REMOVE_ALL   = "pop_up_remove_all", -- 移除所有弹窗
	
	Command = {
		LOGIN 			= "command_login", --登陆
		REG   			= "command_reg", --注册
		START_UP   		= "command_startUp", --启动
		ASYNC       	= "command_async",   --异步消息
		CREATE_PLAYER 	= "create_player", --创角
		ENTER_GAME 		= "enter_game", --进入游戏
		TEST_MESSAGE    = "test_message", --消息测试
	},
	Scene = {
		MAIN 	 = "Main", --主场景
		LOADING  = "Loading", --加载场景
		BATTLE   = "Battle", --战斗场景
	}


}

return M
