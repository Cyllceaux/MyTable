XIncludeFile "my.pbi"
XIncludeFile "myfont.pbi"

DeclareModule MyStyle 
	
	
	EnumerationBinary  _mystyle_border
		#MYSTYLE_BORDER_TOP
		#MYSTYLE_BORDER_LEFT
		#MYSTYLE_BORDER_RIGHT
		#MYSTYLE_BORDER_BOTTOM
	EndEnumeration
	
	#MYSTYLE_BORDER_DEFAULT=#MYSTYLE_BORDER_TOP|#MYSTYLE_BORDER_LEFT|#MYSTYLE_BORDER_RIGHT|#MYSTYLE_BORDER_BOTTOM
	
	Interface MyBorder Extends My::My
		GetMargin.i():SetMargin(value.i)
		GetPadding.i():SetPadding(value.i)
		GetSize.i():SetSize(value.i)
		GetColor.q():SetColor(value.q)
	EndInterface
	
	Enumeration _mystyle_valign
		#MYSTYLE_VALIGN_TOP
		#MYSTYLE_VALIGN_MIDDLE
		#MYSTYLE_VALIGN_BOTTOM
	EndEnumeration
	
	Enumeration _mystyle_halign
		#MYSTYLE_HALIGN_LEFT
		#MYSTYLE_HALIGN_CENTER
		#MYSTYLE_HALIGN_RIGHT
	EndEnumeration
	
	Interface MyStyle Extends My::My
		GetBackColor.q():SetBackColor(value.q)
		GetFrontColor.q():SetFrontColor(value.q)
		GetFont.i():SetFont(*font.MyFont::MyFont)
		GetBorder.i(type.i):SetBorder(type.i,*value.MyBorder)
		GetVAlign.i():SetVAlign(value.i)
		GetHAlign.i():SetHAlign(value.i)
	EndInterface
	
	Declare MyStyleCreate()
	Declare MyBorderCreate(margin.i=1,padding.i=1,size.i=1,color.q=#Black)
		
EndDeclareModule

XIncludeFile "mystyle/mystyle.pb"