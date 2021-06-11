
Module MyTable
	EnableExplicit
	
	Structure strMyTableVTable
		vtable.i
		type.i
	EndStructure
	
	Structure strMyTableStyleBorderStyle
		color.q
		width.i
		selectedcolor.q
		selectedwidth.q
	EndStructure
	
	Structure strMyTableStyleBorder
		border.i
		defaultBorder.strMyTableStyleBorderStyle
		borderLeft.strMyTableStyleBorderStyle
		borderRight.strMyTableStyleBorderStyle
		borderTop.strMyTableStyleBorderStyle
		borderBottom.strMyTableStyleBorderStyle
		elementselectedbordercolor.q
	EndStructure
	
	Structure strMyTableStyle		
		font.i
		backcolor.q
		frontcolor.q
		valign.i
		halign.i
		border.strMyTableStyleBorder
		forecolor.q
		selectedcolor.q
		selectedforecolor.q
		elementselectedcolor.q
		elementselectedforecolor.q
	EndStructure
	
	Structure strMyTableObject Extends strMyTableVTable
		flags.i
		*data
		dirty.b
		style.strMyTableStyle
	EndStructure
	
	Structure strMyTableStyleObject Extends strMyTableVTable
		*obj.strMyTableObject
	EndStructure
	
	Structure strMyTableImage
		orig.i
		sized.i
		resize.b
	EndStructure
	
	Structure strMyTableCell Extends strMyTableObject
		*parent.strMyTableCell
		*col.strMyTableCol
		*row.strMyTableRow
		*table.strMyTableTable
		*application.strMyTableApplication
		listindex.i
		text.s
		value.d
		checked.b
		*cells.strMyTableCellList
		image.strMyTableImage
		
		textwidth.i
		textheight.i
	EndStructure
	
	Structure strMyTableCol Extends strMyTableObject
		*table.strMyTableTable
		*application.strMyTableApplication
		listindex.i
		text.s
		image.strMyTableImage
		
		stretched.b
		width.i
		calcwidth.i
		minwidth.i
		calcminwidth.i
		
		textwidth.i
		textheight.i
		
		sort.i
	EndStructure
	
	Structure strMyTableRow Extends strMyTableObject
		*table.strMyTableTable
		*application.strMyTableApplication
		*cells.strMyTableCellList
		*rows.strMyTableRowList
		level.i
		*parent.strMyTableRow
		listindex.i
		expanded.b
		image.strMyTableImage
		height.i
		calcheight.i
		checked.b
		
		sorts.s
		sortd.d
	EndStructure
	
	Structure strMyTableTable Extends strMyTableObject		
		*application.strMyTableApplication
		List rows.strMyTableRow()
		List expRows.i()
		List cols.strMyTableCol()
		listindex.i
		name.s
		title.s
		redraw.b
		recalc.b
		
		drawing.b
		
		window.i
		canvas.i
		vscroll.i
		hscroll.i
		maxvscroll.i
		maxhscroll.i
		
		defaultheaderheight.i
		calcdefaultheaderheight.i
		headerheight.i
		calcheaderheight.i
		
		defaultrowheight.i
		calcdefaultrowheight.i
		
		Map selectedCells.b()
		Map selectedRows.b()
		Map selectedCols.b()
		Map tempselectedCells.b()
		Map tempselectedRows.b()
		Map tempselectedCols.b()
		selectall.b
		
		md.b
		mxd.i
		myd.i
		*lastcell.strMyTableCell
		*lastrow.strMyTableRow
		*lastcol.strMyTableCol
		
		*resizeRow.strMyTableRow
		*resizeCol.strMyTableCol
		
		eventCellChangedChecked.MyTableProtoEventCellChangedChecked
		eventCellChangedUnChecked.MyTableProtoEventCellChangedUnChecked
		eventCellChangedText.MyTableProtoEventCellChangedText
		eventCellChangedValue.MyTableProtoEventCellChangedValue
		eventCellSelected.MyTableProtoEventCellSelected
		eventRowChangedChecked.MyTableProtoEventRowChangedChecked
		eventRowChangedUnChecked.MyTableProtoEventRowChangedUnChecked
		eventRowChangedExpanded.MyTableProtoEventRowChangedExpanded
		eventRowChangedCollapsed.MyTableProtoEventRowChangedCollapsed
		eventRowSelected.MyTableProtoEventRowSelected
		callback.MyTableProtoCallback
	EndStructure
	
	Structure strMyTableApplication Extends strMyTableObject
		List tables.strMyTableTable()
		lastindex.i
		redraw.b
		recalc.b
	EndStructure
	
	Structure strMyTableRowCol
		row.i
		col.i
		bottom.b
		right.b
		exp.b
		check.b
		*trow.strMyTableRow
		*tcol.strMyTableCol
		*tcell.strMyTableCell
		mx.i
		my.i
	EndStructure
	
	Structure strMyTableCellList
		List cells.strMyTableCell()
	EndStructure
	
	Structure strMyTableRowList
		List rows.strMyTableRow()
	EndStructure
	
	XIncludeFile "declare.pb"
		
	
	Procedure MyTableCreateApplication(flags.i=0)
		Protected *this.strMyTableApplication=AllocateStructure(strMyTableApplication)
		_MyTableInitApplication(*this,flags)
		ProcedureReturn *this
	EndProcedure
	
	Procedure MyTableCreateTable(window.i,canvas.i,vscroll.i,hscroll.i,flags.i=#MYTABLE_TABLE_FLAGS_DEFAULT)
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
			\selectedcolor=RGBA(230,230,250,255)
			\selectedforecolor=RGBA(20,20,20,255)
			\border\defaultBorder\color=RGBA(50,50,50,255)
			\border\defaultBorder\selectedcolor=RGBA(200,200,250,255)
			\border\defaultBorder\width=1
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
			_MyTableInitStyleTable(\style)
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
		
		Protected *row.strMyTableRow=0
		Protected *cell.strMyTableCell=0
		Protected mx=GetGadgetAttribute(*this\canvas,#PB_Canvas_MouseX)
		Protected my=GetGadgetAttribute(*this\canvas,#PB_Canvas_MouseY)
		Protected header.b=Bool(Not(*this\flags & #MYTABLE_TABLE_FLAGS_NO_HEADER))
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
		
		If header
			vsc+*this\calcheaderheight
			If my<*this\calcheaderheight
				*rc\row=-1
			EndIf
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
				sortable=Bool(sortable Or Bool(*rc\tcol\flags & #MYTABLE_COL_FLAGS_SORTABLE))
				sortable=Bool(sortable And Not Bool(*rc\tcol\flags & #MYTABLE_COL_FLAGS_NO_SORTABLE))
				If sortable
					Select *rc\tcol\sort
						Case #MYTABLE_COL_SORT_NONE
							_MyTable_Col_SetSort(*rc\tcol,#MYTABLE_COL_SORT_ASC)
						Case #MYTABLE_COL_SORT_ASC
							_MyTable_Col_SetSort(*rc\tcol,#MYTABLE_COL_SORT_DESC)
						Case #MYTABLE_COL_SORT_DESC
							_MyTable_Col_SetSort(*rc\tcol,#MYTABLE_COL_SORT_NONE)
					EndSelect		
					*this\dirty=#True
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
	
	Procedure _MyTableEvtCanvasMouseMove()
		Protected *this.strMyTableTable=GetGadgetData(EventGadget())
		Protected multiselect.b=Bool(*this\flags & #MYTABLE_TABLE_FLAGS_MULTISELECT)		
		Protected fullrow.b=Bool(*this\flags & #MYTABLE_TABLE_FLAGS_FULLROWSELECT)
		Protected shift.b=Bool(GetGadgetAttribute(*this\canvas,#PB_Canvas_Modifiers) & #PB_Canvas_Shift)
		Protected control.b=Bool(GetGadgetAttribute(*this\canvas,#PB_Canvas_Modifiers) & #PB_Canvas_Control)
		
		
		
		If IsGadget(*this\canvas)
			Protected mx=GetGadgetAttribute(*this\canvas,#PB_Canvas_MouseX)
			Protected my=GetGadgetAttribute(*this\canvas,#PB_Canvas_MouseY)
			
			Protected sized.b=#False
			
			Protected *rc.strMyTableRowCol=_MyTableGetRowCol(*this)
			
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
							If *this\resizeRow\cells\cells()\image\sized And *this\resizeRow\cells\cells()\image\resize
								FreeImage(*this\resizeRow\cells\cells()\image\sized)
								*this\resizeRow\cells\cells()\image\sized=0
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
		Protected redraw.b=#False
		*this\md=#True
		If IsGadget(*this\canvas)
			Protected *rc.strMyTableRowCol=_MyTableGetRowCol(*this)
			
			*this\myd=GetGadgetAttribute(*this\canvas,#PB_Canvas_MouseY)
			*this\mxd=GetGadgetAttribute(*this\canvas,#PB_Canvas_MouseX)
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
				redraw=#True
			ElseIf *rc\exp
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
				If *rc\right
					*this\resizeCol=*rc\tcol
				EndIf
				If *rc\bottom
					*this\resizeRow=*rc\trow
				EndIf
				_MyTableSelect(*this,*rc,#False)	
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
					_MyTableSelect(*this,*rc,#False)	
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
			\redraw=#True
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
			
			If IsGadget(canvas)
				SetGadgetData(canvas,*table)
				BindGadgetEvent(canvas,@_MyTableEvtResize(),#PB_EventType_Resize)
				BindGadgetEvent(canvas,@_MyTableEvtCanvasScroll(),#PB_EventType_MouseWheel)
				BindGadgetEvent(canvas,@_MyTableEvtCanvasMouseMove(),#PB_EventType_MouseMove)
				BindGadgetEvent(canvas,@_MyTableEvtCanvasMouseLeftDown(),#PB_EventType_LeftButtonDown)
				BindGadgetEvent(canvas,@_MyTableEvtCanvasMouseLeftUp(),#PB_EventType_LeftButtonUp)
				BindGadgetEvent(canvas,@_MyTableEvtCanvasMouseLeftUp(),#PB_EventType_LostFocus)
				BindGadgetEvent(canvas,@_MyTableEvtCanvasMouseLeftDouble(),#PB_EventType_LeftDoubleClick)
				BindGadgetEvent(canvas,@_MyTableEvtCanvasMouseRightDown(),#PB_EventType_RightButtonDown)
				BindGadgetEvent(canvas,@_MyTableEvtCanvasMouseRightUp(),#PB_EventType_RightButtonUp)
				BindGadgetEvent(canvas,@_MyTableEvtCanvasMouseRightDouble(),#PB_EventType_RightDoubleClick)
				BindGadgetEvent(canvas,@_MyTableEvtCanvasKeyDown(),#PB_EventType_KeyDown)
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
				_MyTableInitStyleTable(\style)
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
			\style\forecolor=RGBA(250,250,250,255)
			\style\backcolor=RGBA(150,150,150,255)
			\style\border\defaultBorder\color=RGBA(250,250,250,255)
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
			\style\font=\row\style\font
			\style\backcolor=\row\style\backcolor
			\style\frontcolor=\row\style\frontcolor
			\style\forecolor=\row\style\forecolor
			\style\valign=#MYTABLE_STYLE_VALIGN_TOP
			\style\halign=#MYTABLE_STYLE_HALIGN_LEFT
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
	
	
	Macro _MyTableDataSectionMethode(gruppe,methode)
		Data.i @_MyTable_#gruppe#_#methode()
	EndMacro
	
	Macro _MyTableDataSectionSetter(gruppe,name)
		_MyTableDataSectionMethode(gruppe,Set#name)
	EndMacro
	
	Macro _MyTableDataSectionGetter(gruppe,name)
		_MyTableDataSectionMethode(gruppe,Get#name)
	EndMacro
	
	Macro _MyTableDataSectionSetterGetter(gruppe,name)
		_MyTableDataSectionSetter(gruppe,name)
		_MyTableDataSectionGetter(gruppe,name)
	EndMacro
	
	Macro _MyTableDataSectionDefault(gruppe)
		_MyTableDataSectionGetter(gruppe,Type)
		_MyTableDataSectionGetter(gruppe,Style)
		_MyTableDataSectionSetterGetter(gruppe,Flags)
		_MyTableDataSectionSetterGetter(gruppe,Data)
		_MyTableDataSectionSetterGetter(gruppe,Dirty)
		_MyTableDataSectionSetterGetter(gruppe,Selected)
		
		_MyTableDataSectionMethode(gruppe,Autosize)
	EndMacro
	
	Macro _MyTableDataSectionStyleDefault(gruppe)
		_MyTableDataSectionSetterGetter(gruppe,Font)
		_MyTableDataSectionSetterGetter(gruppe,BackColor)
		_MyTableDataSectionSetterGetter(gruppe,FrontColor)
		_MyTableDataSectionSetterGetter(gruppe,ForeColor)
		_MyTableDataSectionSetterGetter(gruppe,SelectedColor)
		_MyTableDataSectionSetterGetter(gruppe,BorderColor)
		_MyTableDataSectionSetterGetter(gruppe,BorderWidth)
		_MyTableDataSectionSetterGetter(gruppe,SelectedBorderColor)
		_MyTableDataSectionSetterGetter(gruppe,SelectedBorderWidth)
		_MyTableDataSectionSetterGetter(gruppe,SelectedForeColor)
		
		_MyTableDataSectionMethode(gruppe,Free)
		_MyTableDataSectionMethode(gruppe,Delete)
	EndMacro
	
	Macro _MyTableDataSectionCellStyleDefault(gruppe)
		_MyTableDataSectionStyleDefault(gruppe)
		_MyTableDataSectionSetterGetter(gruppe,HAlign)
		_MyTableDataSectionSetterGetter(gruppe,VAlign)
		_MyTableDataSectionSetterGetter(gruppe,Border)
		_MyTableDataSectionSetter(gruppe,BorderStyle)
		
	EndMacro
	
	DataSection
		vtable_style_cell:;- Style Cell
		_MyTableDataSectionCellStyleDefault(Style)
		
		vtable_style_row:;- Style Row
		_MyTableDataSectionCellStyleDefault(Style)
		_MyTableDataSectionSetterGetter(Style,ElementSelectedColor)
		_MyTableDataSectionSetterGetter(Style,ElementSelectedBorderColor)
		_MyTableDataSectionSetterGetter(Style,ElementSelectedForeColor)
		
		vtable_style_col:;- Style Col
		_MyTableDataSectionCellStyleDefault(Style)
		_MyTableDataSectionSetterGetter(Style,ElementSelectedColor)
		_MyTableDataSectionSetterGetter(Style,ElementSelectedForeColor)
		
		vtable_style_table:;- Style Table
		_MyTableDataSectionStyleDefault(Style)
		
		vtable_style_application:;- Style Application
		_MyTableDataSectionStyleDefault(Style)
		
		
		vtable_application:;- Application
		_MyTableDataSectionDefault(Application)
		_MyTableDataSectionSetterGetter(Application,Redraw)
		_MyTableDataSectionSetterGetter(Application,Recalc)
		
		_MyTableDataSectionMethode(Application,AddTable)
		_MyTableDataSectionMethode(Application,ClearTables)
		_MyTableDataSectionMethode(Application,Redraw)
		_MyTableDataSectionMethode(Application,Recalc)
		_MyTableDataSectionMethode(Application,Free)
		
		vtable_table:;- Table
		_MyTableDataSectionDefault(Table)
		_MyTableDataSectionGetter(Table,Application)
		_MyTableDataSectionSetterGetter(Table,Name)
		_MyTableDataSectionSetterGetter(Table,Title)
		_MyTableDataSectionSetterGetter(Table,Redraw)
		_MyTableDataSectionSetterGetter(Table,Recalc)
		_MyTableDataSectionSetterGetter(Table,HeaderHeight)
		_MyTableDataSectionSetterGetter(Table,DefaultRowHeight)
		_MyTableDataSectionGetter(Table,SelectedRows)
		_MyTableDataSectionGetter(Table,SelectedCells)
		_MyTableDataSectionGetter(Table,SelectedCols)
		
		_MyTableDataSectionMethode(Table,AddDirtyRows)
		_MyTableDataSectionMethode(Table,AddRow)
		_MyTableDataSectionMethode(Table,DeleteRow)
		_MyTableDataSectionGetter(Table,Row)
		_MyTableDataSectionMethode(Table,RowCount)
		_MyTableDataSectionMethode(Table,VisibleRowCount)
		_MyTableDataSectionMethode(Table,AddCol)
		_MyTableDataSectionMethode(Table,DeleteCol)
		_MyTableDataSectionGetter(Table,Col)
		_MyTableDataSectionMethode(Table,ColCount)
		_MyTableDataSectionGetter(Table,Cell)
		_MyTableDataSectionMethode(Table,Delete)
		_MyTableDataSectionMethode(Table,ClearRows)
		_MyTableDataSectionMethode(Table,ClearCols)
		_MyTableDataSectionMethode(Table,Redraw)
		_MyTableDataSectionMethode(Table,Recalc)
		_MyTableDataSectionMethode(Table,Free)
		_MyTableDataSectionMethode(Table,ScrollToPos)
		_MyTableDataSectionMethode(Table,ScrollToCellPos)
		
		_MyTableDataSectionMethode(Table,RegisterEventCellChangedChecked)
		_MyTableDataSectionMethode(Table,RegisterEventCellChangedUnChecked)
		_MyTableDataSectionMethode(Table,RegisterEventCellChangedText)
		_MyTableDataSectionMethode(Table,RegisterEventCellChangedValue)
		_MyTableDataSectionMethode(Table,RegisterEventCellSelected)
		_MyTableDataSectionMethode(Table,RegisterEventRowChangedChecked)
		_MyTableDataSectionMethode(Table,RegisterEventRowChangedUnChecked)
		_MyTableDataSectionMethode(Table,RegisterEventRowChangedExpanded)
		_MyTableDataSectionMethode(Table,RegisterEventRowChangedCollapsed)
		_MyTableDataSectionMethode(Table,RegisterEventRowSelected)
		
		_MyTableDataSectionMethode(Table,RegisterCallback)
		
		vtable_row:;- Row
		_MyTableDataSectionDefault(Row)
		_MyTableDataSectionGetter(Row,Application)
		_MyTableDataSectionGetter(Row,Table)
		_MyTableDataSectionGetter(Row,Parent)
		_MyTableDataSectionGetter(Row,Position)
		_MyTableDataSectionGetter(Row,Level)
		_MyTableDataSectionSetterGetter(Row,Expanded)
		_MyTableDataSectionSetterGetter(Row,Image)
		_MyTableDataSectionSetterGetter(Row,Checked)
		
		_MyTableDataSectionMethode(Row,AddDirtyRows)
		_MyTableDataSectionMethode(Row,AddRow)
		_MyTableDataSectionMethode(Row,DeleteRow)
		_MyTableDataSectionGetter(Row,Row)
		_MyTableDataSectionMethode(Row,RowCount)
		_MyTableDataSectionGetter(Row,Cell)
		_MyTableDataSectionMethode(Row,Delete)
		_MyTableDataSectionMethode(Row,ScrollTo)
		
		vtable_col:;- Col
		_MyTableDataSectionDefault(Col)
		_MyTableDataSectionGetter(Col,Application)
		_MyTableDataSectionGetter(Col,Table)
		_MyTableDataSectionGetter(Col,Position)
		_MyTableDataSectionSetterGetter(Col,Text)
		_MyTableDataSectionSetterGetter(Col,Image)
		_MyTableDataSectionSetterGetter(Col,Width)
		_MyTableDataSectionSetterGetter(Col,Sort)
		
		
		_MyTableDataSectionMethode(Col,Delete)
		_MyTableDataSectionMethode(Col,ScrollTo)
		
		vtable_cell:;- Cell
		_MyTableDataSectionDefault(Cell)
		_MyTableDataSectionGetter(Cell,Application)
		_MyTableDataSectionGetter(Cell,Table)
		_MyTableDataSectionGetter(Cell,Row)
		_MyTableDataSectionGetter(Cell,Col)
		_MyTableDataSectionGetter(Cell,Parent)
		_MyTableDataSectionSetterGetter(Cell,Text)
		_MyTableDataSectionSetterGetter(Cell,Value)
		_MyTableDataSectionSetterGetter(Cell,Image)
		_MyTableDataSectionSetterGetter(Cell,Checked)
		_MyTableDataSectionMethode(Cell,ScrollTo)
		
	EndDataSection	
EndModule