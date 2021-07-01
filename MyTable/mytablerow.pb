_SimpleSetterGetterPredraw(MyTable,Row,Tooltip,s)
_SimpleSetterGetterSubRedraw(MyTable,Row,Dirty,b)
_SimpleSetterGetterSubPredraw(MyTable,Row,Expanded,b)
_SimpleSetterGetterSubRedraw(MyTable,Row,Checked,b)
_SimpleSetterGetterSubRedraw(MyTable,Row,Disabled,b)
_SimpleSetterGetterSubPredraw(MyTable,Row,Flags,i)
_SimpleSetterGetterSubPredraw(MyTable,Row,Height,i)
_SimpleGetterPointer(MyTable,Row,Table)
_SimpleGetterPointer(MyTable,Row,Parent)
_SimpleGetter(MyTable,Row,Type,i)
_SimpleSetterGetterPredraw(MyTable,Row,Level,i)
_SimpleSetterGetterPointer(MyTable,Row,Data)


Procedure _MyTable_Row_GetApplication(*this.strMyTableRow)
	If *this
		ProcedureReturn *this\table\application
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
		_callcountStart()
		If Not *this\rows
			*this\rows=AllocateStructure(strMyTableRowList)
		EndIf
		LastElement(*this\rows\rows())
		For idx=1 To rows
			Protected *row.strMyTableRow=AddElement(*this\rows\rows())
			_MyTableInitRow(*this\table\application,*this\table,*this,*row,"","",0,0)
			*this\dirty=#True
		Next
		_callcountEnde()
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
		idx=0
		If *this\parent
			ForEach *this\parent\rows\rows()
				If *this\parent\rows\rows()=*this
					DeleteElement(*this\parent\rows\rows())
				Else
					*this\parent\rows\rows()\listindex=idx
					idx+1
				EndIf
			Next
		EndIf
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


Procedure _MyTable_Row_GetPosition(*this.strMyTableRow)
	If *this
		Protected result.i=-1
		If *this\parent
			If *this\parent\rows
				ForEach *this\parent\rows\rows()
					If *this\parent\rows\rows()=*this
						result=ListIndex(*this\parent\rows\rows())
						Break
					EndIf
				Next
			EndIf
		Else
			ForEach *this\table\rows()
				If *this\table\rows()=*this
					result=ListIndex(*this\table\rows())
					Break
				EndIf
			Next
		EndIf
		ProcedureReturn result
	EndIf
EndProcedure

Procedure _MyTable_Row_GetVisiblePosition(*this.strMyTableRow)
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
			ProcedureReturn _MyTableGetOrAddCell(*this,col,#False)
		EndIf
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

_MyTable_GetStylesRow()


Procedure.b _MyTable_Row_GetSelected(*this.strMyTableRow)
	If *this
		
		ProcedureReturn _MyTable_IsSelected(*this)
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

Procedure _MyTable_Row_ScrollTo(*this.strMyTableRow,setSelect.b=#False,redraw.b=#True)
	If *this		
		_MyTable_Table_Predraw(*this\table,#True)
		Protected h=0
		Protected idy=0
		Protected multiselect.b=_MyTable_IsMultiselect(*this\table)
		Protected fullrow.b=_MyTable_IsFullrowselect(*this\table)
		ForEach *this\table\expRows()			
			Protected *row.strMyTableRow=*this\table\expRows()
			If *row=*this
				If setSelect
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

Procedure _MyTable_Row_Autosize_CellHeight(*cell.strMyTableCell,*lastfont.MyFont::MyFont)
	Protected result.i=*cell\table\calcdefaultrowheight
	If (*cell\textheight=0 And *cell\text<>"") Or *cell\dirty
		Protected *nfont.MyFont::MyFont=_MyTable_GetDefaultFont(*cell)
		If *nfont<>*lastfont
			DrawingFont(*nfont\GetFontID())
			*lastfont=*nfont
		EndIf
		*cell\textheight=_MyTableTextHeight(*cell\text)
		*cell\textwidth=_MyTableTextWidth(*cell\text)
	EndIf				
	If *cell\textheight>0
		result=*cell\textheight
	EndIf
	If *cell\cells
		ForEach *cell\cells\cells()
			result+_MyTable_Row_Autosize_CellHeight(*cell\cells\cells(),*lastfont)
		Next
	EndIf
	ProcedureReturn result
EndProcedure

Procedure _MyTable_Row_Expand(*this.strMyTableRow,value.b)
	If *this
		*this\expanded=value
		*this\dirty=#True
		If *this\rows
			ForEach *this\rows\rows()
				_MyTable_Row_Expand(*this\rows\rows(),value)
			Next
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
		Protected *lastfont.MyFont::MyFont=0
		If *this\cells
			ForEach *this\cells\cells()
				Protected *cell.strMyTableCell=*this\cells\cells()
				Protected t=_MyTable_Row_Autosize_CellHeight(*cell,*lastfont)
				If (t+MyTableH4)>result
					result=t
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