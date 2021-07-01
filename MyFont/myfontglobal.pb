Procedure _MyFontInitFont(*font.strMyFontFont,
                           name.s,
                           size.i,
                           flags.i,
                           font.i)
	With *font
		\vtable=?vtable_font
		\name=name
		\size=size
		\flags=flags
		\font=font
		\fontid=FontID(font)
		\type=My::#MY_TYPE_FONT
	EndWith
	
EndProcedure

Global NewList fonts.strMyFontFont()

Procedure MyFontCreateFont(name.s,size.i,flags.i=0)
	ForEach fonts()
		If fonts()\name=name And 
		   fonts()\size=size And 
		   fonts()\flags=flags
			ProcedureReturn fonts()
		EndIf
	Next
	
	Protected font=LoadFont(#PB_Any,name,size,flags)
	If font
		Protected *this.strMyFontFont=AddElement(fonts())
		_MyFontInitFont(*this,name,size,flags,font)
		ProcedureReturn *this
	EndIf
EndProcedure