﻿Global NewMap MyTableWindowTables.i()

Procedure.b _MyTable_IsSelected(*obj.strMyTableObject)
	Select *obj\type
		Case My::#MY_TYPE_CELL
			Protected *cell.strMyTableCell=*obj
			If FindMapElement(*cell\main\selectedCells(),Str(*obj))
				ProcedureReturn *cell\main\selectedCells()
			EndIf
			If FindMapElement(*cell\main\tempselectedCells(),Str(*obj))
				ProcedureReturn *cell\main\tempselectedCells()
			EndIf
			ProcedureReturn *cell\main\selectall
		Case My::#MY_TYPE_COL
			Protected *col.strMyTableCol=*obj
			If FindMapElement(*col\main\selectedCols(),Str(*obj))
				ProcedureReturn *col\main\selectedCols()
			EndIf
			If FindMapElement(*col\main\tempselectedCols(),Str(*obj))
				ProcedureReturn *col\main\tempselectedCols()
			EndIf
			ProcedureReturn *col\main\selectall
		Case My::#MY_TYPE_ROW			
			Protected *row.strMyTableRow=*obj
			If FindMapElement(*row\main\selectedRows(),Str(*obj))
				ProcedureReturn *row\main\selectedRows()
			EndIf
			If FindMapElement(*row\main\tempselectedRows(),Str(*obj))
				ProcedureReturn *row\main\tempselectedRows()
			EndIf
			ProcedureReturn *row\main\selectall
		Case My::#MY_TYPE_TABLE,My::#MY_TYPE_TREE,My::#MY_TYPE_GRID
			Protected *table.strMyTableTable=*obj
			ProcedureReturn *table\selectall
	EndSelect
	ProcedureReturn #False
EndProcedure

Global NewList gadgets.i()

Procedure _MyTable_WinRepaint()
	ForEach gadgets()
		_MyTable_Table_Redraw(gadgets())
	Next
EndProcedure


Procedure MyTableCreateTable(window.i,canvas.i,vscroll.i,hscroll.i,flags.i=#MYTABLE_TABLE_FLAGS_DEFAULT_TABLE)
	Protected *this.strMyTableTable=AllocateStructure(strMyTableTable)	
	_MyTableInitTable(*this,window,canvas,vscroll,hscroll,flags)
	ProcedureReturn *this
EndProcedure

Procedure MyTableCreateTree(window.i,canvas.i,vscroll.i,hscroll.i,flags.i=#MYTABLE_TABLE_FLAGS_DEFAULT_TREE)
	Protected *this.strMyTableTable=AllocateStructure(strMyTableTable)
	_MyTableInitTree(*this,window,canvas,vscroll,hscroll,flags)
	ProcedureReturn *this
EndProcedure

Procedure MyTableCreateGrid(window.i,canvas.i,vscroll.i,hscroll.i,rows.i,cols.i,flags.i=#MYTABLE_TABLE_FLAGS_DEFAULT_GRID)
	Protected *this.strMyTableTable=AllocateStructure(strMyTableTable)
	_MyTableInitGrid(*this,window,canvas,vscroll,hscroll,rows,cols,flags)
	ProcedureReturn *this
EndProcedure

Procedure MyTableCreateNewTable(x.i,y.i,w.i,h.i,flags.i=#MYTABLE_TABLE_FLAGS_DEFAULT_TABLE)
	Protected window=GetActiveWindow()
	Protected canvas=CanvasGadget(#PB_Any,x,y,w,h,#PB_Canvas_Container|#PB_Canvas_Keyboard)
	Protected hscroll=ScrollBarGadget(#PB_Any,0,0,0,20,0,0,0)
	Protected vscroll=ScrollBarGadget(#PB_Any,0,0,20,0,0,0,0,#PB_ScrollBar_Vertical)
	CloseGadgetList()
	
	ProcedureReturn MyTableCreateTable(window,canvas,vscroll,hscroll,flags)
EndProcedure

Procedure MyTableCreateNewTree(x.i,y.i,w.i,h.i,flags.i=#MYTABLE_TABLE_FLAGS_DEFAULT_TREE)
	Protected window=GetActiveWindow()
	Protected canvas=CanvasGadget(#PB_Any,x,y,w,h,#PB_Canvas_Container|#PB_Canvas_Keyboard)
	Protected hscroll=ScrollBarGadget(#PB_Any,0,0,0,20,0,0,0)
	Protected vscroll=ScrollBarGadget(#PB_Any,0,0,20,0,0,0,0,#PB_ScrollBar_Vertical)
	CloseGadgetList()
	
	ProcedureReturn MyTableCreateTree(window,canvas,vscroll,hscroll,flags)
EndProcedure

Procedure MyTableCreateNewGrid(x.i,y.i,w.i,h.i,rows.i,cols.i,flags.i=#MYTABLE_TABLE_FLAGS_DEFAULT_GRID)
	Protected window=GetActiveWindow()
	Protected canvas=CanvasGadget(#PB_Any,x,y,w,h,#PB_Canvas_Container|#PB_Canvas_Keyboard)
	Protected hscroll=ScrollBarGadget(#PB_Any,0,0,0,20,0,0,0)
	Protected vscroll=ScrollBarGadget(#PB_Any,0,0,20,0,0,0,0,#PB_ScrollBar_Vertical)
	CloseGadgetList()
	
	ProcedureReturn MyTableCreateGrid(window,canvas,vscroll,hscroll,rows,cols,flags)
EndProcedure



Procedure  _MyTableInitStyleTable(*style.strMyTableStyle)
	With *style
		\font=MyFont::MyFontCreateFont("Arial",10,#PB_Font_HighQuality)
		\backcolor=RGBA(250,250,250,255)
		\frontcolor=RGBA(230,230,230,255)
		\forecolor=RGBA(50,50,50,255)
		\border\borderDefault\color=RGBA(50,50,50,255)		
		\border\borderDefault\width=1
		\border\border=#MYTABLE_STYLE_BORDER_ALL
	EndWith
EndProcedure

Procedure  _MyTableInitStyleTableSelected(*style.strMyTableStyle)
	With *style
		\backcolor=RGBA(230,230,250,255)
		\forecolor=RGBA(20,20,20,255)
		\border\borderDefault\color=RGBA(200,200,200,255)	
		\border\borderDefault\width=1
		\border\border=#MYTABLE_STYLE_BORDER_ALL
	EndWith
EndProcedure

Procedure  _MyTableInitStyleTableElementSelected(*style.strMyTableStyle)
	With *style
		\backcolor=RGBA(130,50,50,255)
		\forecolor=RGBA(200,200,200,255)
		\border\borderDefault\color=RGBA(200,200,250,255)
		\border\border=#MYTABLE_STYLE_BORDER_ALL
	EndWith
EndProcedure

Procedure  _MyTableInitStyleTableZebra(*style.strMyTableStyle)
	With *style
		\backcolor=RGBA(230,230,250,255)
		\forecolor=RGBA(20,20,20,255)
		\border\borderDefault\color=RGBA(200,200,250,255)
		\border\border=#MYTABLE_STYLE_BORDER_ALL
	EndWith
EndProcedure

Procedure  _MyTableInitStyleTableMouseOver(*style.strMyTableStyle)
	With *style
		\backcolor=RGBA(100,100,120,255)
		\forecolor=RGBA(20,20,20,255)
		\border\borderDefault\color=RGBA(200,200,250,255)
		\border\border=#MYTABLE_STYLE_BORDER_ALL
	EndWith
EndProcedure

Procedure  _MyTableInitStyleTableDisabled(*style.strMyTableStyle)
	With *style
		\backcolor=RGBA(230,230,230,255)
		\forecolor=RGBA(20,20,20,255)
		\border\borderDefault\color=RGBA(200,200,250,255)
		\border\border=#MYTABLE_STYLE_BORDER_ALL
	EndWith
EndProcedure

Procedure  _MyTableInitStyleTableFixed(*style.strMyTableStyle)
	With *style
		\frontcolor=RGBA(250,250,250,255)
		\backcolor=RGBA(150,150,150,255)
		\forecolor=RGBA(250,250,250,255)		
	EndWith
EndProcedure

Procedure  _MyTableInitStyleTableTitle(*style.strMyTableStyle)
	With *style
		\frontcolor=RGBA(250,250,250,255)
		\backcolor=RGBA(150,150,150,255)
		\forecolor=RGBA(250,250,250,255)
		\halign=#MYTABLE_STYLE_HALIGN_CENTER
		\border\border=#MYTABLE_STYLE_BORDER_ALL
	EndWith
EndProcedure

Procedure  _MyTableInitStyleTableEmpty(*style.strMyTableStyle)
	With *style
		\frontcolor=RGBA(250,250,250,255)
		\backcolor=RGBA(150,150,150,255)
		\forecolor=RGBA(50,50,50,255)
		\halign=#MYTABLE_STYLE_HALIGN_CENTER
		\border\border=#MYTABLE_STYLE_BORDER_ALL
	EndWith
EndProcedure

Procedure _MyTableInitStyleObject(*style.strMyTableStyleObject,*this.strMyTableObject,*s.strMyTableStyle)
	With *style
		\vtable=?vtable_style
		\type=My::#MY_TYPE_STYLE
		\obj=*this
		\style=*s
	EndWith
EndProcedure

Procedure _MyTableInitStyles(*this.strMyTableObject)
	With *this
		_MyTableInitStyleTable(\defaultStyle)
		_MyTableInitStyleTableFixed(\fixedStyle)
		_MyTableInitStyleTableSelected(\selectedStyle)
		_MyTableInitStyleTableTitle(\titleStyle)
		_MyTableInitStyleTableMouseOver(\mouseoverStyle)
		_MyTableInitStyleTableEmpty(\emptyStyle)
		_MyTableInitStyleTableElementSelected(\elementselectedStyle)
		_MyTableInitStyleTableZebra(\zebraStyle)
		_MyTableInitStyleTableDisabled(\disabledStyle)
	EndWith
EndProcedure

Procedure _MyTableInitBorderObject(*border.strMyTableBorderObject,
                                   *style.strMyTableStyleObject,
                                   *b.strMyTableStyleBorderStyle)
	With *border
		\vtable=?vtable_border
		\type=My::#MY_TYPE_BORDER
		\style=*style		
		\border=*b
	EndWith
EndProcedure



Procedure _MyTableEvtScroll()
	Protected *this.strMyTableTable=GetGadgetData(EventGadget())
	_MyTable_StopEdit(*this,#True)
	*this\dirty=#True
	_MyTable_Table_Redraw(*this)
EndProcedure

Procedure _MyTableEvtResizeExp(*this.strMyTableTable)
	Protected w=0
	Protected h=0
	If IsGadget(*this\canvas)
		w=GadgetWidth(*this\canvas)
		h=GadgetHeight(*this\canvas)
	EndIf
	If IsImage(*this\canvas)
		w=ImageWidth(*this\canvas)
		h=ImageHeight(*this\canvas)
	EndIf
	If IsGadget(*this\vscroll)
		ResizeGadget(*this\vscroll,
		             w-GadgetWidth(*this\vscroll),
		             #PB_Ignore,
		             #PB_Ignore,
		             h-GadgetHeight(*this\hscroll))
	EndIf
	If IsGadget(*this\hscroll)
		ResizeGadget(*this\hscroll,
		             #PB_Ignore,
		             h-GadgetHeight(*this\hscroll),
		             w-GadgetWidth(*this\vscroll),
		             #PB_Ignore)
	EndIf
	If *this\oldheight<>h Or *this\oldwith<>w
		*this\dirty=#True
		_MyTable_Table_Predraw(*this)
		_MyTable_Table_Redraw(*this)
	EndIf
	*this\oldheight=h
	*this\oldwith=w
EndProcedure

Procedure _MyTableEvtMoveExp(*this.strMyTableTable)
	If *this
		If IsWindow(*this\edit\window)
			ResizeWindow(*this\edit\window,
			             GadgetX(*this\canvas,#PB_Gadget_ScreenCoordinate)+DesktopUnscaledX(*this\edit\cell\startx),
			             GadgetY(*this\canvas,#PB_Gadget_ScreenCoordinate)+DesktopUnscaledY(*this\edit\cell\starty),
			             DesktopUnscaledX(*this\edit\cell\col\calcwidth),
			             DesktopUnscaledY(*this\edit\cell\row\calcheight))
		EndIf
	EndIf
EndProcedure

Procedure _MyTableEvtResize()
	Protected *this.strMyTableTable=GetGadgetData(EventGadget())
	_MyTableEvtResizeExp(*this)
EndProcedure

Procedure _MyTableEvtMove()
	ForEach MyTableWindowTables()
		If MyTableWindowTables()=EventWindow()
			_MyTableEvtMoveExp(Val(MapKey(MyTableWindowTables())))
		EndIf
	Next
	
EndProcedure

Procedure _MyTableGetRowCol(*this.strMyTableTable)
	Protected checkboxes.b=_MyTable_IsCheckboxes(*this)
	Protected hierarchical.b=_MyTable_IsHierarchical(*this)
	Protected resizable.b=_MyTable_IsResizable(*this)
	Protected title.b=_MyTable_IsTitle(*this)
	Protected header.b=_MyTable_IsHeader(*this)
	Protected alwaysexpanded.b=_MyTable_IsHierarchical_Always_Expanded(*this)
	Protected disabled.b=_MyTable_IsDisabled(*this)
	
	
	Protected *row.strMyTableRow=0
	Protected *cell.strMyTableCell=0
	Protected mx=GetGadgetAttribute(*this\canvas,#PB_Canvas_MouseX)
	Protected my=GetGadgetAttribute(*this\canvas,#PB_Canvas_MouseY)
	Protected vsc=0
	Protected hsc=0
	Protected startx=0,starty=0
	Protected *rc.strMyTableRowCol=AllocateStructure(strMyTableRowCol)
	*rc\col=-2
	*rc\row=-2
	
	If IsGadget(*this\vscroll)
		vsc=-DesktopScaledY(GetGadgetState(*this\vscroll))
	Else
		vsc=-DesktopScaledY(*this\vscroll)
	EndIf
	
	If IsGadget(*this\hscroll)
		hsc=-DesktopScaledX(GetGadgetState(*this\hscroll))
	Else
		hsc=-DesktopScaledX(*this\hscroll)
	EndIf
	
	If title
		vsc+*this\calctitleHeight
		If my<*this\calctitleHeight
			ProcedureReturn *rc
		EndIf
	EndIf
	
	If header
		vsc+*this\calcheaderheight
		If title
			If my>*this\calctitleHeight And my<(*this\calcheaderheight+*this\calctitleHeight)
				*rc\row=-1
			EndIf
		Else
			If my<*this\calcheaderheight
				*rc\row=-1
			EndIf
		EndIf
	EndIf
	
	
	
	Protected fwidth=0
	If *this\fixedcols
		ForEach *this\cols()
			If *this\fixedcols>ListIndex(*this\cols())
				fwidth+*this\cols()\calcwidth
			EndIf
		Next		
	EndIf
	If mx<fwidth
		hsc=0
	EndIf
	
	
	ForEach *this\cols()
		Protected *col.strMyTableCol=*this\cols()
		Protected colresize.b=_MyTable_IsResizable(*col)
		
		If mx>(hsc+*col\calcwidth-MyTableW2) And mx<(hsc+*col\calcwidth+MyTableW2)
			*rc\col=ListIndex(*this\cols())
			*rc\right=colresize
			*rc\tcol=*col
			*rc\mx=mx
			Break
		ElseIf mx>hsc And mx<(hsc+*col\calcwidth)
			*rc\col=ListIndex(*this\cols())
			*rc\tcol=*col	
			Break
		Else				
			hsc+*col\calcwidth
		EndIf
		startx=hsc
	Next
	
	
	If *rc\row=-2	
		ForEach *this\expRows()
			*row=*this\expRows()
			Protected rowresize.b=_MyTable_IsResizable(*row)			
			
			If my>(vsc+*row\calcheight-MyTableH2) And my<(vsc+*row\calcheight+MyTableH2)
				*rc\row=ListIndex(*this\expRows())
				*rc\bottom=rowresize
				*rc\trow=*row
				*rc\my=my
				Break
			ElseIf my>vsc And my<(vsc+*row\calcheight)
				*rc\row=ListIndex(*this\expRows())
				*rc\trow=*row
				Break
			Else				
				vsc+*row\calcheight
			EndIf
		Next
		starty=vsc
	EndIf
	
	If *rc\row>-1 And *rc\col>-1
		If Not *rc\trow
			SelectElement(*this\expRows(),*rc\row)
			*rc\trow=*this\expRows()
		EndIf
		*rc\tcell=_MyTableGetOrAddCell(*rc\trow,*rc\col,#True)
		*rc\starty=starty
		*rc\startx=startx
		If Not *rc\tcol
			*rc\tcol=*rc\tcell\col
		EndIf
	EndIf
	
	If *rc\row>-1 And *rc\col=0
		disabled=_MyTable_IsDisabled(*rc\trow)
		If (hierarchical Or checkboxes) And Not disabled
			Checkboxes=_MyTable_IsCheckboxes(*rc\trow)
			Protected ex=*row\level*MyTableW20
			If alwaysexpanded
				ex-MyTableW20
			EndIf
			If mx>ex
				ex=mx-ex
				If hierarchical And checkboxes
					If ex<MyTableW20
						*rc\exp=#True
					ElseIf ex<(MyTableW20*2)
						*rc\check=#True
					EndIf
				ElseIf hierarchical
					If ex<MyTableW20
						*rc\exp=#True
					EndIf
				ElseIf checkboxes
					If ex<MyTableW20
						*rc\check=#True
					EndIf
				EndIf
			EndIf
		EndIf
		
	EndIf
	
	
	
	ProcedureReturn *rc
EndProcedure

Procedure _MyTableEvtCanvasGotFocus()
	Protected *this.strMyTableTable=GetGadgetData(EventGadget())
	
EndProcedure

Procedure _MyTableEvtCanvasLostFocus()
	Protected *this.strMyTableTable=GetGadgetData(EventGadget())
	
EndProcedure

Procedure _MyTableEvtCanvasKeyUp()
	Protected *this.strMyTableTable=GetGadgetData(EventGadget())
	Protected shift.b=Bool(GetGadgetAttribute(*this\canvas,#PB_Canvas_Modifiers) & #PB_Canvas_Shift)
	Protected control.b=Bool(GetGadgetAttribute(*this\canvas,#PB_Canvas_Modifiers) & #PB_Canvas_Control)
	Protected multiselect.b=_MyTable_IsMultiselect(*this)
	
	If IsGadget(*this\canvas)
		
		If Not shift
			If multiselect
				ForEach *this\tempselectedCells()
					*this\selectedCells(MapKey(*this\tempselectedCells()))=*this\tempselectedCells()
					If *this\eventCellSelected
						*this\eventCellSelected(Val(MapKey(*this\tempselectedCells())))
					EndIf
				Next
				ForEach *this\tempselectedCols()
					*this\selectedCols(MapKey(*this\tempselectedCols()))=*this\tempselectedCols()
					If *this\eventColSelected
						*this\eventColSelected(Val(MapKey(*this\tempselectedCols())))
					EndIf
				Next			
				ForEach *this\tempselectedRows()
					*this\selectedRows(MapKey(*this\tempselectedRows()))=*this\tempselectedRows()						
					If *this\eventRowSelected
						*this\eventRowSelected(Val(MapKey(*this\tempselectedRows())))
					EndIf
				Next
			EndIf
			ClearMap(*this\tempselectedCells())
			ClearMap(*this\tempselectedRows())
			ClearMap(*this\tempselectedCols())
			
			_MyTable_Table_Redraw(*this)
		EndIf
	EndIf
EndProcedure

Procedure _MyTableEvtCanvasKeyDown()
	Protected *this.strMyTableTable=GetGadgetData(EventGadget())
	_MyTable_StopEdit(*this,#True)
	If IsGadget(*this\canvas)
		Protected shift.b=Bool(GetGadgetAttribute(*this\canvas,#PB_Canvas_Modifiers) & #PB_Canvas_Shift)
		Protected control.b=Bool(GetGadgetAttribute(*this\canvas,#PB_Canvas_Modifiers) & #PB_Canvas_Control)
		Protected alt.b=Bool(GetGadgetAttribute(*this\canvas,#PB_Canvas_Modifiers) & #PB_Canvas_Alt)
		Protected key=GetGadgetAttribute(*this\canvas,#PB_Canvas_Key)
		
		Protected multiselect.b=_MyTable_IsMultiselect(*this)		
		Protected fullrow.b=_MyTable_IsFullrowselect(*this)
		Protected hierarchical.b=_MyTable_IsHierarchical(*this)
		Protected alwaysexpanded.b=_MyTable_IsHierarchical_Always_Expanded(*this)
		Protected checkboxes.b=_MyTable_IsCheckboxes(*this)
		Protected pages.b=_MyTable_IsPages(*this)
		Protected *cell.strMyTableCell=*this\lastcell
		If *this\shiftcell
			*cell=*this\shiftcell
		EndIf
		Protected *row.strMyTableRow=*this\lastrow
		Protected *col.strMyTableCol=*this\lastcol
		
		Protected editable.b=_MyTable_IsEditable(*this)
		Protected disabled.b=_MyTable_IsDisabled(*this)
		
		
		If *cell
			editable=_MyTable_IsEditable(*cell)			
			checkboxes=_MyTable_IsCheckboxes(*cell)
			disabled.b=_MyTable_IsDisabled(*cell)
			
			If Not *col
				*col=*cell\col
			EndIf
			If Not *row
				*row=*cell\row
			EndIf
		EndIf
		If *row
			alwaysexpanded=_MyTable_IsHierarchical_Always_Expanded(*row)
		EndIf
		
		Select key
			Case #PB_Shortcut_Add
				If hierarchical And *row And Not alwaysexpanded
					*row\expanded=#True
					*this\dirty=#True
					*row\dirty=#True
					_MyTable_Table_Predraw(*this)
					_MyTable_Table_Redraw(*this)
				EndIf
			Case #PB_Shortcut_Subtract 
				If hierarchical And *row And Not alwaysexpanded
					*row\expanded=#False
					*row\dirty=#True
					*this\dirty=#True
					_MyTable_Table_Predraw(*this)
					_MyTable_Table_Redraw(*this)
				EndIf
			Case #PB_Shortcut_Multiply
				If hierarchical And *row And Not alwaysexpanded
					_MyTable_Row_Expand(*row,#True)
					*this\dirty=#True
					_MyTable_Table_Predraw(*this)
					_MyTable_Table_Redraw(*this)
				EndIf
			Case #PB_Shortcut_Divide
				If hierarchical And *row And Not alwaysexpanded
					_MyTable_Row_Expand(*row,#False)										
					*this\dirty=#True
					_MyTable_Table_Predraw(*this)
					_MyTable_Table_Redraw(*this)
				EndIf
			Case #PB_Shortcut_Left
				If *this\datagrid And *cell\col\listindex=1
					_MyTableSelectObject(*cell\row,Bool(shift And multiselect),pages)
					*this\lastcell=0
				ElseIf Not fullrow And *cell And *cell\col\listindex>0
					*cell=_MyTableGetOrAddCell(*cell\row,*cell\col\listindex-1,#True)
					_MyTableSelectObject(*cell,Bool(shift And multiselect),pages)
				EndIf
			Case #PB_Shortcut_Right
				If *this\datagrid And (*cell=0 Or *cell\col\listindex=0)
					*cell=_MyTableGetOrAddCell(*row,1,#True)
					_MyTableSelectObject(*cell,Bool(shift And multiselect),pages)
				ElseIf Not fullrow And *cell And *cell\col\listindex<ListSize(*this\cols())
					*cell=_MyTableGetOrAddCell(*cell\row,*cell\col\listindex+1,#True)
					_MyTableSelectObject(*cell,Bool(shift And multiselect),pages)									
				EndIf
			Case #PB_Shortcut_Up
				If *row
					If *row\explistindex>0
						If pages
							SelectElement(*this\expRowsPage(),*row\explistindex-1)								
							*row=*this\expRowsPage()
						Else
							SelectElement(*this\expRows(),*row\explistindex-1)								
							*row=*this\expRows()
						EndIf				
						
						If fullrow Or (*this\datagrid And (*col=0 Or *col\listindex=0))		
							_MyTableSelectObject(*row,Bool(shift And multiselect),pages)
						Else
							*cell=_MyTableGetOrAddCell(*row,*cell\col\listindex,#True)
							_MyTableSelectObject(*cell,Bool(shift And multiselect),pages)
						EndIf
					EndIf
				EndIf
			Case #PB_Shortcut_Down
				If *row
					If Pages
						If (*row\explistindex+1)<ListSize(*this\expRowsPage())
							SelectElement(*this\expRowsPage(),*row\explistindex+1)			
							*row=*this\expRowsPage()
						EndIf							
					Else
						If (*row\explistindex+1)<ListSize(*this\expRows())
							SelectElement(*this\expRows(),*row\explistindex+1)			
							*row=*this\expRows()
						EndIf
					EndIf
					
					If fullrow Or (*this\datagrid And (*col=0 Or *col\listindex=0))		
						_MyTableSelectObject(*row,Bool(shift And multiselect),pages)
					Else
						*cell=_MyTableGetOrAddCell(*row,*cell\col\listindex,#True)
						_MyTableSelectObject(*cell,Bool(shift And multiselect),pages)
					EndIf
				EndIf
			Case #PB_Shortcut_Space
				If *row
					Checkboxes=_MyTable_IsCheckboxes(*row)
				EndIf
				If checkboxes And *row
					*row\checked=Bool(*row\checked=#False)
					*row\dirty=#True
					*this\dirty=#True					
					If *row\checked And *this\eventRowChangedChecked
						*this\eventRowChangedChecked(*row)
					EndIf
					If Not *row\checked And *this\eventRowChangedUnChecked
						*this\eventRowChangedUnChecked(*row)
					EndIf
					_MyTable_Table_Redraw(*this)
				ElseIf editable And *cell
					*cell\checked=Bool(*cell\checked=#False)
					*cell\dirty=#True
					*this\dirty=#True					
					If *cell\checked And *this\eventCellChangedChecked
						*this\eventCellChangedChecked(*Cell)
					EndIf
					If Not *cell\checked And *this\eventCellChangedUnChecked
						*this\eventCellChangedUnChecked(*Cell)
					EndIf
					_MyTable_Table_Redraw(*this)
				EndIf
			Case #PB_Shortcut_Delete
				If Editable
					ForEach *this\selectedCells()
						If *this\selectedCells()
							Protected *tcell.strMyTableCell=Val(MapKey(*this\selectedCells()))
							Protected old.s=*tcell\text
							_MyTable_Cell_SetTextExp(*tcell,"")
							If *this\eventCellChangedText
								*this\eventCellChangedText(*tcell,old)
							EndIf
						EndIf
					Next
				EndIf
			Case #PB_Shortcut_Return
				_MyTable_StartEditCell(*this\lastcell)			
			Case #PB_Shortcut_PageDown
				If IsGadget(*this\vscroll)
					SetGadgetState(*this\vscroll,GetGadgetState(*this\vscroll)+100)						
				Else
					*this\vscroll+100
				EndIf
				*this\dirty=#True
				_MyTable_Table_Redraw(*this)
			Case #PB_Shortcut_PageUp
				If IsGadget(*this\vscroll)
					SetGadgetState(*this\vscroll,GetGadgetState(*this\vscroll)-100)						
				Else
					*this\vscroll-100
					If *this\vscroll<0
						*this\vscroll=0
					EndIf
				EndIf
				*this\dirty=#True
				_MyTable_Table_Redraw(*this)
		EndSelect
	EndIf
EndProcedure

Procedure _MyTableSelectObject(*obj.strMyTableObject,shift.b,pages.b)
	Protected *row.strMyTableRow=0
	Protected *cell.strMyTableCell=0
	Protected *col.strMyTableCol=0
	Protected *this.strMyTableTable=0
	If *obj
		If *obj\type=My::#MY_TYPE_CELL
			*cell=*obj
			*row=*cell\row
			*col=*cell\col
			*this=*cell\main		
			ClearMap(*this\tempselectedCells())
			ClearMap(*this\tempselectedRows())
			ClearMap(*this\tempselectedCols())	
			If Not shift
				ClearMap(*this\selectedCells())
				ClearMap(*this\selectedRows())
				ClearMap(*this\selectedCols())			
			EndIf
			
			If shift
				*this\shiftcell=*cell				
				Protected rmin,cmin,rmax,cmax,r,c				
				If *this\shiftcell<>*this\lastcell
					rmin=*this\shiftcell\row\explistindex
					rmax=*this\lastcell\row\explistindex
					If rmin>rmax
						Swap rmin,rmax
					EndIf
					
					cmin=*this\shiftcell\col\listindex
					cmax=*this\lastcell\col\listindex
					
					If cmin>cmax
						Swap cmin,cmax
					EndIf
					
					For r=rmin To rmax
						If pages
							SelectElement(*this\expRowsPage(),r)
							*row=*this\expRowsPage()
						Else
							SelectElement(*this\expRows(),r)
							*row=*this\expRows()
						EndIf
						For c=cmin To cmax
							*cell=_MyTableGetOrAddCell(*row,c,#True)
							*this\tempselectedCells(Str(*cell))=#True
						Next
					Next
				EndIf				
			Else
				*this\lastcell=*cell
				*this\selectedCells(Str(*obj))=#True
				If *this\eventCellSelected
					*this\eventCellSelected(*cell)
				EndIf
			EndIf			
		ElseIf *obj\type=My::#MY_TYPE_COL
			*col=*obj
			*this=*col\main
			If Not shift
				ClearMap(*this\selectedCells())
				ClearMap(*this\selectedRows())
				ClearMap(*this\selectedCols())			
			EndIf
			*this\selectedCols(Str(*obj))=#True
			*this\lastcol=*obj
		ElseIf *obj\type=My::#MY_TYPE_ROW
			*row=*obj
			*this=*row\main
			If Not shift
				ClearMap(*this\selectedCells())
				ClearMap(*this\selectedRows())
				ClearMap(*this\selectedCols())			
			EndIf
			*this\selectedRows(Str(*obj))=#True
			*this\lastrow=*obj
		EndIf
		
		If *this
			*this\dirty=#True
			_MyTable_Table_Redraw(*this)
		EndIf
	EndIf
	
EndProcedure

Procedure _MyTableSelect(*this.strMyTableTable,*rc.strMyTableRowCol,temp.b)
	Protected multiselect.b=_MyTable_IsMultiselect(*this)
	
	Protected fullrow.b=_MyTable_IsFullrowselect(*this)
	Protected sortable.b=_MyTable_IsSortable(*this)
	Protected pages.b=_MyTable_IsPages(*this)
	
	Protected shift.b=Bool(GetGadgetAttribute(*this\canvas,#PB_Canvas_Modifiers) & #PB_Canvas_Shift)
	Protected control.b=Bool(GetGadgetAttribute(*this\canvas,#PB_Canvas_Modifiers) & #PB_Canvas_Control)
	Protected rf,rt,cf,ct,r,c
	
	Protected *row.strMyTableRow=0
	
	If *this\datagrid And *rc\col=0 And *rc\row=-1
		ProcedureReturn #False
	EndIf
	
	*this\shiftcell=0
	If *rc\row=-1 And *rc\col>-1
		If Not *this\resizeCol			
			Protected *tcol.strMyTableCol=*rc\tcol
			If *tcol\parent
				*tcol=*tcol\parent
			EndIf
			sortable=_MyTable_IsSortable(*tcol)
			If sortable
				Select *tcol\sort
					Case #MYTABLE_COL_SORT_NONE
						_MyTable_Col_SetSort(*tcol,#MYTABLE_COL_SORT_ASC)
					Case #MYTABLE_COL_SORT_ASC
						_MyTable_Col_SetSort(*tcol,#MYTABLE_COL_SORT_DESC)
					Case #MYTABLE_COL_SORT_DESC
						_MyTable_Col_SetSort(*tcol,#MYTABLE_COL_SORT_NONE)
				EndSelect		
				*this\dirty=#True
				*this\md=#False
			Else
				If multiselect And 
				   (shift Or *this\md) And 
				   *this\lastcol <>0 And 
				   *rc\tcol<>*this\lastcol 
					cf=-1
					ct=-1
					cf=*rc\tcol\listindex
					
					cf=*rc\tcol\listindex
					ct=*this\lastcol\listindex
					If cf>ct
						Swap cf,ct
					EndIf
					For c=cf To ct
						SelectElement(*this\cols(),c)
						If temp
							*this\tempselectedCols(Str(*this\cols()))=#True
						EndIf
					Next
				Else
					If temp
						*this\tempselectedCols(Str(*rc\tcol))=#True
					Else
						*this\lastcol=*this\cols()
						If Not _MyTable_IsSelected(*rc\tcol)
							If *this\eventColSelected
								*this\eventColSelected(*rc\tcol)
							EndIf
						EndIf
						*this\selectedCols(Str(*rc\tcol))=#True
					EndIf
				EndIf
			EndIf
			*this\dirty=#True		
		EndIf			
		ProcedureReturn 0
	Else
		If fullrow Or (*rc\col=0 And *this\datagrid)
			If *rc\row>-1 And *rc\col>-1
				
				If multiselect And 
				   (shift Or *this\md) And 
				   *rc\trow<>*this\lastrow And
				   *this\lastrow<>0 And 
				   *rc\trow\level=*this\lastrow\level And 
				   *rc\trow\parent=*this\lastrow\parent
					
					rf=-1
					rt=-1
					If pages
						ForEach *this\expRowsPage()
							If *this\expRowsPage()=*rc\trow
								rf=ListIndex(*this\expRowsPage())
							EndIf
							If *this\expRowsPage()=*this\lastrow
								rt=ListIndex(*this\expRowsPage())
							EndIf
							If rf>-1 And rt>-1
								Break
							EndIf
						Next
						If rf>-1 And rt>-1
							If rt<rf
								Swap rt,rf									
							EndIf
							For r=rf To rt								
								SelectElement(*this\expRowsPage(),r)
								*row=*this\expRowsPage()
								If temp
									*this\tempselectedRows(Str(*row))=#True
								Else									
									If Not _MyTable_IsSelected(*row)
										If *this\eventRowSelected
											*this\eventRowSelected(*row)
										EndIf
									EndIf
									*this\selectedRows(Str(*row))=#True
								EndIf
							Next
						EndIf
					Else
						ForEach *this\expRows()
							If *this\expRows()=*rc\trow
								rf=ListIndex(*this\expRows())
							EndIf
							If *this\expRows()=*this\lastrow
								rt=ListIndex(*this\expRows())
							EndIf
							If rf>-1 And rt>-1
								Break
							EndIf
						Next
						If rf>-1 And rt>-1
							If rt<rf
								Swap rt,rf									
							EndIf
							For r=rf To rt								
								SelectElement(*this\expRows(),r)
								*row=*this\expRows()
								If temp
									*this\tempselectedRows(Str(*row))=#True
								Else									
									If Not _MyTable_IsSelected(*row)
										If *this\eventRowSelected
											*this\eventRowSelected(*row)
										EndIf
									EndIf
									*this\selectedRows(Str(*row))=#True
								EndIf
							Next
						EndIf
					EndIf
				Else
					If temp
						*this\tempselectedRows(Str(*rc\trow))=#True
					Else
						*this\lastrow=*rc\trow							
						If Not _MyTable_IsSelected(*rc\trow)
							If *this\eventRowSelected
								*this\eventRowSelected(*rc\trow)
							EndIf
						EndIf
						*this\selectedRows(Str(*rc\trow))=#True						
					EndIf
				EndIf
				*this\dirty=#True
			EndIf
		Else
			If *rc\row>-1 And *rc\col>-1
				If multiselect And 
				   (shift Or *this\md) And 
				   *rc\tcell<>*this\lastcell And 
				   *this\lastcell<>0 And 
				   *rc\trow\level=*this\lastcell\row\level And
				   *rc\trow\parent=*this\lastcell\row\parent
					
					cf=*rc\tcol\listindex
					ct=*this\lastcell\col\listindex
					rf=-1
					rt=-1
					ForEach *this\expRows()
						If *this\expRows()=*rc\tcell\row
							rf=ListIndex(*this\expRows())
						EndIf
						If *this\expRows()=*this\lastcell\row
							rt=ListIndex(*this\expRows())
						EndIf
						If rf>-1 And rt>-1
							Break
						EndIf								
					Next
					If rf>-1 And rt>-1
						If rt<rf
							Swap rt,rf									
						EndIf
						If ct<cf
							Swap ct,cf									
						EndIf
						For r=rf To rt
							SelectElement(*this\expRows(),r)
							*row=*this\expRows()
							For c=cf To ct
								Protected *cell.strMyTablecell=_MyTableGetOrAddCell(*row,c,#True)									
								If temp
									*this\tempselectedCells(Str(*cell))=#True
								Else										
									If Not _MyTable_IsSelected(*cell)
										If *this\eventCellSelected
											*this\eventCellSelected(*cell)
										EndIf
									EndIf
									*this\selectedCells(Str(*cell))=#True
								EndIf
							Next
						Next								
					EndIf
				Else
					
					If temp
						*this\tempselectedCells(Str(*rc\tcell))=#True
					Else
						*this\lastcell=*rc\tcell
						If Not _MyTable_IsSelected(*rc\tcell)
							If *this\eventCellSelected
								*this\eventCellSelected(*rc\tcell)
							EndIf
						EndIf
						*this\selectedCells(Str(*rc\tcell))=#True
					EndIf
				EndIf
				
			EndIf
		EndIf
	EndIf
	*this\dirty=#True
EndProcedure

Procedure.s _MyTable_GetTooltip(*this.strMyTableObject)
	Protected *cell.strMyTableCell=0
	Protected *col.strMyTableCol=0
	Protected *row.strMyTableRow=0
	Protected *table.strMyTableTable=0
	Protected result.s=*this\tooltip
	If result=""
		Select *this\type
			Case My::#MY_TYPE_TABLE,My::#MY_TYPE_GRID,My::#MY_TYPE_TREE
				*table=*this
			Case My::#MY_TYPE_ROW
				*row=*this
				*table=*row\main
			Case My::#MY_TYPE_COL
				*col=*this
				*table=*col\main
			Case My::#MY_TYPE_CELL
				*cell=*this
				*table=*cell\main
		EndSelect
		
		If result="" And *cell		
			result=*cell\tooltip
		EndIf
		If result="" And *col
			result=*col\tooltip
		EndIf
		If result="" And *row
			result=*row\tooltip
		EndIf
		If result="" And *table
			result=*table\tooltip
		EndIf	
	EndIf
	ProcedureReturn result
EndProcedure

Procedure _MyTableEvtCanvasMouseMove()
	Protected *this.strMyTableTable=GetGadgetData(EventGadget())
	
	Protected multiselect.b=_MyTable_IsMultiselect(*this)		
	Protected fullrow.b=_MyTable_IsFullrowselect(*this)
	Protected markmouseover.b=_MyTable_IsMark_Mouse_Over(*this)
	
	Protected shift.b=Bool(GetGadgetAttribute(*this\canvas,#PB_Canvas_Modifiers) & #PB_Canvas_Shift)
	Protected control.b=Bool(GetGadgetAttribute(*this\canvas,#PB_Canvas_Modifiers) & #PB_Canvas_Control)
	
	
	
	If IsGadget(*this\canvas)
		Protected mx=GetGadgetAttribute(*this\canvas,#PB_Canvas_MouseX)
		Protected my=GetGadgetAttribute(*this\canvas,#PB_Canvas_MouseY)
		
		Protected sized.b=#False
		
		Protected *rc.strMyTableRowCol=_MyTableGetRowCol(*this)
		If *rc\tcell
			GadgetToolTip(*this\canvas,_MyTable_GetTooltip(*rc\tcell))
		ElseIf *rc\tcol
			GadgetToolTip(*this\canvas,_MyTable_GetTooltip(*rc\tcol))
		ElseIf *rc\trow
			GadgetToolTip(*this\canvas,_MyTable_GetTooltip(*rc\trow))
		Else
			GadgetToolTip(*this\canvas,_MyTable_GetTooltip(*this))
		EndIf
		
		If (*rc\bottom And *rc\right) Or (*this\resizeRow And *this\resizeCol)
			SetGadgetAttribute(*this\canvas,#PB_Canvas_Cursor,#PB_Cursor_LeftUpRightDown)			
			sized=#True
		EndIf
		
		If *rc\bottom Or *this\resizeRow 	
			If Not sized
				SetGadgetAttribute(*this\canvas,#PB_Canvas_Cursor,#PB_Cursor_UpDown)
			EndIf
			If *this\md And *this\resizeRow
				*this\resizeRow\height+DesktopUnscaledY(my-*this\myd)
				If *this\resizeRow\height<0
					*this\resizeRow\height=0
				EndIf
				*this\myd=my
				*this\resizeRow\calcheight=DesktopScaledY(*this\resizeRow\height)
				*this\resizeRow\dirty=#True	
				
				*this\dirty=#True
				_Mytable_Table_Predraw(*this)
				_Mytable_Table_Redraw(*this)
			EndIf			
			sized=#True
		EndIf			
		
		If *rc\right Or *this\resizeCol
			If Not sized
				SetGadgetAttribute(*this\canvas,#PB_Canvas_Cursor,#PB_Cursor_LeftRight)				
			EndIf
			If *this\md And *this\resizeCol
				*this\resizeCol\width+DesktopUnscaledY(mx-*this\mxd)					
				If *this\resizeCol\width<0
					*this\resizeCol\width=0
				EndIf
				*this\mxd=mx
				*this\resizeCol\calcwidth=DesktopScaledX(*this\resizeCol\width)
				*this\resizeCol\dirty=#True					
				*this\dirty=#True
				_Mytable_Table_Predraw(*this)
				_Mytable_Table_Redraw(*this)
			EndIf			
			sized=#True
		EndIf		
		
		
		If Not sized
			SetGadgetAttribute(*this\canvas,#PB_Canvas_Cursor,#PB_Cursor_Default)
			
			If *this\md And multiselect
				ClearMap(*this\tempselectedCells())
				ClearMap(*this\tempselectedRows())
				ClearMap(*this\tempselectedCols())
				_MyTableSelect(*this,*rc,#True)
				*this\dirty=#True
				_MyTable_Table_Redraw(*this)
			ElseIf markmouseover
				If *this\lastmouseovercell<>*rc\tcell
					*this\lastmouseovercell=*rc\tcell
					*this\dirty=#True
					*this\mvcell=*rc\tcell
					*this\mvcol=*rc\tcol
					*this\mvrow=*rc\trow
					_MyTable_Table_Redraw(*this)
				EndIf
			EndIf				
		EndIf
		
		FreeStructure(*rc)
	EndIf
EndProcedure

Procedure _MyTableEvtCanvasMouseLeftDown()
	Protected *this.strMyTableTable=GetGadgetData(EventGadget())
	_MyTable_StopEdit(*this,#True)
	Protected multiselect.b=_MyTable_IsMultiselect(*this)		
	Protected fullrow.b=_MyTable_IsFullrowselect(*this)
	Protected alwaysexpanded.b=_MyTable_IsHierarchical_Always_Expanded(*this)
	
	Protected shift.b=Bool(GetGadgetAttribute(*this\canvas,#PB_Canvas_Modifiers) & #PB_Canvas_Shift)
	Protected control.b=Bool(GetGadgetAttribute(*this\canvas,#PB_Canvas_Modifiers) & #PB_Canvas_Control)
	
	Protected redraw.b=#False
	*this\md=#True
	If IsGadget(*this\canvas)
		Protected *rc.strMyTableRowCol=_MyTableGetRowCol(*this)
		
		*this\myd=GetGadgetAttribute(*this\canvas,#PB_Canvas_MouseY)
		*this\mxd=GetGadgetAttribute(*this\canvas,#PB_Canvas_MouseX)
		If *rc\trow
			alwaysexpanded=_MyTable_IsHierarchical_Always_Expanded(*rc\trow)
		EndIf
		If *rc\check
			*rc\trow\checked=Bool(Not *rc\trow\checked)
			*this\dirty=#True
			If *rc\trow\checked			
				If *this\eventRowChangedChecked
					*this\eventRowChangedChecked(*rc\trow)
				EndIf
			Else
				If *this\eventRowChangedUnChecked
					*this\eventRowChangedUnChecked(*rc\trow)
				EndIf
			EndIf
			*this\md=#False
			redraw=#True
		ElseIf *rc\exp And Not alwaysexpanded
			
			
			*rc\trow\expanded=Bool(Not *rc\trow\expanded)
			*this\dirty=#True
			If *rc\trow\expanded
				If *this\eventRowChangedExpanded
					*this\eventRowChangedExpanded(*rc\trow)
				EndIf
			Else
				If *this\eventRowChangedCollapsed
					*this\eventRowChangedCollapsed(*rc\trow)
				EndIf
			EndIf
			_MyTable_Table_Predraw(*this)
			redraw=#True
			*this\md=#False
			
		Else
			
			If *rc\right And *rc\bottom
				*this\resizeCol=*rc\tcol
				*this\resizeRow=*rc\trow
			ElseIf *rc\right
				*this\resizeCol=*rc\tcol
			ElseIf *rc\bottom
				*this\resizeRow=*rc\trow
			Else
				If Not multiselect Or (Not shift And Not control) And (*rc\col>-1 Or *rc\row>-1)
					ClearMap(*this\selectedCells())
					ClearMap(*this\selectedRows())
					ClearMap(*this\selectedCols())
					*this\selectall=#False
					*this\lastcell=0
					*this\lastrow=0
					*this\lastcol=0
					*this\shiftcell=0
				EndIf
				If control
					*this\lastcell=0
					*this\lastrow=0
					*this\lastcol=0
					*this\shiftcell=0
				EndIf
				ClearMap(*this\tempselectedCells())
				ClearMap(*this\tempselectedRows())
				ClearMap(*this\tempselectedCols())
				_MyTableSelect(*this,*rc,#False)	
			EndIf
			redraw=#True
		EndIf
		
		FreeStructure(*rc)
	EndIf
	If redraw
		_MyTable_Table_Redraw(*this)
	EndIf
EndProcedure

Procedure _MyTableEvtCanvasMouseLeftUp()
	Protected *this.strMyTableTable=GetGadgetData(EventGadget())
	Protected shift.b=Bool(GetGadgetAttribute(*this\canvas,#PB_Canvas_Modifiers) & #PB_Canvas_Shift)
	Protected control.b=Bool(GetGadgetAttribute(*this\canvas,#PB_Canvas_Modifiers) & #PB_Canvas_Control)
	
	Protected multiselect.b=_MyTable_IsMultiselect(*this)
	
	*this\md=#False
	*this\resizeCol=0
	*this\resizeRow=0
	If IsGadget(*this\canvas)
		Protected *rc.strMyTableRowCol=_MyTableGetRowCol(*this)
		If *rc\col>-1 And *rc\row>-1 And Not *rc\exp And Not *rc\check
			If multiselect
				ForEach *this\tempselectedCells()
					*this\selectedCells(MapKey(*this\tempselectedCells()))=*this\tempselectedCells()
					If *this\eventCellSelected
						*this\eventCellSelected(Val(MapKey(*this\tempselectedCells())))
					EndIf
				Next
				ForEach *this\tempselectedCols()
					*this\selectedCols(MapKey(*this\tempselectedCols()))=*this\tempselectedCols()
					If *this\eventColSelected
						*this\eventColSelected(Val(MapKey(*this\tempselectedCols())))
					EndIf
				Next			
				ForEach *this\tempselectedRows()
					*this\selectedRows(MapKey(*this\tempselectedRows()))=*this\tempselectedRows()						
					If *this\eventRowSelected
						*this\eventRowSelected(Val(MapKey(*this\tempselectedRows())))
					EndIf
				Next
				If Not *rc\bottom And Not *rc\right
					_MyTableSelect(*this,*rc,#False)	
				EndIf
			EndIf
			ClearMap(*this\tempselectedCells())
			ClearMap(*this\tempselectedRows())
			ClearMap(*this\tempselectedCols())
			
			_MyTable_Table_Redraw(*this)
		EndIf
		FreeStructure(*rc)
	EndIf
EndProcedure

Procedure _MyTableEvtCanvasMouseLeftDouble()
	Protected *this.strMyTableTable=GetGadgetData(EventGadget())
	_MyTable_StopEdit(*this,#True)
	Protected Fullrowselect.b=_MyTable_IsFullrowselect(*this)
	
	If IsGadget(*this\canvas)
		Protected *rc.strMyTableRowCol=_MyTableGetRowCol(*this)
		If *rc\bottom And *rc\right
			_MyTable_Cell_Autosize(*rc\tcell)
		ElseIf *rc\bottom
			_MyTable_Row_Autosize(*rc\trow)
		ElseIf *rc\right
			_MyTable_Col_Autosize(*rc\tcol)
		Else
			
			If *rc\tcell And Not Fullrowselect
				If *this\eventCellLeftDoubleClick
					If Not *this\eventCellLeftDoubleClick(*rc\tcell)
						_MyTable_StartEdit(*rc)
					EndIf
				Else					
					_MyTable_StartEdit(*rc)
				EndIf
			Else
				If *this\eventCellLeftDoubleClick And *rc\tcell
					*this\eventCellLeftDoubleClick(*rc\tcell)
				ElseIf *this\eventRowLeftDoubleClick And *rc\trow
					*this\eventRowLeftDoubleClick(*rc\trow)
				ElseIf *this\eventColLeftDoubleClick And *rc\tcol			
					*this\eventColLeftDoubleClick(*rc\tcol)
				EndIf		
			EndIf		
			
		EndIf
		FreeStructure(*rc)
	EndIf
EndProcedure

Procedure _MyTableEvtCanvasMouseRightDown()
	Protected *this.strMyTableTable=GetGadgetData(EventGadget())
	_MyTable_StopEdit(*this,#True)
	If IsGadget(*this\canvas)
		Protected *rc.strMyTableRowCol=_MyTableGetRowCol(*this)
		
		FreeStructure(*rc)
	EndIf
EndProcedure

Procedure _MyTableEvtCanvasMouseRightUp()
	Protected *this.strMyTableTable=GetGadgetData(EventGadget())
	_MyTable_StopEdit(*this,#True)
	If IsGadget(*this\canvas)
		Protected *rc.strMyTableRowCol=_MyTableGetRowCol(*this)
		
		FreeStructure(*rc)
	EndIf
EndProcedure

Procedure _MyTableEvtCanvasMouseRightDouble()
	Protected *this.strMyTableTable=GetGadgetData(EventGadget())
	_MyTable_StopEdit(*this,#True)
	If IsGadget(*this\canvas)
		Protected *rc.strMyTableRowCol=_MyTableGetRowCol(*this)
		
		If Not *rc\bottom And Not *rc\check And Not *rc\exp And Not *rc\right
			If *this\eventCellRightDoubleClick And *rc\tcell
				*this\eventCellRightDoubleClick(*rc\tcell)
			ElseIf *this\eventRowRightDoubleClick And *rc\trow
				*this\eventRowRightDoubleClick(*rc\trow)
			ElseIf *this\eventColRightDoubleClick And *rc\tcol
				*this\eventColRightDoubleClick(*rc\tcol)
			EndIf		
		EndIf
		FreeStructure(*rc)
	EndIf
EndProcedure

Procedure _MyTableEvtCanvasMouseRightClick()
	Protected *this.strMyTableTable=GetGadgetData(EventGadget())
	_MyTable_StopEdit(*this,#True)
	If IsGadget(*this\canvas)
		Protected *rc.strMyTableRowCol=_MyTableGetRowCol(*this)
		
		If Not *rc\bottom And Not *rc\check And Not *rc\exp And Not *rc\right
			If *this\eventCellRightClick And *rc\tcell
				*this\eventCellRightClick(*rc\tcell)
			ElseIf *this\eventRowRightClick And *rc\trow
				*this\eventRowRightClick(*rc\trow)
			ElseIf *this\eventColRightClick And *rc\tcol
				*this\eventColRightClick(*rc\tcol)
			EndIf		
		EndIf
		
		FreeStructure(*rc)
	EndIf
EndProcedure

Procedure _MyTableEvtCanvasMouseLeftClick()
	Protected *this.strMyTableTable=GetGadgetData(EventGadget())
	If IsGadget(*this\canvas)
		Protected *rc.strMyTableRowCol=_MyTableGetRowCol(*this)
		
		If Not *rc\bottom And Not *rc\check And Not *rc\exp And Not *rc\right
			If *this\eventCellLeftClick And *rc\tcell
				*this\eventCellLeftClick(*rc\tcell)
			ElseIf *this\eventRowLeftClick And *rc\trow
				*this\eventRowLeftClick(*rc\trow)
			ElseIf *this\eventColLeftClick And *rc\tcol
				*this\eventColLeftClick(*rc\tcol)
			EndIf		
		EndIf
		
		FreeStructure(*rc)
	EndIf
EndProcedure

Procedure _MyTableEvtCanvasScroll()
	Protected *this.strMyTableTable=GetGadgetData(EventGadget())
	_MyTable_StopEdit(*this,#True)
	Protected mw=GetGadgetAttribute(*this\canvas,#PB_Canvas_WheelDelta)
	If mw
		
		If IsGadget(*this\vscroll)
			SetGadgetState(*this\vscroll,GetGadgetState(*this\vscroll)-DesktopScaledY(mw))	
		Else
			*this\vscroll-DesktopScaledY(mw)
			If *this\vscroll>*this\maxvscroll
				*this\vscroll=0
			ElseIf *this\vscroll<0
				*this\vscroll=0
			EndIf
		EndIf
		*this\dirty=#True			
		_MyTable_Table_Redraw(*this)
	EndIf
	
EndProcedure



Procedure _MyTableInitTable(*table.strMyTableTable,
                            window.i,
                            canvas.i,
                            vscroll.i,
                            hscroll.i,
                            flags.i)
	
	AddElement(gadgets())
	UnbindEvent(#PB_Event_Repaint,@_MyTable_WinRepaint(),window)
	BindEvent(#PB_Event_Repaint,@_MyTable_WinRepaint(),window)
	gadgets()=*table
	With *table
		\flags=flags
		If _MyTable_IsGrid(*table)
			\vtable=?vtable_grid
			\type=My::#MY_TYPE_GRID
			\datagrid=#True
		ElseIf _MyTable_IsHierarchical(*table)
			\vtable=?vtable_tree
			\type=My::#MY_TYPE_TREE
			\datagrid=#False
		Else
			\vtable=?vtable_table
			\type=My::#MY_TYPE_TABLE
			\datagrid=#False
		EndIf
		
		
		\redraw=_MyTable_IsRedraw(*table)
		\recalc=#True
		\dirty=#True
		\window=window
		\canvas=canvas
		\vscroll=vscroll
		\hscroll=hscroll
		\defaultrowheight=20
		\calcdefaultrowheight=DesktopScaledY(\defaultrowheight)
		\headerheight=20
		\defaultheaderheight=20
		\calcdefaultheaderheight=20
		\calcheaderheight=DesktopScaledY(\headerheight)
		\calcdefaultheaderheight=DesktopScaledY(\defaultheaderheight)
		\DefaultImageSortAsc=tMyTableDefaultImageSortAsc
		\DefaultImageSortDesc=tMyTableDefaultImageSortDesc
		\DefaultImagePlus=tMyTableDefaultImagePlus
		\DefaultImageMinus=tMyTableDefaultImageMinus
		\DefaultImageCheckBox=tMyTableDefaultImageCheckBox
		\DefaultImageCheckBoxChecked=tMyTableDefaultImageCheckBoxChecked
		\DefaultImagePlusArrow=tMyTableDefaultImagePlusArrow
		\DefaultImageMinusArrow=tMyTableDefaultImageMinusArrow
		\pageElements=100
		\titleHeight=20
		\calctitleHeight=DesktopScaledY(\titleHeight)
		
		If IsGadget(canvas)
			SetGadgetData(canvas,*table)
			UnbindEvent(#PB_Event_MoveWindow,@_MyTableEvtMove(),window)
			BindEvent(#PB_Event_MoveWindow,@_MyTableEvtMove(),window)
			BindGadgetEvent(canvas,@_MyTableEvtResize(),#PB_EventType_Resize)
			BindGadgetEvent(canvas,@_MyTableEvtCanvasScroll(),#PB_EventType_MouseWheel)
			BindGadgetEvent(canvas,@_MyTableEvtCanvasMouseMove(),#PB_EventType_MouseMove)
			BindGadgetEvent(canvas,@_MyTableEvtCanvasMouseLeftDown(),#PB_EventType_LeftButtonDown)
			BindGadgetEvent(canvas,@_MyTableEvtCanvasMouseLeftUp(),#PB_EventType_LeftButtonUp)
			BindGadgetEvent(canvas,@_MyTableEvtCanvasMouseLeftDouble(),#PB_EventType_LeftDoubleClick)
			BindGadgetEvent(canvas,@_MyTableEvtCanvasMouseLeftClick(),#PB_EventType_LeftClick)
			BindGadgetEvent(canvas,@_MyTableEvtCanvasMouseRightDown(),#PB_EventType_RightButtonDown)
			BindGadgetEvent(canvas,@_MyTableEvtCanvasMouseRightUp(),#PB_EventType_RightButtonUp)
			BindGadgetEvent(canvas,@_MyTableEvtCanvasMouseRightDouble(),#PB_EventType_RightDoubleClick)
			BindGadgetEvent(canvas,@_MyTableEvtCanvasMouseRightClick(),#PB_EventType_RightClick)
			BindGadgetEvent(canvas,@_MyTableEvtCanvasKeyDown(),#PB_EventType_KeyDown)
			BindGadgetEvent(canvas,@_MyTableEvtCanvasKeyUp(),#PB_EventType_KeyUp)	
			BindGadgetEvent(canvas,@_MyTableEvtCanvasGotFocus(),#PB_EventType_Focus)	
			BindGadgetEvent(canvas,@_MyTableEvtCanvasLostFocus(),#PB_EventType_LostFocus)	
			MyTableWindowTables(Str(*table))=window
		EndIf
		If IsGadget(vscroll)
			SetGadgetData(vscroll,*table)
			BindGadgetEvent(vscroll,@_MyTableEvtScroll())
			SetGadgetAttribute(vscroll,#PB_ScrollBar_PageLength,GadgetHeight(canvas))
		EndIf
		If IsGadget(hscroll)
			SetGadgetData(hscroll,*table)
			BindGadgetEvent(hscroll,@_MyTableEvtScroll())
			SetGadgetAttribute(hscroll,#PB_ScrollBar_PageLength,GadgetWidth(canvas))
		EndIf
		
		
		_MyTableInitStyles(*table)		
		
	EndWith
	
	_MyTableEvtResizeExp(*table)
EndProcedure

Procedure _MyTableInitTree(*table.strMyTableTable,
                           window.i,
                           canvas.i,
                           vscroll.i,
                           hscroll.i,
                           flags.i)
	_MyTableInitTable(*table,
	                  window,
	                  canvas,
	                  vscroll,
	                  hscroll,
	                  flags|#MYTABLE_TABLE_FLAGS_HIERARCHICAL)
EndProcedure

Procedure _MyTableInitGrid(*table.strMyTableTable,
                           window.i,
                           canvas.i,
                           vscroll.i,
                           hscroll.i,
                           rows.i,
                           cols.i,
                           flags.i)
	_MyTableInitTable(*table,
	                  window,
	                  canvas,
	                  vscroll,
	                  hscroll,
	                  flags|#MYTABLE_TABLE_FLAGS_GRID)
	Protected redraw.b=*table\redraw
	*table\redraw=#False
	Protected *col.strMyTableCol=_MyTable_Table_AddCol(*table,"",100,0,#MYTABLE_COL_FLAGS_NO_RESIZABLE|#MYTABLE_COL_FLAGS_NO_EDITABLE)
	*table\fixedcols=1
	_MyTable_Grid_ResizeGrid(*table,rows,cols)
	_MyTable_Col_Autosize(*col)
	*table\redraw=redraw
EndProcedure

Procedure _MyTableInitRow(*table.strMyTableTable,
                          *parent.strMyTableRow,
                          *row.strMyTableRow,
                          text.s,
                          sep.s,
                          *image.MyImage::MyImage,
                          flags.i)
	
	With *row
		\vtable=?vtable_row
		\type=My::#MY_TYPE_ROW
		\flags=flags			
		\main=*table
		\parent=*parent
		\dirty=#True
		\height=*table\defaultrowheight
		\calcheight=*table\calcdefaultrowheight
		\image=*image
		\expanded=_MyTable_IsHierarchical_Always_Expanded(*table)
		If text<>""
			Protected c=CountString(text,sep)+1
			Protected idx=0
			For idx=1 To c
				Protected *cell.strMyTableCell=_MyTableGetOrAddCell(*row,idx-1,#True)
				_MyTable_Cell_SetText(*cell,StringField(text,idx,sep))				
			Next
		EndIf
		If *parent
			\level=*parent\level+1
			\listindex=ListSize(*parent\rows\rows())-1
		Else
			\listindex=ListSize(*table\rows())-1
		EndIf
	EndWith
	
	
EndProcedure

Procedure _MyTableInitCol(*table.strMyTableTable,
                          *col.strMyTableCol,
                          text.s,
                          width.i,
                          *image.MyImage::MyImage,
                          flags.i)
	
	
	With *col
		\vtable=?vtable_col
		\type=My::#MY_TYPE_COL
		\flags=flags
		\main=*table
		\dirty=#True
		\text=text
		\width=width
		\image=*image
		\sort=#MYTABLE_COL_SORT_NONE
		\datatype=#MYTABLE_DATATYPE_DEFAULT
		If width=#PB_Ignore
			\stretched=#True
		EndIf
		\defaultStyle\forecolor=RGBA(250,250,250,255)
		\defaultStyle\backcolor=RGBA(150,150,150,255)
		\defaultStyle\border\borderDefault\color=RGBA(250,250,250,255)
		\defaultStyle\border\borderDefault\width=1
		\defaultStyle\border\border=#MYTABLE_STYLE_BORDER_ALL
		
		\disabledStyle\forecolor=RGBA(250,250,250,255)
		\disabledStyle\backcolor=RGBA(150,150,150,255)
		\disabledStyle\border\borderDefault\color=RGBA(250,250,250,255)
		\disabledStyle\border\borderDefault\width=1
		\disabledStyle\border\border=#MYTABLE_STYLE_BORDER_ALL
		
		\selectedStyle\forecolor=RGBA(250,250,250,255)
		\selectedStyle\backcolor=RGBA(100,100,100,255)
		\selectedStyle\border\borderDefault\width=1
		\selectedStyle\border\border=#MYTABLE_STYLE_BORDER_ALL
		
		
		\calcwidth=DesktopScaledX(\width)
		\listindex=ListSize(*table\cols())-1
		If \main\datagrid And text="" And \listindex>0
			\text=_MyTableGridColumnName(ListSize(*table\cols())-1)
			\defaultStyle\halign=#MYTABLE_STYLE_HALIGN_CENTER
		ElseIf \main\datagrid And text="" And \listindex=0
			\text=""
			\defaultStyle\halign=#MYTABLE_STYLE_HALIGN_RIGHT
			\datatype=#MYTABLE_DATATYPE_NUMBER
		EndIf
	EndWith
	
	
EndProcedure



Procedure _MyTableInitCell(*table.strMyTableTable,
                           *row.strMyTableRow,
                           *col.strMyTableCol,
                           *parent.strMyTableCell,
                           *cell.strMyTableCell,
                           flags.i)
	With *cell
		\vtable=?vtable_cell
		\type=My::#MY_TYPE_CELL
		\flags=flags
		\main=*table
		\parent=*parent
		\row=*row
		\col=*col
		\dirty=#True
		\defaultStyle\font=\row\defaultStyle\font
		\defaultStyle\backcolor=\row\defaultStyle\backcolor
		\defaultStyle\frontcolor=\row\defaultStyle\frontcolor
		\defaultStyle\forecolor=\row\defaultStyle\forecolor				
		\datatype=*cell\col\datatype
		\defaultStyle\border\border=#MYTABLE_STYLE_BORDER_ALL
		\mask=*cell\col\mask
		If *parent
			\listindex=ListSize(*parent\cells\cells())-1
		Else
			\listindex=ListSize(*row\cells\cells())-1
		EndIf
	EndWith
	
EndProcedure



Procedure _MyTableGetOrAddCell(*row.strMyTableRow,idx.i,force.b)
	If *row
		Protected tidx=idx
		If *row\main\datagrid And Not force
			tidx+1
		EndIf
		
		If ListSize(*row\main\cols())>tidx
			Protected *col.strMyTableCol=SelectElement(*row\main\cols(),tidx)
			Protected *cell.strMyTableCell=0
			If Not *row\cells
				*row\cells=AllocateStructure(strMyTableCellList)
			EndIf
			While ListSize(*row\cells\cells())<=tidx
				LastElement(*row\cells\cells())
				*cell=AddElement(*row\cells\cells())
				_MyTableInitCell(*row\main,*row,*col,0,*cell,0)
			Wend
			If *cell
				ProcedureReturn *cell
			Else
				ProcedureReturn SelectElement(*row\cells\cells(),tidx)
			EndIf
		EndIf
	EndIf
EndProcedure



Procedure.b _MyTable_IsDisabled(*obj.strMyTableObject)
	Protected result.b=*obj\disabled
	If Not result
		Select *obj\type
			Case My::#MY_TYPE_CELL
				Protected *cell.strMyTableCell=*obj
				result=Bool(_MyTable_IsDisabled(*cell\col) Or _MyTable_IsDisabled(*cell\row))
			Case My::#MY_TYPE_ROW
				Protected *row.strMyTableRow=*obj
				result=_MyTable_IsDisabled(*row\main)	
			Case My::#MY_TYPE_COL
				Protected *col.strMyTableCol=*obj
				result=_MyTable_IsDisabled(*col\main)
			Case My::#MY_TYPE_TABLE,My::#MY_TYPE_TREE,My::#MY_TYPE_GRID
				Protected *table.strMyTableTable=*obj
		EndSelect
	EndIf
	ProcedureReturn result
EndProcedure


Procedure _MyTable_StopEdit(*this.strMyTableTable,save.b)
	If *this
		If IsWindow(*this\edit\window)
			If save
				With *this\edit\cell
					Protected old.s=\text
					_MyTable_Cell_SetText(*this\edit\cell,GetGadgetText(*this\edit\gadget))					
					If \main\eventCellChangedText
						\main\eventCellChangedText(*this\edit\cell,old)
					EndIf
				EndWith
			EndIf
			CloseWindow(*this\edit\window)
			*this\edit\window=0
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_KeyEdit()
	Protected *this.strMyTableTable=GetWindowData(EventWindow())
	With *this\edit\cell
		If \text<>GetGadgetText(*this\edit\gadget)
			_MyTable_StopEdit(*this,#True)
		Else
			_MyTable_StopEdit(*this,#False)
		EndIf
	EndWith
	_MyTable_StopEdit(*this,#True)
EndProcedure

Procedure _MyTableEditSetPos(Gadget, Position)
	CompilerSelect #PB_Compiler_OS
		CompilerCase #PB_OS_Windows
			SendMessage_(GadgetID(Gadget), #EM_SETSEL, Position, Position)
	CompilerEndSelect
EndProcedure

Procedure _MyTable_StartEditCell(*cell.strMyTableCell)
	If *cell
		Protected *this.strMyTableTable=*cell\main
		
		Protected editable.b=_MyTable_IsEditable(*cell)		
		Protected disabled.b=_MyTable_IsDisabled(*cell)		
		
		If editable And Not disabled
			Protected custom.b=#False
			If *this\eventCustomCellEdit
				custom=*this\eventCustomCellEdit(*cell,
				                                 GadgetX(*this\canvas,#PB_Gadget_ScreenCoordinate)+*cell\startx,
				                                 GadgetY(*this\canvas,#PB_Gadget_ScreenCoordinate)+*cell\starty,
				                                 *cell\col\calcwidth,
				                                 *cell\row\calcheight)
			EndIf
			If Not custom
				_MyTable_StopEdit(*this,#True)
				
				*this\edit\window=OpenWindow(#PB_Any,
				                             GadgetX(*this\canvas,#PB_Gadget_ScreenCoordinate)+DesktopUnscaledX(*cell\startx),
				                             GadgetY(*this\canvas,#PB_Gadget_ScreenCoordinate)+DesktopUnscaledY(*cell\starty),
				                             DesktopUnscaledX(*cell\col\calcwidth),
				                             DesktopUnscaledY(*cell\row\calcheight),
				                             "",
				                             #PB_Window_BorderLess,
				                             WindowID(*this\window))
				
				*this\edit\menu=CreateMenu(#PB_Any,WindowID(*this\edit\window))
				AddKeyboardShortcut(*this\edit\window,#PB_Shortcut_Return,0)
				BindMenuEvent(*this\edit\menu,0,@_MyTable_KeyEdit())
				*this\edit\gadget=EditorGadget(#PB_Any,
				                               0,
				                               0,
				                               *cell\col\calcwidth,
				                               *cell\row\calcheight)
				*this\edit\cell=*cell
				SetGadgetText(*this\edit\gadget,*cell\text)
				SetActiveGadget(*this\edit\gadget)
				SetGadgetData(*this\edit\gadget,*this)
				SetWindowData(*this\edit\window,*this)
				_MyTableEditSetPos(*this\edit\gadget,Len(*cell\text))
			EndIf
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_StartEdit(*rc.strMyTableRowCol)
	If *rc
		_MyTable_StartEditCell(*rc\tcell)
	EndIf
EndProcedure


_MyTable_IsTableNoGrid(Hierarchical)
_MyTable_IsTableCellColRowNo(Checkboxes)
_MyTable_IsTableColNo(Sortable)
_MyTable_IsTableRowColNo(Resizable)
_MyTable_IsTable(Title)
_MyTable_IsTable(Pages)
_MyTable_IsTableAllNo(Editable)
_MyTable_IsTable(Zebra)
_MyTable_IsTable(Grid)
_MyTable_IsTable(Callback)
_MyTable_IsTable(Border)
_MyTable_IsTable(Multiselect)
_MyTable_IsTable(Fullrowselect)
_MyTable_IsTable(Mark_Mouse_Over)
_MyTable_IsTableRow(Hierarchical_Always_Expanded)
_MyTable_IsTable(Element_Selected)

_MyTable_IsTableNo(Header)
_MyTable_IsTableNo(Redraw)


_MyTable_StylesMethods(Default);}
_MyTable_StylesMethods(Selected)
_MyTable_StylesMethods(Fixed)
_MyTable_StylesMethods(Empty)
_MyTable_StylesMethods(Title)
_MyTable_StylesMethods(ElementSelected)
_MyTable_StylesMethods(MouseOver)
_MyTable_StylesMethods(Zebra)
_MyTable_StylesMethods(Disabled)