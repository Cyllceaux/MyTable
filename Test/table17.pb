EnableExplicit

XIncludeFile "declare.pb"

UseModule MyTable
	
	Global window=OpenWindow(#PB_Any,0,0,800,600,"Table 17 (Editable, Sort, Resize, Datatype)",#PB_Window_SystemMenu|#PB_Window_ScreenCentered|#PB_Window_SizeGadget|#PB_Window_MaximizeGadget|#PB_Window_MinimizeGadget)
	Global canvas=CanvasGadget(#PB_Any,0,0,WindowWidth(window),WindowHeight(window),#PB_Canvas_Container|#PB_Canvas_Keyboard)
	Global hscroll=ScrollBarGadget(#PB_Any,0,0,0,20,0,0,0)
	Global vscroll=ScrollBarGadget(#PB_Any,0,0,20,0,0,0,0,#PB_ScrollBar_Vertical)
	CloseGadgetList()
	
	Global *table.MyTableTable=MyTableCreateTable(window,canvas,vscroll,hscroll,#MYTABLE_TABLE_FLAGS_DEFAULT_TABLE|#MYTABLE_TABLE_FLAGS_RESIZABLE|#MYTABLE_TABLE_FLAGS_SORTABLE|#MYTABLE_TABLE_FLAGS_EDITABLE|#MYTABLE_TABLE_FLAGS_MULTISELECT)
	*table\SetRedraw(#False)
	Define *col.MyTableCol,*style.MyTableStyle,*cell.MyTableCell,*row.MyTableRow
	
	
	#Rows=10
	
	Define i,g
	
	*col=*table\AddCol("Test 1",100)
	*col=*table\AddCol("Test 2",100):*col\SetDatatype(#MYTABLE_DATATYPE_DEFAULT)
	*col=*table\AddCol("Test 3",100):*col\SetDatatype(#MYTABLE_DATATYPE_NUMBER)
	*col=*table\AddCol("Test 4",100):*col\SetDatatype(#MYTABLE_DATATYPE_DATE):*col\SetMask("%dd.%mm.%yyyy")
	*col=*table\AddCol("Test 5",100):*col\SetDatatype(#MYTABLE_DATATYPE_DATE):*col\SetMask("%hh:%ii:%ss")
	
	For i=1 To #Rows
		*row=*table\AddRow("Test "+i+"|Inhalt|"+Random(1000)+"|"+FormatDate("%dd.%mm.%yyyy",AddDate(Date(),#PB_Date_Day,Random(1000)))+"|"+FormatDate("%hh:%ii:%ss",AddDate(Date(),#PB_Date_Second,Random(100000))))
	Next
	
	*table\Autosize()
	*table\SetRedraw(#True)
	
	
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