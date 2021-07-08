EnableExplicit

XIncludeFile "testDeclare.pb"

SetWindowTitle(window,"Test1")

Define y=5
Global *text1.MyText=MyTextCreate(5,y,100,50,"Test 1"):y+55
Global *text1a.MyText=MyTextCreate(5,y,100,22,"Test 1a"):y+35
Global *text2.MyText=MyTextCreate(5,y,100,22,"Test 2"):y+27
Global *text3.MyText=MyTextCreate(5,y,100,22,"Test 3"):y+27
Global *text4.MyText=MyTextCreate(5,y,100,22,"Test 4"):y+27
Global *text5.MyText=MyTextCreate(5,y,100,22,"Ganz langer Text... Also ein wenig länger als nur 'Test *'"):y+27
Global *text6.MyText=MyTextCreate(5,y,100,22,*text5\GetText()):y+27
Global *text7.MyText=MyTextCreate(5,y,150,100,*text5\GetText())
Global *text7a.MyText=MyTextCreate(160,y,150,100,*text5\GetText())
Global *text7b.MyText=MyTextCreate(315,y,150,100,*text5\GetText()):y+105
Global *text8.MyText=MyTextCreate(5,y,100,22,"Test 8"):y+27

Global *style1.MyStyle=MyStyleCreate()
Global *style2.MyStyle=MyStyleCreate()
Global *style3.MyStyle=MyStyleCreate()
Global *style4.MyStyle=MyStyleCreate()
Global *style7.MyStyle=MyStyleCreate()
Global *style7a.MyStyle=MyStyleCreate()
Global *style7b.MyStyle=MyStyleCreate()
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

*style7\SetLineBreak(#True)
*style7a\SetLineBreak(#True):*style7a\SetHAlign(#MYSTYLE_HALIGN_CENTER)
*style7b\SetLineBreak(#True):*style7b\SetHAlign(#MYSTYLE_HALIGN_RIGHT)

*text1\SetStyle(*style1)
*text1a\SetStyle(*style1)
*text2\SetStyle(*style2)
*text3\SetStyle(*style3)
*text4\SetStyle(*style4)
*text7\SetStyle(*style7)
*text7a\SetStyle(*style7a)
*text7b\SetStyle(*style7b)

*text1a\Resize(#PB_Ignore,#PB_Ignore,*text1a\GetCalcWidth(),*text1a\GetCalcHeight())
*text6\Resize(#PB_Ignore,#PB_Ignore,*text6\GetCalcWidth(),*text6\GetCalcHeight())

Procedure.b CustomDraw(*my.MyText,x,y,w,h)
	DrawingMode(#PB_2DDrawing_Transparent)
	DrawText(x,y,"CustomDraw",#Red)
	ProcedureReturn #True
EndProcedure
*text8\BindCustomDraw(@CustomDraw())


XIncludeFile "testUnDeclare.pb"