EnableExplicit

XIncludeFile "testDeclare.pb"

SetWindowTitle(window,"Test1")

Define y=5
Global *text1.MyText=MyTextCreate(5,y,100,22,"Test 1"):y+27
Global *text2.MyText=MyTextCreate(5,y,100,22,"Test 2")



XIncludeFile "testUnDeclare.pb"