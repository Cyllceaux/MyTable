Macro _MyDataSectionMethode(projekt,gruppe,name)
	Data.i @_#projekt#_#gruppe#_#name()
EndMacro

Macro _MyDataSectionGetter(projekt,gruppe,name)
	_MyDataSectionMethode(projekt,gruppe,Get#name)
EndMacro

Macro _MyDataSectionSetter(projekt,gruppe,name)
	_MyDataSectionMethode(projekt,gruppe,Set#name)
EndMacro

Macro _MyDataSectionGetterSetter(projekt,gruppe,name)
	_MyDataSectionGetter(projekt,gruppe,name)
	_MyDataSectionSetter(projekt,gruppe,name)
EndMacro

Macro _MyDataSectionDefault(projekt,gruppe)
	_MyDataSectionGetter(projekt,gruppe,Type)
EndMacro

Macro _MyDataSectionGadgetDefault(projekt,gruppe)
	_MyDataSectionDefault(projekt,gruppe)
	_MyDataSectionGetter(projekt,gruppe,Canvas)
EndMacro

Macro _MyDataSectionScrollableGadgetDefault(projekt,gruppe)
	_MyDataSectionGadgetDefault(projekt,gruppe)
	_MyDataSectionGetter(projekt,gruppe,Canvas)
	_MyDataSectionGetter(projekt,gruppe,VScroll)
	_MyDataSectionGetter(projekt,gruppe,HScroll)
EndMacro

Macro _MyDefaultGetter(projekt,gruppe,name,typ)
	Procedure.typ _#projekt#_#gruppe#_Get#name(*this.str#projekt#gruppe) 
		If *this
			ProcedureReturn *this\name
		EndIf
	EndProcedure
EndMacro