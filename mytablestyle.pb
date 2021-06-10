Macro _MyTableStyleGet(root,name)
	Protected *cell.strMyTableCell=0
	Protected *col.strMyTableCol=0
	Protected *row.strMyTableRow=0
	Protected *table.strMyTableTable=0
	Protected *application.strMyTableApplication=0
	
	Select root\type
		Case #MYTABLE_TYPE_APPLICATION
			*application=root
		Case #MYTABLE_TYPE_TABLE
			*table=root
			*application=*table\application
		Case #MYTABLE_TYPE_ROW
			*row=root
			*table=*row\table
			*application=*table\application
		Case #MYTABLE_TYPE_COL
			*col=root
			*table=*col\table
			*application=*table\application
		Case #MYTABLE_TYPE_CELL
			*cell=root
			*table=*cell\table
			*application=*table\application
	EndSelect
	If Not result And *cell
		result=*cell\style\name
	EndIf
	If Not result And *col
		result=*col\style\name
	EndIf
	If Not result And *row
		result=*row\style\name
	EndIf
	If Not result And *table
		result=*table\style\name
	EndIf
	If Not result And *application
		result=*application\style\name
	EndIf
EndMacro

Macro _MyTableStyleGetCol(root,name)
	Protected *cell.strMyTableCell=0
	Protected *col.strMyTableCol=0
	Protected *row.strMyTableRow=0
	Protected *table.strMyTableTable=0
	Protected *application.strMyTableApplication=0
	
	Select root\type
		Case #MYTABLE_TYPE_APPLICATION
			*application=root
		Case #MYTABLE_TYPE_TABLE
			*table=root
			*application=*table\application
		Case #MYTABLE_TYPE_ROW
			*row=root
			*table=*row\table
			*application=*table\application
		Case #MYTABLE_TYPE_COL
			*col=root
			*table=*col\table
			*application=*table\application
		Case #MYTABLE_TYPE_CELL
			*cell=root			
			*table=*cell\table
			*col=*cell\col			
			*application=*table\application
	EndSelect
	If Not result And *cell
		result=*cell\style\name
	EndIf
	If Not result And *col
		result=*col\style\name
	EndIf
	If Not result And *row
		result=*row\style\name
	EndIf
	If Not result And *table
		result=*table\style\name
	EndIf
	If Not result And *application
		result=*application\style\name
	EndIf
EndMacro

Macro _MyTableStyleGetRow(root,name)
	Protected *cell.strMyTableCell=0
	Protected *col.strMyTableCol=0
	Protected *row.strMyTableRow=0
	Protected *table.strMyTableTable=0
	Protected *application.strMyTableApplication=0
	
	Select root\type
		Case #MYTABLE_TYPE_APPLICATION
			*application=root
		Case #MYTABLE_TYPE_TABLE
			*table=root
			*application=*table\application
		Case #MYTABLE_TYPE_ROW
			*row=root
			*table=*row\table
			*application=*table\application
		Case #MYTABLE_TYPE_COL
			*col=root
			*table=*col\table
			*application=*table\application
		Case #MYTABLE_TYPE_CELL
			*cell=root
			*table=*cell\table
			*row=*cell\row
			*application=*table\application
	EndSelect
	If Not result And *cell
		result=*cell\style\name
	EndIf
	If Not result And *col
		result=*col\style\name
	EndIf
	If Not result And *row
		result=*row\style\name
	EndIf
	If Not result And *table
		result=*table\style\name
	EndIf
	If Not result And *application
		result=*application\style\name
	EndIf
EndMacro

Macro _MyTableStyleSet(name)
	*this\obj\style\name=value
	*this\obj\dirty=#True
	Protected *col.strMyTableCol=0
	Protected *row.strMyTableRow=0
	Protected *cell.strMyTableCell=0
	Select *this\obj\type
		Case #MYTABLE_TYPE_CELL
			*cell=*this\obj
			If *cell\image\sized
				FreeImage(*cell\image\sized)
			EndIf
			*cell\image\sized=0
		Case #MYTABLE_TYPE_COL
			*col=*this\obj
			If *col\image\sized
				FreeImage(*col\image\sized)
			EndIf
			*col\image\sized=0
		Case #MYTABLE_TYPE_ROW
			*row=*this\obj
			If *row\cells
				ForEach *row\cells\cells()
					*row\cells\cells()\style\name=value
					*row\cells\cells()\dirty=#True
				Next
			EndIf
	EndSelect
	_MyTable_Style_Redraw(*this)
EndMacro

Procedure _MyTable_Style_GetFont(*this.strMyTableStyleObject)
	If *this
		Protected result.i=0
		_MyTableStyleGet(*this\obj,font)
		ProcedureReturn result
	EndIf
EndProcedure

Procedure.q _MyTable_Style_GetBackColor(*this.strMyTableStyleObject)
	If *this
		Protected result.q=0
		_MyTableStyleGet(*this\obj,backcolor)
		ProcedureReturn result
	EndIf
EndProcedure

Procedure.q _MyTable_Style_GetSelectedColor(*this.strMyTableStyleObject)
	If *this
		Protected result.q=0
		_MyTableStyleGet(*this\obj,selectedcolor)
		ProcedureReturn result
	EndIf
EndProcedure

Procedure.q _MyTable_Style_GetSelectedForeColor(*this.strMyTableStyleObject)
	If *this
		Protected result.q=0
		_MyTableStyleGet(*this\obj,selectedforecolor)
		ProcedureReturn result
	EndIf
EndProcedure

Procedure.q _MyTable_Style_GetElementSelectedColor(*this.strMyTableStyleObject)
	If *this
		Protected result.q=0
		_MyTableStyleGet(*this\obj,elementselectedcolor)
		ProcedureReturn result
	EndIf
EndProcedure

Procedure.q _MyTable_Style_GetElementSelectedForeColor(*this.strMyTableStyleObject)
	If *this
		Protected result.q=0
		_MyTableStyleGet(*this\obj,elementselectedforecolor)
		ProcedureReturn result
	EndIf
EndProcedure

Procedure.q _MyTable_Style_GetFrontColor(*this.strMyTableStyleObject)
	If *this
		Protected result.q=0
		_MyTableStyleGet(*this\obj,frontcolor)
		ProcedureReturn result
	EndIf
EndProcedure

Procedure.q _MyTable_Style_GetBorderColor(*this.strMyTableStyleObject)
	If *this
		Protected result.q=0
		_MyTableStyleGet(*this\obj,border\bordercolor)
		ProcedureReturn result
	EndIf
EndProcedure

Procedure.q _MyTable_Style_GetSelectedBorderColor(*this.strMyTableStyleObject)
	If *this
		Protected result.q=0
		_MyTableStyleGet(*this\obj,border\selectedbordercolor)
		ProcedureReturn result
	EndIf
EndProcedure

Procedure.q _MyTable_Style_GetElementSelectedBorderColor(*this.strMyTableStyleObject)
	If *this
		Protected result.q=0
		_MyTableStyleGet(*this\obj,border\elementselectedbordercolor)
		ProcedureReturn result
	EndIf
EndProcedure

Procedure.q _MyTable_Style_GetForeColor(*this.strMyTableStyleObject)
	If *this
		Protected result.q=0
		_MyTableStyleGetRow(*this\obj,forecolor)
		ProcedureReturn result
	EndIf
EndProcedure

Procedure _MyTable_Style_GetVAlign(*this.strMyTableStyleObject)
	If *this
		Protected result.i=0
		_MyTableStyleGetRow(*this\obj,valign)
		ProcedureReturn result
	EndIf
EndProcedure

Procedure _MyTable_Style_GetHAlign(*this.strMyTableStyleObject)
	If *this
		Protected result.i=0
		_MyTableStyleGetCol(*this\obj,halign)
		ProcedureReturn result
	EndIf
EndProcedure

Procedure _MyTable_Style_SetFont(*this.strMyTableStyleObject,value.i)
	If *this
		_MyTableStyleSet(font)
	EndIf
EndProcedure

Procedure _MyTable_Style_SetBackColor(*this.strMyTableStyleObject,value.q)
	If *this
		_MyTableStyleSet(backcolor)
	EndIf
EndProcedure

Procedure _MyTable_Style_SetSelectedColor(*this.strMyTableStyleObject,value.q)
	If *this
		_MyTableStyleSet(selectedcolor)
	EndIf
EndProcedure

Procedure _MyTable_Style_SetSelectedForeColor(*this.strMyTableStyleObject,value.q)
	If *this
		_MyTableStyleSet(selectedforecolor)
	EndIf
EndProcedure

Procedure _MyTable_Style_SetElementSelectedColor(*this.strMyTableStyleObject,value.q)
	If *this
		_MyTableStyleSet(elementselectedcolor)
	EndIf
EndProcedure

Procedure _MyTable_Style_SetElementSelectedForeColor(*this.strMyTableStyleObject,value.q)
	If *this
		_MyTableStyleSet(elementselectedforecolor)
	EndIf
EndProcedure

Procedure _MyTable_Style_SetForeColor(*this.strMyTableStyleObject,value.q)
	If *this
		_MyTableStyleSet(forecolor)
	EndIf
EndProcedure

Procedure _MyTable_Style_SetBorderColor(*this.strMyTableStyleObject,value.q)
	If *this
		_MyTableStyleSet(border\bordercolor)
	EndIf
EndProcedure

Procedure _MyTable_Style_SetSelectedBorderColor(*this.strMyTableStyleObject,value.q)
	If *this
		_MyTableStyleSet(border\selectedbordercolor)
	EndIf
EndProcedure

Procedure _MyTable_Style_SetElementSelectedBorderColor(*this.strMyTableStyleObject,value.q)
	If *this
		_MyTableStyleSet(border\elementselectedbordercolor)
	EndIf
EndProcedure

Procedure _MyTable_Style_SetFrontColor(*this.strMyTableStyleObject,value.q)
	If *this
		_MyTableStyleSet(frontcolor)
	EndIf
EndProcedure

Procedure _MyTable_Style_SetVAlign(*this.strMyTableStyleObject,value.i)
	If *this
		_MyTableStyleSet(valign)
	EndIf
EndProcedure

Procedure _MyTable_Style_SetHAlign(*this.strMyTableStyleObject,value.i)
	If *this
		_MyTableStyleSet(halign)
	EndIf
EndProcedure

Procedure _MyTable_Style_Redraw(*this.strMyTableStyleObject)
	Select *this\obj\type
		Case #MYTABLE_TYPE_APPLICATION
			Protected *application.strMyTableApplication=*this\obj
			*application\dirty=#True
			_MyTable_Application_Redraw(*application)
		Case #MYTABLE_TYPE_TABLE
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
		*this\obj\style\font=0
		_MyTable_Style_Redraw(*this)
	EndIf
EndProcedure