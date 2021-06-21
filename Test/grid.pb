EnableExplicit

XIncludeFile "declare.pb"

UseModule MyTable
	
	Global window=OpenWindow(#PB_Any,0,0,800,600,"Grid",#PB_Window_SystemMenu|#PB_Window_ScreenCentered|#PB_Window_SizeGadget|#PB_Window_MaximizeGadget|#PB_Window_MinimizeGadget)
	Global canvas=CanvasGadget(#PB_Any,0,0,WindowWidth(window),WindowHeight(window),#PB_Canvas_Container|#PB_Canvas_Keyboard)
	Global hscroll=ScrollBarGadget(#PB_Any,0,0,0,20,0,0,0)
	Global vscroll=ScrollBarGadget(#PB_Any,0,0,20,0,0,0,0,#PB_ScrollBar_Vertical)
	CloseGadgetList()
	
	Global *grid.MyTableGrid=MyTableCreateGrid(window,canvas,vscroll,hscroll,0,0)
	*grid\SetRedraw(#False)
	*grid\ResizeGrid(2,2)
	*grid\ResizeGrid(4,4)
	*grid\ResizeGrid(5,#PB_Ignore)
	*grid\ResizeGrid(#PB_Ignore,5)
	*grid\ResizeGrid(3,3)
	*grid\ResizeGrid(100,10)
	*grid\ResizeGrid(10000,100)
	
	*grid\SetRedraw(#True)
	
	Define *cell.MyTableCell=*grid\GetCell(0,0)
	*cell\SetText("Hello")
	*cell=*grid\GetCell(0,1)
	*cell\SetText("World")
	
	
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
	
	*grid\Free()
UnuseModule MyTable