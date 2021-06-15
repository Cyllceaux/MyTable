EnableExplicit

XIncludeFile "declare.pb"

UseModule MyTable
	
	Global window=OpenWindow(#PB_Any,0,0,800,600,"Table1",#PB_Window_SystemMenu|#PB_Window_ScreenCentered|#PB_Window_SizeGadget|#PB_Window_MaximizeGadget|#PB_Window_MinimizeGadget)
	Global canvas=CanvasGadget(#PB_Any,0,0,WindowWidth(window),WindowHeight(window),#PB_Canvas_Container|#PB_Canvas_Keyboard)
	Global hscroll=ScrollBarGadget(#PB_Any,0,0,0,20,0,0,0)
	Global vscroll=ScrollBarGadget(#PB_Any,0,0,20,0,0,0,0,#PB_ScrollBar_Vertical)
	CloseGadgetList()
	
	Global *table.MyTableTable=MyTableCreateTable(window,canvas,vscroll,hscroll)
	*table\SetRedraw(#False)
	*table\SetHeaderHeight(40)
	Define *col.MyTableCol,*style.MyTableStyleCol
	*col=*table\AddCol("Test 1",100):*style=*col\GetStyle():*style\SetHAlign(#MYTABLE_STYLE_HALIGN_LEFT)
	*col=*table\AddCol("Test 2",100):*style=*col\GetStyle():*style\SetHAlign(#MYTABLE_STYLE_HALIGN_CENTER)
	*col=*table\AddCol("Test 3",100):*style=*col\GetStyle():*style\SetHAlign(#MYTABLE_STYLE_HALIGN_RIGHT)
	*col=*table\AddCol("Test 4",100):*style=*col\GetStyle():*style\SetHAlign(#MYTABLE_STYLE_HALIGN_LEFT):*style\SetVAlign(#MYTABLE_STYLE_VALIGN_TOP)
	*col=*table\AddCol("Test 5",100):*style=*col\GetStyle():*style\SetHAlign(#MYTABLE_STYLE_HALIGN_CENTER):*style\SetVAlign(#MYTABLE_STYLE_VALIGN_MIDDLE)
	*col=*table\AddCol("Test 6",100):*style=*col\GetStyle():*style\SetHAlign(#MYTABLE_STYLE_HALIGN_RIGHT):*style\SetVAlign(#MYTABLE_STYLE_VALIGN_BOTTOM)
	
	
	#Rows=100
	#Cols=10
	
	Define i,g
	For g=7 To #Cols
		*table\AddCol("Test "+g,100)
	Next
	For i=1 To #Rows
		Define line.s="Test 1_"+i
		For g=2 To #Cols
			line+"|Test "+g+"_"+i
		Next
		*table\AddRow(line)
	Next
	
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