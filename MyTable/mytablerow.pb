_MyTableMakeDraws(Row)
_SimpleSetterGetterPredraw(MyTable,Row,Tooltip,s)
_SimpleSetterGetterSubRedraw(MyTable,Row,Dirty,b)
_SimpleSetterGetterSubPredraw(MyTable,Row,Expanded,b)
_SimpleSetterGetterSubRedraw(MyTable,Row,Checked,b)
_SimpleSetterGetterSubRedraw(MyTable,Row,Disabled,b)
_SimpleSetterGetterSubPredraw(MyTable,Row,Flags,i)
_SimpleSetterGetterSubPredraw(MyTable,Row,Height,i)
_SimpleGetterPointer(MyTable,Row,Main)
_SimpleGetterPointer(MyTable,Row,Parent)
_SimpleGetter(MyTable,Row,Type,i)
_SimpleSetterGetterPredraw(MyTable,Row,Level,i)
_SimpleSetterGetterPointer(MyTable,Row,Data)




Procedure _MyTable_Row_AddRow(*this.strMyTableRow,text.s,sep.s="|",image.i=0,flags.i=0)
	If *this
		If Not *this\rows
			*this\rows=AllocateStructure(strMyTableRowList)
		EndIf
		Protected *row.strMyTableRow=AddElement(*this\rows\rows())
		_MyTableInitRow(*this\main,*this,*row,text,sep,image,flags)
		*this\main\dirty=#True
		*this\dirty=#True
		_MyTable_Table_Predraw(*this\main)
		_MyTable_Table_Redraw(*this\main)
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
			_MyTableInitRow(*this\main,*this,*row,"","",0,0)
			*this\dirty=#True
		Next
		_callcountEnde()
		*this\main\dirty=#True
		_MyTable_Table_Predraw(*this\main)
		_MyTable_Table_Redraw(*this\main)		
	EndIf
EndProcedure

Procedure _MyTable_Row_Delete(*this.strMyTableRow)
	If *this
		Protected idx=0
		Protected *table.strMyTableTable=*this\main
		ForEach *this\main\rows()
			If *this\main\rows()=*this
				DeleteElement(*this\main\rows())
			Else
				*this\main\rows()\listindex=idx
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
		_MyTable_Table_Predraw(*this\main)
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


Procedure _MyTable_Row_GetLevelPosition(*this.strMyTableRow)
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
			ForEach *this\main\rows()
				If *this\main\rows()=*this
					result=ListIndex(*this\main\rows())
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
		ForEach *this\main\expRows()
			If *this\main\expRows()=*this
				result=ListIndex(*this\main\expRows())
				Break
			EndIf
		Next
		If result=-1
			ForEach *this\main\expRowsPage()
				If *this\main\expRowsPage()=*this
					result=ListIndex(*this\main\expRowsPage())
					Break
				EndIf
			Next		
		EndIf
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
		If ListSize(*this\main\cols())>col
			ProcedureReturn _MyTableGetOrAddCell(*this,col,#False)
		EndIf
	EndIf
EndProcedure


Procedure _MyTable_Row_GetImage(*this.strMyTableRow)
	If *this
		ProcedureReturn *this\image
	EndIf
EndProcedure

Procedure _MyTable_Row_RowCount(*this.strMyTableRow)
	If *this
		If *this\rows
			ProcedureReturn ListSize(*this\rows\rows())
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Row_SetImage(*this.strMyTableRow,*value.MyImage::MyImage)
	If *this
		*this\image=*value
		*this\dirty=#True
		*this\main\dirty=#True
		_MyTable_Table_Redraw(*this\main)
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
		*this\main\selectedrows(Str(*this))=value
		*this\main\dirty=#True
		*this\dirty=#True
		_MyTable_Table_Redraw(*this\main)
	EndIf
EndProcedure

Procedure _MyTable_Row_ScrollTo(*this.strMyTableRow,setSelect.b=#False,redraw.b=#True)
	If *this		
		_MyTable_Table_Predraw(*this\main,#True)
		Protected h=0
		Protected idy=0
		Protected multiselect.b=_MyTable_IsMultiselect(*this\main)
		Protected fullrow.b=_MyTable_IsFullrowselect(*this\main)
		ForEach *this\main\expRows()			
			Protected *row.strMyTableRow=*this\main\expRows()
			If *row=*this
				If setSelect
					If fullrow
						If Not multiselect
							ClearMap(*this\main\selectedRows())															
						EndIf
						*this\main\selectedRows(Str(*row))=#True
					EndIf
				EndIf
				Break						
			EndIf
			h+*row\height
			idy+1
		Next
		If IsGadget(*this\main\vscroll)
			SetGadgetState(*this\main\vscroll,h)
		Else
			*this\main\vscroll=h
			If *this\main\vscroll>*this\main\maxvscroll
				*this\main\vscroll=*this\main\maxvscroll
			EndIf
		EndIf
		*this\main\dirty=#True
		If redraw
			_MyTable_Table_Redraw(*this\main)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Row_Autosize_CellHeight(*cell.strMyTableCell,*lastfont.MyFont::MyFont)
	Protected result.i=*cell\main\calcdefaultrowheight
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
		If Not *this\main\drawing
			If IsImage(*this\main\canvas)
				StartDrawing(ImageOutput(*this\main\canvas))
			EndIf
			If IsGadget(*this\main\canvas)
				StartDrawing(CanvasOutput(*this\main\canvas))
			EndIf
		EndIf
		Protected result.i=*this\main\calcdefaultrowheight
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
		If (result+MyTableH4)>*this\main\calcdefaultrowheight			
			result+MyTableH4
		EndIf
		If Not *this\main\drawing
			StopDrawing()
		EndIf
		*this\dirty=#True
		*this\main\dirty=#True
		*this\calcheight=result
		*this\height=DesktopUnscaledY(result)
		If *this\rows
			ForEach *this\rows\rows()
				_MyTable_Row_Autosize(*this\rows\rows())
			Next
		EndIf
		_MyTable_Table_Predraw(*this\main)
		_MyTable_Table_Redraw(*this\main)
	EndIf
	
EndProcedure