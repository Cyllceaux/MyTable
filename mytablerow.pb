Procedure _MyTable_Row_GetType(*this.strMyTableRow)
	If *this
		ProcedureReturn *this\type
	EndIf
EndProcedure

Procedure _MyTable_Row_GetParent(*this.strMyTableRow)
	If *this
		ProcedureReturn *this\parent
	EndIf
EndProcedure

Procedure _MyTable_Row_GetTable(*this.strMyTableRow)
	If *this
		ProcedureReturn *this\table
	EndIf
EndProcedure

Procedure _MyTable_Row_GetApplication(*this.strMyTableRow)
	If *this
		ProcedureReturn *this\table\application
	EndIf
EndProcedure

Procedure _MyTable_Row_GetFlags(*this.strMyTableRow)
	If *this
		ProcedureReturn *this\flags
	EndIf
EndProcedure

Procedure _MyTable_Row_SetFlags(*this.strMyTableRow,value.i)
	If *this
		*this\flags=value
		*this\table\dirty=#True
		*this\dirty=#True
		_MyTable_Table_Redraw(*this\table)
	EndIf
EndProcedure

Procedure _MyTable_Row_AddRow(*this.strMyTableRow,text.s,sep.s="|",image.i=0,flags.i=0)
	If *this
		Protected *row.strMyTableRow=AddElement(*this\rows())
		_MyTableInitRow(*this\table\application,*this\table,*this,*row,text,sep,image,flags)
		*this\table\dirty=#True
		*this\dirty=#True
		_MyTable_Table_Redraw(*this\table)
		ProcedureReturn *row
	EndIf
EndProcedure

Procedure _MyTable_Row_Delete(*this.strMyTableRow)
	If *this
		Protected idx=0
		Protected *table.strMyTableTable=*this\table
		ForEach *this\table\rows()
			If *this\table\rows()=*this
				DeleteElement(*this\table\rows())
			Else
				*this\table\rows()\listindex=idx
				idx+1
			EndIf
		Next
		*table\dirty=#True
		_MyTable_Table_Redraw(*table)
	EndIf
EndProcedure

Procedure _MyTable_Row_DeleteRow(*this.strMyTableRow,idx.i)
	If *this
		If ListSize(*this\rows())>idx
			*this\dirty=#True
			_MyTable_Row_Delete(SelectElement(*this\rows(),idx))
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Row_GetData(*this.strMyTableRow)
	If *this
		ProcedureReturn *this\data
	EndIf
EndProcedure

Procedure _MyTable_Row_GetPosition(*this.strMyTableRow)
	If *this
		Protected result.i=-1
		ForEach *this\table\expRows()
			If *this\table\expRows()=*this
				result=ListIndex(*this\table\expRows())
				Break
			EndIf
		Next
		ProcedureReturn result
	EndIf
EndProcedure

Procedure _MyTable_Row_SetData(*this.strMyTableRow,*value)
	If *this
		*this\data=*value
	EndIf
EndProcedure

Procedure _MyTable_Row_GetDirty(*this.strMyTableRow)
	If *this
		ProcedureReturn *this\dirty
	EndIf
EndProcedure

Procedure _MyTable_Row_SetDirty(*this.strMyTableRow,value.b)
	If *this
		*this\dirty=value
		*this\table\dirty=#True
		_MyTable_Table_Redraw(*this\table)
	EndIf
EndProcedure

Procedure _MyTable_Row_GetRow(*this.strMyTableRow,row.i)
	If *this
		If ListSize(*this\rows())>row
			ProcedureReturn SelectElement(*this\rows(),row)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Row_GetCell(*this.strMyTableRow,col.i)
	If *this
		If ListSize(*this\table\cols())>col
			ProcedureReturn _MyTableGetOrAddCell(*this,col)
		EndIf
	EndIf
EndProcedure

Procedure.b _MyTable_Row_GetExpanded(*this.strMyTableRow)
	If *this
		ProcedureReturn *this\expanded
	EndIf
EndProcedure

Procedure _MyTable_Row_SetExpanded(*this.strMyTableRow,value.b)
	If *this
		*this\expanded=value
		*this\dirty=#True
		*this\table\dirty=#True
		_MyTable_Table_Redraw(*this\table)
	EndIf
EndProcedure

Procedure _MyTable_Row_GetImage(*this.strMyTableRow)
	If *this
		ProcedureReturn *this\image\orig
	EndIf
EndProcedure

Procedure _MyTable_Row_RowCount(*this.strMyTableRow)
	If *this
		ProcedureReturn ListSize(*this\rows())
	EndIf
EndProcedure

Procedure _MyTable_Row_SetImage(*this.strMyTableRow,value.i)
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

Procedure _MyTable_Row_GetStyle(*this.strMyTableRow)
	Protected *style.strMyTableStyleObject=AllocateStructure(strMyTableStyleObject)
	_MyTableInitStyleObject(*style,*this)
	ProcedureReturn *style
EndProcedure

Procedure.b _MyTable_Row_GetChecked(*this.strMyTableRow)
	If *this
		ProcedureReturn *this\checked
	EndIf
EndProcedure

Procedure _MyTable_Row_SetChecked(*this.strMyTableRow,value.b)
	If *this
		*this\checked=value
		*this\table\dirty=#True
		*this\dirty=#True
		_MyTable_Table_Redraw(*this\table)
	EndIf
EndProcedure

Procedure.b _MyTable_Row_GetSelected(*this.strMyTableRow)
	If *this
		Protected result.b=#False
		result=Bool(result Or *this\table\selectedrows(Str(*this)))
		result=Bool(result Or *this\table\selectall)
		
		ProcedureReturn result
	EndIf
EndProcedure

Procedure _MyTable_Row_SetSelected(*this.strMyTableRow,value.b)
	If *this
		*this\table\selectedrows(Str(*this))=value
		*this\table\dirty=#True
		*this\dirty=#True
		_MyTable_Table_Redraw(*this\table)
	EndIf
EndProcedure