Procedure _MyTable_Border_GetObject(*this.strMyTableBorderObject)
	If *this
		ProcedureReturn *this\style\obj
	EndIf
EndProcedure

Procedure _MyTable_Border_GetType(*this.strMyTableBorderObject)
	If *this
		ProcedureReturn *this\type
	EndIf
EndProcedure

Procedure _MyTable_Border_GetStyle(*this.strMyTableBorderObject)
	If *this
		ProcedureReturn *this\style
	EndIf
EndProcedure

Procedure _MyTable_Border_Free(*this.strMyTableBorderObject)
	If *this
		FreeStructure(*this)
	EndIf
EndProcedure

Procedure _MyTable_Border_Delete(*this.strMyTableBorderObject)
	If *this
		*this\border\color=0
		*this\border\width=0
	EndIf
EndProcedure

Macro _MyTableBorderSetterGetter(name,typ)
	_MyTableAddAutoDeclare(.typ _MyTable_Border_Get#name(*this.strMyTableBorderObject))
	Procedure.typ _MyTable_Border_Get#name(*this.strMyTableBorderObject)
		If *this
			Protected result.typ= *this\border\name
			If Not result
				If *this\borderBottom
					result=_MyTable_GetDefaultBorder#name#Bottom(*this\style\obj)
				ElseIf *this\borderDefault
					result=_MyTable_GetDefaultBorder#name#Default(*this\style\obj)
				ElseIf *this\borderLeft
					result=_MyTable_GetDefaultBorder#name#Left(*this\style\obj)
				ElseIf *this\borderRight
					result=_MyTable_GetDefaultBorder#name#Right(*this\style\obj)					
				ElseIf *this\borderTop
					result=_MyTable_GetDefaultBorder#name#Top(*this\style\obj)
				EndIf
			EndIf
			ProcedureReturn result
		EndIf
	EndProcedure
	
	Procedure _MyTable_Border_Set#name(*this.strMyTableBorderObject,value.typ)
		If *this
			*this\border\name=value
			_MyTable_Style_Redraw(*this\style)
		EndIf
	EndProcedure
EndMacro

_MyTableBorderSetterGetter(Color,q)
_MyTableBorderSetterGetter(Width,i)