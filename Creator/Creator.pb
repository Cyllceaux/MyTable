EnableExplicit


XIncludeFile "../Test/declare.pb"

UseModule MyTable
	
	Enumeration _mytable_creator_tree
		#NONE
		#TABLE_FLAGS
		#TABLE_FLAGS_DEFAULT
		#TABLE_EVENTS
		#TABLE_STYLES
		#TABLE_VALUES
		#TABLE_VALUES_ROWS
		#TABLE_VALUES_COLS
		#TABLE_VALUES_FIXED_COLS
		#TABLE_BOOLEAN
		#TABLE_BOOLEAN_REDRAW
		#TABLE_BOOLEAN_RECALC
		#TABLE_BOOLEAN_DISABLED
		#TABLE_BOOLEAN_BATCH
		#TABLE_TEXT
		#TABLE_TEXT_TITLE
		#TABLE_TEXT_EMPTY
		#TABLE_TEXT_NAME
	EndEnumeration
	
	Procedure styleHeaderRow(*row.MyTableRow,*dat)
		Protected *style.MyTableStyle
		*row\SetData(*dat)
		*row\SetFlags(#MYTABLE_ROW_FLAGS_HIERARCHICAL_ALWAYS_EXPANDED)
		*row\SetExpanded(#True)
		*style=*row\GetDefaultStyle()
		*style\SetBackColor(RGBA(50,50,50,255))
		*style\SetForeColor(#White)
		*style=*row\GetSelectedStyle()
		*style\SetBackColor(RGBA(50,50,50,255))
		*style\SetForeColor(#White)
	EndProcedure
	
	Procedure styleEditCell(*cell.MyTableCell,*dat,init.s="")
		Protected *style.MyTableStyle
		*cell\SetData(*dat)
		*cell\SetText(init)
		*style=*cell\GetDefaultStyle()
		*cell\SetFlags(#MYTABLE_CELL_FLAGS_EDITABLE)
		*style\SetBackColor(#Yellow)
		*style=*cell\GetSelectedStyle()
		*cell\SetFlags(#MYTABLE_CELL_FLAGS_EDITABLE)
		*style\SetBackColor(#Yellow)
	EndProcedure
	
	Procedure styleEditCellNumber(*cell.MyTableCell,*dat,init.s="")
		Protected *style.MyTableStyle
		*cell\SetData(*dat)
		*cell\SetDatatype(#MYTABLE_DATATYPE_NUMBER)
		*cell\SetText(init)
		*style=*cell\GetDefaultStyle()
		*style\SetHAlign(#MYTABLE_STYLE_HALIGN_RIGHT)
		*cell\SetFlags(#MYTABLE_CELL_FLAGS_EDITABLE)
		*style\SetBackColor(#Yellow)
		*style=*cell\GetSelectedStyle()
		*cell\SetFlags(#MYTABLE_CELL_FLAGS_EDITABLE)
		*style\SetBackColor(#Yellow)
		*style\SetHAlign(#MYTABLE_STYLE_HALIGN_RIGHT)
	EndProcedure
	
	
	Global window=OpenWindow(#PB_Any,0,0,800,600,"Creator",#PB_Window_SystemMenu|#PB_Window_ScreenCentered|#PB_Window_SizeGadget|#PB_Window_MaximizeGadget|#PB_Window_MinimizeGadget)
	
	Global container=ContainerGadget(#PB_Any,0,0,0,0)
	Global canvasStyle=CanvasGadget(#PB_Any,0,0,0,0,#PB_Canvas_Container|#PB_Canvas_Keyboard)
	Global hscrollStyle=ScrollBarGadget(#PB_Any,0,0,0,20,0,0,0)
	Global vscrollStyle=ScrollBarGadget(#PB_Any,0,0,20,0,0,0,0,#PB_ScrollBar_Vertical)
	CloseGadgetList()
	CloseGadgetList()
	
	Global *rowFixed.MyTableRow
	
	Global *styleTree.MyTableTree=MyTableCreateTree(window,canvasStyle,vscrollStyle,hscrollStyle,#MYTABLE_TABLE_FLAGS_NO_HEADER|#MYTABLE_TABLE_FLAGS_FULLROWSELECT|#MYTABLE_TABLE_FLAGS_NO_REDRAW)
	Global *header.MyTableRow,*checkRow.MyTableRow,*textRow.MyTableRow,*cell.MyTableCell,*style.MyTableStyle
	*styleTree\AddCol("Name",200)
	*styleTree\AddCol("Value",#PB_Ignore)
	*header=*styleTree\AddRow("Table Default Type"):styleHeaderRow(*header,#TABLE_FLAGS_DEFAULT)
	*checkRow=*header\AddRow("Grid"):*checkRow\SetData(#MYTABLE_TABLE_FLAGS_DEFAULT_GRID):*checkRow\SetFlags(#MYTABLE_ROW_FLAGS_CHECKBOXES)
	*checkRow=*header\AddRow("Table"):*checkRow\SetData(#MYTABLE_TABLE_FLAGS_DEFAULT_TABLE):*checkRow\SetFlags(#MYTABLE_ROW_FLAGS_CHECKBOXES):*checkRow\SetChecked(#True)
	*checkRow=*header\AddRow("Tree"):*checkRow\SetData(#MYTABLE_TABLE_FLAGS_DEFAULT_TREE):*checkRow\SetFlags(#MYTABLE_ROW_FLAGS_CHECKBOXES)
	*header=*styleTree\AddRow("Table Type"):styleHeaderRow(*header,#TABLE_FLAGS)
	*checkRow=*header\AddRow("Hierarchical"):*checkRow\SetData(#MYTABLE_TABLE_FLAGS_HIERARCHICAL):*checkRow\SetFlags(#MYTABLE_ROW_FLAGS_CHECKBOXES)
	*checkRow=*header\AddRow("Always Expanded"):*checkRow\SetData(#MYTABLE_TABLE_FLAGS_HIERARCHICAL_ALWAYS_EXPANDED):*checkRow\SetFlags(#MYTABLE_ROW_FLAGS_CHECKBOXES)
	*checkRow=*header\AddRow("Checkboxes"):*checkRow\SetData(#MYTABLE_TABLE_FLAGS_CHECKBOXES):*checkRow\SetFlags(#MYTABLE_ROW_FLAGS_CHECKBOXES)
	*checkRow=*header\AddRow("Fullrow Select"):*checkRow\SetData(#MYTABLE_TABLE_FLAGS_FULLROWSELECT):*checkRow\SetFlags(#MYTABLE_ROW_FLAGS_CHECKBOXES)
	*checkRow=*header\AddRow("Multiselect"):*checkRow\SetData(#MYTABLE_TABLE_FLAGS_MULTISELECT):*checkRow\SetFlags(#MYTABLE_ROW_FLAGS_CHECKBOXES)
	*checkRow=*header\AddRow("Border"):*checkRow\SetData(#MYTABLE_TABLE_FLAGS_BORDER):*checkRow\SetFlags(#MYTABLE_ROW_FLAGS_CHECKBOXES)
	*checkRow=*header\AddRow("No Header"):*checkRow\SetData(#MYTABLE_TABLE_FLAGS_NO_HEADER):*checkRow\SetFlags(#MYTABLE_ROW_FLAGS_CHECKBOXES)
	*checkRow=*header\AddRow("No Redraw"):*checkRow\SetData(#MYTABLE_TABLE_FLAGS_NO_REDRAW):*checkRow\SetFlags(#MYTABLE_ROW_FLAGS_CHECKBOXES)
	*checkRow=*header\AddRow("Callback"):*checkRow\SetData(#MYTABLE_TABLE_FLAGS_CALLBACK):*checkRow\SetFlags(#MYTABLE_ROW_FLAGS_CHECKBOXES)
	*checkRow=*header\AddRow("Sortable"):*checkRow\SetData(#MYTABLE_TABLE_FLAGS_SORTABLE):*checkRow\SetFlags(#MYTABLE_ROW_FLAGS_CHECKBOXES)
	*checkRow=*header\AddRow("Resizeable"):*checkRow\SetData(#MYTABLE_TABLE_FLAGS_RESIZABLE):*checkRow\SetFlags(#MYTABLE_ROW_FLAGS_CHECKBOXES)
	*checkRow=*header\AddRow("Pages"):*checkRow\SetData(#MYTABLE_TABLE_FLAGS_PAGES):*checkRow\SetFlags(#MYTABLE_ROW_FLAGS_CHECKBOXES)
	*checkRow=*header\AddRow("Title"):*checkRow\SetData(#MYTABLE_TABLE_FLAGS_TITLE):*checkRow\SetFlags(#MYTABLE_ROW_FLAGS_CHECKBOXES)
	*checkRow=*header\AddRow("Mark Mouse Over"):*checkRow\SetData(#MYTABLE_TABLE_FLAGS_MARK_MOUSE_OVER):*checkRow\SetFlags(#MYTABLE_ROW_FLAGS_CHECKBOXES)
	*checkRow=*header\AddRow("Editable"):*checkRow\SetData(#MYTABLE_TABLE_FLAGS_EDITABLE):*checkRow\SetFlags(#MYTABLE_ROW_FLAGS_CHECKBOXES)
	*checkRow=*header\AddRow("Zebra"):*checkRow\SetData(#MYTABLE_TABLE_FLAGS_ZEBRA):*checkRow\SetFlags(#MYTABLE_ROW_FLAGS_CHECKBOXES)
	*checkRow=*header\AddRow("Grid"):*checkRow\SetData(#MYTABLE_TABLE_FLAGS_GRID):*checkRow\SetFlags(#MYTABLE_ROW_FLAGS_CHECKBOXES)
	*checkRow=*header\AddRow("Element Selected"):*checkRow\SetData(#MYTABLE_TABLE_FLAGS_ELEMENT_SELECTED):*checkRow\SetFlags(#MYTABLE_ROW_FLAGS_CHECKBOXES)
	*header=*styleTree\AddRow("Text"):styleHeaderRow(*header,#TABLE_TEXT)
	*textRow=*header\AddRow("Title Text"):styleEditCell(*textRow\GetCell(1),#TABLE_TEXT_TITLE)
	*textRow=*header\AddRow("Empty Text"):styleEditCell(*textRow\GetCell(1),#TABLE_TEXT_EMPTY)
	*textRow=*header\AddRow("Name Text"):styleEditCell(*textRow\GetCell(1),#TABLE_TEXT_NAME)
	*header=*styleTree\AddRow("Booleans"):styleHeaderRow(*header,#TABLE_BOOLEAN)
	*checkRow=*header\AddRow("Disabled"):*checkRow\SetData(#TABLE_BOOLEAN_DISABLED):*checkRow\SetFlags(#MYTABLE_ROW_FLAGS_CHECKBOXES)
	*checkRow=*header\AddRow("Recalc"):*checkRow\SetData(#TABLE_BOOLEAN_RECALC):*checkRow\SetFlags(#MYTABLE_ROW_FLAGS_CHECKBOXES)
	*checkRow=*header\AddRow("Redraw"):*checkRow\SetData(#TABLE_BOOLEAN_REDRAW):*checkRow\SetFlags(#MYTABLE_ROW_FLAGS_CHECKBOXES)
	*checkRow=*header\AddRow("Batch"):*checkRow\SetData(#TABLE_BOOLEAN_BATCH):*checkRow\SetFlags(#MYTABLE_ROW_FLAGS_CHECKBOXES)
	*header=*styleTree\AddRow("Values"):styleHeaderRow(*header,#TABLE_VALUES)
	*textRow=*header\AddRow("Rows"):styleEditCellNumber(*textRow\GetCell(1),#TABLE_VALUES_ROWS,"1000")
	*textRow=*header\AddRow("Cols"):styleEditCellNumber(*textRow\GetCell(1),#TABLE_VALUES_COLS,"100")
	*rowFixed=*header\AddRow("FixedCols"):styleEditCellNumber(*rowFixed\GetCell(1),#TABLE_VALUES_FIXED_COLS,"0")
	*header=*styleTree\AddRow("Events"):styleHeaderRow(*header,#TABLE_EVENTS)
	*header=*styleTree\AddRow("Styles"):styleHeaderRow(*header,#TABLE_STYLES)
	
	Global panel=PanelGadget(#PB_Any,0,0,0,0)
	AddGadgetItem(panel,-1,"Preview")
	Global canvasPreview=CanvasGadget(#PB_Any,0,0,0,0,#PB_Canvas_Container|#PB_Canvas_Keyboard)
	Global hscrollPreview=ScrollBarGadget(#PB_Any,0,0,0,20,0,0,0)
	Global vscrollPreview=ScrollBarGadget(#PB_Any,0,0,20,0,0,0,0,#PB_ScrollBar_Vertical)
	CloseGadgetList()
	Global *preview.MyTableTree=MyTableCreateTable(window,canvasPreview,vscrollPreview,hscrollPreview)
	AddGadgetItem(panel,-1,"Source")
	Global editor=EditorGadget(#PB_Any,0,0,0,0,#PB_Editor_ReadOnly)
	CloseGadgetList()
	
	Global splitter=SplitterGadget(#PB_Any,0,0,WindowWidth(window),WindowHeight(window),container,panel,#PB_Splitter_FirstFixed|#PB_Splitter_Separator|#PB_Splitter_Vertical)
	SetGadgetState(splitter,300)
	
	*styleTree\setRedraw(#True)
	*preview\setRedraw(#True)
	
	Procedure Resize()
		ResizeGadget(splitter,
		             #PB_Ignore,
		             #PB_Ignore,
		             WindowWidth(window),
		             WindowHeight(window))
		ResizeGadget(editor,
		             #PB_Ignore,
		             #PB_Ignore,
		             GetGadgetAttribute(panel,#PB_Panel_ItemWidth),
		             GetGadgetAttribute(panel,#PB_Panel_ItemHeight))
		ResizeGadget(canvasPreview,
		             #PB_Ignore,
		             #PB_Ignore,
		             GetGadgetAttribute(panel,#PB_Panel_ItemWidth),
		             GetGadgetAttribute(panel,#PB_Panel_ItemHeight))
		ResizeGadget(canvasStyle,
		             #PB_Ignore,
		             #PB_Ignore,
		             GadgetWidth(container),
		             GadgetHeight(container))
		*styleTree\SetRedraw(#True)
	EndProcedure
	
	BindEvent(#PB_Event_SizeWindow,@Resize(),window)
	BindEvent(#PB_Event_RestoreWindow,@Resize(),window)
	BindEvent(#PB_Event_MaximizeWindow,@Resize(),window)
	BindGadgetEvent(splitter,@Resize())
	BindGadgetEvent(container,@Resize(),#PB_EventType_Resize)
	
	
	Macro _codetableflags(name)
	Case name
		flags|name
		If tableflags<>""
			tableflags+"|"										
		EndIf
		tableflags+MM#name#MM
	EndMacro
	
	Procedure GenerateCode()
		Protected *header.MyTableRow,*row.MyTableRow,*cell.MyTableCell
		Protected tableflags.s=""
		Protected flags=0
		Protected title.s=""
		Protected name.s=""
		Protected empty.s=""		
		Protected booleans.s=""
		Protected cols.i=0
		Protected rows.i=0
		Protected fixed.i=0
		Protected idx
		*preview\SetRedraw(#False)
		
		Protected i,g
		For i=1 To *styleTree\RowCount()
			*header=*styleTree\GetRow(i-1)
			Select *header\GetData()
				Case #TABLE_FLAGS_DEFAULT
					For g=1 To *header\RowCount()
						*row=*header\GetRow(g-1) 
						If *row\GetChecked()
							Select *row\GetData()
									_codetableflags(#MYTABLE_TABLE_FLAGS_DEFAULT_GRID) 
									_codetableflags(#MYTABLE_TABLE_FLAGS_DEFAULT_TABLE) 
									_codetableflags(#MYTABLE_TABLE_FLAGS_DEFAULT_TREE) 
							EndSelect
						EndIf
					Next
				Case #TABLE_FLAGS
					For g=1 To *header\RowCount()
						*row=*header\GetRow(g-1) 
						If *row\GetChecked()
							Select *row\GetData()
									_codetableflags(#MYTABLE_TABLE_FLAGS_HIERARCHICAL) 
									_codetableflags(#MYTABLE_TABLE_FLAGS_HIERARCHICAL_ALWAYS_EXPANDED)
									_codetableflags(#MYTABLE_TABLE_FLAGS_CHECKBOXES)
									_codetableflags(#MYTABLE_TABLE_FLAGS_FULLROWSELECT)
									_codetableflags(#MYTABLE_TABLE_FLAGS_MULTISELECT)
									_codetableflags(#MYTABLE_TABLE_FLAGS_BORDER)
									_codetableflags(#MYTABLE_TABLE_FLAGS_NO_HEADER)
									_codetableflags(#MYTABLE_TABLE_FLAGS_NO_REDRAW)
									_codetableflags(#MYTABLE_TABLE_FLAGS_CALLBACK)
									_codetableflags(#MYTABLE_TABLE_FLAGS_SORTABLE)
									_codetableflags(#MYTABLE_TABLE_FLAGS_RESIZABLE)
									_codetableflags(#MYTABLE_TABLE_FLAGS_PAGES)
									_codetableflags(#MYTABLE_TABLE_FLAGS_TITLE)
									_codetableflags(#MYTABLE_TABLE_FLAGS_MARK_MOUSE_OVER)
									_codetableflags(#MYTABLE_TABLE_FLAGS_EDITABLE)
									_codetableflags(#MYTABLE_TABLE_FLAGS_ZEBRA)
									_codetableflags(#MYTABLE_TABLE_FLAGS_GRID)
									_codetableflags(#MYTABLE_TABLE_FLAGS_ELEMENT_SELECTED)
							EndSelect
						Else
							If *row\GetData() & flags
								*row\SetChecked(#True)
							EndIf
						EndIf
					Next
				Case #TABLE_BOOLEAN
					For g=1 To *header\RowCount()
						*row=*header\GetRow(g-1) 
						If *row\GetChecked()
							Select *row\GetData()
								Case #TABLE_BOOLEAN_REDRAW
									booleans+#CRLF$+LSet("",8," ")+"*preview\SetRedraw(#True)"
								Case #TABLE_BOOLEAN_RECALC
									booleans+#CRLF$+LSet("",8," ")+"*preview\SetRecalc(#True)"
								Case #TABLE_BOOLEAN_BATCH
									booleans+#CRLF$+LSet("",8," ")+"*preview\SetBatch(#True)"
								Case #TABLE_BOOLEAN_DISABLED
									booleans+#CRLF$+LSet("",8," ")+"*preview\SetDisabled(#True)"
									*preview\SetDisabled(#True)
							EndSelect
						Else
							Select *row\GetData()
								Case #TABLE_BOOLEAN_DISABLED
									*preview\SetDisabled(#False)
							EndSelect
						EndIf
					Next					
				Case #TABLE_TEXT
					For g=1 To *header\RowCount()
						*row=*header\GetRow(g-1) 
						*cell=*row\GetCell(1)
						Select *cell\GetData()
							Case #TABLE_TEXT_EMPTY
								empty=*cell\GetText()
							Case #TABLE_TEXT_TITLE
								title=*cell\GetText()	
							Case #TABLE_TEXT_NAME
								name=*cell\GetText()	
						EndSelect
					Next
				Case #TABLE_VALUES
					For g=1 To *header\RowCount()
						*row=*header\GetRow(g-1) 
						*cell=*row\GetCell(1)
						Select *cell\GetData()
							Case #TABLE_VALUES_COLS
								cols=Val(*cell\GetText())
							Case #TABLE_VALUES_ROWS
								rows=Val(*cell\GetText())
							Case #TABLE_VALUES_FIXED_COLS
								fixed=Val(*cell\GetText())
						EndSelect
					Next
			EndSelect
		Next
		
		If flags=#MYTABLE_TABLE_FLAGS_DEFAULT_GRID
			tableflags="#MYTABLE_TABLE_FLAGS_DEFAULT_GRID"
		EndIf
		If flags=#MYTABLE_TABLE_FLAGS_DEFAULT_TABLE
			tableflags="#MYTABLE_TABLE_FLAGS_DEFAULT_TABLE"
		EndIf
		If flags=#MYTABLE_TABLE_FLAGS_DEFAULT_TREE
			tableflags="#MYTABLE_TABLE_FLAGS_DEFAULT_TREE"
		EndIf
		
		Protected result.s=""
		result+"UseModule MyTable"+#CRLF$
		If flags & #MYTABLE_TABLE_FLAGS_CALLBACK
			result+LSet("",4," ")+"Procedure TableCallback(*Row.MyTableRow)"+#CRLF$	+#CRLF$	
			result+LSet("",4," ")+"EndProcedure"+#CRLF$+#CRLF$
		EndIf
		result+LSet("",4," ")+"Procedure createTable(window,canvas,hscroll,vscroll)"+#CRLF$
		result+LSet("",8," ")+"Protected *preview.MyTable=MyTableCreate"
		If flags & #MYTABLE_TABLE_FLAGS_GRID
			result+"Grid(window,canvas,vscroll,hscroll,"+rows+","+cols
		ElseIf flags & #MYTABLE_TABLE_FLAGS_HIERARCHICAL
			result+"Tree(window,canvas,vscroll,hscroll"
		Else
			result+"Table(window,canvas,vscroll,hscroll"
		EndIf
		If tableflags<>""
			result+","+tableflags+")"+#CRLF$
		Else
			result+")"+#CRLF$
		EndIf
		If title<>""
			result+LSet("",8," ")+"*preview\SetTitle("+#DQUOTE$+title+#DQUOTE$+")"+#CRLF$
		EndIf
		If name<>""
			result+LSet("",8," ")+"*preview\SetName("+#DQUOTE$+name+#DQUOTE$+")"+#CRLF$
		EndIf
		If empty<>""
			result+LSet("",8," ")+"*preview\SetEmptyText("+#DQUOTE$+empty+#DQUOTE$+")"+#CRLF$
		EndIf
		If flags & #MYTABLE_TABLE_FLAGS_CALLBACK
			result+LSet("",8," ")+"*preview\BindCallback(@TableCallback())"+#CRLF$
		EndIf
		If booleans<>""
			result+booleans+#CRLF$+#CRLF$
		EndIf
		If fixed>0
			result+LSet("",8," ")+"*preview\SetFixedCols("+fixed+")"+#CRLF$
		EndIf
		result+LSet("",8," ")+"ProcedureReturn *preview"+#CRLF$
		result+LSet("",4," ")+"EndProcedure"+#CRLF$
		result+"UnuseModule MyTable"
		
		Protected *tree.MyTableTree
		Protected *grid.MyTableGrid
		Protected *table.MyTableTable
		
		*preview\SetBatch(#True)
		
		*preview\SetTitle(title)
		*preview\SetEmptyText(empty)
		
		*preview\SetFlags(flags)
		*preview\ReInit()
		
		*rowFixed\SetDisabled(#False)
		
		Select *preview\GetType()
			Case #MYTABLE_TYPE_TABLE
				*table=*preview
				*table\SetFixedCols(fixed)
				For idx=1 To cols
					*table\AddCol("Col "+idx,100)
				Next
				*preview\AddDirtyRows(rows)
			Case #MYTABLE_TYPE_TREE
				*tree=*preview
				*tree\SetFixedCols(fixed)
				For idx=1 To cols
					*tree\AddCol("Col "+idx,100)
				Next
				*preview\AddDirtyRows(rows)
			Case #MYTABLE_TYPE_GRID
				*grid=*preview
				*grid\ResizeGrid(rows,cols)
				*rowFixed\SetDisabled(#True)
		EndSelect
		
		*preview\SetBatch(#False)
		*preview\SetRedraw(#True)
		SetGadgetText(editor,result)
	EndProcedure
	
	Procedure.b RowCheckChange(*row.MyTableRow)
		Protected *parent.MyTableRow=*row\GetParent()
		Protected i,g
		*styleTree\SetRedraw(#False)
		If *parent And *parent\GetData()=#TABLE_FLAGS_DEFAULT
			For i=1 To *styleTree\RowCount()
				*header=*styleTree\GetRow(i-1)
				Select *header\GetData()
					Case #TABLE_FLAGS
						For g=1 To *header\RowCount()
							Protected *trow.MyTableRow=*header\GetRow(g-1) 
							*trow\SetChecked(Bool(*trow\GetData() & *row\GetData()))
						Next
				EndSelect
			Next
		EndIf
		*styleTree\SetRedraw(#True)
		GenerateCode()
	EndProcedure
	
	Procedure.b CellTextChange(*cell.MyTableCell,old.s)
		GenerateCode()
	EndProcedure
	
	Resize()
	GenerateCode()
	
	*styleTree\BindEventCellChangedText(@CellTextChange())
	*styleTree\BindEventRowChangedChecked(@RowCheckChange())
	*styleTree\BindEventRowChangedUnChecked(@RowCheckChange())
	
	Repeat:Until WaitWindowEvent()=#PB_Event_CloseWindow
UnuseModule MyTable