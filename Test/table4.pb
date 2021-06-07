EnableExplicit

XIncludeFile "declare.pb"

UseModule MyTable
	
	Global window=OpenWindow(#PB_Any,0,0,800,600,"Table 4",#PB_Window_SystemMenu|#PB_Window_ScreenCentered|#PB_Window_SizeGadget|#PB_Window_MaximizeGadget|#PB_Window_MinimizeGadget)
	Global canvas=CanvasGadget(#PB_Any,0,0,WindowWidth(window),WindowHeight(window),#PB_Canvas_Container|#PB_Canvas_Keyboard)
	Global hscroll=ScrollBarGadget(#PB_Any,0,0,0,20,0,0,0)
	Global vscroll=ScrollBarGadget(#PB_Any,0,0,20,0,0,0,0,#PB_ScrollBar_Vertical)
	CloseGadgetList()
	
	Global *table.MyTableTable=MyTableCreateTable(window,canvas,vscroll,hscroll)
	*table\SetRedraw(#False)
	Define *col.MyTableCol,*style.MyTableStyleCol,*cell.MyTableCell,*row.MyTableRow
	*col=*table\AddCol("Test 1",120,rowImage):*style=*col\GetStyle():*style\SetHAlign(#MYTABLE_STYLE_HALIGN_LEFT)
	*col=*table\AddCol("Test 2",120,rowImageSub):*style=*col\GetStyle():*style\SetHAlign(#MYTABLE_STYLE_HALIGN_CENTER)
	*col=*table\AddCol("Test 3",120,rowImageSub2):*style=*col\GetStyle():*style\SetHAlign(#MYTABLE_STYLE_HALIGN_RIGHT)
	
	
	#Rows=100
	#Cols=10
	
	Define i,g
	For g=4 To #Cols
		*col=*table\AddCol("Test "+g,120,images(Random(9,0)))		
	Next
	For i=1 To #Rows
		*row=*table\AddRow("","",images(Random(9,0)))		
		For g=0 To (#Cols-1)
			*cell=*row\GetCell(g)			
			If Random(1,0)
				*cell\SetImage(images(Random(9,0)))	
			EndIf
			If Random(1,0)
				*cell\SetText("Text "+i+"_"+g)
			EndIf
			If Random(1,0)
				*cell\SetFlags(#MYTABLE_CELL_FLAGS_CHECKBOXES)
				Select Random(2,0)
					Case 0
						*style=*cell\GetStyle()
						*style\SetHAlign(#MYTABLE_STYLE_HALIGN_LEFT)						
					Case 1
						*style=*cell\GetStyle()
						*style\SetHAlign(#MYTABLE_STYLE_HALIGN_CENTER)
					Case 2
						*style=*cell\GetStyle()
						*style\SetHAlign(#MYTABLE_STYLE_HALIGN_RIGHT)
				EndSelect
			EndIf
		Next
	Next
	
	*table\SetRedraw(#True)
	
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
	
	*table\Free()
UnuseModule MyTable