XIncludeFile "my.pbi"

DeclareModule MyFont
	
	Interface MyFont Extends My::My
		GetName.s()
		GetSize.i()
		GetStyle.i()
		
		GetFont.i()
		GetFontID.i()
	EndInterface
	
	Declare MyFontCreate(name.s,size.i,style.i=0)
	
EndDeclareModule

XIncludeFile "MyFont/myfont.pb"