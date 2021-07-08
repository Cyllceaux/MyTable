Module MyTemplate
	EnableExplicit
	
	
	XIncludeFile "templatemacro.pb"
	XIncludeFile "templatestructure.pb"
	XIncludeFile "templatedeclare.pb"
	XIncludeFile "templateautodeclare.pb"
	XIncludeFile "templateglobal.pb"
	XIncludeFile "templatetemplate.pb"
	
	DataSection
		vtable_template:
		_MyDataSectionDefault(MyTemplate,Template)
	EndDataSection	
EndModule
