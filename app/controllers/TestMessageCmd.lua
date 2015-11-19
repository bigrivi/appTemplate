local class = clover.class
local table = require "clover.language.table"
local logger = clover.Logger()
local Item = import "..models.Item"

local M = class()


function M:ctor()
	self.apiService = {}
	self.userModel = {}
	self.itemList = {}
end 

function M:execute(event)
	logger:info("message test start ===================")
	logger:info("message test end ===================")
	--self.userModel:on("change:money",handler(self,self.handlerPropertyChange))
	
	--self.userModel:on("change",handler(self,self.handlerChange))

	--self.userModel:set("money",1000)
	--self.userModel:set("vit",45)
	--self.userModel:off("change:money")
	--self.userModel:set("money",555)
	--self.itemList:on("add",handler(self,self.handlerItemAdd))
	self.itemList:on("remove",handler(self,self.handlerItemRemove))
	--self.itemList:on("add|remove",handler(self,self.handlerItemChange))

	self.itemList:add({config_id = 100,amount = 25})
	self.itemList:add({config_id = 101,amount = 26})
	self.itemList:add({config_id = 102,amount = 28})
	self.itemList:add({config_id = 103,amount = 5})
	
	--local item = Item({config_id = 156,amount = 20})
	--self.itemList:add(item)
	--local clone = item:clone()
	--item:set("config_id",1000000)
	--self.itemList:add(item)
	--item:destroy()
	
	--self.itemList:remove(100)
	--self.itemList:remove(clone)
	--clone:on("all",handler(self,self._onModelEvet))
	--clone:destroy()
	self.userModel:on("change",handler(self,self.handlerChange))
	self.itemList:unshift({config_id = 108,amount = 3})
	self.itemList:unshift({config_id = 109,amount = 4})
	self.itemList:unshift({config_id = 110,amount = 1})
	self.itemList:pop()
	self.itemList:sort()
	self.itemList:forEach(function(index,v)
		--dump(v.attributes)
	end)
	
	local map = self.itemList:map(
		function(k,v)
			return v:get("config_id")*2
		end
	)
	local src = {1,2,3,4,5,6}
	local shuffle = self.itemList:shuffle()
	
	--local found = self.itemList:where({amount = 25})
	--dump(#found)
	--test shop buy
	--self.apiService:buyItem(1,500,1)
	--self.apiService:chat("wow1",1)
	--self.apiService:chat("wow2",1)
	--self.apiService:chat("wow3",1)
end 

function M:_onModelEvet(evt)
	--dump(evt.data.type)
end 

function M:handlerPropertyChange(evt)
	--dump(evt.data.oldValue)
	--dump(evt.data)
end 

function M:handlerChange(evt)
	--dump(evt.data.oldValue)
	--dump(self.userModel:previous("money"))
	self.itemList:each(function(k,v)
		dump(v.attributes)
	end)
end 

function M:handlerItemAdd(evt)
	dump("add item ,size =>"..self.itemList:length())
end 

function M:handlerItemRemove(evt)
	dump("remove item  ,size =>"..self.itemList:length())
end

function M:handlerItemChange(evt)
	dump("change item ,size =>"..self.itemList:length())
end

return M
