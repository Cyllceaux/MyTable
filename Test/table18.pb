EnableExplicit

XIncludeFile "declare.pb"

UseModule MyTable
	
	Global window=OpenWindow(#PB_Any,0,0,800,600,"Table 18 (Callback, 1 Million, Pages)",#PB_Window_SystemMenu|#PB_Window_ScreenCentered|#PB_Window_SizeGadget|#PB_Window_MaximizeGadget|#PB_Window_MinimizeGadget)
	Global canvas=CanvasGadget(#PB_Any,0,0,WindowWidth(window),WindowHeight(window)-28,#PB_Canvas_Container|#PB_Canvas_Keyboard)
	Global hscroll=ScrollBarGadget(#PB_Any,0,0,0,20,0,0,0)
	Global vscroll=ScrollBarGadget(#PB_Any,0,0,20,0,0,0,0,#PB_ScrollBar_Vertical)
	CloseGadgetList()
	
	Global pages=SpinGadget(#PB_Any,4,WindowHeight(window)-24,100,20,1,1,#PB_Spin_Numeric)
	
	Global *table.MyTableTable=MyTableCreateTable(window,canvas,vscroll,hscroll,#MYTABLE_TABLE_FLAGS_DEFAULT_TABLE|#MYTABLE_TABLE_FLAGS_FULLROWSELECT|#MYTABLE_TABLE_FLAGS_MULTISELECT|#MYTABLE_TABLE_FLAGS_CALLBACK|#MYTABLE_TABLE_FLAGS_PAGES)
	*table\SetRedraw(#False)
	*table\SetPageElements(100)
	
	Define *col.MyTableCol,*style.MyTableStyle,*cell.MyTableCell,*row.MyTableRow
	*col=*table\AddCol("Test 1",120,rowImage):*style=*col\GetDefaultStyle():*style\SetHAlign(#MYTABLE_STYLE_HALIGN_LEFT)
	*col=*table\AddCol("Test 2",120,rowImageSub):*style=*col\GetDefaultStyle():*style\SetHAlign(#MYTABLE_STYLE_HALIGN_CENTER)
	*col=*table\AddCol("Test 3",120,rowImageSub2):*style=*col\GetDefaultStyle():*style\SetHAlign(#MYTABLE_STYLE_HALIGN_RIGHT)
	
	Procedure callback(*row.MyTableRow)
		Protected *cell1.MyTableCell=*row\GetCell(0)
		Protected *cell2.MyTableCell=*row\GetCell(1)
		Protected *cell3.MyTableCell=*row\GetCell(2)
		*cell1\SetText("Cell "+*row\GetPosition()+"_1")
		*cell2\SetText("Cell "+*row\GetPosition()+"_2")
		*cell3\SetText("Cell "+*row\GetPosition()+"_3")
		
		*cell1\SetImageLeft(images(Random(9,0)))
		*cell2\SetImageLeft(images(Random(9,0)))
		*cell3\SetImageLeft(images(Random(9,0)))
	EndProcedure
	
	*table\AddDirtyRows(1000000)
	*table\RegisterCallback(@callback())
	*table\SetRedraw(#True)
	
	SetGadgetAttribute(pages,#PB_Spin3D_Maximum,*table\GetPages())
	SetGadgetState(pages,1)
	
	Procedure Resize()
		ResizeGadget(canvas,
		             #PB_Ignore,
		             #PB_Ignore,
		             WindowWidth(window),
		             WindowHeight(window))
		ResizeGadget(pages,
		             #PB_Ignore,
		             WindowHeight(window)-24,
		             #PB_Ignore,
		             #PB_Ignore)
	EndProcedure
	
	Procedure spin()
		*table\SetPage(GetGadgetState(pages))
	EndProcedure
	
	BindEvent(#PB_Event_SizeWindow,@Resize(),window)
	BindEvent(#PB_Event_RestoreWindow,@Resize(),window)
	BindEvent(#PB_Event_MaximizeWindow,@Resize(),window)
	BindEvent(#PB_Event_MinimizeWindow,@Resize(),window)
	BindGadgetEvent(Pages,@spin(),#PB_EventType_Change)
	
	Repeat:Until WaitWindowEvent()=#PB_Event_CloseWindow
	
	*table\Free()
UnuseModule MyTable