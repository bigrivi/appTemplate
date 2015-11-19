local Data = clover.class()


function Data:ctor(rawData)
	self.data = rawData
end 

function Data:all()
	return self.data
end 

function Data:findBy(attr,value)
	local res = {}
	for i,v in pairs(self.data) do
		if v[attr] == value then
			table.insert(res,v)
		end 
	end 
	return res
end 

function Data:findById(id)
	return self.data[id]
end 


return Data