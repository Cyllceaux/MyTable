_SimpleSetterGetter(MyTable,Col,Tooltip,s)
_SimpleSetterGetterSubRedraw(MyTable,Col,Dirty,b)
_SimpleSetterGetterSubPredraw(MyTable,Col,Flags,i)
_SimpleSetterGetterSubPredraw(MyTable,Col,Disabled,b)
_SimpleGetterPointer(MyTable,Col,Table)
_SimpleGetter(MyTable,Col,Type,i)
_SimpleSetterGetterPointer(MyTable,Col,Data)
_SimpleSetterGetterSubRedraw(MyTable,Col,Text,s)
_SimpleGetter(MyTable,Col,Mask,s)
_SimpleSetterGetterSubPredraw(MyTable,Col,Colspan,i)
_SimpleGetter(MyTable,Col,Datatype,i)


Procedure _MyTable_Col_SetMask(*this.strMyTableCol,value.s)
	If *this
		ForEach *this\table\rows()
			If *this\table\rows()\cells And ListSize(*this\table\rows()\cells\cells())>*this\listindex
				Protected *cell.strMyTableCell=_MyTableGetOrAddCell(*this\table\rows(),*this\listindex,#True)
				If *cell\mask=*this\mask
					*cell\mask=value
					*cell\dirty=#True
				EndIf
			EndIf
		Next
		*this\mask=value
		*this\dirty=#True
		*this\table\dirty=#True		
		_MyTable_Table_Redraw(*this\table)
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
		ForEach *this\table\rows()
			If *this\table\rows()\cells And ListSize(*this\table\rows()\cells\cells())>*this\listindex
				Protected *cell.strMyTableCell=_MyTableGetOrAddCell(*this\table\rows(),*this\listindex,#True)
				If *cell\datatype=*this\datatype
					*cell\datatype=value
					*cell\defaultStyle\halign=*this\defaultStyle\halign
					*cell\dirty=#True
				EndIf
			EndIf
		Next
		*this\datatype=value
		*this\dirty=#True
		*this\table\dirty=#True		
		_MyTable_Table_Redraw(*this\table)
	EndIf
EndProcedure

Procedure _MyTable_Col_GetApplication(*this.strMyTableCol)
	If *this
		ProcedureReturn *this\table\application
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
		ForEach *this\table\cols()
			*this\table\cols()\sort=#MYTABLE_COL_SORT_NONE
		Next
		*this\sort=sort
		Protected numeric.b=Bool(_MyTable_IsCheckboxes(*this) Or 
		                         *this\datatype & #MYTABLE_DATATYPE_NUMBER Or 
		                         *this\datatype & #MYTABLE_DATATYPE_DATE)
		
		_callcountStart()
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
		_callcountEnde()
	EndIf
EndProcedure

Procedure _MyTable_Col_SetSort(*this.strMyTableCol,value.i)
	If *this
		*this\sort=value
		*this\dirty=#True
		*this\table\dirty=#True		
		If *this\parent
			_MyTable_Col_Sort(*this\parent,value)
		Else
			_MyTable_Col_Sort(*this,value)
		EndIf
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
		Protected *table.strMyTableTable=*this\table
		ForEach *this\table\cols()
			If *this\table\cols()=*this
				DeleteElement(*this\table\cols())
				ForEach *this\table\rows()
					_MyTable_Col_DeleteColRow(*this\table\rows(),idx)
				Next
			Else
				*this\table\cols()\listindex=idx
				idx+1
				If *this\table\datagrid
					*this\table\cols()\text=_MyTableGridColumnName(idx)
					*this\table\cols()\dirty=#True
					*this\table\cols()\textheight=0
					*this\table\cols()\textwidth=0
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
		*this\table\dirty=#True
		_MyTable_Table_Predraw(*this\table)
		_MyTable_Table_Redraw(*this\table)
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
		*this\table\selectedcols(Str(*this))=value
		*this\table\dirty=#True
		*this\dirty=#True
		_MyTable_Table_Redraw(*this\table)
	EndIf
EndProcedure


Procedure _MyTable_Col_ScrollTo(*this.strMyTableCol,setSelect.b=#False,redraw.b=#True)
	If *this		
		_MyTable_Table_Predraw(*this\table,#True)
		Protected w=0
		Protected idw=0
		ForEach *this\table\cols()			
			Protected *col.strMyTableCol=*this\table\cols()			
			If *col=*this
				If setSelect
					Protected multiselect.b=_MyTable_IsMultiselect(*this)
					Protected fullrow.b=_MyTable_IsFullrowselect(*this)
					If fullrow
						If Not multiselect
							ClearMap(*this\table\selectedCols())															
						EndIf
						*this\table\selectedCols(Str(*col))=#True
					EndIf
				EndIf
				Break						
			EndIf
			w+*col\width
			idw+1
		Next
		If IsGadget(*this\table\hscroll)
			SetGadgetState(*this\table\hscroll,w)
		Else
			*this\table\hscroll=w
			If *this\table\hscroll>*this\table\maxhscroll
				*this\table\hscroll=*this\table\maxhscroll
			EndIf
		EndIf
		*this\table\dirty=#True
		If redraw
			_MyTable_Table_Redraw(*this\table)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Col_AutosizeSubRow(*this.strMyTableCol,*row.strMyTableRow)
	Protected hierarchical.b=_MyTable_IsHierarchical(*this\table)
	Protected checkboxes.b=_MyTable_IsCheckboxes(*this\table)
	Protected *lastfont.MyFont::MyFont=0
	Protected tresult.i=0
	If *this\listindex=0
		If hierarchical And *this\listindex=0
			tresult+(MyTableW20 * (*row\level + 1))
		EndIf
		If checkboxes And *this\listindex=0
			tresult+MyTableW20
		EndIf
		If *row\image
			If *this\listindex=0
				tresult+*row\table\defaultrowheight+MyTableW8
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
			tresult+*cell\table\defaultrowheight+MyTableW8
		EndIf
		If *cell\imageRight	
			tresult+*cell\table\defaultrowheight+MyTableW8
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
		
		If Not *this\table\drawing
			If IsImage(*this\table\canvas)
				StartDrawing(ImageOutput(*this\table\canvas))
			EndIf
			If IsGadget(*this\table\canvas)
				StartDrawing(CanvasOutput(*this\table\canvas))
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
		If *this\table\datagrid And *this\listindex=0
			result=MyTableW8+_MyTableTextWidth(Str(ListSize(*this\table\rows())))+MyTableW8
		Else
			result=*this\textwidth+MyTableW8
			
			If *this\image
				result+*this\table\calcheaderheight-MyTableW8
				result+MyTableW8			
			EndIf
			If *this\sort
				result+MyTableW20
			EndIf		
			
			ForEach *this\table\rows()
				If *this\table\rows()\cells
					If ListSize(*this\table\rows()\cells\cells())>*this\listindex					
						Protected tresult=_MyTable_Col_AutosizeSubRow(*this,*this\table\rows())					
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
		*this\table\dirty=#True
		If Not *this\table\drawing
			StopDrawing()
		EndIf
		_callcountEnde()
		_MyTable_Table_Predraw(*this\table)
		_MyTable_Table_Redraw(*this\table)
	EndIf
EndProcedure