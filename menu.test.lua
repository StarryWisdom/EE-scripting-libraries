require("menu")
require("ee-test")

menu=gmMenu:new()
menu:addItem("test1/test1",function () print "a" end )
menu:addItem("test1/test2",function () print "a" end )
menu:displayMenu()

assert(#menuTest==1)
assert(menuTest[1].name=="+test1")
assert(menu:getCurrentMenu()=="")
menu:setCurrentMenu("test1")
assert(menu:getCurrentMenu()=="test1")

menu:displayMenu()
assert(#menuTest==3)
--assert(menuTest[1].name=="+test1")

clearGMFunctions()