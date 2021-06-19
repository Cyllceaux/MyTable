EnableExplicit

XIncludeFile "declare.pb"


UseModule MyTable
	
	Structure Element
		canvas.i
		string.i
		vscroll.i
		hscroll.i	
		*grid.MyTableGrid
	EndStructure
	
	Global NewList elemente.Element()
	
	Global window=OpenWindow(#PB_Any,0,0,800,600,"Excel (lookalike)",#PB_Window_SystemMenu|#PB_Window_ScreenCentered|#PB_Window_SizeGadget|#PB_Window_MaximizeGadget|#PB_Window_MinimizeGadget)
	
	Global panel=PanelGadget(#PB_Any,0,0,WindowWidth(window),WindowHeight(window))
	CloseGadgetList()
	
	
	Global *app.MyTableApplication=MyTableCreateApplication()
	
	Procedure.b EvtCellSelect(*cell.MyTableCell)
		Protected *grid.MyTableGrid=*cell\GetTable()
		Protected *element.Element=*grid\GetData()
		
		If *cell\GetFormula()<>""
			SetGadgetText(*element\string,*cell\GetFormula())
		Else
			SetGadgetText(*element\string,*cell\GetText())
		EndIf
	EndProcedure
	
	Procedure.b EvtCellSelectTextChange(*cell.MyTableCell,old.s)
		Protected *grid.MyTableGrid=*cell\GetTable()
		Protected *element.Element=*grid\GetData()
		
		If *cell\GetFormula()<>""
			SetGadgetText(*element\string,*cell\GetFormula())
		Else
			SetGadgetText(*element\string,*cell\GetText())
		EndIf
	EndProcedure
	
	
	Procedure AddGridElement()
		Protected *element.Element=AddElement(elemente())
		OpenGadgetList(panel)
		AddGadgetItem(panel,-1,"Grid 1")
		*element\string=StringGadget(#PB_Any,0,0,GetGadgetAttribute(panel,#PB_Panel3D_ItemWidth),22,"")
		*element\canvas=CanvasGadget(#PB_Any,0,24,GetGadgetAttribute(panel,#PB_Panel3D_ItemWidth),GetGadgetAttribute(panel,#PB_Panel3D_ItemHeight)-24,#PB_Canvas_Container|#PB_Canvas_Keyboard)
		*element\hscroll=ScrollBarGadget(#PB_Any,0,0,0,20,0,0,0)
		*element\vscroll=ScrollBarGadget(#PB_Any,0,0,20,0,0,0,0,#PB_ScrollBar_Vertical)
		CloseGadgetList()
		CloseGadgetList()
		SetGadgetData(*element\string,*element)
		*element\grid=*app\AddGrid(window,
		                           *element\canvas,
		                           *element\vscroll,
		                           *element\hscroll,
		                           10000,
		                           100,
		                           "",
		                           #MYTABLE_TABLE_FLAGS_DEFAULT_GRID|#MYTABLE_TABLE_FLAGS_NO_REDRAW)
		*element\grid\SetData(*element)
		SetGadgetItemText(panel,CountGadgetItems(panel)-1,*element\grid\GetName())
		*element\grid\SetRedraw(#True)
		*element\grid\RegisterEventCellSelected(@EvtCellSelect())
		*element\grid\RegisterEventCellChangedText(@EvtCellSelectTextChange())
	EndProcedure
	
	Procedure Resize()
		ResizeGadget(panel,
		             #PB_Ignore,
		             #PB_Ignore,
		             WindowWidth(window),
		             WindowHeight(window))
		
		ForEach elemente()
			ResizeGadget(elemente()\string,
			             #PB_Ignore,
			             #PB_Ignore,
			             GetGadgetAttribute(panel,#PB_Panel3D_ItemWidth),
			             #PB_Ignore)
			ResizeGadget(elemente()\canvas,
			             #PB_Ignore,
			             #PB_Ignore,
			             GetGadgetAttribute(panel,#PB_Panel3D_ItemWidth),
			             GetGadgetAttribute(panel,#PB_Panel3D_ItemHeight)-24)
		Next
	EndProcedure
	
	AddGridElement()
	AddGridElement()
	AddGridElement()

	
	BindEvent(#PB_Event_SizeWindow,@Resize(),window)
	BindEvent(#PB_Event_RestoreWindow,@Resize(),window)
	BindEvent(#PB_Event_MaximizeWindow,@Resize(),window)
	BindEvent(#PB_Event_MinimizeWindow,@Resize(),window)
	
	Repeat:Until WaitWindowEvent()=#PB_Event_CloseWindow
	
	*app\Free()
UnuseModule MyTable