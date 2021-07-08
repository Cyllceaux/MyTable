Module MyFont
	EnableExplicit
	
	
	XIncludeFile "myfontmacro.pb"
	XIncludeFile "myfontstructure.pb"
	XIncludeFile "myfontdeclare.pb"
	XIncludeFile "myfontautodeclare.pb"
	XIncludeFile "myfontglobal.pb"
	XIncludeFile "myfontfont.pb"
	
	DataSection
		vtable_myfont:
		_MyDataSectionDefault(MyFont,Font)
		_MyDataSectionGetter(MyFont,Font,Name)
		_MyDataSectionGetter(MyFont,Font,Size)
		_MyDataSectionGetter(MyFont,Font,Style)
		_MyDataSectionGetter(MyFont,Font,Font)
		_MyDataSectionGetter(MyFont,Font,FontID)
	EndDataSection	
EndModule
