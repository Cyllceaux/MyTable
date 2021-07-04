XIncludeFile "my.pbi"

DeclareModule MyFont
	
	#MYFONT_VERSION = 253
	#MYFONT_VERSION_DATE = 20210704
	
	Interface MyFont
		GetType()
		GetFlags()
		GetName.s()
		GetSize()
		
		GetFont()
		GetFontID()
	EndInterface
	
	Declare MyFontCreateFont(name.s,size.i,flags.i=0)	
	
EndDeclareModule

XIncludeFile "MyFont/myFont.pb"