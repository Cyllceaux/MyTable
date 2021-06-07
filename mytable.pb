
Module MyTable
	EnableExplicit
	
	Structure strMyTableVTable
		vtable.i
		type.i
	EndStructure
	
	Structure strMyTableStyleBorder
		bordercolor.q
		selectedbordercolor.q
		
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
		elementselectedcolor.q
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
		List cells.strMyTableCell()
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
		List cells.strMyTableCell()
		List rows.strMyTableRow()
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
		
		window.i
		canvas.i
		vscroll.i
		hscroll.i
		
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
		*lastcell.strMyTableCell
		*lastrow.strMyTableRow
		*lastcol.strMyTableCol
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
			\border\bordercolor=RGBA(50,50,50,255)
			\border\selectedbordercolor=RGBA(200,200,250,255)
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
		
		Protected *row.strMyTableRow=0
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
			If mx>(hsc+*col\calcwidth-MyTableW2) And mx<(hsc+*col\calcwidth+MyTableW2)
				*rc\col=ListIndex(*this\cols())
				*rc\right=#True
				Break
			ElseIf mx>hsc And mx<(hsc+*col\calcwidth)
				*rc\col=ListIndex(*this\cols())
				Break
			Else				
				hsc+*col\calcwidth
			EndIf
		Next
		
		
		If *rc\row=-2	
			ForEach *this\expRows()
				*row=*this\expRows()
				If my>(vsc+*row\calcheight-MyTableH2) And my<(vsc+*row\calcheight+MyTableH2)
					*rc\row=ListIndex(*this\expRows())
					*rc\bottom=#True
					Break
				ElseIf my>vsc And my<(vsc+*row\calcheight)
					*rc\row=ListIndex(*this\expRows())
					Break
				Else				
					vsc+*row\calcheight
				EndIf
			Next
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
		Protected rf,rt,cf,ct,r,c
		
		Protected *cell.strMyTableCell=0
		Protected *col.strMyTableCol=0
		Protected *row.strMyTableRow=0
		
		
		If *rc\row=-1 And *rc\col>-1
			*col=SelectElement(*this\cols(),*rc\col)
			Select *col\sort
				Case #MYTABLE_COL_SORT_NONE
					_MyTable_Col_SetSort(*col,#MYTABLE_COL_SORT_ASC)
				Case #MYTABLE_COL_SORT_ASC
					_MyTable_Col_SetSort(*col,#MYTABLE_COL_SORT_DESC)
				Case #MYTABLE_COL_SORT_DESC
					_MyTable_Col_SetSort(*col,#MYTABLE_COL_SORT_NONE)
			EndSelect		
			*this\md=#False
		Else
			If fullrow
				If *rc\row>-1 And *rc\col>-1
					SelectElement(*this\expRows(),*rc\row)
					*row=*this\expRows()
					
					If multiselect And 
					   (shift Or *this\md) And 
					   *row<>*this\lastrow And
					   *this\lastrow<>0 And 
					   *row\level=*this\lastrow\level And 
					   *row\parent=*this\lastrow\parent
						
						rf=-1
						rt=-1
						ForEach *this\expRows()
							If *this\expRows()=*row
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
									*this\selectedRows(Str(*row))=#True
								EndIf
							Next
						EndIf
					Else
						If temp
							*this\tempselectedRows(Str(*row))=#True
						Else
							*this\lastrow=*row
							*this\selectedRows(Str(*row))=#True
						EndIf
					EndIf
					*this\dirty=#True
				EndIf
			Else
				If *rc\row>-1 And *rc\col>-1
					SelectElement(*this\expRows(),*rc\row)
					*row=*this\expRows()
					*cell=_MyTableGetOrAddCell(*row,*rc\col)
					If multiselect And 
					   (shift Or *this\md) And 
					   *cell<>*this\lastcell And 
					   *this\lastcell<>0 And 
					   *cell\row\level=*this\lastcell\row\level And
					   *cell\row\parent=*this\lastcell\row\parent
						
						cf=*cell\col\listindex
						ct=*this\lastcell\col\listindex
						rf=-1
						rt=-1
						ForEach *this\expRows()
							If *this\expRows()=*cell\row
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
									*cell=_MyTableGetOrAddCell(*row,c)									
									If temp
										*this\tempselectedCells(Str(*cell))=#True
									Else
										*this\selectedCells(Str(*cell))=#True
									EndIf
								Next
							Next								
						EndIf
					Else
						
						If temp
							*this\tempselectedCells(Str(*cell))=#True
						Else
							*this\lastcell=*cell
							*this\selectedCells(Str(*cell))=#True
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
			Protected *rc.strMyTableRowCol=_MyTableGetRowCol(*this)
			
			If *rc\bottom And *rc\right
				SetGadgetAttribute(*this\canvas,#PB_Canvas_Cursor,#PB_Cursor_LeftUpRightDown)
			ElseIf *rc\bottom
				SetGadgetAttribute(*this\canvas,#PB_Canvas_Cursor,#PB_Cursor_UpDown)
			ElseIf *rc\right
				SetGadgetAttribute(*this\canvas,#PB_Canvas_Cursor,#PB_Cursor_LeftRight)
			Else
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
		Protected *row.strMyTableRow=0
		Protected multiselect.b=Bool(*this\flags & #MYTABLE_TABLE_FLAGS_MULTISELECT)		
		Protected fullrow.b=Bool(*this\flags & #MYTABLE_TABLE_FLAGS_FULLROWSELECT)
		Protected shift.b=Bool(GetGadgetAttribute(*this\canvas,#PB_Canvas_Modifiers) & #PB_Canvas_Shift)
		Protected control.b=Bool(GetGadgetAttribute(*this\canvas,#PB_Canvas_Modifiers) & #PB_Canvas_Control)
		
		*this\md=#True
		If IsGadget(*this\canvas)
			Protected *rc.strMyTableRowCol=_MyTableGetRowCol(*this)
			
			If *rc\check
				SelectElement(*this\expRows(),*rc\row)
				*row=*this\expRows()
				*row\checked=Bool(Not *row\checked)
				*this\dirty=#True
			ElseIf *rc\exp
				SelectElement(*this\expRows(),*rc\row)
				*row=*this\expRows()
				*row\expanded=Bool(Not *row\expanded)
				*this\dirty=#True
				_MyTable_Table_Predraw(*this)
			Else
				If Not multiselect Or (Not shift And Not control)
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
			
			FreeStructure(*rc)
		EndIf
		_MyTable_Table_Redraw(*this)
	EndProcedure
	
	Procedure _MyTableEvtCanvasMouseLeftUp()
		Protected *this.strMyTableTable=GetGadgetData(EventGadget())
		Protected shift.b=Bool(GetGadgetAttribute(*this\canvas,#PB_Canvas_Modifiers) & #PB_Canvas_Shift)
		Protected control.b=Bool(GetGadgetAttribute(*this\canvas,#PB_Canvas_Modifiers) & #PB_Canvas_Control)
		Protected multiselect.b=Bool(*this\flags & #MYTABLE_TABLE_FLAGS_MULTISELECT)	
		
		*this\md=#False
		If IsGadget(*this\canvas)
			Protected *rc.strMyTableRowCol=_MyTableGetRowCol(*this)
			If *rc\col>-1 And *rc\row>-1
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
				Else
					ClearMap(*this\selectedCells())
					ClearMap(*this\selectedCols())
					ClearMap(*this\selectedRows())
				EndIf
				ClearMap(*this\tempselectedCells())
				ClearMap(*this\tempselectedRows())
				ClearMap(*this\tempselectedCols())
				
				_MyTableSelect(*this,*rc,#False)	
				_MyTable_Table_Redraw(*this)
			EndIf
			FreeStructure(*rc)
		EndIf
	EndProcedure
	
	Procedure _MyTableEvtCanvasMouseLeftDouble()
		Protected *this.strMyTableTable=GetGadgetData(EventGadget())
		If IsGadget(*this\canvas)
			Protected *rc.strMyTableRowCol=_MyTableGetRowCol(*this)
			
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
				If *this\vscroll<0
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
			\calcheaderheight=DesktopScaledY(\headerheight)
			
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
				\listindex=ListSize(*parent\rows())-1
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
			\style\border\bordercolor=RGBA(250,250,250,255)
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
				\listindex=ListSize(*parent\cells())-1
			Else
				\listindex=ListSize(*row\cells())-1
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
				While ListSize(*row\cells())<=idx
					LastElement(*row\cells())
					*cell=AddElement(*row\cells())
					_MyTableInitCell(*row\table\application,*row\table,*row,*col,0,*cell,0)
				Wend
				If *cell
					ProcedureReturn *cell
				Else
					ProcedureReturn SelectElement(*row\cells(),idx)
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
	EndMacro
	
	Macro _MyTableDataSectionStyleDefault(gruppe)
		_MyTableDataSectionSetterGetter(gruppe,Font)
		_MyTableDataSectionSetterGetter(gruppe,BackColor)
		_MyTableDataSectionSetterGetter(gruppe,FrontColor)
		_MyTableDataSectionSetterGetter(gruppe,ForeColor)
		_MyTableDataSectionSetterGetter(gruppe,SelectedColor)
		_MyTableDataSectionSetterGetter(gruppe,BorderColor)
		_MyTableDataSectionSetterGetter(gruppe,SelectedBorderColor)
		
		_MyTableDataSectionMethode(gruppe,Free)
		_MyTableDataSectionMethode(gruppe,Delete)
	EndMacro
	
	Macro _MyTableDataSectionCellStyleDefault(gruppe)
		_MyTableDataSectionStyleDefault(gruppe)
		_MyTableDataSectionSetterGetter(gruppe,HAlign)
		_MyTableDataSectionSetterGetter(gruppe,VAlign)
		
	EndMacro
	
	DataSection
		vtable_style_cell:;- Style Cell
		_MyTableDataSectionCellStyleDefault(Style)
		
		vtable_style_row:;- Style Row
		_MyTableDataSectionCellStyleDefault(Style)
		_MyTableDataSectionSetterGetter(Style,ElementSelectedColor)
		_MyTableDataSectionSetterGetter(Style,ElementSelectedBorderColor)
		
		vtable_style_col:;- Style Col
		_MyTableDataSectionCellStyleDefault(Style)
		_MyTableDataSectionSetterGetter(Style,ElementSelectedColor)
		_MyTableDataSectionSetterGetter(Style,ElementSelectedBorderColor)
		
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
		_MyTableDataSectionSetterGetter(Table,Name)
		_MyTableDataSectionSetterGetter(Table,Title)
		_MyTableDataSectionSetterGetter(Table,Redraw)
		_MyTableDataSectionSetterGetter(Table,Recalc)
		_MyTableDataSectionSetterGetter(Table,HeaderHeight)
		_MyTableDataSectionSetterGetter(Table,DefaultRowHeight)
		
		_MyTableDataSectionMethode(Table,AddRow)
		_MyTableDataSectionMethode(Table,DeleteRow)
		_MyTableDataSectionGetter(Table,Row)
		_MyTableDataSectionMethode(Table,RowCount)
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
		
		vtable_row:;- Row
		_MyTableDataSectionDefault(Row)
		_MyTableDataSectionSetterGetter(Row,Expanded)
		_MyTableDataSectionSetterGetter(Row,Image)
		_MyTableDataSectionSetterGetter(Row,Checked)
		
		_MyTableDataSectionMethode(Row,AddRow)
		_MyTableDataSectionMethode(Row,DeleteRow)
		_MyTableDataSectionGetter(Row,Row)
		_MyTableDataSectionMethode(Row,RowCount)
		_MyTableDataSectionGetter(Row,Cell)
		_MyTableDataSectionMethode(Row,Delete)
		
		vtable_col:;- Col
		_MyTableDataSectionDefault(Col)
		_MyTableDataSectionSetterGetter(Col,Text)
		_MyTableDataSectionSetterGetter(Col,Image)
		_MyTableDataSectionSetterGetter(Col,Width)
		_MyTableDataSectionSetterGetter(Col,Sort)
		
		
		_MyTableDataSectionMethode(Col,Delete)
		
		vtable_cell:;- Cell
		_MyTableDataSectionDefault(Cell)
		_MyTableDataSectionSetterGetter(Cell,Text)
		_MyTableDataSectionSetterGetter(Cell,Value)
		_MyTableDataSectionSetterGetter(Cell,Image)
		_MyTableDataSectionSetterGetter(Cell,Checked)
		
	EndDataSection	
EndModule