EnableExplicit

XIncludeFile "declare.pb"

UseModule MyTable
	
	Global window=OpenWindow(#PB_Any,0,0,800,600,"Tree",#PB_Window_SystemMenu|#PB_Window_ScreenCentered|#PB_Window_SizeGadget|#PB_Window_MaximizeGadget|#PB_Window_MinimizeGadget)
	Global canvas=CanvasGadget(#PB_Any,0,0,WindowWidth(window),WindowHeight(window),#PB_Canvas_Container|#PB_Canvas_Keyboard)
	Global hscroll=ScrollBarGadget(#PB_Any,0,0,0,20,0,0,0)
	Global vscroll=ScrollBarGadget(#PB_Any,0,0,20,0,0,0,0,#PB_ScrollBar_Vertical)
	CloseGadgetList()
	
	Global *tree.MyTableTable=MyTableCreateTree(window,canvas,vscroll,hscroll)
	*tree\SetRedraw(#False)
	Define *col.MyTableCol,*style.MyTableStyle,*stamm.MyTableRow,*ast.MyTableRow,*zweig.MyTableRow,*blatt.MyTableRow
	*col=*tree\AddCol("Test 1",#PB_Ignore,rowImage)
	
	#Rows=10
	
	Define i,g,h,j
	For i=1 To #Rows
		*stamm=*tree\AddRow("Stamm "+i)
		*stamm\SetExpanded(#True)
		For g=1 To #rows
			*ast=*stamm\AddRow("Ast "+g)
			*ast\SetExpanded(#True)
			For h=1 To #rows
				*zweig=*ast\AddRow("Zweig "+h)
				*zweig\SetExpanded(#True)
				For j=1 To #rows
					*blatt=*zweig\AddRow("Blatt "+j)
				Next
			Next
		Next
	Next
	
	*tree\SetRedraw(#True)
	
	Define *cell.MyTableCell=*tree\GetCell(1,0)
	Define *row.MyTableRow=*cell\GetRow()
	Debug *cell\GetText()
	Debug *row\GetPosition()
	Debug *row\GetVisiblePosition()
	
	Define *vcell.MyTableCell=*tree\GetVisibleCell(12,0)
	Define *vrow.MyTableRow=*vcell\GetRow()
	Debug *vcell\GetText()
	Debug *vrow\GetPosition()
	Debug *vrow\GetVisiblePosition()
	
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
	
	*tree\Free()
UnuseModule MyTable