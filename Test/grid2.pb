EnableExplicit


#MYTABLE_FORMULA = 0

XIncludeFile "..\mytable.pbi"


Enumeration _menu
	#MAIN_NULL
	#MAIN_RETURN
EndEnumeration

UseModule MyTable
	
	Global mainWindow=OpenWindow(#PB_Any,0,0,1100,600,"MyTable Grid2",#PB_Window_SystemMenu|#PB_Window_ScreenCentered|#PB_Window_SizeGadget|#PB_Window_MaximizeGadget|#PB_Window_MinimizeGadget)
	Global menu=CreateMenu(#PB_Any,WindowID(mainWindow))
	
	
	Global canvasFormula=CanvasGadget(#PB_Any,0,0,WindowWidth(mainWindow),WindowHeight(mainWindow),#PB_Canvas_Container|#PB_Canvas_Border|#PB_Canvas_Keyboard)
	Global hscrollFormula=ScrollBarGadget(#PB_Any,0,0,0,20,0,0,100)
	Global vscrollFormula=ScrollBarGadget(#PB_Any,0,0,20,0,0,0,100,#PB_ScrollBar_Vertical)              
	CloseGadgetList()
	
	
	
	Procedure evtResizeWindow()
		
		ResizeGadget(canvasFormula,
		             #PB_Ignore,
		             #PB_Ignore,
		             WindowWidth(mainWindow),
		             WindowHeight(mainWindow))
	EndProcedure
	
	
	BindEvent(#PB_Event_SizeWindow,@evtResizeWindow(),mainWindow)
	BindEvent(#PB_Event_RestoreWindow,@evtResizeWindow(),mainWindow)
	BindEvent(#PB_Event_MaximizeWindow,@evtResizeWindow(),mainWindow)
	
	Define *table.MyTableTable=MyTableGridRegister(mainWindow,canvasFormula,hscrollFormula,vscrollFormula,100,10)
	
	Define frow=0
	*table\SetCellText(frow,0,"Hello"):*table\SetCellText(frow,1,"World"):frow+1
	
	
	
	Repeat:Until WaitWindowEvent()=#PB_Event_CloseWindow
	
	
	*table\UnRegister()
	
	
UnuseModule MyTable