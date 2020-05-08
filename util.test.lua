require("ee-test")
require("util")
assert(starryUtil.math.lerp(1,2,0)==1)
assert(starryUtil.math.lerp(1,2,1)==2)
assert(starryUtil.math.lerp(2,1,0)==2)
assert(starryUtil.math.lerp(2,1,1)==1)
assert(starryUtil.math.lerp(2,1,.5)==1.5)

getAllObjectsTest={}
assert(starryUtil.debug.getNumberOfObjectsString()=="")
getAllObjectsTest={{typeName ="test"}}
assert(starryUtil.debug.getNumberOfObjectsString()=="test 1")
getAllObjectsTest={{typeName ="test"},{typeName ="test"}}
assert(starryUtil.debug.getNumberOfObjectsString()=="test 2")
getAllObjectsTest={{typeName ="testA"},{typeName ="testB"}}
assert(starryUtil.debug.getNumberOfObjectsString()=="testA 1\ntestB 1")
getAllObjectsTest={{typeName ="testA"},{typeName ="testB"},{typeName ="testB"}}
assert(starryUtil.debug.getNumberOfObjectsString()=="testA 1\ntestB 2")
