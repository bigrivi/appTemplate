local socket = require("socket")
local ByteArray = clover.ByteArray

import('.NetMessageCmdDef')
local logger = clover.Logger("app.net.NetServer")
local NetEvent = import("..events.NetEvent")
local PacketBuffer = import(".PacketBuffer")
local Consts = import "..constants.Consts"

-- pack the message data by protobuf
local function encode(data) 
    local size = string.len(data)
    --local __packData = string.pack("<IA",size,pbdata)
    local __ba1 = ByteArray.new()
        :writeShort(size)
        :writeString(data)
        :setPos(1)
    return __ba1:getPack()
end


local function decode(data) 
    local __ba1 = ByteArray.new()
        :writeBuf(data)
        :setPos(1)
    local size = __ba1:readShort()
    return  size,__ba1:readString(size)
end


   
local M = clover.class(clover.EventDispatcher)

--CONSTRUCTOR ---------------------------
--_______________________________________

function M:ctor()
	self.__autoConnect = true;            -- send request before auto connect
	self.__autoReConnect = false; 
	self.__tickScheduler = nil            -- timer for data
	self.__reconnectScheduler = nil       -- timer for reconnect
	self.__connectTimeTickScheduler = nil -- timer for connect timeout
	self.__connectedCallBack = nil
	self.__blockMessageQueue  = {}
	self.__penddingCallBack  = {}
	self.name = 'NetController'
	self.tcp = nil
	self.isConnected = false
	self.status = nil
	self.dispatcher = {}
	self.connectType = M.CONNECT_TYPE_ONCE; 
	self._buf = PacketBuffer.new()
end

--PRIVATE/PROTECTED---------------------
--_______________________________________

-- handle messsage data from server 
function M:onData(data)
	local __msgs = self._buf:parsePackets(data)
	for i,msg in ipairs(__msgs) do
		self:__parseMessage(msg)
	end 
end


-- handle messsage data from server 
function M:__parseMessage(data)	
	local gsResponse = proto.gs_main.GS_Response()
	gsResponse:ParseFromString(data)
	logger:info("message [0x%x] receive",gsResponse.u_protocol_id)
	local isReceiveValidCode = false
	if self.validCode == nil then
		isReceiveValidCode = true
	end 
	self.validCode = gsResponse.u_valid_code
	local errorCode = gsResponse.u_error_code
	local serverTime = gsResponse.u_time
	local validCode = gsResponse.u_valid_code
	local response,responseMsgName
	local responseMsg = gsResponse.message
	if responseMsg then
		responseMsgName = responseMsg.s_msg_name
		local responseMsgBody = responseMsg.s_msg_body
		if responseMsgName ~= nil and responseMsgName ~= '' then
			local responsePackageName = NetMessagePackage[responseMsgName];
			response = _G['proto'][responsePackageName][responseMsgName]()
			response:ParseFromString(responseMsgBody)
		end
	end
	if isReceiveValidCode then
		self:dispatchEvent(NetEvent(NetEvent.RECEIVE_CODE),self)
	end 
	if self.__penddingCallBack[gsResponse.u_protocol_id] then
		self.__penddingCallBack[gsResponse.u_protocol_id](errorCode,response)
		self.__penddingCallBack[gsResponse.u_protocol_id] = nil
	else
		self.dispatcher:dispatchEvent(clover.Event(Consts.Command.ASYNC),{code = gsResponse.u_protocol_id,msgName = responseMsgName,msgData = response})
	end 
	self.status = M.STATUS_IDLE
	if #self.__blockMessageQueue>0 then
		self:send(self.__blockMessageQueue[1].code,self.__blockMessageQueue[1].data,self.__blockMessageQueue[1].callback)
	end
	
end


function M:__connect()
	local __succ, __status = self.tcp:connect(self.host, self.port)
	return __succ == 1 or __status == M.STATUS_ALREADY_CONNECTED
end



function M:_connectFailure(status)
	logger:info("connectFailure");
	--auto reconnect check
	if self.__autoReConnect then
		local __reconnect =  function()
			logger:info("reconnect start..");
			self:connect()
		end
		if self.__reconnectScheduler==nil then
			self.__reconnectScheduler = cstimer.addScheduler(__reconnect, M.SOCKET_RECONNECT_TIME,-1)
		end 
		__reconnect()
	end
	
end


-- connecte success, cancel the M timerout timer
function M:__onConnected()
	logger:info(string.format("onConnected"))
	self.isConnected = true
	self.status = M.STATUS_IDLE
	self:dispatchEvent(NetEvent(NetEvent.CONNECTED),self)
	if self.__reconnectScheduler then
		 cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.__reconnectScheduler)
		self.__reconnectScheduler = nil
	end

	if self.__connectedCallBack then
		self.__connectedCallBack()
		self.__connectedCallBack = nil
	end


	if self.__connectTimeTickScheduler then
		 cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.__connectTimeTickScheduler)
		self.__connectTimeTickScheduler = nil
	end 

	local __tick = function()
		-- if use "*l" pattern, some buffer will be discarded, why?
		local __body, __status, __partial = self.tcp:receive("*a")  -- read the package body
		--logger:debug("body:", __body, "__status:", __status, "__partial:", __partial)
		if __status == M.STATUS_CLOSED or __status == M.STATUS_NOT_CONNECTED then
			self:close()
			return
		end
		if  (__body and string.len(__body) == 0) or
			(__partial and string.len(__partial) == 0)
		then return end
		if __body and __partial then __body = __body .. __partial end
		self:onData(__partial or __body)
	end

	-- start to read TCP data
	 self.__tickScheduler = cc.Director:getInstance():getScheduler():scheduleScriptFunc(__tick, self.SOCKET_TICK_TIME, false)
end

function M:__checkConnect()
	logger:info("check connect ")
	local __succ = self:__connect() 
	if __succ then
		self:__onConnected()
	end
	return __succ
end



--PUBLIC-----
--_______________________________________

-- right now connect to server
function M:connect(host,port)
	self.host = host
	self.port = port
	logger:info("connect to server ",host,port)
	--self:__debug("connect server "..self.host..":"..self.port.." ....")
	self.tcp = socket.tcp()
	self.tcp:settimeout(0) 
	self.status = M.STATUS_CONNECTING
	-- check whether M is success
	-- the M is failure if socket isn't connected after SOCKET_CONNECT_FAIL_TIMEOUT seconds
	local __connectTimeTick = function ()
		if self.isConnected then return end
		self.waitConnect = self.waitConnect or 0
		self.waitConnect = self.waitConnect + 0.1
		if self.waitConnect >= M.SOCKET_CONNECT_FAIL_TIMEOUT then
			self.waitConnect = nil
			self:close()
			self:_connectFailure()
			return
		end
		self:__checkConnect()
	end
	 self.__connectTimeTickScheduler = cc.Director:getInstance():getScheduler():scheduleScriptFunc(__connectTimeTick, self.SOCKET_TICK_TIME, false)
end


-- close the current socket M
function M:close()

	if self.__connectTimeTickScheduler then
		 cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.__connectTimeTickScheduler)
         self.__connectTimeTickScheduler = nil
	end 
	if self.__tickScheduler then
		 cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.__tickScheduler)
         self.__tickScheduler = nil
	end

	if self.__reconnectScheduler then
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.__reconnectScheduler)
         self.__reconnectScheduler = nil
	end

	if self.isConnected == false then
		return 0
	end
	logger:info("close connect")
	self.isConnected = false
	self.waitConnect = nil
	self.status = M.STATUS_IDLE
	self.tcp:close()
end

-- dicconnect the current socket M
function M:disconnect()
	logger:info("disconnect")
	self:close()
end

-- re connect
function M:reconnect()
	logger:info("reconnect")
	self:connect()
end


function M:send(code,message,callback)
	--self:send(gsRequest.u_protocol_id,pbdata,function(errorCode,data)
		--message:process(errorCode,data)
	--end)
	--insert into block queue
	if self.status==M.STATUS_BUSY then
		table.insert(self.__blockMessageQueue,{code = code,data = message,callback = callback})
		logger:info("current connection is busy.")
		return
	end
	
	local gsRequest = proto.gs_main.GS_Request()
	gsRequest.u_protocol_id = code
	gsRequest.u_valid_code = self.validCode
	if message then
		local messageTbl = getmetatable(message)
		local messageName = messageTbl["_descriptor"]["name"]
		gsRequest.message.s_msg_name = messageName
		gsRequest.message.s_msg_body = message:SerializeToString()
	end
	local data = gsRequest:SerializeToString()
	self.status = M.STATUS_BUSY
	self.__penddingCallBack[gsRequest.u_protocol_id] = callback
	logger:info(string.format("send message 0x%x %s",gsRequest.u_protocol_id,gsRequest.message.s_msg_name))
	print(tostring(gsRequest))
	local state, error, index = self.tcp:send(encode(data))
	--remove from block queue after sended
	for i,messageData in ipairs(self.__blockMessageQueue) do
		if messageData.code == gsRequest.u_protocol_id then
			table.remove(self.__blockMessageQueue,i)
		end
	end
	if state == nil then
		if error == "timeout" then return M.TIMETOUT
		elseif error == "closed" then return M.CLOSED end
	else
		return 1
	end
	
end


function M:startHeartbeat()
   
	local function onHeartHandler()
		new.HeartBeatMessage():send()
	end
	cstimer.removeScheduler(self.heartTimer)
	self.heartTimer = cstimer.addScheduler(onHeartHandler, 60,-1)
end


function M:setName( __name )
	self.name = __name
	return self
end


function M:autoConnect(__connect)
	self.__autoConnect = __connect
	return self
end


function M:getStatus()
	return self.status
end

--constants
M.SOCKET_TICK_TIME = 0           -- check socket data interval
M.SOCKET_RECONNECT_TIME = 5         -- socket reconnect try interval
M.SOCKET_CONNECT_FAIL_TIMEOUT = 3   -- socket failure timeout

M.STATUS_CLOSED = "closed"
M.STATUS_BUSY = "BUSY"
M.STATUS_IDLE = "IDLE"
M.STATUS_CONNECTING = "CONNECTING"
M.STATUS_NOT_CONNECTED = "Socket is not connected"
M.STATUS_ALREADY_CONNECTED = "already connected"
M.STATUS_ALREADY_IN_PROGRESS = "Operation already in progress"
M.STATUS_TIMEOUT = "timeout"

M.CONNECT_TYPE_ONCE = "once"; 
M.CONNECT_TYPE_ALAWYS = "alawys"; 


M.TIMEOUT = -1
M.CLOSED = -2
M.EMPTY = -3    --means read empty data

M.instance= nil
return M



