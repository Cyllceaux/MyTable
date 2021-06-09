Procedure _MyTable_Cell_GetType(*this.strMyTableCell)
	If *this
		ProcedureReturn *this\type
	EndIf
EndProcedure

Procedure _MyTable_Cell_GetParent(*this.strMyTableCell)
	If *this
		ProcedureReturn *this\parent
	EndIf
EndProcedure

Procedure _MyTable_Cell_GetRow(*this.strMyTableCell)
	If *this
		ProcedureReturn *this\row
	EndIf
EndProcedure

Procedure _MyTable_Cell_GetCol(*this.strMyTableCell)
	If *this
		ProcedureReturn *this\col
	EndIf
EndProcedure

Procedure _MyTable_Cell_GetTable(*this.strMyTableCell)
	If *this
		ProcedureReturn *this\table
	EndIf
EndProcedure

Procedure _MyTable_Cell_GetApplication(*this.strMyTableCell)
	If *this
		ProcedureReturn *this\table\application
	EndIf
EndProcedure

Procedure _MyTable_Cell_GetFlags(*this.strMyTableCell)
	If *this
		ProcedureReturn *this\flags
	EndIf
EndProcedure

Procedure _MyTable_Cell_SetFlags(*this.strMyTableCell,value.i)
	If *this
		*this\flags=value
		*this\table\dirty=#True
		*this\dirty=#True
		_MyTable_Table_Redraw(*this\table)
	EndIf
EndProcedure

Procedure.s _MyTable_Cell_GetText(*this.strMyTableCell)
	If *this
		ProcedureReturn *this\text
	EndIf
EndProcedure

Procedure _MyTable_Cell_SetText(*this.strMyTableCell,value.s)
	If *this
		*this\text=value
		*this\table\dirty=#True
		*this\dirty=#True
		_MyTable_Table_Redraw(*this\table)
	EndIf
EndProcedure

Procedure _MyTable_Cell_GetData(*this.strMyTableCell)
	If *this
		ProcedureReturn *this\data
	EndIf
EndProcedure

Procedure _MyTable_Cell_SetData(*this.strMyTableCell,*value)
	If *this
		*this\data=*value
	EndIf
EndProcedure

Procedure _MyTable_Cell_GetDirty(*this.strMyTableCell)
	If *this
		ProcedureReturn *this\dirty
	EndIf
EndProcedure

Procedure _MyTable_Cell_SetDirty(*this.strMyTableCell,value.b)
	If *this
		*this\dirty=value
		*this\table\dirty=#True
		*this\dirty=#True
		_MyTable_Table_Redraw(*this\table)
	EndIf
EndProcedure

Procedure.b _MyTable_Cell_GetChecked(*this.strMyTableCell)
	If *this
		ProcedureReturn *this\checked
	EndIf
EndProcedure

Procedure _MyTable_Cell_SetChecked(*this.strMyTableCell,value.b)
	If *this
		*this\checked=value		
		*this\value=value		
		*this\table\dirty=#True
		*this\dirty=#True
		_MyTable_Table_Redraw(*this\table)
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

Procedure.d _MyTable_Cell_GetValue(*this.strMyTableCell)
	If *this
		ProcedureReturn *this\value
	EndIf
EndProcedure

Procedure _MyTable_Cell_SetValue(*this.strMyTableCell,value.d)
	If *this
		*this\value=value
		*this\text=StrD(value)
		*this\table\dirty=#True
		*this\dirty=#True
		_MyTable_Table_Redraw(*this\table)
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

Procedure _MyTable_Cell_ScrollTo(*this.strMyTableCell,setSelect.b=#False)
	If *this			
		_MyTable_Table_Predraw(*this,#True)
		Protected h=0
		Protected w=0
		Protected idy=0
		Protected idx=0
		ForEach *this\table\expRows()			
			Protected *row.strMyTableRow=*this\table\expRows()
			If *row=*this\row
				Protected multiselect.b=Bool(*this\table\flags & #MYTABLE_TABLE_FLAGS_MULTISELECT)
				ForEach *this\table\cols()
					If *this\table\cols()=*this\col
						Break
					EndIf
					w+*this\table\cols()\width
					idx+1
				Next
				If Not multiselect
					ClearMap(*this\table\selectedCells())
				EndIf
				*this\table\selectedCells(Str(*this))=#True
				Break
			EndIf
			h+*row\height
			idy+1
		Next
		If IsGadget(*this\table\vscroll)
			SetGadgetState(*this\table\vscroll,h)
		Else
			*this\table\vscroll=h
			If *this\table\vscroll>*this\table\maxvscroll
				*this\table\vscroll=*this\table\maxvscroll
			EndIf
		EndIf
		If IsGadget(*this\table\hscroll)
			SetGadgetState(*this\table\hscroll,w)
		Else
			*this\table\hscroll=w
			If *this\table\hscroll>*this\table\maxhscroll
				*this\table\hscroll=*this\table\maxhscroll
			EndIf
		EndIf
		*this\table\dirty=#True
		_MyTable_Table_Redraw(*this\table)
	EndIf
EndProcedure