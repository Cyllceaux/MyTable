Module MyText
	EnableExplicit
	
	
	XIncludeFile "mytextmacro.pb"
	XIncludeFile "mytextstructure.pb"
	XIncludeFile "mytextdeclare.pb"
	XIncludeFile "mytextautodeclare.pb"
	XIncludeFile "mytextglobal.pb"
	XIncludeFile "mytexttext.pb"
	
	DataSection
		vtable_mytext:
		_MyDataSectionGadgetDefault(MyText,Text)
		_MyDataSectionGetterSetter(MyText,Text,Text)
		_MyDataSectionGetterSetter(MyText,Text,Style)
	EndDataSection	
EndModule
