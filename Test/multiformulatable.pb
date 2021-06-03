EnableExplicit

XIncludeFile "default.pb"
XIncludeFile "..\mytable.pbi"

UseModule MyTable
	
	Enumeration _menu
		#MAIN_NULL
		#MAIN_RETURN
	EndEnumeration
	
	Global mainWindow=OpenWindow(#PB_Any,0,0,800,600,"Multi Formula Grids",#PB_Window_SystemMenu|#PB_Window_ScreenCentered|#PB_Window_SizeGadget|#PB_Window_MaximizeGadget|#PB_Window_MinimizeGadget)
	Global menu=CreateMenu(#PB_Any,WindowID(mainWindow))
	
	Global panel=PanelGadget(#PB_Any,0,0,WindowWidth(mainWindow),WindowHeight(mainWindow))
	AddGadgetItem(panel,-1,"Table 1")
	Global stringFormula1=StringGadget(#PB_Any,0,0,0,22,""):DisableGadget(stringFormula1,#True)
	Global canvasFormula1=CanvasGadget(#PB_Any,0,24,0,0,#PB_Canvas_Container|#PB_Canvas_Border|#PB_Canvas_Keyboard)
	Global hscrollFormula1=ScrollBarGadget(#PB_Any,0,0,0,20,0,0,100)
	Global vscrollFormula1=ScrollBarGadget(#PB_Any,0,0,20,0,0,0,100,#PB_ScrollBar_Vertical)              
	CloseGadgetList()
	AddGadgetItem(panel,-1,"Table 2")
	Global stringFormula2=StringGadget(#PB_Any,0,0,0,22,""):DisableGadget(stringFormula2,#True)
	Global canvasFormula2=CanvasGadget(#PB_Any,0,24,0,0,#PB_Canvas_Container|#PB_Canvas_Border|#PB_Canvas_Keyboard)
	Global hscrollFormula2=ScrollBarGadget(#PB_Any,0,0,0,20,0,0,100)
	Global vscrollFormula2=ScrollBarGadget(#PB_Any,0,0,20,0,0,0,100,#PB_ScrollBar_Vertical)              
	CloseGadgetList()
	AddGadgetItem(panel,-1,"Table 3")
	Global stringFormula3=StringGadget(#PB_Any,0,0,0,22,""):DisableGadget(stringFormula3,#True)
	Global canvasFormula3=CanvasGadget(#PB_Any,0,24,0,0,#PB_Canvas_Container|#PB_Canvas_Border|#PB_Canvas_Keyboard)
	Global hscrollFormula3=ScrollBarGadget(#PB_Any,0,0,0,20,0,0,100)
	Global vscrollFormula3=ScrollBarGadget(#PB_Any,0,0,20,0,0,0,100,#PB_ScrollBar_Vertical)              
	CloseGadgetList()
	CloseGadgetList()
	
	Procedure SelectCell(*cell.MyTableCell)
		Protected stringFormula=0
		Protected *table.MyTableTable=*cell\GetTable()
		Select *table\GetCanvas()
			Case canvasFormula1
				stringFormula=stringFormula1
			Case canvasFormula2
				stringFormula=stringFormula2
			Case canvasFormula3
				stringFormula=stringFormula3
		EndSelect
		
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
	
	Global *application.MyTableApplication=MyTableCreateApplication()
	
	CompilerIf #MYTABLE_FORMULA Or #MYTABLE_MATRIX
		Define *canvasFormula1.MyTableTable=*application\GridRegister(mainWindow,canvasFormula1,hscrollFormula1,vscrollFormula1,1000,100,#MYTABLE_TABLE_FLAGS_GRID_FORMULA_DEFAULT,0,"canvasFormula1")
		Define *canvasFormula2.MyTableTable=*application\GridRegister(mainWindow,canvasFormula2,hscrollFormula2,vscrollFormula2,1000,100,#MYTABLE_TABLE_FLAGS_GRID_FORMULA_DEFAULT,0,"canvasFormula2")
		Define *canvasFormula3.MyTableTable=*application\GridRegister(mainWindow,canvasFormula3,hscrollFormula3,vscrollFormula3,1000,100,#MYTABLE_TABLE_FLAGS_GRID_FORMULA_DEFAULT,0,"canvasFormula3")
	CompilerElse
		Define *canvasFormula1.MyTableTable=*application\GridRegister(mainWindow,canvasFormula1,hscrollFormula1,vscrollFormula1,1000,100,#MYTABLE_TABLE_FLAGS_GRID_DEFAULT,0,"canvasFormula1")
		Define *canvasFormula2.MyTableTable=*application\GridRegister(mainWindow,canvasFormula2,hscrollFormula2,vscrollFormula2,1000,100,#MYTABLE_TABLE_FLAGS_GRID_DEFAULT,0,"canvasFormula2")
		Define *canvasFormula3.MyTableTable=*application\GridRegister(mainWindow,canvasFormula3,hscrollFormula3,vscrollFormula3,1000,100,#MYTABLE_TABLE_FLAGS_GRID_DEFAULT,0,"canvasFormula3")
	CompilerEndIf
	
	*canvasFormula1\SetEventCellSelected(@SelectCell())
	*canvasFormula2\SetEventCellSelected(@SelectCell())
	*canvasFormula3\SetEventCellSelected(@SelectCell())
	
	;{
	; Workaround for Canvas
		Procedure EvtGF()
			AddKeyboardShortcut(mainWindow,#PB_Shortcut_Return,#MAIN_RETURN)
		EndProcedure
		
		Procedure EvtLF()
			RemoveKeyboardShortcut(mainWindow,#PB_Shortcut_Return)
		EndProcedure
		
		BindGadgetEvent(stringFormula1,@EvtGF(),#PB_EventType_Focus)
		BindGadgetEvent(stringFormula1,@EvtLF(),#PB_EventType_LostFocus)
		BindGadgetEvent(stringFormula2,@EvtGF(),#PB_EventType_Focus)
		BindGadgetEvent(stringFormula2,@EvtLF(),#PB_EventType_LostFocus)
		BindGadgetEvent(stringFormula3,@EvtGF(),#PB_EventType_Focus)
		BindGadgetEvent(stringFormula3,@EvtLF(),#PB_EventType_LostFocus)
	;}
	
	Procedure EvtReturn()
		If GetActiveGadget()=stringFormula1 Or GetActiveGadget()=stringFormula2 Or GetActiveGadget()=stringFormula3
			Protected *cell.MyTableCell=GetGadgetData(GetActiveGadget())
			Protected *table.MyTableTable=*cell\GetTable()
			
			*cell\SetMatrix(GetGadgetText(GetActiveGadget()))
			*table\Recalc()
		EndIf
	EndProcedure
	
	Procedure evtResizeWindow()
		ResizeGadget(panel,
		             #PB_Ignore,
		             #PB_Ignore,
		             WindowWidth(EventWindow()),
		             WindowHeight(EventWindow()))
		ResizeGadget(stringFormula1,
		             #PB_Ignore,
		             #PB_Ignore,
		             GetGadgetAttribute(panel,#PB_Panel_ItemWidth),
		             #PB_Ignore)
		
		ResizeGadget(canvasFormula1,
		             #PB_Ignore,
		             #PB_Ignore,
		             GetGadgetAttribute(panel,#PB_Panel_ItemWidth),
		             GetGadgetAttribute(panel,#PB_Panel_ItemHeight)-24)
		ResizeGadget(stringFormula2,
		             #PB_Ignore,
		             #PB_Ignore,
		             GetGadgetAttribute(panel,#PB_Panel_ItemWidth),
		             #PB_Ignore)
		
		ResizeGadget(canvasFormula2,
		             #PB_Ignore,
		             #PB_Ignore,
		             GetGadgetAttribute(panel,#PB_Panel_ItemWidth),
		             GetGadgetAttribute(panel,#PB_Panel_ItemHeight)-24)
		
		ResizeGadget(stringFormula3,
		             #PB_Ignore,
		             #PB_Ignore,
		             GetGadgetAttribute(panel,#PB_Panel_ItemWidth),
		             #PB_Ignore)
		
		ResizeGadget(canvasFormula3,
		             #PB_Ignore,
		             #PB_Ignore,
		             GetGadgetAttribute(panel,#PB_Panel_ItemWidth),
		             GetGadgetAttribute(panel,#PB_Panel_ItemHeight)-24)
	EndProcedure
	
	BindEvent(#PB_Event_SizeWindow,@evtResizeWindow(),mainWindow)
	BindEvent(#PB_Event_RestoreWindow,@evtResizeWindow(),mainWindow)
	BindEvent(#PB_Event_MaximizeWindow,@evtResizeWindow(),mainWindow)
	BindMenuEvent(menu,#MAIN_RETURN,@EvtReturn())
	
	
	*application\SetRecalc(#False)
	Define trow,tcol,i,g
	For trow=0 To 10
		For tcol=0 To 3
			*canvasFormula1\SetCellValue(trow,tcol,Random(100,1))
			*canvasFormula2\SetCellValue(trow,tcol,Random(1000,1)/100)
			*canvasFormula3\SetCellFormula(trow,tcol,"=canvasFormula1!RC+canvasFormula2!RC")
		Next	
		tcol+1
		*canvasFormula1\SetCellFormula(trow,tcol,"=SUM(RC(-5):RC(-2))")
		*canvasFormula2\SetCellFormula(trow,tcol,"=MUL(RC(-5):RC(-2))")		
		*canvasFormula3\SetCellFormula(trow,tcol,"=SUM(canvasFormula1!RC(-5):RC(-2))+MUL(canvasFormula2!RC(-5):RC(-2))")
		*canvasFormula3\SetCellFormula(trow,tcol+1,"=canvasFormula1!RC(-1)+canvasFormula2!RC(-1)")
	Next
	*application\SetRecalc(#True)

	
	PostEvent(#PB_Event_SizeWindow,mainWindow,0)
	
	Repeat:Until WaitWindowEvent()=#PB_Event_CloseWindow
	
	*application\UnRegister()
	
UnuseModule MyTable