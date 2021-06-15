Procedure MyTableCreateApplication(flags.i=0)
	Protected *this.strMyTableApplication=AllocateStructure(strMyTableApplication)
	_MyTableInitApplication(*this,flags)
	ProcedureReturn *this
EndProcedure

Procedure MyTableCreateTable(window.i,canvas.i,vscroll.i,hscroll.i,flags.i=#MYTABLE_TABLE_FLAGS_DEFAULT_TABLE)
	Protected *this.strMyTableTable=AllocateStructure(strMyTableTable)
	_MyTableInitTable(0,*this,window,canvas,vscroll,hscroll,flags)
	ProcedureReturn *this
EndProcedure

Procedure  _MyTableInitStyleTable(*style.strMyTableStyle)
	With *style
		\font=GetGadgetFont(#PB_Default)
		\backcolor=RGBA(250,250,250,255)
		\frontcolor=RGBA(230,230,230,255)
		\forecolor=RGBA(50,50,50,255)
		\border\borderDefault\color=RGBA(50,50,50,255)		
		\border\borderDefault\width=1
	EndWith
EndProcedure

Procedure  _MyTableInitStyleTableSelected(*style.strMyTableStyle)
	With *style
		\backcolor=RGBA(230,230,250,255)
		\forecolor=RGBA(20,20,20,255)
		\border\borderDefault\color=RGBA(200,200,250,255)
	EndWith
EndProcedure

Procedure  _MyTableInitStyleTableMouseOver(*style.strMyTableStyle)
	With *style
		\backcolor=RGBA(100,100,120,255)
		\forecolor=RGBA(20,20,20,255)
		\border\borderDefault\color=RGBA(200,200,250,255)
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
	EndWith
EndProcedure

Procedure _MyTableInitStyleObject(*style.strMyTableStyleObject,*this.strMyTableObject)
	With *style
		Select *this\type
			Case #MYTABLE_TYPE_APPLICATION
				\vtable=?vtable_style_application
			Case #MYTABLE_TYPE_CELL
				\vtable=?vtable_style_cell
			Case #MYTABLE_TYPE_COL
				\vtable=?vtable_style_col
			Case #MYTABLE_TYPE_ROW
				\vtable=?vtable_style_row
			Case #MYTABLE_TYPE_TABLE
				\vtable=?vtable_style_table
		EndSelect
		\type=#MYTABLE_TYPE_STYLE
		\obj=*this
	EndWith
EndProcedure

Procedure _MyTableInitApplication(*application.strMyTableApplication,
                                  flags.i)
	With *application
		\vtable=?vtable_application
		\type=#MYTABLE_TYPE_APPLICATION
		\flags=flags
		\recalc=#True
		\redraw=#True
		\dirty=#True
		_MyTableInitStyleTable(\defaultStyle)
		_MyTableInitStyleTableFixed(\fixedStyle)		
		_MyTableInitStyleTableSelected(\selectedStyle)
		_MyTableInitStyleTableTitle(\titleStyle)
		_MyTableInitStyleTableMouseOver(\mouseoverStyle)
	EndWith
EndProcedure

Procedure _MyTableEvtScroll()
	Protected *this.strMyTableTable=GetGadgetData(EventGadget())
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
	*this\dirty=#True
	_MyTable_Table_Predraw(*this)
	_MyTable_Table_Redraw(*this)
EndProcedure


Procedure _MyTableEvtResize()
	Protected *this.strMyTableTable=GetGadgetData(EventGadget())
	_MyTableEvtResizeExp(*this)
EndProcedure

Procedure _MyTableGetRowCol(*this.strMyTableTable)
	Protected checkboxes.b=Bool(*this\flags & #MYTABLE_TABLE_FLAGS_CHECKBOXES)
	Protected hierarchical.b=Bool(*this\flags & #MYTABLE_TABLE_FLAGS_HIERARCHICAL)
	Protected resizable.b=Bool(*this\flags & #MYTABLE_TABLE_FLAGS_RESIZABLE)
	Protected title.b=Bool(*this\flags & #MYTABLE_TABLE_FLAGS_TITLE)
	Protected header.b=Bool(Not Bool(*this\flags & #MYTABLE_TABLE_FLAGS_NO_HEADER))
	Protected alwaysexpanded.b=Bool(*this\flags & #MYTABLE_TABLE_FLAGS_HIERARCHICAL_ALWAYS_EXPANDED)
	
	Protected *row.strMyTableRow=0
	Protected *cell.strMyTableCell=0
	Protected mx=GetGadgetAttribute(*this\canvas,#PB_Canvas_MouseX)
	Protected my=GetGadgetAttribute(*this\canvas,#PB_Canvas_MouseY)
	Protected vsc=0
	Protected hsc=0
	Protected *rc.strMyTableRowCol=AllocateStructure(strMyTableRowCol)
	*rc\col=-2
	*rc\row=-2
	
	If IsGadget(*this\vscroll)
		vsc=-GetGadgetState(*this\vscroll)
	Else
		vsc=-*this\vscroll
	EndIf
	
	If IsGadget(*this\hscroll)
		hsc=-GetGadgetState(*this\hscroll)
	Else
		hsc=-*this\hscroll
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
		Protected colresize.b=Bool(resizable Or *col\flags & #MYTABLE_COL_FLAGS_RESIZABLE)
		colresize=Bool(colresize And Not Bool(*col\flags & #MYTABLE_COL_FLAGS_NO_RESIZABLE))
		
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
	Next
	
	
	If *rc\row=-2	
		ForEach *this\expRows()
			*row=*this\expRows()
			Protected rowresize.b=Bool(resizable Or *row\flags & #MYTABLE_ROW_FLAGS_RESIZABLE)
			rowresize=Bool(rowresize And Not Bool(*row\flags & #MYTABLE_ROW_FLAGS_NO_RESIZABLE))
			
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
	EndIf
	
	If *rc\row>-1 And *rc\col>-1
		If Not *rc\trow
			SelectElement(*this\expRows(),*rc\row)
			*rc\trow=*this\expRows()
		EndIf
		*rc\tcell=_MyTableGetOrAddCell(*rc\trow,*rc\col)
		If Not *rc\tcol
			*rc\tcol=*rc\tcell\col
		EndIf
	EndIf
	
	If *rc\row>-1 And *rc\col=0
		If hierarchical Or checkboxes
			Protected ex=*row\level*MyTableW20
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

Procedure _MyTableEvtCanvasKeyDown()
	Protected *this.strMyTableTable=GetGadgetData(EventGadget())
	If IsGadget(*this\canvas)
		Protected shift.b=Bool(GetGadgetAttribute(*this\canvas,#PB_Canvas_Modifiers) & #PB_Canvas_Shift)
		Protected control.b=Bool(GetGadgetAttribute(*this\canvas,#PB_Canvas_Modifiers) & #PB_Canvas_Control)
		Protected alt.b=Bool(GetGadgetAttribute(*this\canvas,#PB_Canvas_Modifiers) & #PB_Canvas_Alt)
		Protected key=GetGadgetAttribute(*this\canvas,#PB_Canvas_Key)
		Select key
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

Procedure _MyTableSelect(*this.strMyTableTable,*rc.strMyTableRowCol,temp.b)
	Protected multiselect.b=Bool(*this\flags & #MYTABLE_TABLE_FLAGS_MULTISELECT)
	
	Protected fullrow.b=Bool(*this\flags & #MYTABLE_TABLE_FLAGS_FULLROWSELECT)
	Protected shift.b=Bool(GetGadgetAttribute(*this\canvas,#PB_Canvas_Modifiers) & #PB_Canvas_Shift)
	Protected control.b=Bool(GetGadgetAttribute(*this\canvas,#PB_Canvas_Modifiers) & #PB_Canvas_Control)
	Protected sortable.b=Bool(*this\flags & #MYTABLE_TABLE_FLAGS_SORTABLE)
	
	Protected rf,rt,cf,ct,r,c
	
	If *rc\row=-1 And *rc\col>-1
		If Not *this\resizeCol			
			Protected *tcol.strMyTableCol=*rc\tcol
			If *tcol\parent
				*tcol=*tcol\parent
			EndIf
			sortable=Bool(sortable Or Bool(*tcol\flags & #MYTABLE_COL_FLAGS_SORTABLE))
			sortable=Bool(sortable And Not Bool(*tcol\flags & #MYTABLE_COL_FLAGS_NO_SORTABLE))
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
			EndIf			
		EndIf			
		ProcedureReturn 0
	Else
		If fullrow
			If *rc\row>-1 And *rc\col>-1
				
				If multiselect And 
				   (shift Or *this\md) And 
				   *rc\trow<>*this\lastrow And
				   *this\lastrow<>0 And 
				   *rc\trow\level=*this\lastrow\level And 
				   *rc\trow\parent=*this\lastrow\parent
					
					rf=-1
					rt=-1
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
							Protected *row.strMyTableRow=*this\expRows()
							If temp
								*this\tempselectedRows(Str(*row))=#True
							Else									
								If Not *this\selectedRows(Str(*row))
									If *this\eventRowSelected
										*this\eventRowSelected(*row)
									EndIf
								EndIf
								*this\selectedRows(Str(*row))=#True
							EndIf
						Next
					EndIf
				Else
					If temp
						*this\tempselectedRows(Str(*rc\trow))=#True
					Else
						*this\lastrow=*rc\trow							
						If Not *this\selectedRows(Str(*rc\trow))
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
								Protected *cell.strMyTablecell=_MyTableGetOrAddCell(*row,c)									
								If temp
									*this\tempselectedCells(Str(*cell))=#True
								Else										
									If Not *this\selectedCells(Str(*cell))
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
						If Not *this\selectedCells(Str(*rc\tcell))
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
	Protected *application.strMyTableApplication=0
	Protected result.s=*this\tooltip
	If result=""
		Select *this\type
			Case #MYTABLE_TYPE_APPLICATION
				*application=*this
			Case #MYTABLE_TYPE_TABLE
				*table=*this
				*application=*table\application
			Case #MYTABLE_TYPE_ROW
				*row=*this
				*table=*row\table
				*application=*table\application
			Case #MYTABLE_TYPE_COL
				*col=*this
				*table=*col\table
				*application=*table\application
			Case #MYTABLE_TYPE_CELL
				*cell=*this
				*table=*cell\table
				*application=*table\application
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
		If result="" And *application
			result=*application\tooltip			
		EndIf
	EndIf
	ProcedureReturn result
EndProcedure

Procedure _MyTableEvtCanvasMouseMove()
	Protected *this.strMyTableTable=GetGadgetData(EventGadget())
	Protected multiselect.b=Bool(*this\flags & #MYTABLE_TABLE_FLAGS_MULTISELECT)		
	Protected fullrow.b=Bool(*this\flags & #MYTABLE_TABLE_FLAGS_FULLROWSELECT)
	Protected markmouseover.b=Bool(*this\flags & #MYTABLE_TABLE_FLAGS_MARK_MOUSE_OVER)
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
				If *this\resizeRow\image\sized And *this\resizeRow\image\resize
					FreeImage(*this\resizeRow\image\sized)
					*this\resizeRow\image\sized=0
				EndIf
				If *this\resizeRow\cells
					ForEach *this\resizeRow\cells\cells()
						If *this\resizeRow\cells\cells()\imageLeft\sized And *this\resizeRow\cells\cells()\imageLeft\resize
							FreeImage(*this\resizeRow\cells\cells()\imageLeft\sized)
							*this\resizeRow\cells\cells()\imageLeft\sized=0
						EndIf
					Next
					ForEach *this\resizeRow\cells\cells()
						If *this\resizeRow\cells\cells()\imageRight\sized And *this\resizeRow\cells\cells()\imageRight\resize
							FreeImage(*this\resizeRow\cells\cells()\imageRight\sized)
							*this\resizeRow\cells\cells()\imageRight\sized=0
						EndIf
					Next
				EndIf
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
				*this\dirty=#True
				*this\mvcell=*rc\tcell
				*this\mvcol=*rc\tcol
				*this\mvrow=*rc\trow
				_MyTable_Table_Redraw(*this)
			EndIf				
		EndIf
		
		FreeStructure(*rc)
	EndIf
EndProcedure

Procedure _MyTableEvtCanvasMouseLeftDown()
	Protected *this.strMyTableTable=GetGadgetData(EventGadget())
	Protected multiselect.b=Bool(*this\flags & #MYTABLE_TABLE_FLAGS_MULTISELECT)		
	Protected fullrow.b=Bool(*this\flags & #MYTABLE_TABLE_FLAGS_FULLROWSELECT)
	Protected shift.b=Bool(GetGadgetAttribute(*this\canvas,#PB_Canvas_Modifiers) & #PB_Canvas_Shift)
	Protected control.b=Bool(GetGadgetAttribute(*this\canvas,#PB_Canvas_Modifiers) & #PB_Canvas_Control)
	Protected alwaysexpanded.b=Bool(*this\flags & #MYTABLE_TABLE_FLAGS_HIERARCHICAL_ALWAYS_EXPANDED)
	
	Protected redraw.b=#False
	*this\md=#True
	If IsGadget(*this\canvas)
		Protected *rc.strMyTableRowCol=_MyTableGetRowCol(*this)
		
		*this\myd=GetGadgetAttribute(*this\canvas,#PB_Canvas_MouseY)
		*this\mxd=GetGadgetAttribute(*this\canvas,#PB_Canvas_MouseX)
		If *rc\trow
			alwaysexpanded=Bool(alwaysexpanded Or Bool(*rc\trow\flags & #MYTABLE_ROW_FLAGS_HIERARCHICAL_ALWAYS_EXPANDED))
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
				If Not multiselect Or (Not shift And Not control) And *rc\col>-1 And *rc\row>-1
					ClearMap(*this\selectedCells())
					ClearMap(*this\selectedRows())
					ClearMap(*this\selectedCols())
					*this\selectall=#False
					*this\lastcell=0
					*this\lastrow=0
					*this\lastcol=0
				EndIf
				If control
					*this\lastcell=0
					*this\lastrow=0
					*this\lastcol=0
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
	Protected multiselect.b=Bool(*this\flags & #MYTABLE_TABLE_FLAGS_MULTISELECT)	
	
	*this\md=#False
	*this\resizeCol=0
	*this\resizeRow=0
	If IsGadget(*this\canvas)
		Protected *rc.strMyTableRowCol=_MyTableGetRowCol(*this)
		If *rc\col>-1 And *rc\row>-1 And Not *rc\exp And Not *rc\check
			If multiselect
				ForEach *this\tempselectedCells()
					*this\selectedCells(MapKey(*this\tempselectedCells()))=*this\tempselectedCells()
				Next
				ForEach *this\tempselectedCols()
					*this\selectedCols(MapKey(*this\tempselectedCols()))=*this\tempselectedCols()
				Next			
				ForEach *this\tempselectedRows()
					*this\selectedRows(MapKey(*this\tempselectedRows()))=*this\tempselectedRows()						
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
	If IsGadget(*this\canvas)
		Protected *rc.strMyTableRowCol=_MyTableGetRowCol(*this)
		If *rc\bottom And *rc\right
			_MyTable_Cell_Autosize(*rc\tcell)
		ElseIf *rc\bottom
			_MyTable_Row_Autosize(*rc\trow)
		ElseIf *rc\right
			_MyTable_Col_Autosize(*rc\tcol)
		Else
			
			If *this\eventCellLeftDoubleClick And *rc\tcell
				*this\eventCellLeftDoubleClick(*rc\tcell)
			EndIf
			If *this\eventRowLeftDoubleClick And *rc\trow
				*this\eventRowLeftDoubleClick(*rc\trow)
			EndIf		
			
		EndIf
		FreeStructure(*rc)
	EndIf
EndProcedure

Procedure _MyTableEvtCanvasMouseRightDown()
	Protected *this.strMyTableTable=GetGadgetData(EventGadget())
	If IsGadget(*this\canvas)
		Protected *rc.strMyTableRowCol=_MyTableGetRowCol(*this)
		
		FreeStructure(*rc)
	EndIf
EndProcedure

Procedure _MyTableEvtCanvasMouseRightUp()
	Protected *this.strMyTableTable=GetGadgetData(EventGadget())
	If IsGadget(*this\canvas)
		Protected *rc.strMyTableRowCol=_MyTableGetRowCol(*this)
		
		FreeStructure(*rc)
	EndIf
EndProcedure

Procedure _MyTableEvtCanvasMouseRightDouble()
	Protected *this.strMyTableTable=GetGadgetData(EventGadget())
	If IsGadget(*this\canvas)
		Protected *rc.strMyTableRowCol=_MyTableGetRowCol(*this)
		
		If Not *rc\bottom And Not *rc\check And Not *rc\exp And Not *rc\right
			If *this\eventCellRightDoubleClick And *rc\tcell
				*this\eventCellRightDoubleClick(*rc\tcell)
			EndIf
			If *this\eventRowRightDoubleClick And *rc\trow
				*this\eventRowRightDoubleClick(*rc\trow)
			EndIf		
		EndIf
		FreeStructure(*rc)
	EndIf
EndProcedure

Procedure _MyTableEvtCanvasMouseRightClick()
	Protected *this.strMyTableTable=GetGadgetData(EventGadget())
	If IsGadget(*this\canvas)
		Protected *rc.strMyTableRowCol=_MyTableGetRowCol(*this)
		
		If Not *rc\bottom And Not *rc\check And Not *rc\exp And Not *rc\right
			If *this\eventCellRightClick And *rc\tcell
				*this\eventCellRightClick(*rc\tcell)
			EndIf
			If *this\eventRowRightClick And *rc\trow
				*this\eventRowRightClick(*rc\trow)
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
			EndIf
			If *this\eventRowLeftClick And *rc\trow
				*this\eventRowLeftClick(*rc\trow)
			EndIf		
		EndIf
		
		FreeStructure(*rc)
	EndIf
EndProcedure

Procedure _MyTableEvtCanvasScroll()
	Protected *this.strMyTableTable=GetGadgetData(EventGadget())
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

Procedure _MyTableInitTable(*application.strMyTableApplication,
                            *table.strMyTableTable,
                            window.i,
                            canvas.i,
                            vscroll.i,
                            hscroll.i,
                            flags.i)
	With *table
		\vtable=?vtable_table
		\type=#MYTABLE_TYPE_TABLE
		\flags=flags
		\application=*application
		\redraw=Bool(Not Bool(\flags & #MYTABLE_TABLE_FLAGS_NO_REDRAW))
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
			BindGadgetEvent(canvas,@_MyTableEvtCanvasMouseLeftUp(),#PB_EventType_LostFocus)
		EndIf
		If IsGadget(vscroll)
			SetGadgetData(vscroll,*table)
			BindGadgetEvent(vscroll,@_MyTableEvtScroll())
		EndIf
		If IsGadget(hscroll)
			SetGadgetData(hscroll,*table)
			BindGadgetEvent(hscroll,@_MyTableEvtScroll())
		EndIf
		
		If *application
			\listindex=ListSize(*application\tables())-1
		Else
			_MyTableInitStyleTable(\defaultStyle)
			_MyTableInitStyleTableFixed(\fixedStyle)
			_MyTableInitStyleTableSelected(\selectedStyle)
			_MyTableInitStyleTableTitle(\titleStyle)
			_MyTableInitStyleTableMouseOver(\mouseoverStyle)
		EndIf
	EndWith
	
	_MyTableEvtResizeExp(*table)
EndProcedure

Procedure _MyTableInitRow(*application.strMyTableApplication,
                          *table.strMyTableTable,
                          *parent.strMyTableRow,
                          *row.strMyTableRow,
                          text.s,
                          sep.s,
                          image.i,
                          flags.i)
	
	Protected alwaysexpanded.b=Bool(*table\flags & #MYTABLE_TABLE_FLAGS_HIERARCHICAL_ALWAYS_EXPANDED)
	With *row
		\vtable=?vtable_row
		\type=#MYTABLE_TYPE_ROW
		\flags=flags			
		\application=*application
		\table=*table
		\parent=*parent
		\dirty=#True
		\height=*table\defaultrowheight
		\calcheight=*table\calcdefaultrowheight
		\image\orig=image		
		\expanded=alwaysexpanded
		If text<>""
			Protected c=CountString(text,sep)+1
			Protected idx=0
			For idx=1 To c
				Protected *cell.strMyTableCell=_MyTableGetOrAddCell(*row,idx-1)
				*cell\text=StringField(text,idx,sep)
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

Procedure _MyTableInitCol(*application.strMyTableApplication,
                          *table.strMyTableTable,
                          *col.strMyTableCol,
                          text.s,
                          width.i,
                          image.i,
                          flags.i)
	
	
	With *col
		\vtable=?vtable_col
		\type=#MYTABLE_TYPE_COL
		\flags=flags
		\application=*application
		\table=*table
		\dirty=#True
		\text=text
		\width=width
		\image\orig=image
		\sort=#MYTABLE_COL_SORT_NONE
		If width=#PB_Ignore
			\stretched=#True
		EndIf
		\defaultStyle\forecolor=RGBA(250,250,250,255)
		\defaultStyle\backcolor=RGBA(150,150,150,255)
		\defaultStyle\border\borderDefault\color=RGBA(250,250,250,255)
		\calcwidth=DesktopScaledX(\width)
		\listindex=ListSize(*table\cols())-1
	EndWith
	
	
EndProcedure

Procedure _MyTableInitCell(*application.strMyTableApplication,
                           *table.strMyTableTable,
                           *row.strMyTableRow,
                           *col.strMyTableCol,
                           *parent.strMyTableCell,
                           *cell.strMyTableCell,
                           flags.i)
	With *cell
		\vtable=?vtable_cell
		\type=#MYTABLE_TYPE_CELL
		\flags=flags
		\application=*application
		\table=*table
		\parent=*parent
		\row=*row
		\col=*col
		\dirty=#True
		\defaultStyle\font=\row\defaultStyle\font
		\defaultStyle\backcolor=\row\defaultStyle\backcolor
		\defaultStyle\frontcolor=\row\defaultStyle\frontcolor
		\defaultStyle\forecolor=\row\defaultStyle\forecolor
		\defaultStyle\valign=#MYTABLE_STYLE_VALIGN_TOP
		\defaultStyle\halign=#MYTABLE_STYLE_HALIGN_LEFT
		If *parent
			\listindex=ListSize(*parent\cells\cells())-1
		Else
			\listindex=ListSize(*row\cells\cells())-1
		EndIf
	EndWith
	
EndProcedure

Procedure.s _MyTableCleanName(name.s)
	Protected result.s=Trim(name)
	If result<>""
		Protected regex=CreateRegularExpression(#PB_Any,"[^\w\d_]")
		result=ReplaceString(result," ","_")
		
		If ExamineRegularExpression(regex,result)
			While NextRegularExpressionMatch(regex)
				Protected op.s=RegularExpressionMatchString(regex)
				result=ReplaceString(result,op,"")
			Wend
		EndIf
		
		FreeRegularExpression(regex)
	EndIf
	ProcedureReturn result
EndProcedure

Procedure _MyTableGetOrAddCell(*row.strMyTableRow,idx.i)
	If *row
		If ListSize(*row\table\cols())>idx
			Protected *col.strMyTableCol=SelectElement(*row\table\cols(),idx)
			Protected *cell.strMyTableCell=0
			If Not *row\cells
				*row\cells=AllocateStructure(strMyTableCellList)
			EndIf
			While ListSize(*row\cells\cells())<=idx
				LastElement(*row\cells\cells())
				*cell=AddElement(*row\cells\cells())
				_MyTableInitCell(*row\table\application,*row\table,*row,*col,0,*cell,0)
			Wend
			If *cell
				ProcedureReturn *cell
			Else
				ProcedureReturn SelectElement(*row\cells\cells(),idx)
			EndIf
		EndIf
	EndIf
EndProcedure

Procedure _MyTableTextHeight(text.s)
	ProcedureReturn TextHeight(text) * (CountString(text,#CRLF$) + 1)
EndProcedure

Procedure  _MyTableTextWidth(text.s)
	Protected c=CountString(text,#CRLF$)
	If c
		Protected result.i=0,idx=0
		For idx=0 To c
			Protected w=TextWidth(StringField(text,idx+1,#CRLF$))
			If w>result
				result=w
			EndIf
		Next
		ProcedureReturn result
	Else
		ProcedureReturn TextWidth(text)
	EndIf
EndProcedure

Procedure _MyTableDrawTextCompleteCenter(by,text.s,color.q,maxlen.i)
	Protected tt.s=text
	Protected tw=_MyTableTextWidth(text)
	Protected c=CountString(text,#CRLF$)
	Protected bx=0
	Protected idx
	If c>0
		For idx=0 To c
			tt=StringField(text,idx+1,#CRLF$)
			tw=TextWidth(tt)
			bx=maxlen/2-tw/2
			DrawText(bx,by,tt,color)
			by+TextHeight(tt)
		Next
	Else
		If tw>maxlen
			Protected result.s=""
			c=CountString(tt," ")
			For idx=0 To c
				Protected ts.s=StringField(tt,idx+1," ")
				If _MyTableTextWidth(result+" "+ts)>maxlen
					result+#CRLF$
				EndIf
				If result=""
					result=ts
				Else
					result=Trim(result+" "+ts)
				EndIf
			Next
			_MyTableDrawTextCompleteCenter(by,result,color,maxlen)
		Else
			bx=maxlen/2-tw/2
			DrawText(bx,by,tt,color)
		EndIf
	EndIf
EndProcedure

Procedure _MyTableDrawText(x,y,text.s,color.q,maxlen.i)
	If text<>"" And maxlen>0 And maxlen>TextWidth("...")
		Protected c=CountString(text,#CRLF$)
		Protected tw=0
		Protected tt.s=""		
		Protected h=0
		If c>0
			Protected idx=0
			For idx=0 To c
				tt=StringField(text,idx+1,#CRLF$)
				tw=TextWidth(tt)
				If tw>maxlen
					While tw>maxlen
						tt=Mid(tt,1,Len(tt)-1)
						tw=TextWidth(tt+"...")						
					Wend
					tt+"..."
				EndIf
				DrawText(x,y+h,tt,color)	
				h+TextHeight(tt)
			Next
		Else
			tt=text
			tw=TextWidth(tt)
			If tw>maxlen
				While tw>maxlen
					tt=Mid(tt,1,Len(tt)-1)
					tw=TextWidth(tt+"...")						
				Wend
				tt+"..."
			EndIf			
			DrawText(x,y,tt,color)
			h+TextHeight(tt)
		EndIf
		ProcedureReturn h
	EndIf	
EndProcedure