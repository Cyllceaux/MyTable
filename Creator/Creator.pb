EnableExplicit


XIncludeFile "../Test/declare.pb"

UseModule MyTable
	
	Enumeration _mytable_creator_tree
		#NONE
		#TABLE_FLAGS
		#TABLE_TEXT
		#TABLE_TEXT_TITLE
		#TABLE_TEXT_EMPTY
	EndEnumeration
	
	Procedure styleHeaderRow(*row.MyTableRow,*dat)
		Protected *style.MyTableStyle
		*row\SetData(*dat)
		*style=*row\GetDefaultStyle()
		*style\SetBackColor(RGBA(50,50,50,255))
		*style\SetForeColor(#White)
		*style=*row\GetSelectedStyle()
		*style\SetBackColor(RGBA(50,50,50,255))
		*style\SetForeColor(#White)
	EndProcedure
	
	Procedure styleEditCell(*cell.MyTableCell,*dat)
		Protected *style.MyTableStyle
		*cell\SetData(*dat)
		*style=*cell\GetDefaultStyle()
		*cell\SetFlags(#MYTABLE_CELL_FLAGS_EDITABLE)
		*style\SetBackColor(#Yellow)
		*style=*cell\GetSelectedStyle()
		*cell\SetFlags(#MYTABLE_CELL_FLAGS_EDITABLE)
		*style\SetBackColor(#Yellow)
	EndProcedure
	
	
	Global window=OpenWindow(#PB_Any,0,0,800,600,"Creator",#PB_Window_SystemMenu|#PB_Window_ScreenCentered|#PB_Window_SizeGadget|#PB_Window_MaximizeGadget|#PB_Window_MinimizeGadget)
	
	Global canvasStyle=CanvasGadget(#PB_Any,0,0,0,0,#PB_Canvas_Container|#PB_Canvas_Keyboard)
	Global hscrollStyle=ScrollBarGadget(#PB_Any,0,0,0,20,0,0,0)
	Global vscrollStyle=ScrollBarGadget(#PB_Any,0,0,20,0,0,0,0,#PB_ScrollBar_Vertical)
	CloseGadgetList()
	
	Global *styleTree.MyTableTree=MyTableCreateTree(window,canvasStyle,vscrollStyle,hscrollStyle,#MYTABLE_TABLE_FLAGS_NO_HEADER|#MYTABLE_TABLE_FLAGS_FULLROWSELECT|#MYTABLE_TABLE_FLAGS_NO_REDRAW)
	Global *header.MyTableRow,*checkRow.MyTableRow,*textRow.MyTableRow,*cell.MyTableCell,*style.MyTableStyle
	*styleTree\AddCol("Name",200)
	*styleTree\AddCol("Value",#PB_Ignore)
	*header=*styleTree\AddRow("Table Type"):styleHeaderRow(*header,#TABLE_FLAGS):*header\SetExpanded(#True):*header\SetFlags(#MYTABLE_ROW_FLAGS_HIERARCHICAL_ALWAYS_EXPANDED)
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
	*header=*styleTree\AddRow("Text"):styleHeaderRow(*header,#TABLE_TEXT):*header\SetExpanded(#True):*header\SetFlags(#MYTABLE_ROW_FLAGS_HIERARCHICAL_ALWAYS_EXPANDED)
	*textRow=*header\AddRow("Title Text"):styleEditCell(*textRow\GetCell(1),#TABLE_TEXT_TITLE)
	*textRow=*header\AddRow("Empty Text"):styleEditCell(*textRow\GetCell(1),#TABLE_TEXT_EMPTY)
	
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
	
	Global splitter=SplitterGadget(#PB_Any,0,0,WindowWidth(window),WindowHeight(window),canvasStyle,panel,#PB_Splitter_FirstFixed|#PB_Splitter_Separator|#PB_Splitter_Vertical)
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
		*styleTree\SetRedraw(#True)
	EndProcedure
	
	BindEvent(#PB_Event_SizeWindow,@Resize(),window)
	BindEvent(#PB_Event_RestoreWindow,@Resize(),window)
	BindEvent(#PB_Event_MaximizeWindow,@Resize(),window)
	
	
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
		Protected empty.s=""
		
		Protected i,g
		For i=1 To *styleTree\RowCount()
			*header=*styleTree\GetRow(i-1)
			Select *header\GetData()
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
		
		Protected result.s="Procedure createTable(window,canvas,hscroll,vscroll)"+#CRLF$
		result+LSet("",4," ")+"UseModule MyTable"+#CRLF$
		If tableflags<>""
			result+LSet("",8," ")+"Protected *preview.MyTable=MyTableCreateTable(window,canvas,vscroll,hscroll,"+tableflags+")"+#CRLF$
		Else
			result+LSet("",8," ")+"Protected *preview.MyTable=MyTableCreateTable(window,canvas,vscroll,hscroll)"+#CRLF$
		EndIf
		If title<>""
			result+LSet("",8," ")+"*preview\SetTitle("+#DQUOTE$+title+#DQUOTE$+")"+#CRLF$
		EndIf
		If empty<>""
			result+LSet("",8," ")+"*preview\SetEmptyText("+#DQUOTE$+empty+#DQUOTE$+")"+#CRLF$
		EndIf
		result+LSet("",8," ")+"ProcedureReturn *preview"+#CRLF$
		result+LSet("",4," ")+"UnuseModule MyTable"+#CRLF$
		result+"EndProcedure"
		
		*preview\SetTitle(title)
		*preview\SetEmptyText(empty)
		*preview\SetFlags(flags)
		
		SetGadgetText(editor,result)
	EndProcedure
	
	Procedure.b RowCheckChange(*row.MyTableRow)
		GenerateCode()
	EndProcedure
	
	Procedure.b CellTextChange(*cell.MyTableCell,old.s)
		GenerateCode()
	EndProcedure
	
	Resize()
	GenerateCode()
	
	*styleTree\RegisterEventCellChangedText(@CellTextChange())
	*styleTree\RegisterEventRowChangedChecked(@RowCheckChange())
	*styleTree\RegisterEventRowChangedUnChecked(@RowCheckChange())
	
	Repeat:Until WaitWindowEvent()=#PB_Event_CloseWindow
UnuseModule MyTable