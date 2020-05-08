function clearGMFunctions()
	menuTest={}
end
function addGMFunction(name,fn)
	table.insert(menuTest,{name=name,fn=fn})
end

function getAllObjects()
	return getAllObjectsTest
end

function resetTest()
	menuTest={}
	getAllObjectsTest={}
end

resetTest()