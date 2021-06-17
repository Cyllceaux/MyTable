EnableExplicit

XIncludeFile "declare.pb"

UseModule MyTable
	
	Global window=OpenWindow(#PB_Any,0,0,800,600,"Table13 (Fonts, Borders, Colors)",#PB_Window_SystemMenu|#PB_Window_ScreenCentered|#PB_Window_SizeGadget|#PB_Window_MaximizeGadget|#PB_Window_MinimizeGadget)
	Global canvas=CanvasGadget(#PB_Any,0,0,WindowWidth(window),WindowHeight(window),#PB_Canvas_Container|#PB_Canvas_Keyboard)
	Global hscroll=ScrollBarGadget(#PB_Any,0,0,0,20,0,0,0)
	Global vscroll=ScrollBarGadget(#PB_Any,0,0,20,0,0,0,0,#PB_ScrollBar_Vertical)
	CloseGadgetList()
	
	Define Dim fonts(3)
	fonts(0)=MyTableCreateFont("Arial",12,#PB_Font_HighQuality|#PB_Font_Bold)
	fonts(1)=MyTableCreateFont("Arial",12,#PB_Font_HighQuality|#PB_Font_Italic)
	fonts(2)=MyTableCreateFont("Arial",12,#PB_Font_HighQuality|#PB_Font_StrikeOut)
	fonts(3)=MyTableCreateFont("Arial",12,#PB_Font_HighQuality|#PB_Font_Underline)
	
	Global *table.MyTableTable=MyTableCreateTable(window,canvas,vscroll,hscroll,#MYTABLE_TABLE_FLAGS_DEFAULT_TABLE)
	*table\SetRedraw(#False)
	Define *col.MyTableCol,*style.MyTableStyle,*cell.MyTableCell,*row.MyTableRow,*tablestyle.MyTableStyle,*cellstyle.MyTableStyle
	
	
	#Rows=10
	#Cols=5
	
	Define i,g
	Define border=0
	For g=1 To #Cols
		*col=*table\AddCol("Test "+g,100,images(Random(9,0)))
		*style=*col\GetDefaultStyle()
		*style\SetHAlign(#MYTABLE_STYLE_HALIGN_RIGHT)
		*style\SetFont(fonts(Random(ArraySize(fonts()))))
		*style\SetForeColor(RGBA(Random(200,50),Random(200,50),Random(200,50),255))
		*style\SetBackColor(RGBA(Random(100,50),Random(100,50),Random(100,50),255))
	
		border=0
		If Random(1)
			border|#MYTABLE_STYLE_BORDER_BOTTOM
		EndIf
		If Random(1)
			border|#MYTABLE_STYLE_BORDER_LEFT
		EndIf
		If Random(1)
			border|#MYTABLE_STYLE_BORDER_RIGHT
		EndIf
		If Random(1)
			border|#MYTABLE_STYLE_BORDER_TOP
		EndIf
		*style\SetBorder(border)
		*style\SetBorderColor(RGBA(Random(200,50),Random(200,50),Random(200,50),255))
		*style\SetBorderWidth(Random(4,1))
	Next
	For i=1 To #Rows
		*row=*table\AddRow("","",images(Random(9,0)))		
		For g=0 To (#Cols-1)
			*cell=*row\GetCell(g)
			*cell\SetText("Text "+i+"_"+g)
			*cell\SetImageLeft(images(Random(9,0)))	
			*cellstyle=*cell\GetDefaultStyle()
			*cellstyle\SetFont(fonts(Random(ArraySize(fonts()))))
			*cellstyle\SetForeColor(RGBA(Random(200,50),Random(200,50),Random(200,50),255))
			*cellstyle\SetBackColor(RGBA(Random(250,200),Random(250,200),Random(250,200),255))
			border=0
			If Random(1)
				border|#MYTABLE_STYLE_BORDER_BOTTOM
			EndIf
			If Random(1)
				border|#MYTABLE_STYLE_BORDER_LEFT
			EndIf
			If Random(1)
				border|#MYTABLE_STYLE_BORDER_RIGHT
			EndIf
			If Random(1)
				border|#MYTABLE_STYLE_BORDER_TOP
			EndIf
			*cellstyle\SetBorder(border)
			*cellstyle\SetBorderColor(RGBA(Random(200,50),Random(200,50),Random(200,50),255))
			*cellstyle\SetBorderWidth(Random(4,1))
		Next
	Next
	
	*table\Autosize()
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