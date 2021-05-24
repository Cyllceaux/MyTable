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

Procedure SelectCell(canvas,*cell.strMyTableCell)
	CompilerIf #MYTABLE_FORMULA
		If *cell\formula=""
			SetGadgetText(stringFormula,*cell\text)
		Else
			SetGadgetText(stringFormula,*cell\formula)
		EndIf
	CompilerElse
		SetGadgetText(stringFormula,*cell\text)
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
		Protected *cell.strMyTableCell=GetGadgetData(stringFormula)
		_MyTableFillCellFormula(*cell,GetGadgetText(stringFormula))
		MyTableRecalc(canvasFormula)
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


MyTableGridRegister(mainWindow,canvasFormula,hscrollFormula,vscrollFormula,10000,100)
MyTableSetEventCellSelected(canvasFormula,@SelectCell())

_makeTimestamp(Register)



_makeTimestamp(AddRow)


PostEvent(#PB_Event_SizeWindow,mainWindow,0)

ResizeWindow(mainWindow,#PB_Ignore,#PB_Ignore,1100,620)

Repeat:Until WaitWindowEvent()=#PB_Event_CloseWindow


MyTableUnRegister(canvasFormula)


