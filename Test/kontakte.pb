EnableExplicit

XIncludeFile "declare.pb"

UseModule MyTable
	UseModule MyFont
	
	Global titel=MyFontCreateFont("Arial",14,#PB_Font_Bold)
	Global header=MyFontCreateFont("Arial",12)
	
	Global window=OpenWindow(#PB_Any,0,0,800,600,"Kontakte (lookalike)",#PB_Window_SystemMenu|#PB_Window_ScreenCentered|#PB_Window_SizeGadget|#PB_Window_MaximizeGadget|#PB_Window_MinimizeGadget)
	Global canvas=CanvasGadget(#PB_Any,0,0,WindowWidth(window),WindowHeight(window),#PB_Canvas_Container|#PB_Canvas_Keyboard)
	Global hscroll=ScrollBarGadget(#PB_Any,0,0,0,20,0,0,0)
	Global vscroll=ScrollBarGadget(#PB_Any,0,0,20,0,0,0,0,#PB_ScrollBar_Vertical)
	CloseGadgetList()
	
	Global *tree.MyTableTable=MyTableCreateTree(window,canvas,vscroll,hscroll,#MYTABLE_TABLE_FLAGS_HIERARCHICAL_ALWAYS_EXPANDED|#MYTABLE_TABLE_FLAGS_FULLROWSELECT|#MYTABLE_TABLE_FLAGS_MARK_MOUSE_OVER)
	*tree\SetRedraw(#False)
	Define *col.MyTableCol,*rowStyle.MyTableStyle,*tableStyle.MyTableStyle,*colStyle.MyTableStyle
	Define i,g
	*col=*tree\AddCol("Name",#PB_Ignore):*colStyle=*col\GetDefaultStyle():*colStyle\SetBackColor(RGBA(5,5,5,255)):*colStyle\SetForeColor(RGBA(250,250,250,255)):*colStyle\SetFont(header)
	*col=*tree\AddCol("E-Mail",#PB_Ignore):*colStyle=*col\GetDefaultStyle():*colStyle\SetBackColor(RGBA(5,5,5,255)):*colStyle\SetForeColor(RGBA(250,250,250,255)):*colStyle\SetFont(header)
	*col=*tree\AddCol("Telefon",#PB_Ignore):*colStyle=*col\GetDefaultStyle():*colStyle\SetBackColor(RGBA(5,5,5,255)):*colStyle\SetForeColor(RGBA(250,250,250,255)):*colStyle\SetFont(header)
	
	*tree\SetDefaultRowHeight(32)
	*tableStyle=*tree\GetDefaultStyle()
	*tableStyle\SetBackColor(RGBA(5,5,5,255))
	*tableStyle\SetForeColor(RGBA(250,250,250,255))
	
	Define *row.MyTableRow=*tree\AddRow("&")	
	*rowStyle=*row\GetDefaultStyle()
	*rowStyle\SetFont(titel)
	For g=1 To Random(100)
		*row\AddRow("Name "+g+"|Mail "+g+"|Telefon "+g,"|",images(Random(9)))
	Next
	For i=Asc("A") To Asc("Z")
		*row=*tree\AddRow(Chr(i))	
		*rowStyle=*row\GetDefaultStyle()
		*rowStyle\SetFont(titel)
		For g=1 To Random(100)
			*row\AddRow(Chr(i)+" - Name "+g+"|Mail "+g+"|Telefon "+g,"|",images(Random(9)))
		Next
	Next
	
	
	*tree\SetRedraw(#True)
	
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
	
	UnuseModule MyFont
UnuseModule MyTable