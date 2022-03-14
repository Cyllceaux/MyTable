﻿_MyTableMakeDraws(Col)
_SimpleSetterGetter(MyTable,Col,Tooltip,s)
_SimpleSetterGetterSubRedraw(MyTable,Col,Dirty,b)
_SimpleSetterGetterSubPredraw(MyTable,Col,Flags,i)
_SimpleSetterGetterSubPredraw(MyTable,Col,Disabled,b)
_SimpleGetterPointer(MyTable,Col,Main)
_SimpleGetter(MyTable,Col,Type,i)
_SimpleSetterGetterPointer(MyTable,Col,Data)
_SimpleSetterGetterSubRedraw(MyTable,Col,Text,s)
_SimpleGetter(MyTable,Col,Mask,s)
_SimpleSetterGetterSubPredraw(MyTable,Col,Colspan,i)
_SimpleGetter(MyTable,Col,Datatype,i)


Procedure _MyTable_Col_SetMask(*this.strMyTableCol,value.s)
	If *this
		ForEach *this\main\rows()
			If *this\main\rows()\cells And ListSize(*this\main\rows()\cells\cells())>*this\listindex
				Protected *cell.strMyTableCell=_MyTableGetOrAddCell(*this\main\rows(),*this\listindex,#True)
				If *cell\mask=*this\mask
					*cell\mask=value
					*cell\dirty=#True
				EndIf
			EndIf
		Next
		*this\mask=value
		*this\dirty=#True
		*this\main\dirty=#True		
		_MyTable_Table_Redraw(*this\main)
	EndIf
EndProcedure

Procedure _MyTable_Col_SetDatatype(*this.strMyTableCol,value.i)
	If *this
		If value=#MYTABLE_DATATYPE_NUMBER
			*this\defaultStyle\halign=#MYTABLE_STYLE_HALIGN_RIGHT
		ElseIf value=#MYTABLE_DATATYPE_DATE
			*this\defaultStyle\halign=#MYTABLE_STYLE_HALIGN_CENTER
		Else
			*this\defaultStyle\halign=#MYTABLE_STYLE_HALIGN_LEFT
		EndIf
		ForEach *this\main\rows()
			If *this\main\rows()\cells And ListSize(*this\main\rows()\cells\cells())>*this\listindex
				Protected *cell.strMyTableCell=_MyTableGetOrAddCell(*this\main\rows(),*this\listindex,#True)
				If *cell\datatype=*this\datatype
					*cell\datatype=value
					*cell\defaultStyle\halign=*this\defaultStyle\halign
					*cell\dirty=#True
				EndIf
			EndIf
		Next
		*this\datatype=value
		*this\dirty=#True
		*this\main\dirty=#True		
		_MyTable_Table_Redraw(*this\main)
	EndIf
EndProcedure


Procedure _MyTable_Col_GetPosition(*this.strMyTableCol)
	If *this
		ProcedureReturn *this\listindex
	EndIf
EndProcedure


Procedure _MyTable_Col_GetSort(*this.strMyTableCol)
	If *this
		ProcedureReturn *this\sort
	EndIf
EndProcedure

Procedure _MyTable_Col_CreateSort(*row.strMyTableRow,col.i,sort.i,numeric.b)
	Protected *cell.strMyTableCell=_MyTableGetOrAddCell(*row,col,#True)
	*row\sorts=*cell\text
	*row\sortd=*cell\value
	
	If *row\rows And ListSize(*row\rows\rows())>0
		ForEach *row\rows\rows()			
			_MyTable_Col_CreateSort(*row\rows\rows(),col,sort,numeric)			
		Next
		Select sort
			Case #MYTABLE_COL_SORT_NONE
				SortStructuredList(*row\rows\rows(),#PB_Sort_Ascending,OffsetOf(strMyTableRow\listindex),TypeOf(strMyTableRow\listindex))
			Case #MYTABLE_COL_SORT_ASC	
				If numeric
					SortStructuredList(*row\rows\rows(),#PB_Sort_Ascending,OffsetOf(strMyTableRow\sortd),TypeOf(strMyTableRow\sortd))
				Else
					SortStructuredList(*row\rows\rows(),#PB_Sort_Ascending,OffsetOf(strMyTableRow\sorts),TypeOf(strMyTableRow\sorts))
				EndIf
			Case #MYTABLE_COL_SORT_DESC	
				If numeric
					SortStructuredList(*row\rows\rows(),#PB_Sort_Descending,OffsetOf(strMyTableRow\sortd),TypeOf(strMyTableRow\sortd))
				Else
					SortStructuredList(*row\rows\rows(),#PB_Sort_Descending,OffsetOf(strMyTableRow\sorts),TypeOf(strMyTableRow\sorts))
				EndIf
		EndSelect
	EndIf
EndProcedure

Procedure _MyTable_Col_Sort(*this.strMyTableCol,sort.i)
	If *this				
		ForEach *this\main\cols()
			*this\main\cols()\sort=#MYTABLE_COL_SORT_NONE
		Next
		*this\sort=sort
		Protected numeric.b=Bool(_MyTable_IsCheckboxes(*this) Or 
		                         *this\datatype & #MYTABLE_DATATYPE_NUMBER Or 
		                         *this\datatype & #MYTABLE_DATATYPE_DATE)
		
		_callcountStart()
		Protected *table.strMyTableTable=*this\main
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
		_callcountEnde()
	EndIf
EndProcedure

Procedure _MyTable_Col_SetSort(*this.strMyTableCol,value.i)
	If *this
		*this\sort=value
		*this\dirty=#True
		*this\main\dirty=#True		
		If *this\parent
			_MyTable_Col_Sort(*this\parent,value)
		Else
			_MyTable_Col_Sort(*this,value)
		EndIf
		_MyTable_Table_Redraw(*this\main)
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
		*this\main\dirty=#True
		_MyTable_Table_Predraw(*this\main)
		_MyTable_Table_Redraw(*this\main)
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
		*this\main\dirty=#True
		_MyTable_Table_Predraw(*this\main)
		_MyTable_Table_Redraw(*this\main)
	EndIf
EndProcedure


Procedure _MyTable_Col_DeleteColRow(*row.strMyTableRow,idx)
	If *row\cells
		If ListSize(*row\cells\cells())>idx
			SelectElement(*row\cells\cells(),idx)
			DeleteElement(*row\cells\cells())
		EndIf
	EndIf
	*row\dirty=#True
	If *row\rows
		ForEach *row\rows\rows()
			_MyTable_Col_DeleteColRow(*row\rows\rows(),idx)
		Next
	EndIf
EndProcedure

Procedure _MyTable_Col_Delete(*this.strMyTableCol)
	If *this
		Protected idx=0
		Protected *table.strMyTableTable=*this\main
		ForEach *this\main\cols()
			If *this\main\cols()=*this
				DeleteElement(*this\main\cols())
				ForEach *this\main\rows()
					_MyTable_Col_DeleteColRow(*this\main\rows(),idx)
				Next
			Else
				*this\main\cols()\listindex=idx
				idx+1
				If *this\main\datagrid
					*this\main\cols()\text=_MyTableGridColumnName(idx)
					*this\main\cols()\dirty=#True
					*this\main\cols()\textheight=0
					*this\main\cols()\textwidth=0
				EndIf
			EndIf
		Next		
		*table\dirty=#True
		_MyTable_Table_Predraw(*table)
		_MyTable_Table_Redraw(*table)
	EndIf
EndProcedure


Procedure _MyTable_Col_GetImage(*this.strMyTableCol)
	If *this
		ProcedureReturn *this\image
	EndIf
EndProcedure

Procedure _MyTable_Col_SetImage(*this.strMyTableCol,*value.MyImage::MyImage)
	If *this
		*this\image=*value
		*this\dirty=#True
		*this\main\dirty=#True
		_MyTable_Table_Predraw(*this\main)
		_MyTable_Table_Redraw(*this\main)
	EndIf
EndProcedure

_MyTable_GetStylesCol()

Procedure.b _MyTable_Col_GetSelected(*this.strMyTableCol)
	If *this
		ProcedureReturn _MyTable_IsSelected(*this)
	EndIf
EndProcedure

Procedure _MyTable_Col_SetSelected(*this.strMyTableCol,value.b)
	If *this
		*this\main\selectedcols(Str(*this))=value
		*this\main\dirty=#True
		*this\dirty=#True
		_MyTable_Table_Redraw(*this\main)
	EndIf
EndProcedure


Procedure _MyTable_Col_ScrollTo(*this.strMyTableCol,setSelect.b=#False,redraw.b=#True)
	If *this		
		_MyTable_Table_Predraw(*this\main,#True)
		Protected w=0
		Protected idw=0
		ForEach *this\main\cols()			
			Protected *col.strMyTableCol=*this\main\cols()			
			If *col=*this
				If setSelect
					Protected multiselect.b=_MyTable_IsMultiselect(*this)
					Protected fullrow.b=_MyTable_IsFullrowselect(*this)
					If fullrow
						If Not multiselect
							ClearMap(*this\main\selectedCols())															
						EndIf
						*this\main\selectedCols(Str(*col))=#True
					EndIf
				EndIf
				Break						
			EndIf
			w+*col\width
			idw+1
		Next
		If IsGadget(*this\main\hscroll)
			SetGadgetState(*this\main\hscroll,w)
		Else
			*this\main\hscroll=w
			If *this\main\hscroll>*this\main\maxhscroll
				*this\main\hscroll=*this\main\maxhscroll
			EndIf
		EndIf
		*this\main\dirty=#True
		If redraw
			_MyTable_Table_Redraw(*this\main)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Col_AutosizeSubRow(*this.strMyTableCol,*row.strMyTableRow)
	Protected hierarchical.b=_MyTable_IsHierarchical(*this\main)
	Protected hierarchicalAlwaysExpanded.b=_MyTable_IsHierarchical_Always_Expanded(*this\main)
	Protected checkboxes.b=_MyTable_IsCheckboxes(*this\main)
	Protected *lastfont.MyFont::MyFont=0
	Protected tresult.i=0
	If *this\listindex=0
		If hierarchical And *this\listindex=0
			tresult+(MyTableW20 * (*row\level + 1))
		EndIf
		If hierarchicalAlwaysExpanded
			tresult-MyTableW20
		EndIf
		If checkboxes And *this\listindex=0
			tresult+MyTableW20
		EndIf
		If *row\image
			If *this\listindex=0
				tresult+*row\main\defaultrowheight+MyTableW8
			EndIf
		EndIf
	EndIf
	If *row\cells And ListSize(*row\cells\cells())>*this\listindex	
		Protected *cell.strMyTableCell=_MyTableGetOrAddCell(*row,*this\listindex,#True)
		If (*cell\textwidth=0 And *cell\text<>"") Or *cell\dirty
			Protected *nfont.MyFont::MyFont=_MyTable_GetDefaultFont(*cell)
			If *nfont<>*lastfont
				DrawingFont(*nfont\GetFontID())
				*lastfont=*nfont
			EndIf
			*cell\textwidth=_MyTableTextWidth(*cell\text)
			*cell\textheight=_MyTableTextHeight(*cell\text)
		EndIf
		tresult+*cell\textwidth+MyTableW8
		If *cell\imageLeft
			tresult+*cell\main\defaultrowheight+MyTableW8
		EndIf
		If *cell\imageRight	
			tresult+*cell\main\defaultrowheight+MyTableW8
		EndIf
	EndIf
	If *row\rows
		ForEach *row\rows\rows()
			Protected sresult=_MyTable_Col_AutosizeSubRow(*this,*row\rows\rows())	
			If sresult>tresult
				tresult=sresult
			EndIf
		Next
	EndIf
	ProcedureReturn tresult
EndProcedure

Procedure _MyTable_Col_Autosize(*this.strMyTableCol)
	If *this And Not *this\stretched
		
		If Not *this\main\drawing
			If IsImage(*this\main\canvas)
				StartDrawing(ImageOutput(*this\main\canvas))
			EndIf
			If IsGadget(*this\main\canvas)
				StartDrawing(CanvasOutput(*this\main\canvas))
			EndIf
		EndIf
		_callcountStart()
		
		If (*this\textheight=0 And *this\text<>"") Or *this\dirty
			Protected *nfont.MyFont::MyFont=_MyTable_GetDefaultFont(*this)
			DrawingFont(*nfont\GetFontID())
			*this\textheight=_MyTableTextHeight(*this\text)
			*this\textwidth=_MyTableTextWidth(*this\text)
		EndIf
		
		Protected result.i=0
		If *this\main\datagrid And *this\listindex=0
			result=MyTableW8+_MyTableTextWidth(Str(ListSize(*this\main\rows())))+MyTableW8
		Else
			result=*this\textwidth+MyTableW8
			
			If *this\image
				result+*this\main\calcheaderheight-MyTableW8
				result+MyTableW8			
			EndIf
			If *this\sort
				result+MyTableW20
			EndIf		
			
			ForEach *this\main\rows()
				If *this\main\rows()\cells
					If ListSize(*this\main\rows()\cells\cells())>*this\listindex					
						Protected tresult=_MyTable_Col_AutosizeSubRow(*this,*this\main\rows())					
						If tresult>result
							result=tresult
						EndIf
					EndIf
				EndIf
			Next
		EndIf
		*this\calcwidth=result+MyTableW8
		*this\width=DesktopUnscaledX(*this\calcwidth)
		*this\dirty=#True
		*this\main\dirty=#True
		If Not *this\main\drawing
			StopDrawing()
		EndIf
		_callcountEnde()
		_MyTable_Table_Predraw(*this\main)
		_MyTable_Table_Redraw(*this\main)
	EndIf
EndProcedure