CompilerIf Not #PB_Compiler_IsMainFile
	Global *selectedTable.MyTableTableObject=0
	
	CompilerIf Not Defined(bx,#PB_Variable)
		Global bx=0
	CompilerEndIf
	
	CompilerIf Not Defined(by,#PB_Variable)
		Global by=0
	CompilerEndIf
	
	Global pmGruppe=ComboBoxGadget(#PB_Any,bx,by,150,22):bx+150
	AddGadgetItem(pmGruppe,-1,"Default")
	AddGadgetItem(pmGruppe,-1,"Selected")
	AddGadgetItem(pmGruppe,-1,"Fixed")	
	AddGadgetItem(pmGruppe,-1,"Mouse Over")	
	AddGadgetItem(pmGruppe,-1,"Element SelectedStyle")
	AddGadgetItem(pmGruppe,-1,"Zebra")
	AddGadgetItem(pmGruppe,-1,"Title")
	AddGadgetItem(pmGruppe,-1,"Empty")
	AddGadgetItem(pmGruppe,-1,"Disabled")
	SetGadgetState(pmGruppe,0)
	
	bx+4
	Global btnBold=ButtonGadget(#PB_Any,bx,by,22,22,"B",#PB_Button_Toggle):bx+22
	Global btnItalic=ButtonGadget(#PB_Any,bx,by,22,22,"I",#PB_Button_Toggle):bx+22
	Global btnStrike=ButtonGadget(#PB_Any,bx,by,22,22,"S",#PB_Button_Toggle):bx+22
	Global btnUnder=ButtonGadget(#PB_Any,bx,by,22,22,"U",#PB_Button_Toggle):bx+22
	
	bx+4
	Global pmFont=ComboBoxGadget(#PB_Any,bx,by,150,22,#PB_ComboBox_Editable):bx+150
	AddGadgetItem(pmFont,-1,"Arial")
	AddGadgetItem(pmFont,-1,"Calibri")
	AddGadgetItem(pmFont,-1,"Cambria")
	AddGadgetItem(pmFont,-1,"Comic Sans MS")
	AddGadgetItem(pmFont,-1,"Consolas")
	AddGadgetItem(pmFont,-1,"Lucida Console")
	AddGadgetItem(pmFont,-1,"Times New Roman")
	SetGadgetState(pmFont,0)
	
	Global spSize=SpinGadget(#PB_Any,bx,by,50,22,0,100,#PB_Spin_Numeric):bx+50
	SetGadgetState(spSize,12)
	
	bx+4
	
	
	Global pmvalign=ComboBoxGadget(#PB_Any,bx,by,70,22):bx+70
	AddGadgetItem(pmvalign,-1,"Top")
	AddGadgetItem(pmvalign,-1,"Middle")
	AddGadgetItem(pmvalign,-1,"Bottom")
	SetGadgetState(pmvalign,0)
	Global pmhalign=ComboBoxGadget(#PB_Any,bx,by,70,22):bx+70
	AddGadgetItem(pmhalign,-1,"Left")
	AddGadgetItem(pmhalign,-1,"Center")
	AddGadgetItem(pmhalign,-1,"Right")
	SetGadgetState(pmhalign,0)
	
	by+24
	bx=0
	
	Global btnLeft=ButtonGadget(#PB_Any,bx,by,22,22,"L",#PB_Button_Toggle):bx+22
	Global btnTop=ButtonGadget(#PB_Any,bx,by,22,22,"T",#PB_Button_Toggle):bx+22
	Global btnRight=ButtonGadget(#PB_Any,bx,by,22,22,"R",#PB_Button_Toggle):bx+22
	Global btnBottom=ButtonGadget(#PB_Any,bx,by,22,22,"B",#PB_Button_Toggle):bx+22
	Global pmBorder=ComboBoxGadget(#PB_Any,bx,by,100,22,#PB_ComboBox_Editable):bx+100
	AddGadgetItem(pmBorder,-1,"Default")
	AddGadgetItem(pmBorder,-1,"Top")
	AddGadgetItem(pmBorder,-1,"Left")
	AddGadgetItem(pmBorder,-1,"Bottom")
	AddGadgetItem(pmBorder,-1,"Right")
	SetGadgetState(pmBorder,0)
	Global spwidth=SpinGadget(#PB_Any,bx,by,50,22,0,10,#PB_Spin_Numeric):bx+50
	SetGadgetState(spwidth,1)
	Global btnBorder=ButtonGadget(#PB_Any,bx,by,50,22,"Border"):bx+50
	bx+4
	Global btnFront=ButtonGadget(#PB_Any,bx,by,50,22,"Front"):bx+50
	Global btnBack=ButtonGadget(#PB_Any,bx,by,50,22,"Back"):bx+50
	Global btnFore=ButtonGadget(#PB_Any,bx,by,50,22,"Fore"):bx+50
	
	
	
	by+24
	
	
	Procedure getStyle(*obj.MyTableObject)
		Protected *cell.MyTableCell=0
		Protected *row.MyTableRow=0
		Protected *col.MyTableCol=0
		Protected *table.MyTableTableObject=0
		Select GetGadgetState(pmGruppe)
			Case 0
				ProcedureReturn *obj\GetDefaultStyle()
			Case 1
				ProcedureReturn *obj\GetSelectedStyle()
			Case 2
				ProcedureReturn *obj\GetFixedStyle()
			Case 3
				ProcedureReturn *obj\GetMouseOverStyle()		
			Case 4
				If *obj\getType()=#MYTABLE_TYPE_CELL
					*cell=*obj
					ProcedureReturn getStyle(*cell\getTable())
				ElseIf *obj\getType()=#MYTABLE_TYPE_ROW
					*row=*obj
					ProcedureReturn *row\getElementSelectedStyle()
				ElseIf *obj\getType()=#MYTABLE_TYPE_COL
					*col=*obj
					ProcedureReturn *col\getElementSelectedStyle()
				ElseIf *obj\getType()=#MYTABLE_TYPE_TABLE Or *obj\getType()=#MYTABLE_TYPE_TREE Or *obj\getType()=#MYTABLE_TYPE_GRID	
					*table=*obj			
					ProcedureReturn *table\getElementSelectedStyle()
				EndIf		
			Case 5
				If *obj\getType()=#MYTABLE_TYPE_CELL
					*cell=*obj
					ProcedureReturn getStyle(*cell\getTable())
				ElseIf *obj\getType()=#MYTABLE_TYPE_ROW
					*row=*obj
					ProcedureReturn getStyle(*row\getTable())
				ElseIf *obj\getType()=#MYTABLE_TYPE_COL
					*col=*obj
					ProcedureReturn getStyle(*col\getTable())
				ElseIf *obj\getType()=#MYTABLE_TYPE_TABLE Or *obj\getType()=#MYTABLE_TYPE_TREE Or *obj\getType()=#MYTABLE_TYPE_GRID	
					*table=*obj			
					ProcedureReturn *table\getZebraStyle()
				EndIf						
			Case 6
				If *obj\getType()=#MYTABLE_TYPE_CELL
					*cell=*obj
					ProcedureReturn getStyle(*cell\getTable())
				ElseIf *obj\getType()=#MYTABLE_TYPE_ROW
					*row=*obj
					ProcedureReturn getStyle(*row\getTable())
				ElseIf *obj\getType()=#MYTABLE_TYPE_COL
					*col=*obj
					ProcedureReturn getStyle(*col\getTable())
				ElseIf *obj\getType()=#MYTABLE_TYPE_TABLE Or *obj\getType()=#MYTABLE_TYPE_TREE Or *obj\getType()=#MYTABLE_TYPE_GRID	
					*table=*obj			
					ProcedureReturn *table\getTitleStyle()
				EndIf	
			Case 7
				If *obj\getType()=#MYTABLE_TYPE_CELL
					*cell=*obj
					ProcedureReturn getStyle(*cell\getTable())
				ElseIf *obj\getType()=#MYTABLE_TYPE_ROW
					*row=*obj
					ProcedureReturn getStyle(*row\getTable())
				ElseIf *obj\getType()=#MYTABLE_TYPE_COL
					*col=*obj
					ProcedureReturn getStyle(*col\getTable())
				ElseIf *obj\getType()=#MYTABLE_TYPE_TABLE Or *obj\getType()=#MYTABLE_TYPE_TREE Or *obj\getType()=#MYTABLE_TYPE_GRID	
					*table=*obj			
					ProcedureReturn *table\getEmptyStyle()
				EndIf			
			Case 8
				ProcedureReturn *obj\GetDisabledStyle()	
		EndSelect		
	EndProcedure
	
	Procedure getBorder(*obj.MyTableObject)
		Protected *style.MyTableStyle=getStyle(*obj)
		
		Select GetGadgetState(pmBorder)
			Case 0
				ProcedureReturn *style\getBorderDefault()
			Case 1
				ProcedureReturn *style\getBorderTop()
			Case 2
				ProcedureReturn *style\getBorderLeft()
			Case 3
				ProcedureReturn *style\getBorderBottom()		
			Case 4
				ProcedureReturn *style\getBorderRight()		
		EndSelect		
	EndProcedure
	
	Procedure changeBorder(fl)
		
		Protected NewList cells.MyTableCell()
		Protected NewList cols.MyTableCol()
		Protected NewList rows.MyTableRow()
		
		Protected flags=0
		Protected found.b=#False
		
		Protected *style.MyTableStyle=0
		*selectedTable\GetSelectedCells(cells())
		*selectedTable\GetSelectedRows(rows())
		*selectedTable\GetSelectedCols(cols())
		*selectedTable\SetRedraw(#False)
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
			*style=getStyle(rows())
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
			*style=getStyle(cols())
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
			*style=getStyle(*selectedTable)
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
		*selectedTable\SetRedraw(#True)
		FreeList(cells())
		FreeList(cols())
		FreeList(rows())
	EndProcedure
	
	Procedure changeFlags(fl)
		
		Protected NewList cells.MyTableCell()
		Protected NewList cols.MyTableCol()
		Protected NewList rows.MyTableRow()
		
		Protected flags=0
		Protected found.b=#False
		
		Protected *nfont.MyTableFont=0
		Protected *font.MyTableFont=0
		Protected *style.MyTableStyle=0
		*selectedTable\GetSelectedCells(cells())
		*selectedTable\GetSelectedRows(rows())
		*selectedTable\GetSelectedCols(cols())
		*selectedTable\SetRedraw(#False)
		ForEach cells()
			found=#True
			*style=getStyle(cells())
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
			*style=getStyle(rows())
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
			*style=getStyle(cols())
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
			*style=getStyle(*selectedTable)
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
		*selectedTable\SetRedraw(#True)
		FreeList(cells())
		FreeList(cols())
		FreeList(rows())
	EndProcedure
	
	Procedure changeFont(font.s,size.i)
		
		Protected NewList cells.MyTableCell()
		Protected NewList cols.MyTableCol()
		Protected NewList rows.MyTableRow()
		
		Protected flags=0
		Protected found.b=#False
		
		Protected *nfont.MyTableFont=0
		Protected *font.MyTableFont=0
		Protected *style.MyTableStyle=0
		*selectedTable\GetSelectedCells(cells())
		*selectedTable\GetSelectedRows(rows())
		*selectedTable\GetSelectedCols(cols())
		*selectedTable\SetRedraw(#False)
		ForEach cells()
			found=#True
			*style=getStyle(cells())
			*font=*style\GetFont()
			flags=*font\GetFlags()
			*nfont=MyTableCreateFont(font,size,flags)
			*style\SetFont(*nfont)		
		Next
		ForEach rows()
			found=#True
			*style=getStyle(rows())
			*font=*style\GetFont()
			flags=*font\GetFlags()
			*nfont=MyTableCreateFont(font,size,flags)
			*style\SetFont(*nfont)		
		Next
		ForEach cols()
			found=#True
			*style=getStyle(cols())
			*font=*style\GetFont()
			flags=*font\GetFlags()
			*nfont=MyTableCreateFont(font,size,flags)
			*style\SetFont(*nfont)		
		Next
		If Not found
			*style=getStyle(*selectedTable)
			*font=*style\GetFont()
			flags=*font\GetFlags()
			*nfont=MyTableCreateFont(font,size,flags)
			*style\SetFont(*nfont)	
		EndIf
		*selectedTable\SetRedraw(#True)
		FreeList(cells())
		FreeList(cols())
		FreeList(rows())
	EndProcedure
	
	
	Procedure front()
		
		Protected NewList cells.MyTableCell()
		Protected NewList cols.MyTableCol()
		Protected NewList rows.MyTableRow()
		
		
		Protected found.b=#False
		
		Protected *nfont.MyTableFont=0
		Protected *font.MyTableFont=0
		Protected *style.MyTableStyle=0
		*selectedTable\GetSelectedCells(cells())
		*selectedTable\GetSelectedRows(rows())
		*selectedTable\GetSelectedCols(cols())
		*selectedTable\SetRedraw(#False)
		
		*style=getStyle(*selectedTable)
		Protected flags.q=ColorRequester(*style\GetFrontColor())
		
		ForEach cells()
			found=#True
			*style=getStyle(cells())
			*style\SetFrontColor(flags)
		Next
		ForEach rows()
			found=#True
			*style=getStyle(rows())
			*style\SetFrontColor(flags)
		Next
		ForEach cols()
			found=#True
			*style=getStyle(cols())
			*style\SetFrontColor(flags)
		Next
		If Not found
			*style=getStyle(*selectedTable)
			*style\SetFrontColor(flags)
		EndIf
		*selectedTable\SetRedraw(#True)
		FreeList(cells())
		FreeList(cols())
		FreeList(rows())
	EndProcedure
	
	
	
	Procedure align()
		Protected NewList cells.MyTableCell()
		Protected NewList cols.MyTableCol()
		Protected NewList rows.MyTableRow()
		
		Protected halign=GetGadgetState(pmhalign)
		Protected valign=GetGadgetState(pmvalign)
		
		Protected found.b=#False
		
		Protected *nfont.MyTableFont=0
		Protected *font.MyTableFont=0
		Protected *style.MyTableStyle=0
		
		*selectedTable\GetSelectedCells(cells())
		*selectedTable\GetSelectedRows(rows())
		*selectedTable\GetSelectedCols(cols())
		*selectedTable\SetRedraw(#False)
		
		*style=getStyle(*selectedTable)
		
		ForEach cells()
			found=#True
			*style=getStyle(cells())
			*style\SetHAlign(halign)
			*style\SetVAlign(valign)
		Next
		ForEach rows()
			found=#True
			*style=getStyle(rows())
			*style\SetHAlign(halign)
			*style\SetVAlign(valign)
		Next
		ForEach cols()
			found=#True
			*style=getStyle(cols())
			*style\SetHAlign(halign)
			*style\SetVAlign(valign)
		Next
		If Not found
			*style=getStyle(*selectedTable)
			*style\SetHAlign(halign)
			*style\SetVAlign(valign)
		EndIf
		*selectedTable\SetRedraw(#True)
		FreeList(cells())
		FreeList(cols())
		FreeList(rows())
	EndProcedure
	
	Procedure borderW()
		Protected NewList cells.MyTableCell()
		Protected NewList cols.MyTableCol()
		Protected NewList rows.MyTableRow()
		
		
		Protected found.b=#False
		
		Protected *nfont.MyTableFont=0
		Protected *font.MyTableFont=0
		Protected *style.MyTableStyle=0
		Protected *border.MyTableBorder
		*selectedTable\GetSelectedCells(cells())
		*selectedTable\GetSelectedRows(rows())
		*selectedTable\GetSelectedCols(cols())
		*selectedTable\SetRedraw(#False)
		
		*style=getStyle(*selectedTable)
		*border=getBorder(*selectedTable)
		ForEach cells()
			found=#True
			*style=getStyle(cells())
			*border=getBorder(cells())
			*border\SetWidth(GetGadgetState(spwidth))
		Next
		ForEach rows()
			found=#True
			*style=getStyle(rows())
			*border=getBorder(rows())
			*border\SetWidth(GetGadgetState(spwidth))
		Next
		ForEach cols()
			found=#True
			*style=getStyle(cols())
			*border=getBorder(cols())
			*border\SetWidth(GetGadgetState(spwidth))
		Next
		If Not found
			*style=getStyle(*selectedTable)
			*border=getBorder(*selectedTable)
			*border\SetWidth(GetGadgetState(spwidth))
		EndIf
		*selectedTable\SetRedraw(#True)
		FreeList(cells())
		FreeList(cols())
		FreeList(rows())
	EndProcedure
	
	Procedure border()
		
		Protected NewList cells.MyTableCell()
		Protected NewList cols.MyTableCol()
		Protected NewList rows.MyTableRow()
		
		
		Protected found.b=#False
		
		Protected *nfont.MyTableFont=0
		Protected *font.MyTableFont=0
		Protected *style.MyTableStyle=0
		Protected *border.MyTableBorder=0
		*selectedTable\GetSelectedCells(cells())
		*selectedTable\GetSelectedRows(rows())
		*selectedTable\GetSelectedCols(cols())
		*selectedTable\SetRedraw(#False)
		
		*style=getStyle(*selectedTable)
		*border=getBorder(*selectedTable)
		Protected flags.q=ColorRequester(*border\GetColor())
		
		ForEach cells()
			found=#True
			*style=getStyle(cells())
			*border=getBorder(cells())
			*border\SetColor(flags)
		Next
		ForEach rows()
			found=#True
			*style=getStyle(rows())
			*border=getBorder(rows())
			*border\SetColor(flags)
		Next
		ForEach cols()
			found=#True
			*style=getStyle(cols())
			*border=getBorder(cols())
			*border\SetColor(flags)
		Next
		If Not found
			*style=getStyle(*selectedTable)
			*border=getBorder(*selectedTable)
			*border\SetColor(flags)
		EndIf
		*selectedTable\SetRedraw(#True)
		FreeList(cells())
		FreeList(cols())
		FreeList(rows())
	EndProcedure
	
	Procedure fore()
		
		Protected NewList cells.MyTableCell()
		Protected NewList cols.MyTableCol()
		Protected NewList rows.MyTableRow()
		
		
		Protected found.b=#False
		
		Protected *nfont.MyTableFont=0
		Protected *font.MyTableFont=0
		Protected *style.MyTableStyle=0
		*selectedTable\GetSelectedCells(cells())
		*selectedTable\GetSelectedRows(rows())
		*selectedTable\GetSelectedCols(cols())
		*selectedTable\SetRedraw(#False)
		
		*style=getStyle(*selectedTable)
		Protected flags.q=ColorRequester(*style\GetForeColor())
		
		ForEach cells()
			found=#True
			*style=getStyle(cells())
			*style\SetForeColor(flags)
		Next
		ForEach rows()
			found=#True
			*style=getStyle(rows())
			*style\SetForeColor(flags)
		Next
		ForEach cols()
			found=#True
			*style=getStyle(cols())
			*style\SetForeColor(flags)
		Next
		If Not found
			*style=getStyle(*selectedTable)
			*style\SetForeColor(flags)
		EndIf
		*selectedTable\SetRedraw(#True)
		FreeList(cells())
		FreeList(cols())
		FreeList(rows())
	EndProcedure
	
	Procedure back()
		
		Protected NewList cells.MyTableCell()
		Protected NewList cols.MyTableCol()
		Protected NewList rows.MyTableRow()
		
		
		Protected found.b=#False
		
		Protected *nfont.MyTableFont=0
		Protected *font.MyTableFont=0
		Protected *style.MyTableStyle=0
		*selectedTable\GetSelectedCells(cells())
		*selectedTable\GetSelectedRows(rows())
		*selectedTable\GetSelectedCols(cols())
		*selectedTable\SetRedraw(#False)
		
		*style=getStyle(*selectedTable)
		Protected flags.q=ColorRequester(*style\GetBackColor())
		
		ForEach cells()
			found=#True
			*style=getStyle(cells())
			*style\SetBackColor(flags)
		Next
		ForEach rows()
			found=#True
			*style=getStyle(rows())
			*style\SetBackColor(flags)
		Next
		ForEach cols()
			found=#True
			*style=getStyle(cols())
			*style\SetBackColor(flags)
		Next
		If Not found
			*style=getStyle(*selectedTable)
			*style\SetBackColor(flags)
		EndIf
		*selectedTable\SetRedraw(#True)
		FreeList(cells())
		FreeList(cols())
		FreeList(rows())
	EndProcedure
	
	
	BindGadgetEvent(btnfront,@front())
	BindGadgetEvent(btnBack,@back())
	BindGadgetEvent(btnfore,@fore())
	BindGadgetEvent(btnBorder,@border())
	BindGadgetEvent(spwidth,@borderw())		
	BindGadgetEvent(pmvalign,@align())
	BindGadgetEvent(pmhalign,@align())
	
	
	
	
	Procedure bold():changeFlags(#PB_Font_Bold):EndProcedure:BindGadgetEvent(btnBold,@bold())
	Procedure italic():changeFlags(#PB_Font_Italic):EndProcedure:BindGadgetEvent(btnItalic,@italic())
	Procedure Strike():changeFlags(#PB_Font_StrikeOut):EndProcedure:BindGadgetEvent(btnStrike,@strike())
	Procedure under():changeFlags(#PB_Font_Underline):EndProcedure:BindGadgetEvent(btnUnder,@under())
	
	Procedure cfont():changeFont(GetGadgetText(pmFont),GetGadgetState(spSize)):EndProcedure:BindGadgetEvent(pmFont,@cfont()):BindGadgetEvent(spSize,@cfont())
	
	Procedure bleft():changeBorder(#MYTABLE_STYLE_BORDER_LEFT):EndProcedure:BindGadgetEvent(btnLeft,@bleft())
	Procedure bright():changeBorder(#MYTABLE_STYLE_BORDER_RIGHT):EndProcedure:BindGadgetEvent(btnRight,@bright())
	Procedure btop():changeBorder(#MYTABLE_STYLE_BORDER_TOP):EndProcedure:BindGadgetEvent(btnTop,@btop())
	Procedure bbottom():changeBorder(#MYTABLE_STYLE_BORDER_BOTTOM):EndProcedure:BindGadgetEvent(btnBottom,@bbottom())
	
	
	Procedure ButtonUpdate(*style.MyTableStyle)
		Protected *font.MyTableFont=*style\GetFont()
		Protected *border.MyTableBorder=*style\getBorderDefault()
		
		SetGadgetState(btnBold,Bool(*font\GetFlags() & #PB_Font_Bold))
		SetGadgetState(btnItalic,Bool(*font\GetFlags() & #PB_Font_Italic))
		SetGadgetState(btnStrike,Bool(*font\GetFlags() & #PB_Font_StrikeOut))
		SetGadgetState(btnUnder,Bool(*font\GetFlags() & #PB_Font_Underline))
		
		SetGadgetText(pmFont,*font\GetName())
		SetGadgetState(spSize,*font\GetSize())
		
		SetGadgetState(btnLeft,Bool(*style\GetBorder() & #MYTABLE_STYLE_BORDER_LEFT))
		SetGadgetState(btnRight,Bool( *style\GetBorder() & #MYTABLE_STYLE_BORDER_RIGHT))
		SetGadgetState(btnTop,Bool(*style\GetBorder() & #MYTABLE_STYLE_BORDER_TOP))
		SetGadgetState(btnBottom,Bool(*style\GetBorder() & #MYTABLE_STYLE_BORDER_BOTTOM))
		
		SetGadgetState(spwidth,*border\GetWidth())
		
		SetGadgetState(pmhalign,*style\GetHAlign())
		SetGadgetState(pmvalign,*style\GetvAlign())
	EndProcedure
	
CompilerEndIf