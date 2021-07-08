EnableExplicit

XIncludeFile "testDeclare.pb"

SetWindowTitle(window,"Test1")

Define y=5
Global *text1.MyText=MyTextCreate(5,y,100,50,"Test 1"):y+55
Global *text2.MyText=MyTextCreate(5,y,100,22,"Test 2"):y+27
Global *text3.MyText=MyTextCreate(5,y,100,22,"Test 3"):y+27
Global *text4.MyText=MyTextCreate(5,y,100,22,"Test 4"):y+27
Global *text1a.MyText=MyTextCreate(5,y,100,22,"Test 1a"):y+27

Global *style1.MyStyle=MyStyleCreate()
Global *style2.MyStyle=MyStyleCreate()
Global *style3.MyStyle=MyStyleCreate()
Global *style4.MyStyle=MyStyleCreate()
Global *font1.MyFont=MyFontCreate("Arial",10,#PB_Font_Bold|#PB_Font_HighQuality)
Global *border1.MyBorder=MyBorderCreate(4,4,4)
Global *border2.MyBorder=MyBorderCreate(1,1,1,#Green)
*style1\SetFont(*font1)
*style1\setFrontColor(#Red)
*style1\setBackColor(RGBA(200,150,150,255))
*style1\SetBorder(#MYSTYLE_BORDER_DEFAULT,*border1)
*style1\SetBorder(#MYSTYLE_BORDER_TOP,*border2)
*style1\SetVAlign(#MYSTYLE_VALIGN_MIDDLE)
*style1\SetHAlign(#MYSTYLE_HALIGN_CENTER)

*style3\SetHAlign(#MYSTYLE_HALIGN_RIGHT)
*style4\SetHAlign(#MYSTYLE_HALIGN_CENTER)


*text1\SetStyle(*style1)
*text1a\SetStyle(*style1)
*text2\SetStyle(*style2)
*text3\SetStyle(*style3)
*text4\SetStyle(*style4)

*text1a\Resize(#PB_Ignore,#PB_Ignore,*text1a\GetCalcWidth(),*text1a\GetCalcHeight())

XIncludeFile "testUnDeclare.pb"