menuNode = {}
function menuNode:_getMenu(name)
	-- hopefully private
	-- if you need to call this outside of this library it's a sign I 
	-- may need a new function but I may need to turn it to public
	assert(not (self == nil), "_getMenu self cant be nil")
	assert(type(name) == "string", "_getMenu name should be a string")
	for key,node in pairs(self._sub_menu) do
		if node._name == name then
			return node
		end
	end
	return nil
end
function menuNode:new()
	local o = {
		_sub_menu = {},
		_onclick = nil, -- on the menu being opened / clicked
		_button_name_fn=nil,
		_name = ""
	}
	setmetatable(o,self)
	self.__index=self
	return o
end
gmMenu = menuNode:new()
function gmMenu:_getInnerMenu(baseMenus)
	assert(not (self == nil), "_getInnerMenu self cant be nil")
	local ret=self
	for k,v in pairs(baseMenus) do
		ret=ret:_getMenu(v)
		if ret == nil then
			return ret
		end
	end
	return ret
end
function gmMenu:setCurrentMenu(name)
	assert(not (self == nil), "setCurrentMenu self cant be nil")
	assert(type(name) == "string", "setCurrentMenu name should be a string")
	self._currentMenu=name
end
function gmMenu:getCurrentMenu()
	return self._currentMenu
end
function gmMenu:_showMenuClosers(closers)
	assert(not (self == nil), "_showClosers self cant be nil")
	local backText=""
	for n,i in pairs(closers) do
		local bt=backText
		addGMFunction("-"..i,
			function ()
				self:setCurrentMenu(bt)
				self:displayMenu()
			end
		)
		if backText == "" then
			backText=backText..i
		else
			backText=backText.."/"..i
		end
	end
end
function gmMenu:displayMenu(menu)
	assert(not (self == nil), "displayMenu self cant be nil")
	if not (menu == nil) then
		self:setCurrentMenu(menu)
	end
	clearGMFunctions()
	local preMenu=self:_splitMenu(self._currentMenu)
	self:_showMenuClosers(preMenu)
	local inner=self:_getInnerMenu(preMenu)
	for k,menu in pairs(inner._sub_menu) do
		local prefix = "+"
		if #menu._sub_menu == 0 then
			prefix=""
		end
		local menu_name=menu._name
		if (menu._button_name_fn) then
			menu_name=menu._button_name_fn()
		end
		addGMFunction(prefix..menu_name,
			function ()
				if not (#menu._sub_menu == 0) then
					local o=self._currentMenu
					if not (o == "") then
						o=o.."/"
					end
					o=o..menu._name
					self:setCurrentMenu(o)
					self:displayMenu()
				end
				if not (menu._onclick == nil) then
					menu._onclick()
				end			end 
		)
	end
end
function gmMenu:_internalAddItem(menus,fn,button_name_fn)
	assert(not (self == nil), "_internalAddItem self cant be nil")
	assert(type(menus) == "table", "_internalAddItem first argument should be a table")
	assert(fn == nil or type(fn) == "function", "_internalAddItem second argument should be a function or nil")
	assert(button_name_fn == nil or type(button_name_fn) == "function", "_internalAddItem third item must be a function or nil")
	local node=self
	for k,v in pairs(menus) do
		if node:_getMenu(v) == nil then
			table.insert(node._sub_menu,menuNode:new())
			node._sub_menu[#node._sub_menu]._name=v
		end
		node=node:_getMenu(v)
		if (k==#menus) then
			node._onclick=fn
			node._button_name_fn=button_name_fn
		end
	end
end
function gmMenu:addItem(name,fn,button_name_fn)
	assert(not (self == nil), "addItem self cant be nil")
	assert(type(name) == "string" or type(name) == "table", "addItem first argument should be a string or a table")
	assert(type(fn) == "function", "addItem second argument should be a function")
	assert(button_name_fn == nil or type(button_name_fn) == "function", "addItem third item must be a function or nil")
	local menus=name
	if (type(name) == "string") then 
		menus=self:_splitMenu(name)
	end
	self:_internalAddItem(menus,fn,button_name_fn)
end
function gmMenu:setDynamicButtonText(name,button_name_fn)
	assert(not (self == nil), "addItem self cant be nil")
	assert(type(name) == "string" or type(name) == "table", "addItem first argument should be a string or a table")
	assert(type(button_name_fn) == "function", "addItem second item must be a function")
	local menus=name
	if (type(name) == "string") then 
		menus=self:_splitMenu(name)
	end
	self:_internalAddItem(menus,nil,button_name_fn)
end
function gmMenu:_splitMenu(name,ret)
	assert(not (self == nil), "_splitMenu self cant be nil")
	assert(type(name) == "string", "_splitMenu name should be a string")
	local ret = ret or {}
	if not (name:find("/")==nil) then
		local base=name:sub(0,name:find("/")-1)
		local remain=name:sub(name:find("/")+1)
		ret[#ret+1]=base
		return self:_splitMenu(remain,ret)
	else
		if not (name=="") then
			ret[#ret+1]=name
		end
		return ret
	end
end
function gmMenu:new()
	local o = {
		_currentMenu = "" -- the current open menu
	}
	setmetatable(o,self)
	self.__index=self;
	return o
end