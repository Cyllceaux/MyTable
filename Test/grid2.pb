EnableExplicit

XIncludeFile "declare.pb"

UseModule MyTable
	
	Global window=OpenWindow(#PB_Any,0,0,800,600,"Grid2 (Pages)",#PB_Window_SystemMenu|#PB_Window_ScreenCentered|#PB_Window_SizeGadget|#PB_Window_MaximizeGadget|#PB_Window_MinimizeGadget)
	Global canvas=CanvasGadget(#PB_Any,0,0,WindowWidth(window),WindowHeight(window)-28,#PB_Canvas_Container|#PB_Canvas_Keyboard)
	Global hscroll=ScrollBarGadget(#PB_Any,0,0,0,20,0,0,0)
	Global vscroll=ScrollBarGadget(#PB_Any,0,0,20,0,0,0,0,#PB_ScrollBar_Vertical)
	CloseGadgetList()
	Global pages=SpinGadget(#PB_Any,4,WindowHeight(window)-24,100,20,1,1,#PB_Spin_Numeric)
	
	Global *grid.MyTableGrid=MyTableCreateGrid(window,canvas,vscroll,hscroll,0,0,#MYTABLE_TABLE_FLAGS_DEFAULT_GRID|#MYTABLE_TABLE_FLAGS_PAGES)
	*grid\SetRedraw(#False)
	*grid\ResizeGrid(2,2)
	*grid\ResizeGrid(4,4)
	*grid\ResizeGrid(5,#PB_Ignore)
	*grid\ResizeGrid(#PB_Ignore,5)
	*grid\ResizeGrid(3,3)
	*grid\ResizeGrid(100,10)
	*grid\ResizeGrid(100000,1000)
	*grid\SetPageElements(100)
	
	*grid\SetRedraw(#True)
	
	
	SetGadgetAttribute(pages,#PB_Spin3D_Maximum,*grid\GetPages())
	SetGadgetState(pages,1)
	
	Procedure spin()
		*grid\SetPage(GetGadgetState(pages))
	EndProcedure
	
	Procedure Resize()
		ResizeGadget(canvas,
		             #PB_Ignore,
		             #PB_Ignore,
		             WindowWidth(window),
		             WindowHeight(window)-28)
				ResizeGadget(pages,
		             #PB_Ignore,
		             WindowHeight(window)-24,
		             #PB_Ignore,
		             #PB_Ignore)
	EndProcedure
	
	BindEvent(#PB_Event_SizeWindow,@Resize(),window)
	BindEvent(#PB_Event_RestoreWindow,@Resize(),window)
	BindEvent(#PB_Event_MaximizeWindow,@Resize(),window)
	BindEvent(#PB_Event_MinimizeWindow,@Resize(),window)
	
	BindGadgetEvent(Pages,@spin(),#PB_EventType_Change)
	
	Repeat:Until WaitWindowEvent()=#PB_Event_CloseWindow
	
	*grid\Free()
UnuseModule MyTable