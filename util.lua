-- starryUtil v1
starryUtil={
	math={
		-- linear interpolation
		-- mostly intended as an aid to make code more readable
		lerp=function(a,b,t)
			assert(type(a)=="number")
			assert(type(b)=="number")
			assert(type(t)=="number")
			return a + t * (b - a);
		end
	},
	debug={
		-- get a multi-line string for the number of objects at the current time
		-- intended to be used via addGMMessage or print, but there may be other uses
		-- it may be worth considering adding a function which would return an array rather than a string
		getNumberOfObjectsString=function()
			local counts={}
			--first up we accumulate the number of each type of object
			for _,obj in pairs(getAllObjects()) do
				if counts[obj.typeName]==nil then
					counts[obj.typeName]=0
				end
				counts[obj.typeName]=counts[obj.typeName]+1
			end
			-- we want the ordering to be stable so we build a key list
			local sortedKeys={}
			for key in pairs(counts) do
				table.insert(sortedKeys, key)
			end
			table.sort(sortedKeys)
			--lastly we build the output
			local ret=""
			for _,key in ipairs(sortedKeys) do
				if not(ret=="") then
					ret=ret.."\n"
				end
				ret=ret..key.." "..counts[key]
			end
			return ret
		end
	},
}
