EnableExplicit

#MYTABLE_DEBUG = 0
#MYTABLE_DEBUG_LEVEL = 0

DebugLevel #MYTABLE_DEBUG_LEVEL

UsePNGImageDecoder()

XIncludeFile "..\mytable.pbi"


Enumeration _menu
	#MAIN_NULL
	#MAIN_RETURN
EndEnumeration

UseModule MyTable
	
	
	Global mainWindow=OpenWindow(#PB_Any,0,0,1100,600,"MyTable Formula",#PB_Window_SystemMenu|#PB_Window_ScreenCentered|#PB_Window_SizeGadget|#PB_Window_MaximizeGadget|#PB_Window_MinimizeGadget)
	Global menu=CreateMenu(#PB_Any,WindowID(mainWindow))
	
	
	Global stringFormula=StringGadget(#PB_Any,0,0,0,22,""):DisableGadget(stringFormula,#True)
	Global canvasFormula=CanvasGadget(#PB_Any,0,24,0,0,#PB_Canvas_Container|#PB_Canvas_Border|#PB_Canvas_Keyboard)
	Global hscrollFormula=ScrollBarGadget(#PB_Any,0,0,0,20,0,0,100)
	Global vscrollFormula=ScrollBarGadget(#PB_Any,0,0,20,0,0,0,100,#PB_ScrollBar_Vertical)              
	CloseGadgetList()
	
	
	
	Procedure evtResizeWindow()
		
		ResizeGadget(stringFormula,
		             #PB_Ignore,
		             #PB_Ignore,
		             WindowWidth(mainWindow),
		             #PB_Ignore)
		
		ResizeGadget(canvasFormula,
		             #PB_Ignore,
		             #PB_Ignore,
		             WindowWidth(mainWindow),
		             WindowHeight(mainWindow)-24)
	EndProcedure
	
	Procedure SelectCell(*cell.MyTableCell)
		CompilerIf #MYTABLE_FORMULA
			If *cell\GetFormula()=""
				SetGadgetText(stringFormula,*cell\GetText())
			Else
				SetGadgetText(stringFormula,*cell\GetFormula())
			EndIf
		CompilerElse
			SetGadgetText(stringFormula,*cell\GetText())
		CompilerEndIf
		SetGadgetData(stringFormula,*cell)
		DisableGadget(stringFormula,#False)
	EndProcedure
	
	
	;{
	; Workaround for Canvas
		Procedure EvtGF()
			AddKeyboardShortcut(mainWindow,#PB_Shortcut_Return,#MAIN_RETURN)
		EndProcedure
		
		Procedure EvtLF()
			RemoveKeyboardShortcut(mainWindow,#PB_Shortcut_Return)
		EndProcedure
		
		BindGadgetEvent(stringFormula,@EvtGF(),#PB_EventType_Focus)
		BindGadgetEvent(stringFormula,@EvtLF(),#PB_EventType_LostFocus)
	;}
	
	Procedure EvtReturn()
		If GetActiveGadget()=stringFormula
			Protected *cell.MyTableCell=GetGadgetData(stringFormula)
			Protected *table.MyTableTable=*cell\GetTable()
			*cell\SetFormula(GetGadgetText(stringFormula))
			*table\Recalc()
		EndIf
	EndProcedure
	
	BindEvent(#PB_Event_SizeWindow,@evtResizeWindow(),mainWindow)
	BindEvent(#PB_Event_RestoreWindow,@evtResizeWindow(),mainWindow)
	BindEvent(#PB_Event_MaximizeWindow,@evtResizeWindow(),mainWindow)
	BindMenuEvent(menu,#MAIN_RETURN,@EvtReturn())
	
	
	
	Macro DQ
		"
	EndMacro
	
	Macro _makeTimestamp(name)
		CompilerIf #PB_Compiler_Debugger 
			CompilerIf #MYTABLE_DEBUG_LEVEL=1
				Debug "",1
				Debug "------------------"+DQ#name#DQ+"------Dauer: "+Str(ElapsedMilliseconds()-timestamp)+"ms -----------------------------------------------",1
				timestamp=ElapsedMilliseconds()
				Debug "",1
			CompilerEndIf
		CompilerEndIf
	EndMacro
	
	Define timestamp=ElapsedMilliseconds()
	
	
	Define *table.MyTableTable=MyTableGridRegister(mainWindow,canvasFormula,hscrollFormula,vscrollFormula,10000,100,#MYTABLE_TABLE_FLAGS_GRID_FORMULA_DEFAULT)
	*table\SetEventCellSelected(@SelectCell())
	
	_makeTimestamp(Register)
	
	
	
	
	Define frow=0
	*table\SetCellFormula(frow,0,"Hello"):*table\SetCellFormula(frow,1,"World"):frow+1
	*table\SetCellFormula(frow,0,"=1+1"):*table\SetCellFormula(frow,1,"'"+*table\GetCellFormula(frow,0)):frow+1
	*table\SetCellFormula(frow,0,"=1*1"):*table\SetCellFormula(frow,1,"'"+*table\GetCellFormula(frow,0)):frow+1
	*table\SetCellFormula(frow,0,"=1*1+1"):*table\SetCellFormula(frow,1,"'"+*table\GetCellFormula(frow,0)):frow+1
	*table\SetCellFormula(frow,0,"=1*(1+1)"):*table\SetCellFormula(frow,1,"'"+*table\GetCellFormula(frow,0)):frow+1
	*table\SetCellFormula(frow,0,~"=A1 & \" \" & B1"):*table\SetCellFormula(frow,1,"'"+*table\GetCellFormula(frow,0)):frow+1
	*table\SetCellFormula(frow,0,~"=\"Test\"\"\""):*table\SetCellFormula(frow,1,"'"+*table\GetCellFormula(frow,0)):frow+1
	*table\SetCellFormula(frow,0,~"=\"Test\"\"\"\""):*table\SetCellFormula(frow,1,"'"+*table\GetCellFormula(frow,0)):frow+1
	*table\SetCellFormula(frow,0,~"=\"Test: \" & (1+1)"):*table\SetCellFormula(frow,1,"'"+*table\GetCellFormula(frow,0)):frow+1
	*table\SetCellFormula(frow,0,~"=\"Test: \" & (1.5*9.2)"):*table\SetCellFormula(frow,1,"'"+*table\GetCellFormula(frow,0)):frow+1
	*table\SetCellFormula(frow,0,~"=A2+A3+A4+A5"):*table\SetCellFormula(frow,1,"'"+*table\GetCellFormula(frow,0)):frow+1
	*table\SetCellFormula(frow,0,~"=A12"):*table\SetCellFormula(frow,1,"'"+*table\GetCellFormula(frow,0)):frow+1
	
	*table\AutosizeColumn(1)
	*table\AutosizeColumn(2)
	
	_makeTimestamp(AddRow)
	
	
	PostEvent(#PB_Event_SizeWindow,mainWindow,0)
	
	
	Repeat:Until WaitWindowEvent()=#PB_Event_CloseWindow
	
	
	*table\UnRegister()
	
	
UnuseModule MyTable