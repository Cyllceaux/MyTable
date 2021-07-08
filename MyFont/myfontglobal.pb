IncludeFile "../MyGlobal/myglobalglobal.pb"


Global NewList fonts.strMyFontFont()

Procedure MyFontCreate(name.s,size.i,style.i=0)
	ForEach fonts()
		If fonts()\name=name And fonts()\size=size And fonts()\style=style
			ProcedureReturn fonts()
		EndIf
	Next
	Protected font.i=LoadFont(#PB_Any,name,size,style)
	If font
		Protected *this.strMyFontFont=AddElement(fonts())
		With *this
			\vtable=?vtable_myfont
			\type=My::#MY_TYPE_FONT
			\name=name
			\size=size
			\style=style
			\font=font
			\fontID=FontID(font)
		EndWith		
		ProcedureReturn *this
	EndIf
EndProcedure