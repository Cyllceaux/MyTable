EnableExplicit


XIncludeFile "default.pb"
XIncludeFile "..\mytable.pbi"


Enumeration _menu
	#MAIN_NULL
	#MAIN_RETURN
EndEnumeration

UseModule MyTable
	
	Global mainWindow=OpenWindow(#PB_Any,0,0,1100,600,"MyTable Grid",#PB_Window_SystemMenu|#PB_Window_ScreenCentered|#PB_Window_SizeGadget|#PB_Window_MaximizeGadget|#PB_Window_MinimizeGadget)
	Global menu=CreateMenu(#PB_Any,WindowID(mainWindow))
	
	
	Global stringFormula=StringGadget(#PB_Any,0,0,WindowWidth(mainWindow),22,""):DisableGadget(stringFormula,#True)
	Global canvasFormula=CanvasGadget(#PB_Any,0,24,WindowWidth(mainWindow),WindowHeight(mainWindow)-24,#PB_Canvas_Container|#PB_Canvas_Border|#PB_Canvas_Keyboard)
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
		CompilerIf #MYTABLE_MATRIX
			If *cell\GetMatrix()=""
				CompilerIf #MYTABLE_FORMULA
					If *cell\GetFormula()=""
						SetGadgetText(stringFormula,*cell\GetText())
					Else
						SetGadgetText(stringFormula,*cell\GetFormula())
					EndIf
				CompilerElse
					SetGadgetText(stringFormula,*cell\GetText())
				CompilerEndIf
			Else
				SetGadgetText(stringFormula,*cell\GetMatrix())
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
			CompilerIf #MYTABLE_MATRIX
				*cell\SetMatrix(GetGadgetText(stringFormula))
			CompilerElse
				*cell\SetText(GetGadgetText(stringFormula))
			CompilerEndIf
			Protected *table.MyTableTable=*cell\GetTable()
			*table\Recalc()
		EndIf
	EndProcedure
	
	BindEvent(#PB_Event_SizeWindow,@evtResizeWindow(),mainWindow)
	BindEvent(#PB_Event_RestoreWindow,@evtResizeWindow(),mainWindow)
	BindEvent(#PB_Event_MaximizeWindow,@evtResizeWindow(),mainWindow)
	BindMenuEvent(menu,#MAIN_RETURN,@EvtReturn())
	
	
	
	Global *application.MyTableApplication=MyTableCreateApplication()
	
	Define *table.MyTableTable=*application\GridRegister(mainWindow,canvasFormula,hscrollFormula,vscrollFormula,1000,100,#MYTABLE_TABLE_FLAGS_GRID_FORMULA_MATRIX_DEFAULT)
	*table\SetEventCellSelected(@SelectCell())
	
	Define trow=0
	Define tcol=0
	*table\SetRedraw(#False)
	*table\SetCellMatrix(trow,tcol,"{9}"):*table\SetCellText(trow,tcol+1,*table\GetCellMatrix(trow,tcol)):*table\SetCellFormula(trow,tcol+2,"=MATRIXVALUE("+trow+";"+tcol+")"):trow+1
	*table\SetCellMatrix(trow,tcol,"{9;1}"):*table\SetCellText(trow,tcol+1,*table\GetCellMatrix(trow,tcol)):*table\SetCellFormula(trow,tcol+2,"=MATRIXVALUE("+trow+";"+tcol+";0)"):*table\SetCellFormula(trow,tcol+3,"=MATRIXVALUE("+trow+";"+tcol+";1)"):trow+1
	*table\SetCellMatrix(trow,tcol,"{9;1;5}"):*table\SetCellText(trow,tcol+1,*table\GetCellMatrix(trow,tcol)):*table\SetCellFormula(trow,tcol+2,"=MATRIXVALUE("+trow+";"+tcol+";0)"):*table\SetCellFormula(trow,tcol+3,"=MATRIXVALUE("+trow+";"+tcol+";1)"):*table\SetCellFormula(trow,tcol+4,"=MATRIXVALUE("+trow+";"+tcol+";2)"):trow+1
	*table\SetCellMatrix(trow,tcol,"{{9;1};1;5}"):*table\SetCellText(trow,tcol+1,*table\GetCellMatrix(trow,tcol)):*table\SetCellFormula(trow,tcol+2,"=MATRIXVALUE("+trow+";"+tcol+";0;0)"):*table\SetCellFormula(trow,tcol+3,"=MATRIXVALUE("+trow+";"+tcol+";1)"):trow+1
	*table\SetCellMatrix(trow,tcol,"{{9;1};1;{9;1;5}}"):*table\SetCellText(trow,tcol+1,*table\GetCellMatrix(trow,tcol)):*table\SetCellFormula(trow,tcol+2,"=MATRIXVALUE("+trow+";"+tcol+";2;2)"):trow+1
	*table\SetCellMatrix(trow,tcol,"{{9;1;{9;1;5}};1;{9;1;5}}"):*table\SetCellText(trow,tcol+1,*table\GetCellMatrix(trow,tcol)):*table\SetCellFormula(trow,tcol+2,"=MATRIXVALUE("+trow+";"+tcol+";0;2;1)"):trow+1
	*table\SetRedraw(#True)
	
	*table\AutosizeColumn(1)
	*table\AutosizeColumn(2)
	
	
	
	Repeat:Until WaitWindowEvent()=#PB_Event_CloseWindow
	
	
	*table\UnRegister()
	
	
UnuseModule MyTable