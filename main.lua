-- cclog
cclog = function(...)
    print(string.format(...))
end

-- for CCLuaEngine traceback
function __G__TRACKBACK__(msg)

    if log and type(log.error) == "function" then
        log.error(msg)
    else
        cclog("----------------------------------------")
        cclog("LUA ERROR: " .. tostring(msg) .. "\n")
        cclog(debug.traceback())
        cclog("----------------------------------------")
    end
    return msg
end


cc.FileUtils:getInstance():setPopupNotify(false)
cc.FileUtils:getInstance():addSearchPath("src/")
cc.FileUtils:getInstance():addSearchPath("res/")
require "config"
require "cocos.init"
require "external"
clover = require "clover"
local function main()
	local MyApp = require "app.MyApp"
	MyApp()
end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    print(msg)
end
