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
	
	Define *table.MyTableTable=MyTableRegister(mainWindow,canvasFormula,hscrollFormula,vscrollFormula)
	*table\AddColumn("Column 1",100)
	*table\AddColumn("Column 2",100)
	*table\AddColumn("Column 3",100)
	*table\AddColumn("Column 4",100)
	
	Define frow=0
	For frow=1 To 10
		*table\AddRow(Str(frow)+"|Text "+frow+"|second "+frow+"|more text"+frow)
	Next
	Define *row.MyTableRow=*table\GetRow(3)
	Define *col.MyTableCol=*table\GetCol(2)
	Define *cell.MyTableCol=*table\GetCell(3,2)
	Define *cell2.MyTableCol=*table\GetCell(1,1)
	
	Define fontT=LoadFont(#PB_Any,"Arial",10,#PB_Font_HighQuality)
	Define fontR=LoadFont(#PB_Any,"Arial",12,#PB_Font_HighQuality|#PB_Font_Bold)
	Define fontC=LoadFont(#PB_Any,"Arial",14,#PB_Font_HighQuality|#PB_Font_Italic)
	Define fontCell=LoadFont(#PB_Any,"Arial",26,#PB_Font_HighQuality)
	
	*table\SetFont(FontID(fontT))
	*row\SetFont(FontID(fontR)):*row\SetBackground(RGBA(240,250,240,255))
	NewList cells.MyTableCell()
	*row\GetCells(cells())
	*col\SetFont(FontID(fontC)):*col\SetBackground(RGBA(240,250,250,255))
	*cell\SetFont(FontID(fontCell)):*cell\SetBackground(RGBA(250,240,250,255))
	*cell2\SetFont(FontID(fontCell)):*cell2\SetBackground(RGBA(250,240,250,255))

	*table\SetBackground(RGBA(255,255,240,255))
	*table\AutosizeHeader(#PB_Ignore)
	*table\AutosizeColumn(#PB_Ignore)
	*table\AutosizeRow(#PB_Ignore)
	
	
	Repeat:Until WaitWindowEvent()=#PB_Event_CloseWindow
	
	
	*table\UnRegister()
	
	
UnuseModule MyTable