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
		result=*cell\name
	EndIf
	If Not result And *col
		result=*col\name
	EndIf
	If Not result And *row
		result=*row\name
	EndIf
	If Not result And *table
		result=*table\name
	EndIf
	If Not result And *application
		result=*application\name
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
		result=*cell\name
	EndIf
	If Not result And *col
		result=*col\name
	EndIf
	If Not result And *row
		result=*row\name
	EndIf
	If Not result And *table
		result=*table\name
	EndIf
	If Not result And *application
		result=*application\name
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
		result=*cell\name
	EndIf
	If Not result And *col
		result=*col\name
	EndIf
	If Not result And *row
		result=*row\name
	EndIf
	If Not result And *table
		result=*table\name
	EndIf
	If Not result And *application
		result=*application\name
	EndIf
EndMacro

Macro _MyTableStyleGetRowCol(root,name)
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
			*col=*cell\col
			*application=*table\application
	EndSelect
	If Not result And *cell
		result=*cell\name
	EndIf
	If Not result And *col
		result=*col\name
	EndIf
	If Not result And *row
		result=*row\name
	EndIf
	If Not result And *table
		result=*table\name
	EndIf
	If Not result And *application
		result=*application\name
	EndIf
EndMacro

Macro _MyTableStyleGetAlternative(root,name,alternative)
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
		result=*cell\name
		If Not result
			result=*cell\alternative
		EndIf
	EndIf
	If Not result And *col
		result=*col\name
		If Not result
			result=*col\alternative
		EndIf
	EndIf
	If Not result And *row
		result=*row\name
		If Not result
			result=*row\alternative
		EndIf
	EndIf
	If Not result And *table
		result=*table\name
		If Not result
			result=*table\alternative
		EndIf
	EndIf
	If Not result And *application
		result=*application\name
		If Not result
			result=*application\alternative
		EndIf
	EndIf
EndMacro

Macro _MyTableStyleGetColAlternative(root,name,alternative)
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
		result=*cell\name
		If Not result
			result=*cell\alternative
		EndIf
	EndIf
	If Not result And *col
		result=*col\name
		If Not result
			result=*col\alternative
		EndIf
	EndIf
	If Not result And *row
		result=*row\name
		If Not result
			result=*row\alternative
		EndIf
	EndIf
	If Not result And *table
		result=*table\name
		If Not result
			result=*table\alternative
		EndIf
	EndIf
	If Not result And *application
		result=*application\name
		If Not result
			result=*application\alternative
		EndIf
	EndIf
EndMacro

Macro _MyTableStyleGetRowAlternative(root,name,alternative)
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
		result=*cell\name
		If Not result
			result=*cell\alternative
		EndIf
	EndIf
	If Not result And *col
		result=*col\name
		If Not result
			result=*col\alternative
		EndIf
	EndIf
	If Not result And *row
		result=*row\name
		If Not result
			result=*row\alternative
		EndIf
	EndIf
	If Not result And *table
		result=*table\name
		If Not result
			result=*table\alternative
		EndIf
	EndIf
	If Not result And *application
		result=*application\name
		If Not result
			result=*application\alternative
		EndIf
	EndIf
EndMacro

Macro _MyTableStyleGetRowColAlternative(root,name,alternative)
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
			*col=*cell\col
			*application=*table\application
	EndSelect
	If Not result And *cell
		result=*cell\name
		If Not result
			result=*cell\alternative
		EndIf
	EndIf
	If Not result And *col
		result=*col\name
		If Not result
			result=*col\alternative
		EndIf
	EndIf
	If Not result And *row
		result=*row\name
		If Not result
			result=*row\alternative
		EndIf
	EndIf
	If Not result And *table
		result=*table\name
		If Not result
			result=*table\alternative
		EndIf
	EndIf
	If Not result And *application
		result=*application\name
		If Not result
			result=*application\alternative
		EndIf
	EndIf
EndMacro

Macro _MyTableStyleSet(name)
	
	*this\obj\dirty=#True
	Protected *col.strMyTableCol=0
	Protected *row.strMyTableRow=0
	Protected *cell.strMyTableCell=0
	Select *this\obj\type
		Case #MYTABLE_TYPE_CELL
			*cell=*this\obj
			If *cell\imageLeft\sized
				FreeImage(*cell\imageLeft\sized)
			EndIf
			*cell\imageLeft\sized=0
			If *cell\imageRight\sized
				FreeImage(*cell\imageRight\sized)
			EndIf
			*cell\imageRight\sized=0
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
					If *this\obj\name=*row\cells\cells()\name
						*row\cells\cells()\name=value
						*row\cells\cells()\dirty=#True
					EndIf
				Next
			EndIf
	EndSelect
	*this\obj\name=value
	_MyTable_Style_Redraw(*this)
EndMacro

Macro _MyTable_SetterGetter(state,name,typ)
	Procedure.typ _MyTable_Style_Get#state#name(*this.strMyTableStyleObject)
		If *this
			Protected result.typ=0		
			_MyTableStyleGet(*this\obj,state#Style\name)
			ProcedureReturn result
		EndIf
	EndProcedure
	
	Procedure _MyTable_Style_Set#state#name(*this.strMyTableStyleObject,value.typ)
		If *this
			_MyTableStyleSet(state#Style\name)
		EndIf
	EndProcedure
EndMacro

Macro _MyTable_SetterGetterCol(state,name,typ)
	Procedure.typ _MyTable_Style_Get#state#name(*this.strMyTableStyleObject)
		If *this
			Protected result.typ=0		
			_MyTableStyleGetCol(*this\obj,state#Style\name)
			ProcedureReturn result
		EndIf
	EndProcedure
	
	Procedure _MyTable_Style_Set#state#name(*this.strMyTableStyleObject,value.typ)
		If *this
			_MyTableStyleSet(state#Style\name)
		EndIf
	EndProcedure
EndMacro

Macro _MyTable_SetterGetterRow(state,name,typ)
	Procedure.typ _MyTable_Style_Get#state#name(*this.strMyTableStyleObject)
		If *this
			Protected result.typ=0		
			_MyTableStyleGetRow(*this\obj,state#Style\name)
			ProcedureReturn result
		EndIf
	EndProcedure
	
	Procedure _MyTable_Style_Set#state#name(*this.strMyTableStyleObject,value.typ)
		If *this
			_MyTableStyleSet(state#Style\name)
		EndIf
	EndProcedure
EndMacro

Macro _MyTable_SetterGetterRowCol(state,name,typ)
	Procedure.typ _MyTable_Style_Get#state#name(*this.strMyTableStyleObject)
		If *this
			Protected result.typ=0		
			_MyTableStyleGetRowCol(*this\obj,state#Style\name)
			ProcedureReturn result
		EndIf
	EndProcedure
	
	Procedure _MyTable_Style_Set#state#name(*this.strMyTableStyleObject,value.typ)
		If *this
			_MyTableStyleSet(state#Style\name)
		EndIf
	EndProcedure
EndMacro

Macro _MyTable_SetterGetterBorder(state,tname,name,typ)
	
	Procedure _MyTable_Style_Set#state#Border#name#tname(*this.strMyTableStyleObject,value.typ)
		If *this
			_MyTableStyleSet(state#Style\border\border#tname\name)
		EndIf
	EndProcedure
	
	Procedure.typ _MyTable_Style_Get#state#Border#name#tname(*this.strMyTableStyleObject,value.typ)
		If *this
			Protected result.typ
			_MyTableStyleGetAlternative(*this\obj,state#Style\border\border#tname\name,defaultStyle\border\border#tname\name)
			ProcedureReturn result
		EndIf
	EndProcedure
	
EndMacro

Macro _MyTableStyleBorder(state,name)
	_MyTable_SetterGetterBorder(state,name,Color,q)
	_MyTable_SetterGetterBorder(state,name,Width,q)
	
EndMacro

Macro _MyTable_SetterGetter_default(state)
	_MyTable_SetterGetterRow(state,Font,i)
	_MyTable_SetterGetterRow(state,ForeColor,q)
	_MyTable_SetterGetterRow(state,BackColor,q)
	_MyTable_SetterGetterRow(state,FrontColor,q)
	_MyTable_SetterGetterCol(state,HAlign,i)
	_MyTable_SetterGetter(state,VAlign,i)
	
	
	_MyTableStyleBorder(state,Default);}
	_MyTableStyleBorder(state,Top)
	_MyTableStyleBorder(state,Left)
	_MyTableStyleBorder(state,Bottom)
	_MyTableStyleBorder(state,Right)
	
	Procedure _MyTable_Style_Get#state#Border(*this.strMyTableStyleObject)
		If *this
			Protected result.i=0
			_MyTableStyleGetRowCol(*this\obj,state#Style\border\border)
			ProcedureReturn result
		EndIf
	EndProcedure
	
	Procedure _MyTable_Style_Set#state#Border(*this.strMyTableStyleObject,value.i)
		If *this
			_MyTableStyleSet(state#Style\border\border)
		EndIf
	EndProcedure
	
	
EndMacro




_MyTable_SetterGetter_default(Default);}
_MyTable_SetterGetter_default(Zebra)	
_MyTable_SetterGetter_default(Selected)
_MyTable_SetterGetter_default(ElementSelected)
_MyTable_SetterGetter_default(Fixed)					
_MyTable_SetterGetter_default(Title)					




Procedure _MyTable_Style_GetObject(*this.strMyTableStyleObject)
	If *this
		ProcedureReturn *this\obj
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
		;TODO Delete Style
		_MyTable_Style_Redraw(*this)
	EndIf
EndProcedure