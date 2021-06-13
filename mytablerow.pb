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

Procedure _MyTable_Row_GetLevel(*this.strMyTableRow)
	If *this
		ProcedureReturn *this\level
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
		If Not *this\rows
			*this\rows=AllocateStructure(strMyTableRowList)
		EndIf
		Protected *row.strMyTableRow=AddElement(*this\rows\rows())
		_MyTableInitRow(*this\table\application,*this\table,*this,*row,text,sep,image,flags)
		*this\table\dirty=#True
		*this\dirty=#True
		_MyTable_Table_Redraw(*this\table)
		ProcedureReturn *row
	EndIf
EndProcedure

Procedure _MyTable_Row_AddDirtyRows(*this.strMyTableRow,text.s,rows.i)
	If *this
		Protected idx
		_callcountStart(row_adddirtyrows)
		If Not *this\rows
			*this\rows=AllocateStructure(strMyTableRowList)
		EndIf
		LastElement(*this\rows\rows())
		For idx=1 To rows
			Protected *row.strMyTableRow=AddElement(*this\rows\rows())
			_MyTableInitRow(*this\table\application,*this\table,*this,*row,"","",0,0)
			*this\dirty=#True
		Next
		_callcountEnde(row_adddirtyrows)
		*this\table\dirty=#True
		_MyTable_Table_Redraw(*this\table)		
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
		If *this\rows
			If ListSize(*this\rows\rows())>idx
				*this\dirty=#True
				_MyTable_Row_Delete(SelectElement(*this\rows\rows(),idx))
			EndIf
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Row_GetData(*this.strMyTableRow)
	If *this
		ProcedureReturn *this\data
	EndIf
EndProcedure

Procedure.s _MyTable_Row_GetTooltip(*this.strMyTableRow)
	If *this
		ProcedureReturn *this\tooltip
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
		If *this\rows
			If ListSize(*this\rows\rows())>row
				ProcedureReturn SelectElement(*this\rows\rows(),row)
			EndIf
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
		If *this\rows
			ProcedureReturn ListSize(*this\rows\rows())
		EndIf
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

Procedure _MyTable_Row_SetTooltip(*this.strMyTableRow,value.s)
	If *this
		*this\tooltip=value
	EndIf
EndProcedure

Procedure _MyTable_Row_ScrollTo(*this.strMyTableRow,setSelect.b=#False,redraw.b=#True)
	If *this		
		_MyTable_Table_Predraw(*this\table,#True)
		Protected h=0
		Protected idy=0
		ForEach *this\table\expRows()			
			Protected *row.strMyTableRow=*this\table\expRows()
			If *row=*this
				If setSelect
					Protected multiselect.b=Bool(*this\table\flags & #MYTABLE_TABLE_FLAGS_MULTISELECT)
					Protected fullrow.b=Bool(*this\table\flags & #MYTABLE_TABLE_FLAGS_FULLROWSELECT)
					If fullrow
						If Not multiselect
							ClearMap(*this\table\selectedRows())															
						EndIf
						*this\table\selectedRows(Str(*row))=#True
					EndIf
				EndIf
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
		*this\table\dirty=#True
		If redraw
			_MyTable_Table_Redraw(*this\table)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Row_Autosize(*this.strMyTableRow)
	If *this
		If Not *this\table\drawing
			If IsImage(*this\table\canvas)
				StartDrawing(ImageOutput(*this\table\canvas))
			EndIf
			If IsGadget(*this\table\canvas)
				StartDrawing(CanvasOutput(*this\table\canvas))
			EndIf
		EndIf
		Protected result.i=*this\table\calcdefaultrowheight
		Protected lastfont.i=0
		If*this\cells
			ForEach *this\cells\cells()
				If (*this\cells\cells()\textheight=0 And *this\cells\cells()\text<>"") Or *this\cells\cells()\dirty
					Protected nfont=_MyTable_GetFont(*this\table\rows()\cells\cells())
					If nfont<>lastfont
						If IsFont(nfont)
							nfont=FontID(nfont)
						EndIf
						DrawingFont(nfont)
						lastfont=nfont
					EndIf
					*this\cells\cells()\textheight=_MyTableTextHeight(*this\cells\cells()\text)
					*this\cells\cells()\textwidth=_MyTableTextWidth(*this\cells\cells()\text)
				EndIf
				If (*this\cells\cells()\textheight+MyTableH4)>result
					result=*this\cells\cells()\textheight
				EndIf
			Next
		EndIf
		If (result+MyTableH4)>*this\table\calcdefaultrowheight			
			result+MyTableH4
		EndIf
		If Not *this\table\drawing
			StopDrawing()
		EndIf
		*this\dirty=#True
		*this\table\dirty=#True
		*this\calcheight=result
		*this\height=DesktopUnscaledY(result)
		If *this\rows
			ForEach *this\rows\rows()
				_MyTable_Row_Autosize(*this\rows\rows())
			Next
		EndIf
		_MyTable_Table_Predraw(*this\table)
		_MyTable_Table_Redraw(*this\table)
	EndIf
	
EndProcedure