EnableExplicit

XIncludeFile "declare.pb"

UseModule MyTable
	
	Global window=OpenWindow(#PB_Any,0,0,800,600,"Table 16 (Editable, Sort, Resize, ImageLeft)",#PB_Window_SystemMenu|#PB_Window_ScreenCentered|#PB_Window_SizeGadget|#PB_Window_MaximizeGadget|#PB_Window_MinimizeGadget)
	Global canvas=CanvasGadget(#PB_Any,0,0,WindowWidth(window),WindowHeight(window),#PB_Canvas_Container|#PB_Canvas_Keyboard)
	Global hscroll=ScrollBarGadget(#PB_Any,0,0,0,20,0,0,0)
	Global vscroll=ScrollBarGadget(#PB_Any,0,0,20,0,0,0,0,#PB_ScrollBar_Vertical)
	CloseGadgetList()
	
	Global *table.MyTableTable=MyTableCreateTable(window,canvas,vscroll,hscroll,#MYTABLE_TABLE_FLAGS_DEFAULT_TABLE|#MYTABLE_TABLE_FLAGS_RESIZABLE|#MYTABLE_TABLE_FLAGS_SORTABLE|#MYTABLE_TABLE_FLAGS_EDITABLE|#MYTABLE_TABLE_FLAGS_MULTISELECT)
	*table\SetRedraw(#False)
	Define *col.MyTableCol,*style.MyTableStyle,*cell.MyTableCell,*row.MyTableRow
	
	
	#Rows=100
	#Cols=10
	
	Define i,g
	For g=1 To #Cols
		*col=*table\AddCol("Test "+g,100,images(Random(9,0)))
		If g=5
			*col\SetFlags(#MYTABLE_COL_FLAGS_NO_EDITABLE)
		EndIf
	Next
	For i=1 To #Rows
		*row=*table\AddRow("","",images(Random(9,0)))		
		If i=5
			*row\SetFlags(#MYTABLE_ROW_FLAGS_NO_EDITABLE)
		EndIf
		For g=1 To #Cols
			*cell=*row\GetCell(g-1)
			*cell\SetText("Text "+i+"_"+g)
			*cell\SetImageLeft(images(Random(9,0)))	
			If g=i
				*cell\SetFlags(#MYTABLE_CELL_FLAGS_NO_EDITABLE)
			EndIf
		Next
	Next
	
	*table\Autosize()
	*table\SetRedraw(#True)
	
	Procedure.b customCellEdit(*cell.MyTableCell)
		Protected *col.MyTableCol=*cell\GetCol()
		Protected *row.MyTableRow=*cell\GetRow()
		If *col\GetPosition()=2
			Protected result.s=InputRequester("Custom 1","For Column 3",*cell\GetText())
			If result <>""
				*cell\SetText(result)
			EndIf
			ProcedureReturn #True
		EndIf
		ProcedureReturn #False
	EndProcedure
	
	*table\BindEventCustomCellEdit(@customCellEdit())
	
	Procedure Resize()
		ResizeGadget(canvas,
		             #PB_Ignore,
		             #PB_Ignore,
		             WindowWidth(window),
		             WindowHeight(window))
	EndProcedure
	
	BindEvent(#PB_Event_SizeWindow,@Resize(),window)
	BindEvent(#PB_Event_RestoreWindow,@Resize(),window)
	BindEvent(#PB_Event_MaximizeWindow,@Resize(),window)
	BindEvent(#PB_Event_MinimizeWindow,@Resize(),window)
	
	Repeat:Until WaitWindowEvent()=#PB_Event_CloseWindow
	
	*table\Free()
UnuseModule MyTable