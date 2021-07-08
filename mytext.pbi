XIncludeFile "my.pbi"
XIncludeFile "mystyle.pbi"

DeclareModule MyText 
	
	Interface MyText Extends My::MyGadget
		GetText.s():SetText(value.s)
		GetStyle.i():SetStyle(*value.MyStyle::MyStyle)
	EndInterface
	
	Declare MyTextCreate(x.i,y.i,w.i,h.i,text.s)
	
	
EndDeclareModule

XIncludeFile "mytext/mytext.pb"