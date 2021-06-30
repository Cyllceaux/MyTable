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



_MyTableBorderSetterGetter(Color,q)
_MyTableBorderSetterGetter(Width,i)