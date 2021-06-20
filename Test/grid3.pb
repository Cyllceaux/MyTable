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
	
	Global window=OpenWindow(#PB_Any,0,0,800,600,"Grid3 (fonts, Borders, Editable)",#PB_Window_SystemMenu|#PB_Window_ScreenCentered|#PB_Window_SizeGadget|#PB_Window_MaximizeGadget|#PB_Window_MinimizeGadget)
	Global menu=CreateMenu(#PB_Any,WindowID(window))
	Global bx=0
	Global btnBold=ButtonGadget(#PB_Any,bx,0,22,22,"B",#PB_Button_Toggle):bx+22
	Global btnItalic=ButtonGadget(#PB_Any,bx,0,22,22,"I",#PB_Button_Toggle):bx+22
	Global btnStrike=ButtonGadget(#PB_Any,bx,0,22,22,"S",#PB_Button_Toggle):bx+22
	Global btnUnder=ButtonGadget(#PB_Any,bx,0,22,22,"U",#PB_Button_Toggle):bx+22
	
	bx+4
	Global pmFont=ComboBoxGadget(#PB_Any,bx,0,150,22,#PB_ComboBox_Editable):bx+150
	AddGadgetItem(pmFont,-1,"Arial")
	AddGadgetItem(pmFont,-1,"Calibri")
	AddGadgetItem(pmFont,-1,"Cambria")
	AddGadgetItem(pmFont,-1,"Comic Sans MS")
	AddGadgetItem(pmFont,-1,"Consolas")
	AddGadgetItem(pmFont,-1,"Lucida Console")
	AddGadgetItem(pmFont,-1,"Times New Roman")
	SetGadgetState(pmFont,0)
	
	Global spSize=SpinGadget(#PB_Any,bx,0,50,22,0,100,#PB_Spin_Numeric):bx+50
	SetGadgetState(spSize,12)
	
	bx+4
	
	Global btnLeft=ButtonGadget(#PB_Any,bx,0,22,22,"L",#PB_Button_Toggle):bx+22
	Global btnTop=ButtonGadget(#PB_Any,bx,0,22,22,"T",#PB_Button_Toggle):bx+22
	Global btnRight=ButtonGadget(#PB_Any,bx,0,22,22,"R",#PB_Button_Toggle):bx+22
	Global btnBottom=ButtonGadget(#PB_Any,bx,0,22,22,"B",#PB_Button_Toggle):bx+22
	
	Global panel=PanelGadget(#PB_Any,0,24,WindowWidth(window),WindowHeight(window)-24)
	CloseGadgetList()
	
	Procedure changeBorder(fl)
		Protected *element.Element=SelectElement(elemente(),GetGadgetState(panel))
		Protected NewList cells.MyTableCell()
		Protected NewList cols.MyTableCol()
		Protected NewList rows.MyTableRow()
		
		Protected flags=0
		Protected found.b=#False
		
		Protected *style.MyTableStyle=0
		*element\grid\GetSelectedCells(cells())
		*element\grid\GetSelectedRows(rows())
		*element\grid\GetSelectedCols(cols())
		*element\grid\SetRedraw(#False)
		ForEach cells()
			found=#True
			*style=cells()\GetDefaultStyle()
			flags=*style\GetBorder()
			If GetGadgetState(EventGadget())
				flags|fl
			Else
				flags!fl
			EndIf			
			If flags=0
				flags=#MYTABLE_STYLE_BORDER_NONE
			EndIf
			*style\SetBorder(flags)
		Next
		ForEach rows()
			found=#True
			*style=rows()\GetDefaultStyle()
			flags=*style\GetBorder()
			If GetGadgetState(EventGadget())
				flags|fl
			Else
				flags!fl
			EndIf
			*style\SetBorder(flags)
		Next
		ForEach cols()
			found=#True
			*style=cols()\GetDefaultStyle()
			flags=*style\GetBorder()
			If GetGadgetState(EventGadget())
				flags|fl
			Else
				flags!fl
			EndIf
			If flags=0
				flags=#MYTABLE_STYLE_BORDER_NONE
			EndIf
			*style\SetBorder(flags)
		Next
		If Not found
			*style=*element\grid\GetDefaultStyle()
			flags=*style\GetBorder()
			If GetGadgetState(EventGadget())
				flags|fl
			Else
				flags!fl
			EndIf
			If flags=0
				flags=#MYTABLE_STYLE_BORDER_NONE
			EndIf
			*style\SetBorder(flags)
		EndIf
		*element\grid\SetRedraw(#True)
		FreeList(cells())
		FreeList(cols())
		FreeList(rows())
	EndProcedure
	
	Procedure changeFlags(fl)
		Protected *element.Element=SelectElement(elemente(),GetGadgetState(panel))
		Protected NewList cells.MyTableCell()
		Protected NewList cols.MyTableCol()
		Protected NewList rows.MyTableRow()
		
		Protected flags=0
		Protected found.b=#False
		
		Protected *nfont.MyTableFont=0
		Protected *font.MyTableFont=0
		Protected *style.MyTableStyle=0
		*element\grid\GetSelectedCells(cells())
		*element\grid\GetSelectedRows(rows())
		*element\grid\GetSelectedCols(cols())
		*element\grid\SetRedraw(#False)
		ForEach cells()
			found=#True
			*style=cells()\GetDefaultStyle()
			*font=*style\GetFont()
			flags=*font\GetFlags()
			If GetGadgetState(EventGadget())
				flags|fl
			Else
				flags!fl
			EndIf
			*nfont=MyTableCreateFont(*font\GetName(),*font\GetSize(),flags)
			*style\SetFont(*nfont)		
		Next
		ForEach rows()
			found=#True
			*style=rows()\GetDefaultStyle()
			*font=*style\GetFont()
			flags=*font\GetFlags()
			If GetGadgetState(EventGadget())
				flags|fl
			Else
				flags!fl
			EndIf
			*nfont=MyTableCreateFont(*font\GetName(),*font\GetSize(),flags)
			*style\SetFont(*nfont)		
		Next
		ForEach cols()
			found=#True
			*style=cols()\GetDefaultStyle()
			*font=*style\GetFont()
			flags=*font\GetFlags()
			If GetGadgetState(EventGadget())
				flags|fl
			Else
				flags!fl
			EndIf
			*nfont=MyTableCreateFont(*font\GetName(),*font\GetSize(),flags)
			*style\SetFont(*nfont)		
		Next
		If Not found
			*style=*element\grid\GetDefaultStyle()
			*font=*style\GetFont()
			flags=*font\GetFlags()
			If GetGadgetState(EventGadget())
				flags|fl
			Else
				flags!fl
			EndIf
			*nfont=MyTableCreateFont(*font\GetName(),*font\GetSize(),flags)
			*style\SetFont(*nfont)	
		EndIf
		*element\grid\SetRedraw(#True)
		FreeList(cells())
		FreeList(cols())
		FreeList(rows())
	EndProcedure
	
	Procedure changeFont(font.s,size.i)
		Protected *element.Element=SelectElement(elemente(),GetGadgetState(panel))
		Protected NewList cells.MyTableCell()
		Protected NewList cols.MyTableCol()
		Protected NewList rows.MyTableRow()
		
		Protected flags=0
		Protected found.b=#False
		
		Protected *nfont.MyTableFont=0
		Protected *font.MyTableFont=0
		Protected *style.MyTableStyle=0
		*element\grid\GetSelectedCells(cells())
		*element\grid\GetSelectedRows(rows())
		*element\grid\GetSelectedCols(cols())
		*element\grid\SetRedraw(#False)
		ForEach cells()
			found=#True
			*style=cells()\GetDefaultStyle()
			*font=*style\GetFont()
			flags=*font\GetFlags()
			*nfont=MyTableCreateFont(font,size,flags)
			*style\SetFont(*nfont)		
		Next
		ForEach rows()
			found=#True
			*style=rows()\GetDefaultStyle()
			*font=*style\GetFont()
			flags=*font\GetFlags()
			*nfont=MyTableCreateFont(font,size,flags)
			*style\SetFont(*nfont)		
		Next
		ForEach cols()
			found=#True
			*style=cols()\GetDefaultStyle()
			*font=*style\GetFont()
			flags=*font\GetFlags()
			*nfont=MyTableCreateFont(font,size,flags)
			*style\SetFont(*nfont)		
		Next
		If Not found
			*style=*element\grid\GetDefaultStyle()
			*font=*style\GetFont()
			flags=*font\GetFlags()
			*nfont=MyTableCreateFont(font,size,flags)
			*style\SetFont(*nfont)	
		EndIf
		*element\grid\SetRedraw(#True)
		FreeList(cells())
		FreeList(cols())
		FreeList(rows())
	EndProcedure
	
	Procedure bold():changeFlags(#PB_Font_Bold):EndProcedure:BindGadgetEvent(btnBold,@bold())
	Procedure italic():changeFlags(#PB_Font_Italic):EndProcedure:BindGadgetEvent(btnItalic,@italic())
	Procedure Strike():changeFlags(#PB_Font_StrikeOut):EndProcedure:BindGadgetEvent(btnStrike,@strike())
	Procedure under():changeFlags(#PB_Font_Underline):EndProcedure:BindGadgetEvent(btnUnder,@under())
	
	Procedure cfont():changeFont(GetGadgetText(pmFont),GetGadgetState(spSize)):EndProcedure:BindGadgetEvent(pmFont,@cfont()):BindGadgetEvent(spSize,@cfont())
	
	Procedure bleft():changeBorder(#MYTABLE_STYLE_BORDER_LEFT):EndProcedure:BindGadgetEvent(btnLeft,@bleft())
	Procedure bright():changeBorder(#MYTABLE_STYLE_BORDER_RIGHT):EndProcedure:BindGadgetEvent(btnRight,@bright())
	Procedure btop():changeBorder(#MYTABLE_STYLE_BORDER_TOP):EndProcedure:BindGadgetEvent(btnTop,@btop())
	Procedure bbottom():changeBorder(#MYTABLE_STYLE_BORDER_BOTTOM):EndProcedure:BindGadgetEvent(btnBottom,@bbottom())
	
	Global *app.MyTableApplication=MyTableCreateApplication()
	
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
	
	
	Procedure ButtonUpdate(*element.Element,*style.MyTableStyle)
		Protected *font.MyTableFont=*style\GetFont()
		SetGadgetState(btnBold,Bool(*font\GetFlags() & #PB_Font_Bold))
		SetGadgetState(btnItalic,Bool(*font\GetFlags() & #PB_Font_Italic))
		SetGadgetState(btnStrike,Bool(*font\GetFlags() & #PB_Font_StrikeOut))
		SetGadgetState(btnUnder,Bool(*font\GetFlags() & #PB_Font_Underline))
		
		SetGadgetText(pmFont,*font\GetName())
		SetGadgetState(spSize,*font\GetSize())
		
		SetGadgetState(btnLeft,Bool(*style\GetBorder() & #MYTABLE_STYLE_BORDER_LEFT))
		SetGadgetState(btnRight,Bool( *style\GetBorder() & #MYTABLE_STYLE_BORDER_RIGHT))
		SetGadgetState(btnTop,Bool( *style\GetBorder() & #MYTABLE_STYLE_BORDER_TOP))
		SetGadgetState(btnBottom,Bool( *style\GetBorder() & #MYTABLE_STYLE_BORDER_BOTTOM))
	EndProcedure
	
	Procedure.b EvtCellSelect(*cell.MyTableCell)
		Protected *grid.MyTableGrid=*cell\GetTable()
		Protected *element.Element=*grid\GetData()
		
		Protected *style.MyTableStyle=*cell\GetDefaultStyle()
		
		ButtonUpdate(*element,*style)
		
		If *cell\GetFormula()<>""
			SetGadgetText(*element\string,*cell\GetFormula())
		Else
			SetGadgetText(*element\string,*cell\GetText())
		EndIf
	EndProcedure
	
	Procedure.b EvtRowSelect(*row.MyTableRow)
		Protected *grid.MyTableGrid=*row\GetTable()
		Protected *element.Element=*grid\GetData()
		
		Protected *style.MyTableStyle=*row\GetDefaultStyle()
		
		ButtonUpdate(*element,*style)
	EndProcedure
	
	Procedure.b EvtColSelect(*col.MyTableCol)
		Protected *grid.MyTableGrid=*col\GetTable()
		Protected *element.Element=*grid\GetData()
		
		Protected *style.MyTableStyle=*col\GetDefaultStyle()
		
		ButtonUpdate(*element,*style)
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
	
	Procedure change()
		ForEach elemente()
			elemente()\grid\SetRedraw(Bool(GetGadgetState(panel)=ListIndex(elemente())))
			If Bool(GetGadgetState(panel)=ListIndex(elemente()))
				ButtonUpdate(elemente(),elemente()\grid\GetDefaultStyle())
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
		*element\grid\RegisterEventCellSelected(@EvtCellSelect())
		*element\grid\RegisterEventColSelected(@EvtColSelect())
		*element\grid\RegisterEventRowSelected(@EvtRowSelect())
		*element\grid\RegisterEventCellChangedText(@EvtCellSelectTextChange())
		change()
	EndProcedure
	
	Procedure Resize()
		ResizeGadget(panel,
		             #PB_Ignore,
		             #PB_Ignore,
		             WindowWidth(window),
		             WindowHeight(window)-24)
		
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
	
	
	;AddGridElement()
	;AddGridElement()
	AddGridElement()
	
	
	BindEvent(#PB_Event_SizeWindow,@Resize(),window)
	BindEvent(#PB_Event_RestoreWindow,@Resize(),window)
	BindEvent(#PB_Event_MaximizeWindow,@Resize(),window)
	BindEvent(#PB_Event_MinimizeWindow,@Resize(),window)
	BindGadgetEvent(panel,@change(),#PB_EventType_Change)
	
	
	
	Repeat:Until WaitWindowEvent()=#PB_Event_CloseWindow
	
	*app\Free()
UnuseModule MyTable