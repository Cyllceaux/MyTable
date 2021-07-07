EnableExplicit

XIncludeFile "declare.pb"


UseModule MyTable
	
	Structure Element
		canvas.i
		string.i
		vscroll.i
		hscroll.i	
		*grid.MyTableGrid
		menu.i
	EndStructure
	
	Global NewList elemente.Element()
	
	Global window=OpenWindow(#PB_Any,0,0,900,600,"Grid3 (fonts, Borders, Editable)",#PB_Window_SystemMenu|#PB_Window_ScreenCentered|#PB_Window_SizeGadget|#PB_Window_MaximizeGadget|#PB_Window_MinimizeGadget)
	Global menu=CreateMenu(#PB_Any,WindowID(window))
	
	XIncludeFile "menu.pb"
	
	Global panel=PanelGadget(#PB_Any,0,by,WindowWidth(window),WindowHeight(window)-by)
	CloseGadgetList()
	
		
	Procedure KeyEdit()
		Protected gadget=GetActiveGadget()
		Protected *element.Element=GetGadgetData(gadget)
		
		Protected NewList cells.MyTableCell()
		*element\grid\GetSelectedCells(cells())
		*element\grid\SetRedraw(#False)
		ForEach cells()
			cells()\SetText(GetGadgetText(*element\string))	
		Next
		*element\grid\SetRedraw(#True)
		FreeList(cells())
	EndProcedure
	
	BindMenuEvent(menu,100,@KeyEdit())
	
	Procedure FF()
		AddKeyboardShortcut(window,#PB_Shortcut_Return,100)		
	EndProcedure
	
	Procedure LF()
		RemoveKeyboardShortcut(window,#PB_Shortcut_Return)
	EndProcedure
	
	
	
	
	Procedure.b EvtCellSelect(*cell.MyTableCell)
		Protected *grid.MyTableGrid=*cell\GetTable()
		*selectedTable=*grid
		Protected *element.Element=*grid\GetData()
		
		Protected *style.MyTableStyle=*cell\GetDefaultStyle()
		
		ButtonUpdate(*style)
		
		If *cell\GetFormula()<>""
			SetGadgetText(*element\string,*cell\GetFormula())
		Else
			SetGadgetText(*element\string,*cell\GetText())
		EndIf
	EndProcedure
	
	Procedure.b EvtRowSelect(*row.MyTableRow)
		Protected *grid.MyTableGrid=*row\GetTable()
		*selectedTable=*grid
		Protected *element.Element=*grid\GetData()
		
		Protected *style.MyTableStyle=*row\GetDefaultStyle()
		
		ButtonUpdate(*style)
	EndProcedure
	
	Procedure.b EvtColSelect(*col.MyTableCol)
		Protected *grid.MyTableGrid=*col\GetTable()
		*selectedTable=*grid
		Protected *element.Element=*grid\GetData()
		
		Protected *style.MyTableStyle=*col\GetDefaultStyle()
		
		ButtonUpdate(*style)
	EndProcedure
	
	Procedure.b EvtCellSelectTextChange(*cell.MyTableCell,old.s)
		Protected *grid.MyTableGrid=*cell\GetTable()
		*selectedTable=*grid
		Protected *element.Element=*grid\GetData()
		
		If *cell\GetFormula()<>""
			SetGadgetText(*element\string,*cell\GetFormula())
		Else
			SetGadgetText(*element\string,*cell\GetText())
		EndIf
	EndProcedure
	
	Procedure change()
		ForEach elemente()
			elemente()\grid\SetRedraw(Bool(GetGadgetState(panel)=ListIndex(elemente())))
			If Bool(GetGadgetState(panel)=ListIndex(elemente()))
				*selectedTable=elemente()\grid
				ButtonUpdate(elemente()\grid\GetDefaultStyle())
			EndIf
		Next
	EndProcedure
	
	
	
	Procedure AddGridElement()
		Protected *element.Element=AddElement(elemente())
		OpenGadgetList(panel)
		AddGadgetItem(panel,-1,"Grid")
		Protected pw=GetGadgetAttribute(panel,#PB_Panel_ItemWidth)
		Protected ph=GetGadgetAttribute(panel,#PB_Panel_ItemHeight)
		*element\string=EditorGadget(#PB_Any,0,0,pw,22)
		BindGadgetEvent(*element\string,@FF(),#PB_EventType_Focus)
		BindGadgetEvent(*element\string,@LF(),#PB_EventType_LostFocus)
		*element\canvas=CanvasGadget(#PB_Any,0,24,pw,ph-24,#PB_Canvas_Container|#PB_Canvas_Keyboard)
		*element\hscroll=ScrollBarGadget(#PB_Any,0,0,0,20,0,0,0)
		*element\vscroll=ScrollBarGadget(#PB_Any,0,0,20,0,0,0,0,#PB_ScrollBar_Vertical)
		CloseGadgetList()
		CloseGadgetList()	
		
		SetGadgetData(*element\string,*element)
		*element\grid=MyTableCreateGrid(window,
		                           *element\canvas,
		                           *element\vscroll,
		                           *element\hscroll,
		                           10000,
		                           100,
		                           #MYTABLE_TABLE_FLAGS_DEFAULT_GRID|#MYTABLE_TABLE_FLAGS_NO_REDRAW|#MYTABLE_TABLE_FLAGS_MARK_MOUSE_OVER)		
		*element\grid\SetName("Grid "+CountGadgetItems(panel))
		*element\grid\SetData(*element)
		SetGadgetItemText(panel,CountGadgetItems(panel)-1,*element\grid\GetName())
		*element\grid\BindEventCellSelected(@EvtCellSelect())
		*element\grid\BindEventColSelected(@EvtColSelect())
		*element\grid\BindEventRowSelected(@EvtRowSelect())
		*element\grid\BindEventCellChangedText(@EvtCellSelectTextChange())
		change()
	EndProcedure
	
	Procedure Resize()
		ResizeGadget(panel,
		             #PB_Ignore,
		             #PB_Ignore,
		             WindowWidth(window),
		             WindowHeight(window)-by)
		
		ForEach elemente()
			ResizeGadget(elemente()\string,
			             #PB_Ignore,
			             #PB_Ignore,
			             GetGadgetAttribute(panel,#PB_Panel_ItemWidth),
			             #PB_Ignore)
			ResizeGadget(elemente()\canvas,
			             #PB_Ignore,
			             #PB_Ignore,
			             GetGadgetAttribute(panel,#PB_Panel_ItemWidth),
			             GetGadgetAttribute(panel,#PB_Panel_ItemHeight)-24)
			
		Next
	EndProcedure
	
	
	AddGridElement()
	AddGridElement()
	AddGridElement()
	
	
	BindEvent(#PB_Event_SizeWindow,@Resize(),window)
	BindEvent(#PB_Event_RestoreWindow,@Resize(),window)
	BindEvent(#PB_Event_MaximizeWindow,@Resize(),window)
	BindEvent(#PB_Event_MinimizeWindow,@Resize(),window)
	BindGadgetEvent(panel,@change(),#PB_EventType_Change)
	
	
	
	Repeat:Until WaitWindowEvent()=#PB_Event_CloseWindow
	
UnuseModule MyTable