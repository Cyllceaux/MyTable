Procedure _MyTable_Style_GetObject(*this.strMyTableStyleObject)
	If *this
		ProcedureReturn *this\obj
	EndIf
EndProcedure

Procedure _MyTable_Style_GetType(*this.strMyTableStyleObject)
	If *this
		ProcedureReturn *this\type
	EndIf
EndProcedure

Procedure _MyTable_Style_Redraw(*this.strMyTableStyleObject)
	Select *this\obj\type
		Case #MYTABLE_TYPE_APPLICATION
			Protected *application.strMyTableApplication=*this\obj
			*application\dirty=#True
			_MyTable_Application_Redraw(*application)
		Case #MYTABLE_TYPE_TABLE,#MYTABLE_TYPE_GRID,#MYTABLE_TYPE_TREE
			Protected *table.strMyTableTable=*this\obj
			*table\dirty=#True
			_MyTable_Table_Redraw(*table)
		Case #MYTABLE_TYPE_ROW
			Protected *row.strMyTableRow=*this\obj
			*row\dirty=#True
			*row\table\dirty=#True
			_MyTable_Table_Redraw(*row\table)
		Case #MYTABLE_TYPE_COL
			Protected *col.strMyTableCol=*this\obj
			*col\dirty=#True
			*col\table\dirty=#True
			_MyTable_Table_Redraw(*col\table)
		Case #MYTABLE_TYPE_CELL
			Protected *cell.strMyTableCell=*this\obj
			*cell\dirty=#True
			*cell\table\dirty=#True
			_MyTable_Table_Redraw(*cell\table)
	EndSelect
EndProcedure


Procedure _MyTable_Style_Free(*this.strMyTableStyleObject)
	If *this
		FreeStructure(*this)
	EndIf
EndProcedure

Procedure _MyTable_Style_Delete(*this.strMyTableStyleObject)
	If *this
		*this\style\backcolor=0
		*this\style\border\border=0
		*this\style\border\borderDefault\color=0
		*this\style\border\borderDefault\width=0
		*this\style\border\borderTop\color=0
		*this\style\border\borderTop\width=0
		*this\style\border\borderLeft\color=0
		*this\style\border\borderLeft\width=0
		*this\style\border\borderRight\color=0
		*this\style\border\borderRight\width=0
		*this\style\border\borderBottom\color=0
		*this\style\border\borderBottom\width=0
		*this\style\font=0
		*this\style\forecolor=0
		*this\style\frontcolor=0
		*this\style\halign=0
		*this\style\valign=0
		_MyTable_Style_Redraw(*this)
	EndIf
EndProcedure

Macro _MyTable_Style_GetterSetter(name,typ,sub=)
	Procedure _MyTable_Style_Set#name(*this.strMyTableStyleObject,value.typ)
		If *this
			*this\style\sub#name=value
			_MyTable_Style_Redraw(*this)
		EndIf
	EndProcedure
	
	Procedure.typ _MyTable_Style_Get#name(*this.strMyTableStyleObject)
		If *this
			Protected result.typ=*this\style\sub#name
			If Not result
				result=_mytable_getDefault#name(*this\obj)
			EndIf
			ProcedureReturn result
		EndIf
	EndProcedure
EndMacro

Macro _MyTable_Style_GetterSetterPointer(name,typ,sub=)
	Procedure _MyTable_Style_Set#name(*this.strMyTableStyleObject,*value.typ)
		If *this
			*this\style\sub#name=*value
			_MyTable_Style_Redraw(*this)
		EndIf
	EndProcedure
	
	Procedure _MyTable_Style_Get#name(*this.strMyTableStyleObject)
		If *this
			Protected *result.typ=*this\style\sub#name
			If Not *result
				*result=_mytable_getDefault#name(*this\obj)
			EndIf
			ProcedureReturn *result
		EndIf
	EndProcedure
EndMacro

Macro _MyTable_Style_GetterSetterBorder(name,typ,pos)
	Procedure _MyTable_Style_SetBorder#name#pos(*this.strMyTableStyleObject,value.typ)
		If *this
			*this\style\border\border#pos\name=value
			_MyTable_Style_Redraw(*this)
		EndIf
	EndProcedure
	
	Procedure.typ _MyTable_Style_GetBorder#name#pos(*this.strMyTableStyleObject)
		If *this
			Protected result.typ=*this\style\border\border#pos\name
			If Not result
				result=_mytable_getDefaultBorder#name#pos(*this\obj)
			EndIf
			ProcedureReturn result
		EndIf
	EndProcedure
EndMacro

Macro _MyTable_Style_GetterSetterBorders(name,typ)
	_MyTable_Style_GetterSetterBorder(name,typ,Default)
	_MyTable_Style_GetterSetterBorder(name,typ,Top)
	_MyTable_Style_GetterSetterBorder(name,typ,Bottom)
	_MyTable_Style_GetterSetterBorder(name,typ,Left)
	_MyTable_Style_GetterSetterBorder(name,typ,Right)
EndMacro


_MyTable_Style_GetterSetterPointer(Font,strMyTableFont)
_MyTable_Style_GetterSetter(HAlign,i)
_MyTable_Style_GetterSetter(VAlign,i)
_MyTable_Style_GetterSetter(BackColor,q)
_MyTable_Style_GetterSetter(FrontColor,q)
_MyTable_Style_GetterSetter(ForeColor,q)
_MyTable_Style_GetterSetter(Border,i,border\)
_MyTable_Style_GetterSetterBorders(Color,q)
_MyTable_Style_GetterSetterBorders(Width,i)
