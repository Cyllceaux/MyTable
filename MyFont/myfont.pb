Module MyFont
	EnableExplicit
	
	IncludeFile "myfontstructure.pb"
	IncludeFile "../MyGlobal/myglobalmacro.pb"
	IncludeFile "../MyGlobal/myglobaldeclare.pb"
	IncludeFile "declare.pb"
	IncludeFile "autodeclare.pb"
	IncludeFile "myfontglobal.pb"
	IncludeFile "myfontfont.pb"
	IncludeFile "../MyGlobal/myglobalglobal.pb"
	
	DataSection
		vtable_font: ;- Font
		_DataSectionGetter(MyFont,Font,Type)
		_DataSectionGetter(MyFont,Font,Flags)
		_DataSectionGetter(MyFont,Font,Name)
		_DataSectionGetter(MyFont,Font,Size)
		
		_DataSectionGetter(MyFont,Font,Font)
		_DataSectionGetter(MyFont,Font,FontID)
	EndDataSection
	
EndModule