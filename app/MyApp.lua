local StartUpCmd = import ".controllers.StartUpCmd"
local AsyncCmd = import ".controllers.AsyncCmd"
local UserLoginCmd = import ".controllers.UserLoginCmd"
local UserRegCmd = import ".controllers.UserRegCmd"
local CreatePlayerCmd = import ".controllers.CreatePlayerCmd"
local GameEnterCmd = import ".controllers.GameEnterCmd"
local TestMessageCmd = import ".controllers.TestMessageCmd"

local NetServer = import ".net.NetServer"
local ApiService = import ".net.ApiService"
local Config = import ".config.Config"
local Modules = import ".config.Modules"
local Consts = import ".constants.Consts"

local UserModel = import ".models.UserModel"
local PlayerModel = import ".models.PlayerModel"
local PlayerList = import ".models.PlayerList"
local ItemModel = import ".models.ItemModel"

local Item = import ".models.Item"
local ItemList = import ".models.ItemList"


local Utils = import ".utils.Utils"
local MyApp = clover.class()


function MyApp:ctor()
   function clover.Application:start()
		--server
   		self.injector:mapClass("netServer",NetServer,true)
		self.injector:mapClass("apiService",ApiService,true)
		--config
		self.injector:mapValue("config",Config)
		--utils
		self.injector:mapClass("utils",Utils,true)
		--model
		self.injector:mapClass("userModel",UserModel,true)
		self.injector:mapClass("userPlayerList",PlayerList,true)
		self.injector:mapClass("itemModel",ItemModel,true)
		self.injector:mapClass("itemList",ItemList,true)

		--commands
		self.command:add(Consts.Command.START_UP,StartUpCmd)
		self.command:add(Consts.Command.ASYNC,AsyncCmd)
		self.command:add(Consts.Command.LOGIN,UserLoginCmd)
		self.command:add(Consts.Command.REG,UserRegCmd)
		self.command:add(Consts.Command.CREATE_PLAYER,CreatePlayerCmd)
		self.command:add(Consts.Command.ENTER_GAME,GameEnterCmd)
		self.command:add(Consts.Command.TEST_MESSAGE,TestMessageCmd)
		self.dispatcher:dispatchEvent(clover.Event(Consts.Command.START_UP))
	end 
	clover.Application()
end

return MyApp
