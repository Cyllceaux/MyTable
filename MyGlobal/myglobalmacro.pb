Macro MM
	"
EndMacro

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
	_MyDataSectionGetter(projekt,gruppe,X)
	_MyDataSectionGetter(projekt,gruppe,Y)
	_MyDataSectionGetter(projekt,gruppe,W)
	_MyDataSectionGetter(projekt,gruppe,H)
	_MyDataSectionGetterSetter(projekt,gruppe,Redraw)
	_MyDataSectionMethode(projekt,gruppe,Redraw)
	_MyDataSectionMethode(projekt,gruppe,Resize)
	_MyDataSectionMethode(projekt,gruppe,Free)
EndMacro

Macro _MyDataSectionScrollableGadgetDefault(projekt,gruppe)
	_MyDataSectionGadgetDefault(projekt,gruppe)

EndMacro

Macro _MyDefaultGetter(projekt,gruppe,name,typ)
	Procedure.typ _#projekt#_#gruppe#_Get#name(*this.str#projekt#gruppe) 
		If *this
			ProcedureReturn *this\name
		EndIf
	EndProcedure
EndMacro

Macro _MyDefaultGetterPointer(projekt,gruppe,name)
	Procedure _#projekt#_#gruppe#_Get#name(*this.str#projekt#gruppe) 
		If *this
			ProcedureReturn *this\name
		EndIf
	EndProcedure
EndMacro

Macro _MyDefaultSetter(projekt,gruppe,name,typ)
	Procedure _#projekt#_#gruppe#_Set#name(*this.str#projekt#gruppe,value.typ) 
		If *this
			*this\name=value
		EndIf
	EndProcedure
EndMacro

Macro _MyDefaultSetterRedraw(projekt,gruppe,name,typ)
	Procedure _#projekt#_#gruppe#_Set#name(*this.str#projekt#gruppe,value.typ) 
		If *this
			*this\name=value
		EndIf
		_#projekt#_#gruppe#_Redraw(*this)
	EndProcedure
EndMacro

Macro _MyDefaultSetterPointerRedraw(projekt,gruppe,name)
	Procedure _#projekt#_#gruppe#_Set#name(*this.str#projekt#gruppe,*value) 
		If *this
			*this\name=*value
		EndIf
		_#projekt#_#gruppe#_Redraw(*this)
	EndProcedure
EndMacro

Macro _MyDefaultGetterSetter(projekt,gruppe,name,typ)
	_MyDefaultGetter(projekt,gruppe,name,typ)
	_MyDefaultSetter(projekt,gruppe,name,typ)
EndMacro

Macro _MyDefaultGetterSetterRedraw(projekt,gruppe,name,typ)
	_MyDefaultGetter(projekt,gruppe,name,typ)
	_MyDefaultSetterRedraw(projekt,gruppe,name,typ)
EndMacro

Macro _MyDefaultGetterSetterPointerRedraw(projekt,gruppe,name)
	_MyDefaultGetterPointer(projekt,gruppe,name)
	_MyDefaultSetterPointerRedraw(projekt,gruppe,name)
EndMacro


Macro _MyDefaultMy(projekt,gruppe)
	_MyDefaultGetter(projekt,gruppe,Type,i)
EndMacro

Macro _MyDefaultMyGadget(projekt,gruppe)
	_MyDefaultMy(projekt,gruppe)
	_MyDefaultGetter(projekt,gruppe,X,i)
	_MyDefaultGetter(projekt,gruppe,Y,i)
	_MyDefaultGetter(projekt,gruppe,W,i)
	_MyDefaultGetter(projekt,gruppe,H,i)
	_MyDefaultGetterSetterRedraw(projekt,gruppe,Redraw,b)
EndMacro

Macro _MyDefaultMyScrollableGadget(projekt,gruppe)
	_MyDefaultMyGadget(projekt,gruppe)
	
EndMacro