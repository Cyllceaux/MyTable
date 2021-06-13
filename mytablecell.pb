_MyTableSimpleSetterGetter(Cell,Tooltip,s)
_MyTableSimpleSetterGetterSubRedraw(Cell,Dirty,b)
_MyTableSimpleSetterGetterSubRedraw(Cell,Flags,i)
_MyTableSimpleSetterGetterSubRedraw(Cell,Text,s)
_MyTableSimpleSetterGetterSubRedraw(Cell,Value,d)
_MyTableSimpleSetterGetterSubRedraw(Cell,Checked,b)
_MyTableSimpleSetterGetterPointer(Cell,Data)
_MyTableSimpleGetter(Cell,Type,i)
_MyTableSimpleGetterPointer(Cell,Parent)
_MyTableSimpleGetterPointer(Cell,Row)
_MyTableSimpleGetterPointer(Cell,Col)
_MyTableSimpleGetterPointer(Cell,Table)


Procedure _MyTable_Cell_GetApplication(*this.strMyTableCell)
	If *this
		ProcedureReturn *this\table\application
	EndIf
EndProcedure


Procedure _MyTable_Cell_SetSelected(*this.strMyTableCell,value.b)
	If *this
		*this\table\selectedcells(Str(*this))=value
		*this\table\dirty=#True
		*this\dirty=#True
		_MyTable_Table_Redraw(*this\table)
	EndIf
EndProcedure

Procedure.b _MyTable_Cell_GetSelected(*this.strMyTableCell)
	If *this
		Protected result.b=#False
		result=Bool(result Or *this\table\selectedcells(Str(*this)))
		result=Bool(result Or *this\table\selectedrows(Str(*this\row)))
		result=Bool(result Or *this\table\selectedcols(Str(*this\col)))
		result=Bool(result Or *this\table\selectall)
		
		ProcedureReturn result
	EndIf
EndProcedure


Procedure _MyTable_Cell_GetImage(*this.strMyTableCell)
	If *this
		ProcedureReturn *this\image\orig
	EndIf
EndProcedure

Procedure _MyTable_Cell_SetImage(*this.strMyTableCell,value.i)
	If *this
		*this\image\orig=value
		If IsImage(*this\image\sized)
			FreeImage(*this\image\sized)
			*this\image\sized=0
		EndIf
		*this\dirty=#True
		*this\table\dirty=#True
		_MyTable_Table_Redraw(*this\table)
	EndIf
EndProcedure

Procedure _MyTable_Cell_GetStyle(*this.strMyTableCell)
	Protected *style.strMyTableStyleObject=AllocateStructure(strMyTableStyleObject)
	_MyTableInitStyleObject(*style,*this)
	ProcedureReturn *style
EndProcedure

Procedure _MyTable_Cell_ScrollTo(*this.strMyTableCell,setSelect.b=#False,redraw.b=#True)
	If *this			
		_MyTable_Row_ScrollTo(*this\row,#False,#False)
		_MyTable_Col_ScrollTo(*this\col,#False,#False)
		Protected multiselect.b=Bool(*this\table\flags & #MYTABLE_TABLE_FLAGS_MULTISELECT)
		If Not multiselect
			ClearMap(*this\table\selectedCells())
		EndIf
		*this\table\selectedCells(Str(*this))=#True
		*this\table\dirty=#True		
		If redraw
			_MyTable_Table_Redraw(*this\table)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Cell_Autosize(*this.strMyTableCell)
	If *this
		_MyTable_Col_Autosize(*this\col)
		_MyTable_Row_Autosize(*this\row)
	EndIf
EndProcedure