Procedure _MyTable_Col_GetType(*this.strMyTableCol)
	If *this
		ProcedureReturn *this\type
	EndIf
EndProcedure

Procedure _MyTable_Col_GetFlags(*this.strMyTableCol)
	If *this
		ProcedureReturn *this\flags
	EndIf
EndProcedure

Procedure _MyTable_Col_SetFlags(*this.strMyTableCol,value.i)
	If *this
		*this\flags=value
		*this\dirty=#True
		*this\table\dirty=#True
		_MyTable_Table_Predraw(*this\table)
		_MyTable_Table_Redraw(*this\table)
	EndIf
EndProcedure

Procedure _MyTable_Col_GetSort(*this.strMyTableCol)
	If *this
		ProcedureReturn *this\sort
	EndIf
EndProcedure

Procedure _MyTable_Col_CreateSort(*row.strMyTableRow,col.i,sort.i,numeric.b)
	Protected *cell.strMyTableCell=_MyTableGetOrAddCell(*row,col)
	*row\sorts=*cell\text
	*row\sortd=*cell\value
	If ListSize(*row\rows())>0
		ForEach *row\rows()			
			_MyTable_Col_CreateSort(*row\rows(),col,sort,numeric)			
		Next
		Select sort
			Case #MYTABLE_COL_SORT_NONE
				SortStructuredList(*row\rows(),#PB_Sort_Ascending,OffsetOf(strMyTableRow\listindex),TypeOf(strMyTableRow\listindex))
			Case #MYTABLE_COL_SORT_ASC	
				If numeric
					SortStructuredList(*row\rows(),#PB_Sort_Ascending,OffsetOf(strMyTableRow\sortd),TypeOf(strMyTableRow\sortd))
				Else
					SortStructuredList(*row\rows(),#PB_Sort_Ascending,OffsetOf(strMyTableRow\sorts),TypeOf(strMyTableRow\sorts))
				EndIf
			Case #MYTABLE_COL_SORT_DESC	
				If numeric
					SortStructuredList(*row\rows(),#PB_Sort_Descending,OffsetOf(strMyTableRow\sortd),TypeOf(strMyTableRow\sortd))
				Else
					SortStructuredList(*row\rows(),#PB_Sort_Descending,OffsetOf(strMyTableRow\sorts),TypeOf(strMyTableRow\sorts))
				EndIf
		EndSelect
	EndIf
EndProcedure

Procedure _MyTable_Col_Sort(*this.strMyTableCol,sort.i)
	If *this		
		ForEach *this\table\cols()
			*this\table\cols()\sort=#MYTABLE_COL_SORT_NONE
		Next
		*this\sort=sort
		Protected numeric.b=Bool(*this\flags & #MYTABLE_COL_FLAGS_CHECKBOXES)
		_callcountStart(sort)
		Protected *table.strMyTableTable=*this\table
		Protected *row.strMyTableRow=0
	
		ForEach *table\rows()			
			_MyTable_Col_CreateSort(*table\rows(),*this\listindex,sort,numeric)			
		Next
		Select sort
			Case #MYTABLE_COL_SORT_NONE
				SortStructuredList(*table\rows(),#PB_Sort_Ascending,OffsetOf(strMyTableRow\listindex),TypeOf(strMyTableRow\listindex))
			Case #MYTABLE_COL_SORT_ASC	
				If numeric
					SortStructuredList(*table\rows(),#PB_Sort_Ascending,OffsetOf(strMyTableRow\sortd),TypeOf(strMyTableRow\sortd))
				Else
					SortStructuredList(*table\rows(),#PB_Sort_Ascending,OffsetOf(strMyTableRow\sorts),TypeOf(strMyTableRow\sorts))
				EndIf
			Case #MYTABLE_COL_SORT_DESC	
				If numeric
					SortStructuredList(*table\rows(),#PB_Sort_Descending,OffsetOf(strMyTableRow\sortd),TypeOf(strMyTableRow\sortd))
				Else
					SortStructuredList(*table\rows(),#PB_Sort_Descending,OffsetOf(strMyTableRow\sorts),TypeOf(strMyTableRow\sorts))
				EndIf
		EndSelect
		_MyTable_Table_Predraw(*table)
		_callcountEnde(sort)
	EndIf
EndProcedure

Procedure _MyTable_Col_SetSort(*this.strMyTableCol,value.i)
	If *this
		*this\sort=value
		*this\dirty=#True
		*this\table\dirty=#True		
		_MyTable_Col_Sort(*this,value)
		_MyTable_Table_Redraw(*this\table)
	EndIf
EndProcedure

Procedure _MyTable_Col_GetWidth(*this.strMyTableCol)
	If *this
		ProcedureReturn *this\width
	EndIf
EndProcedure

Procedure _MyTable_Col_SetWidth(*this.strMyTableCol,value.i)
	If *this
		*this\width=value
		If value=#PB_Ignore
			*this\stretched=#True			
		Else
			*this\stretched=#False
			*this\calcwidth=DesktopScaledX(value)
		EndIf
		*this\dirty=#True
		*this\table\dirty=#True
		_MyTable_Table_Predraw(*this\table)
		_MyTable_Table_Redraw(*this\table)
	EndIf
EndProcedure

Procedure _MyTable_Col_GetMinWidth(*this.strMyTableCol)
	If *this
		ProcedureReturn *this\minwidth
	EndIf
EndProcedure

Procedure _MyTable_Col_SetMinWidth(*this.strMyTableCol,value.i)
	If *this
		*this\minwidth=value
		*this\calcminwidth=DesktopScaledX(value)		
		*this\dirty=#True
		*this\table\dirty=#True
		_MyTable_Table_Predraw(*this\table)
		_MyTable_Table_Redraw(*this\table)
	EndIf
EndProcedure

Procedure.s _MyTable_Col_GetText(*this.strMyTableCol)
	If *this
		ProcedureReturn *this\text
	EndIf
EndProcedure

Procedure _MyTable_Col_SetText(*this.strMyTableCol,value.s)
	If *this
		*this\text=value
		*this\dirty=#True
		*this\table\dirty=#True
		_MyTable_Table_Redraw(*this\table)
	EndIf
EndProcedure

Procedure _MyTable_Col_DeleteColRow(*row.strMyTableRow,idx)
	If ListSize(*row\cells())>idx
		SelectElement(*row\cells(),idx)
		DeleteElement(*row\cells())
	EndIf
	*row\dirty=#True
	ForEach *row\rows()
		_MyTable_Col_DeleteColRow(*row\rows(),idx)
	Next
EndProcedure

Procedure _MyTable_Col_Delete(*this.strMyTableCol)
	If *this
		Protected idx=0
		Protected *table.strMyTableTable=*this\table
		ForEach *this\table\cols()
			If *this\table\cols()=*this
				If IsImage(*this\image\sized)
					FreeImage(*this\image\sized)
				EndIf
				DeleteElement(*this\table\cols())
				ForEach *this\table\rows()
					_MyTable_Col_DeleteColRow(*this\table\rows(),idx)
				Next
			Else
				*this\table\cols()\listindex=idx
				idx+1
			EndIf
		Next		
		*table\dirty=#True
		_MyTable_Table_Predraw(*table)
		_MyTable_Table_Redraw(*table)
	EndIf
EndProcedure

Procedure _MyTable_Col_GetData(*this.strMyTableCol)
	If *this
		ProcedureReturn *this\data
	EndIf
EndProcedure

Procedure _MyTable_Col_SetData(*this.strMyTableCol,*value)
	If *this
		*this\data=*value
	EndIf
EndProcedure

Procedure _MyTable_Col_GetDirty(*this.strMyTableCol)
	If *this
		ProcedureReturn *this\dirty
	EndIf
EndProcedure

Procedure _MyTable_Col_SetDirty(*this.strMyTableCol,value.b)
	If *this
		*this\dirty=value
		*this\table\dirty=#True
		_MyTable_Table_Redraw(*this\table)
	EndIf
EndProcedure

Procedure _MyTable_Col_GetImage(*this.strMyTableCol)
	If *this
		ProcedureReturn *this\image\orig
	EndIf
EndProcedure

Procedure _MyTable_Col_SetImage(*this.strMyTableCol,value.i)
	If *this
		*this\image\orig=value
		If IsImage(*this\image\sized)
			FreeImage(*this\image\sized)
			*this\image\sized=0
		EndIf
		*this\dirty=#True
		*this\table\dirty=#True
		_MyTable_Table_Predraw(*this\table)
		_MyTable_Table_Redraw(*this\table)
	EndIf
EndProcedure

Procedure _MyTable_Col_GetStyle(*this.strMyTableCol)
	Protected *style.strMyTableStyleObject=AllocateStructure(strMyTableStyleObject)
	_MyTableInitStyleObject(*style,*this)
	ProcedureReturn *style
EndProcedure

Procedure.b _MyTable_Col_GetSelected(*this.strMyTableCol)
	If *this
		Protected result.b=#False
		result=Bool(result Or *this\table\selectedcols(Str(*this)))
		result=Bool(result Or *this\table\selectall)
		
		ProcedureReturn result
	EndIf
EndProcedure

Procedure _MyTable_Col_SetSelected(*this.strMyTableCol,value.b)
	If *this
		*this\table\selectedcols(Str(*this))=value
		*this\table\dirty=#True
		*this\dirty=#True
		_MyTable_Table_Redraw(*this\table)
	EndIf
EndProcedure