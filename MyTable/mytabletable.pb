
_BindEvent(MyTable,ColLeftClick)	
_BindEvent(MyTable,ColRightClick)
_BindEvent(MyTable,ColLeftDoubleClick)		
_BindEvent(MyTable,ColRightDoubleClick)
_BindEvent(MyTable,ColSelected)
_BindEvent(MyTable,CellChangedChecked)
_BindEvent(MyTable,CellChangedUnChecked)
_BindEvent(MyTable,CellChangedText)
_BindEvent(MyTable,CellChangedValue)
_BindEvent(MyTable,CellSelected)		
_BindEvent(MyTable,CellLeftClick)	
_BindEvent(MyTable,CellRightClick)
_BindEvent(MyTable,CellLeftDoubleClick)		
_BindEvent(MyTable,CellRightDoubleClick)
_BindEvent(MyTable,RowChangedChecked)
_BindEvent(MyTable,RowChangedUnChecked)
_BindEvent(MyTable,RowChangedExpanded)
_BindEvent(MyTable,RowChangedCollapsed)
_BindEvent(MyTable,RowSelected)
_BindEvent(MyTable,RowLeftClick)	
_BindEvent(MyTable,RowRightClick)
_BindEvent(MyTable,RowLeftDoubleClick)		
_BindEvent(MyTable,RowRightDoubleClick)
_BindEvent(MyTable,CustomCellDraw)
_BindEvent(MyTable,CustomCellEdit)

_SimpleSetterGetter(MyTable,Table,Tooltip,s)
_SimpleSetterGetterPredraw(MyTable,Table,Title,s)
_SimpleSetterGetterPredraw(MyTable,Table,Dirty,b)
_SimpleSetterGetterPredraw(MyTable,Table,Batch,b)
_SimpleSetterGetterPredraw(MyTable,Table,Disabled,b)
_SimpleGetter(MyTable,Table,Flags,i)
_SimpleSetterGetterPredraw(MyTable,Table,EmptyText,s)
_SimpleSetterGetterPredraw(MyTable,Table,FixedCols,i)
_SimpleSetterGetter(MyTable,Table,Type,i)
_SimpleSetterGetterPredraw(MyTable,Table,DefaultImageSortAsc,i)
_SimpleSetterGetterPredraw(MyTable,Table,DefaultImageSortDesc,i)
_SimpleSetterGetterPredraw(MyTable,Table,DefaultImagePlus,i)
_SimpleSetterGetterPredraw(MyTable,Table,DefaultImageMinus,i)
_SimpleSetterGetterPredraw(MyTable,Table,DefaultImageCheckBox,i)
_SimpleSetterGetterPredraw(MyTable,Table,DefaultImageCheckBoxChecked,i)
_SimpleSetterGetterPredraw(MyTable,Table,DefaultImagePlusArrow,i)
_SimpleSetterGetterPredraw(MyTable,Table,DefaultImageMinusArrow,i)
_SimpleSetterGetterPredraw(MyTable,Table,Page,i)
_SimpleSetterGetterPredraw(MyTable,Table,PageElements,i)

_SimpleSetterGetter(MyTable,Table,Canvas,i)
_SimpleSetterGetter(MyTable,Table,HScroll,i)
_SimpleSetterGetter(MyTable,Table,VScroll,i)
_SimpleSetterGetter(MyTable,Table,Window,i)

Procedure _MyTable_Table_Reinit(*this.strMyTableTable)
	If *this
		Protected rows=ListSize(*this\rows())
		Protected cols=ListSize(*this\cols())
		ClearList(*this\rows())
		ClearList(*this\cols())
		If _MyTable_IsGrid(*this)
			_MyTableInitGrid(*this\application,
			                 *this,
			                 *this\window,
			                 *this\canvas,
			                 *this\vscroll,
			                 *this\hscroll,
			                 rows,
			                 cols,
			                 *this\flags)
		ElseIf _MyTable_IsHierarchical(*this)
			_MyTableInitTree(*this\application,
			                 *this,
			                 *this\window,
			                 *this\canvas,
			                 *this\vscroll,
			                 *this\hscroll,			                 
			                 *this\flags)
		Else
			_MyTableInitTable(*this\application,
			                  *this,
			                  *this\window,
			                  *this\canvas,
			                  *this\vscroll,
			                  *this\hscroll,			                 
			                  *this\flags)
		EndIf
		*this\dirty=#True
		_MyTable_Table_Predraw(*this)
		_MyTable_Table_Redraw(*this)
	EndIf
EndProcedure

Procedure _MyTable_Table_SetFlags(*this.strMyTableTable,value.i)
	If *this
		*this\flags=value
		If _MyTable_IsGrid(*this)
			*this\vtable=?vtable_grid
			*this\type=#MYTABLE_TYPE_GRID
			*this\datagrid=#True
			
		ElseIf _MyTable_IsHierarchical(*this)
			*this\vtable=?vtable_tree
			*this\type=#MYTABLE_TYPE_TREE
			*this\datagrid=#False
		Else
			*this\vtable=?vtable_table
			*this\type=#MYTABLE_TYPE_TABLE
			*this\datagrid=#False
		EndIf
		*this\dirty=#True
		_MyTable_Table_Predraw(*this)
		_MyTable_Table_Redraw(*this)
	EndIf
EndProcedure

Procedure _MyTable_Table_GetPages(*this.strMyTableTable)
	If *this
		If *this\pageElements=0
			*this\pageElements=1
		EndIf
		_MyTable_Table_Predraw(*this)
		ProcedureReturn Round(ListSize(*this\rows())/*this\pageElements,#PB_Round_Up)
	EndIf
EndProcedure

Procedure _MyTable_Table_GetCalcHeight(*this.strMyTableTable)
	If *this
		Protected result=_MyTable_Table_Predraw(*this,#True)
		ProcedureReturn DesktopScaledY(result)
	EndIf
EndProcedure

Procedure _MyTable_Table_GetCalcWidth(*this.strMyTableTable)
	If *this
		Protected result=0
		_MyTable_Table_Predraw(*this,#True)
		ForEach *this\cols()
			result+*this\cols()\calcwidth			
		Next
		ProcedureReturn DesktopScaledX(result)
	EndIf
EndProcedure



Procedure.s _MyTable_Table_GetName(*this.strMyTableTable)
	If *this
		ProcedureReturn *this\name
	EndIf
EndProcedure

Procedure _MyTable_Table_SetName(*this.strMyTableTable,value.s)
	If *this
		Protected nname.s=_MyTableCleanName(value)
		If *this\application
			If nname<>*this\name
				If nname=""
					While _MyTable_Application_HasName(*this\application,"Table"+*this\application\lastindex)
						*this\application\lastindex+1
					Wend
					*this\name="Table"+*this\application\lastindex
				Else
					If Not _MyTable_Application_HasName(*this\application,nname)
						*this\name=nname
					EndIf
				EndIf
			EndIf
		Else
			*this\name=nname
		EndIf
	EndIf
EndProcedure


Procedure _MyTable_Table_AddRow(*this.strMyTableTable,text.s,sep.s="|",image.i=0,flags.i=0)
	If *this
		Protected *row.strMyTableRow=AddElement(*this\rows())
		_MyTableInitRow(*this\application,*this,0,*row,text,sep,image,flags)
		*this\dirty=#True
		_MyTable_Table_Predraw(*this)
		_MyTable_Table_Redraw(*this)
		ProcedureReturn *row
	EndIf
EndProcedure

Procedure _MyTable_Table_AddDirtyRows(*this.strMyTableTable,rows.i)
	If *this
		_callcountStart()
		Protected idx
		LastElement(*this\rows())
		For idx=1 To rows			
			Protected *row.strMyTableRow=AddElement(*this\rows())
			_MyTableInitRow(*this\application,*this,0,*row,"","",0,0)
			*this\dirty=#True
		Next		
		_callcountEnde()
		_MyTable_Table_Predraw(*this)
		_MyTable_Table_Redraw(*this)
	EndIf
EndProcedure

Procedure _MyTable_Table_AddCol(*this.strMyTableTable,text.s,width.i,image.i=0,flags.i=0)
	If *this
		Protected *col.strMyTableCol=AddElement(*this\cols())
		_MyTableInitCol(*this\application,*this,*col,text,width,image,flags)
		*this\dirty=#True
		_MyTable_Table_Predraw(*this)
		_MyTable_Table_Redraw(*this)
		ProcedureReturn *col
	EndIf
EndProcedure

Procedure _MyTable_Table_Delete(*this.strMyTableTable)
	If *this
		DeleteMapElement(MyTableWindowTables(),Str(*this))
		If IsGadget(*this\canvas)				
			UnbindGadgetEvent(*this\canvas,@_MyTableEvtResize(),#PB_EventType_Resize)
			UnbindGadgetEvent(*this\canvas,@_MyTableEvtCanvasScroll(),#PB_EventType_MouseWheel)
			UnbindGadgetEvent(*this\canvas,@_MyTableEvtCanvasMouseMove(),#PB_EventType_MouseMove)
			UnbindGadgetEvent(*this\canvas,@_MyTableEvtCanvasMouseLeftDown(),#PB_EventType_LeftButtonDown)
			UnbindGadgetEvent(*this\canvas,@_MyTableEvtCanvasMouseLeftUp(),#PB_EventType_LeftButtonUp)
			UnbindGadgetEvent(*this\canvas,@_MyTableEvtCanvasMouseLeftDouble(),#PB_EventType_LeftDoubleClick)
			UnbindGadgetEvent(*this\canvas,@_MyTableEvtCanvasMouseLeftClick(),#PB_EventType_LeftClick)
			UnbindGadgetEvent(*this\canvas,@_MyTableEvtCanvasMouseRightDown(),#PB_EventType_RightButtonDown)
			UnbindGadgetEvent(*this\canvas,@_MyTableEvtCanvasMouseRightUp(),#PB_EventType_RightButtonUp)
			UnbindGadgetEvent(*this\canvas,@_MyTableEvtCanvasMouseRightDouble(),#PB_EventType_RightDoubleClick)
			UnbindGadgetEvent(*this\canvas,@_MyTableEvtCanvasMouseRightClick(),#PB_EventType_RightClick)
			UnbindGadgetEvent(*this\canvas,@_MyTableEvtCanvasKeyDown(),#PB_EventType_KeyDown)
			UnbindGadgetEvent(*this\canvas,@_MyTableEvtCanvasKeyUp(),#PB_EventType_KeyUp)	
			UnbindGadgetEvent(*this\canvas,@_MyTableEvtCanvasGotFocus(),#PB_EventType_Focus)	
			UnbindGadgetEvent(*this\canvas,@_MyTableEvtCanvasLostFocus(),#PB_EventType_LostFocus)	
		EndIf
		If IsGadget(*this\vscroll)
			UnbindGadgetEvent(*this\vscroll,@_MyTableEvtScroll())
		EndIf
		If IsGadget(*this\hscroll)
			UnbindGadgetEvent(*this\hscroll,@_MyTableEvtScroll())
		EndIf
		
		If *this\application
			Protected idx=0
			ForEach *this\application\tables()
				If *this\application\tables()=*this
					DeleteElement(*this\application\tables())
					Break
				Else
					*this\application\tables()\listindex=idx
					idx+1
				EndIf
			Next
		Else
			FreeStructure(*this)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Table_Free(*this.strMyTableTable)
	_MyTable_Table_Delete(*this)
EndProcedure

Procedure _MyTable_Table_GetData(*this.strMyTableTable)
	If *this
		ProcedureReturn *this\data
	EndIf
EndProcedure

Procedure _MyTable_Table_SetData(*this.strMyTableTable,*value)
	If *this
		*this\data=*value
	EndIf
EndProcedure

Procedure _MyTable_Table_ClearRows(*this.strMyTableTable,*value)
	If *this
		ClearList(*this\rows())
		*this\dirty=#True
		_MyTable_Table_Predraw(*this)
		_MyTable_Table_Redraw(*this)
	EndIf
EndProcedure

Procedure _MyTable_Table_ClearCols(*this.strMyTableTable,*value)
	If *this
		ClearList(*this\cols())				
		ForEach *this\rows()
			If *this\rows()\cells				
				FreeStructure(*this\rows()\cells)
				*this\rows()\cells=0
			EndIf
		Next
		*this\dirty=#True
		_MyTable_Table_Predraw(*this)
		_MyTable_Table_Redraw(*this)
	EndIf
EndProcedure




Procedure _MyTable_Table_Draw_Header(*this.strMyTableTable,by,*font.strMyTableFont,width.i,height.i,scrollx.i,scrolly.i,fixed.b)
	Protected border.b=_MyTable_IsBorder(*this)
	Protected bx=-scrollx	
	Protected idx=0
	Protected start=1	
	Protected fwidth.i=0
	Protected cc=0
	
	Protected ElementSelected.b=_MyTable_IsElement_Selected(*this)
	
	ForEach *this\cols()
		*this\cols()\parent=0
		If *this\cols()\dirty Or *this\cols()\textheight=0 Or *this\cols()\textwidth=0
			Protected *nfont.strMyTableFont=_MyTable_GetDefaultFont(*this\cols())
			DrawingFont(*nfont\fontid)
			*this\cols()\calcwidth=DesktopScaledX(*this\cols()\width)			
			*this\cols()\textwidth=_MyTableTextWidth(*this\cols()\text)
			*this\cols()\textheight=_MyTableTextHeight(*this\cols()\text)			
			*this\cols()\dirty=#False			
		EndIf
		If *this\fixedcols>ListIndex(*this\cols())
			fwidth+*this\cols()\calcwidth
		EndIf
	Next
	
	
	If fixed
		bx=0		
		cc=*this\fixedcols
	Else
		bx+fwidth
		start+*this\fixedcols
		cc=ListSize(*this\cols())
	EndIf
	
	
	For idx=start To cc
		Protected *col.strMyTableCol=SelectElement(*this\cols(),idx-1)
		Protected calcwidth.i=*col\calcwidth
		Protected selected.b=_MyTable_IsSelected(*col)
		Protected disabled.b=_MyTable_IsDisabled(*col)
		Protected tborder=_MyTable_GetDefaultBorder(*col)
		Protected bElementSelected.b=#False
		Protected *cell.strMyTableCell=0
		
		If ElementSelected
			ForEach *this\selectedCells()
				If *this\selectedCells()
					*cell=Val(MapKey(*this\selectedCells()))
					If *cell\col=*col
						bElementSelected=#True
						Break
					EndIf
				EndIf
			Next
			
			If Not bElementSelected
				ForEach *this\tempselectedCells()
					If *this\tempselectedCells()
						*cell=Val(MapKey(*this\tempselectedCells()))
						If *cell\col=*col
							bElementSelected=#True
							Break
						EndIf
					EndIf
				Next
			EndIf
		EndIf
		
		If *col\colspan>1
			Protected i=0
			For i=2 To *col\colspan
				Protected *tcol.strMyTableCol=SelectElement(*this\cols(),idx-2+i)
				calcwidth+*tcol\calcwidth
				*tcol\parent=*col
			Next
		EndIf
		
		If calcwidth>0
			
			Protected *tfont.strMyTableFont
			If disabled
				*tfont=_MyTable_GetDisabledFont(*col)
			ElseIf selected
				*tfont=_MyTable_GetSelectedFont(*col)
			ElseIf bElementSelected
				*tfont=_MyTable_GetElementSelectedFont(*col)
			Else
				*tfont=_MyTable_GetDefaultFont(*col)
			EndIf
			
			If *tfont
				DrawingFont(*tfont\fontid)					
			Else
				DrawingFont(*font\fontid)
			EndIf
			
			Protected addx=DesktopScaledX(2)
			Protected addy=0
			Protected valign=_MyTable_GetDefaultVAlign(*col)
			Protected halign=_MyTable_GetDefaultHAlign(*col)
			
			
			
			DrawingMode(#PB_2DDrawing_Default)
			BackColor(_MyTable_GetDefaultBackColor(*col))
			FrontColor(_MyTable_GetDefaultFrontColor(*col))
			ClipOutput(bx,by,calcwidth,*this\calcheaderheight)
			If disabled
				Box(bx,by,calcwidth,*this\calcheaderheight,_MyTable_GetDisabledBackColor(*col))
			ElseIf selected
				Box(bx,by,calcwidth,*this\calcheaderheight,_MyTable_GetSelectedBackColor(*col))
			ElseIf bElementSelected
				Box(bx,by,calcwidth,*this\calcheaderheight,_MyTable_GetElementSelectedBackColor(*col))
			Else
				Box(bx,by,calcwidth,*this\calcheaderheight,_MyTable_GetDefaultBackColor(*col))
			EndIf
			
			If *col\image And *col\image\orig And IsImage(*col\image\orig)
				addx+DesktopScaledX(2)
				If Not *col\image\sized
					*col\image\sized=CopyImage(*col\image\orig,#PB_Any)
					ResizeImage(*col\image\sized,*this\calcheaderheight-MyTableW8,*this\calcheaderheight-MyTableH8)
				EndIf
				DrawingMode(#PB_2DDrawing_AlphaClip)
				DrawImage(ImageID(*col\image\sized),bx+addx,by+addy+MyTableW4)
				DrawingMode(#PB_2DDrawing_Default)
				addx+*this\calcheaderheight
			EndIf
			
			If halign=#MYTABLE_STYLE_HALIGN_CENTER
				If *col\sort
					addx+(calcwidth - addx - MyTableW20) /2-*col\textwidth/2
				Else
					addx+(calcwidth - addx) /2-*col\textwidth/2
				EndIf
			ElseIf halign=#MYTABLE_STYLE_HALIGN_RIGHT
				addx+calcwidth - *col\textwidth - MyTableW8 - addx
				If *col\sort
					addx - MyTableW20
				EndIf
			Else
				addx+DesktopScaledX(2)
			EndIf
			
			If valign=#MYTABLE_STYLE_VALIGN_MIDDLE
				addy+*this\calcheaderheight/2 - *col\textheight/2
			ElseIf valign=#MYTABLE_STYLE_VALIGN_BOTTOM
				addy+*this\calcheaderheight-*col\textheight-MyTableH1			
			Else
				addy+DesktopScaledY(1)
			EndIf
			
			DrawingMode(#PB_2DDrawing_AlphaClip)
			Select *col\sort
				Case #MYTABLE_COL_SORT_ASC
					DrawImage(ImageID(*this\DefaultImageSortAsc),bx+calcwidth-MyTableW20,by)
				Case #MYTABLE_COL_SORT_DESC
					DrawImage(ImageID(*this\DefaultImageSortDesc),bx+calcwidth-MyTableW20,by)
			EndSelect
			
			DrawingMode(#PB_2DDrawing_Default)
			Protected ta=0
			If *col\sort
				ta=MyTableW20
			EndIf
			
			If Disabled
				_MyTableDrawText(bx+addx,addy+by,*col\text,_MyTable_GetDisabledForeColor(*col),calcwidth-addx-ta)
			ElseIf selected
				_MyTableDrawText(bx+addx,addy+by,*col\text,_MyTable_GetSelectedForeColor(*col),calcwidth-addx-ta)
			ElseIf bElementSelected
				_MyTableDrawText(bx+addx,addy+by,*col\text,_MyTable_GetelementSelectedForeColor(*col),calcwidth-addx-ta)
			Else
				_MyTableDrawText(bx+addx,addy+by,*col\text,_MyTable_GetDefaultForeColor(*col),calcwidth-addx-ta)
			EndIf
			
			If border
				Protected bw=0
				Protected c=0
				Protected bcolor.q=0
				DrawingMode(#PB_2DDrawing_Default)
				If Bool(tborder & #MYTABLE_STYLE_BORDER_TOP)
					If disabled
						bcolor=_MyTable_GetDisabledBorderColorTop(*col)
						c=_MyTable_GetDisabledBorderWidthTop(*col)
					ElseIf selected
						bcolor=_MyTable_GetSelectedBorderColorTop(*col)
						c=_MyTable_GetSelectedBorderWidthTop(*col)
					ElseIf elementselected
						bcolor=_MyTable_GetElementSelectedBorderColorTop(*col)
						c=_MyTable_GetElementSelectedBorderWidthTop(*col)
					Else
						bcolor=_MyTable_GetDefaultBorderColorTop(*col)
						c=_MyTable_GetDefaultBorderWidthTop(*col)
					EndIf
					c=DesktopScaledY(c)
					Box(bx,by,calcwidth,c,bcolor)
				EndIf
				
				If Bool(tborder &  #MYTABLE_STYLE_BORDER_RIGHT)
					If disabled
						bcolor=_MyTable_GetDisabledBorderColorRight(*col)
						c=_MyTable_GetDisabledBorderWidthRight(*col)
					ElseIf selected
						bcolor=_MyTable_GetSelectedBorderColorRight(*col)
						c=_MyTable_GetSelectedBorderWidthRight(*col)
					ElseIf elementselected
						bcolor=_MyTable_GetElementSelectedBorderColorRight(*col)
						c=_MyTable_GetElementSelectedBorderWidthRight(*col)
					Else
						bcolor=_MyTable_GetDefaultBorderColorRight(*col)
						c=_MyTable_GetDefaultBorderWidthRight(*col)
					EndIf
					c=DesktopScaledX(c)
					Box(bx+calcwidth-c,by,calcwidth,c,bcolor)
				EndIf
				If Bool(tborder &  #MYTABLE_STYLE_BORDER_BOTTOM)
					If disabled
						bcolor=_MyTable_GetDisabledBorderColorBottom(*col)
						c=_MyTable_GetDisabledBorderWidthBottom(*col)
					ElseIf selected
						bcolor=_MyTable_GetSelectedBorderColorBottom(*col)
						c=_MyTable_GetSelectedBorderWidthBottom(*col)
					ElseIf elementselected
						bcolor=_MyTable_GetElementSelectedBorderColorBottom(*col)
						c=_MyTable_GetElementSelectedBorderWidthBottom(*col)
					Else
						bcolor=_MyTable_GetDefaultBorderColorBottom(*col)
						c=_MyTable_GetDefaultBorderWidthBottom(*col)
					EndIf
					c=DesktopScaledY(c)
					Box(bx,*this\calcheaderheight-c,calcwidth,c,bcolor)
				EndIf
				If Bool(tborder &  #MYTABLE_STYLE_BORDER_LEFT)
					If disabled
						bcolor=_MyTable_GetDisabledBorderColorLeft(*col)
						c=_MyTable_GetDisabledBorderWidthLeft(*col)
					ElseIf selected
						bcolor=_MyTable_GetSelectedBorderColorLeft(*col)
						c=_MyTable_GetSelectedBorderWidthLeft(*col)
					ElseIf elementselected
						bcolor=_MyTable_GetElementSelectedBorderColorLeft(*col)
						c=_MyTable_GetElementSelectedBorderWidthLeft(*col)
					Else
						bcolor=_MyTable_GetDefaultBorderColorLeft(*col)
						c=_MyTable_GetDefaultBorderWidthLeft(*col)
					EndIf
					c=DesktopScaledX(c)
					Box(bx,by,c,*this\calcheaderheight,bcolor)
				EndIf				
			EndIf
			UnclipOutput()
			bx+calcwidth
			If bx>=width
				Break
			EndIf
		EndIf
		If *col\colspan>1
			idx+(*col\colspan-1)
		EndIf
	Next
	ProcedureReturn *this\calcheaderheight
EndProcedure

Procedure _MyTable_Table_Draw_CellText(bx,by,addx,addy,*font.strMyTableFont,fixed,selected,checkboxes,disabled,idx,*cell.strMyTableCell,cw)
	Protected result=*cell\table\calcdefaultrowheight
	Protected valign=_MyTable_GetDefaultVAlign(*cell)
	Protected halign=_MyTable_GetDefaultHAlign(*cell)
	Protected *col.strMyTableCol=*cell\col
	Protected *this.strMyTableRow=*cell\row
	Protected tw=0
	
	
	Protected *tfont.strMyTableFont=0
	If disabled
		*tfont=_MyTable_GetDisabledFont(*cell)
	ElseIf fixed
		*tfont=_MyTable_GetFixedFont(*cell)
	ElseIf selected
		*tfont=_MyTable_GetSelectedFont(*cell)
	Else
		*tfont=_MyTable_GetDefaultFont(*cell)
	EndIf
	
	
	If *tfont
		DrawingFont(*tfont\fontid)		
	Else						
		DrawingFont(*font\fontid)		
	EndIf
	
	If *cell\dirty Or *cell\textwidth=0 Or *cell\textheight=0
		*cell\textwidth=_MyTableTextWidth(*cell\text)
		*cell\textheight=_MyTableTextHeight(*cell\text)
	EndIf
	
	If *cell\imageRight And *cell\imageRight\orig And IsImage(*cell\imageRight\orig)
		
		If *cell\imageRight\resize					
			tw=*this\calcheight+MyTableW4
		Else
			tw=*this\table\calcdefaultrowheight+MyTableW4
		EndIf
		
	EndIf
	
	If halign=#MYTABLE_STYLE_HALIGN_CENTER
		If checkboxes And idx>1
			addx+(*col\calcwidth-addx - MyTableW20-tw)/2-*cell\textwidth/2
		Else
			addx+(*col\calcwidth-addx-tw)/2-*cell\textwidth/2
		EndIf
	ElseIf halign=#MYTABLE_STYLE_HALIGN_RIGHT
		addx+*col\calcwidth - *cell\textwidth - MyTableW8 - addx - tw
		If checkboxes And idx>1
			addx-MyTableW20
		EndIf
	Else
		addx+DesktopScaledX(2)
	EndIf
	
	If valign=#MYTABLE_STYLE_VALIGN_MIDDLE
		addy+*this\calcheight/2 - *cell\textheight/2
	ElseIf valign=#MYTABLE_STYLE_VALIGN_BOTTOM
		addy+*this\calcheight-*cell\textheight-MyTableH1
	Else
		addy+DesktopScaledY(1)
	EndIf
	
	If *cell\text<>""
		
		If fixed
			_MyTableDrawText(bx+addx,by+addy,*cell\text,_MyTable_GetFixedForeColor(*cell),cw-addx-tw)
		Else
			If selected
				_MyTableDrawText(bx+addx,by+addy,*cell\text,_MyTable_GetSelectedForeColor(*cell),cw-addx-tw)
			Else
				_MyTableDrawText(bx+addx,by+addy,*cell\text,_MyTable_GetDefaultForeColor(*cell),cw-addx-tw)
			EndIf
		EndIf		
		result=*cell\textheight
	EndIf
	
	If *cell\cells
		ForEach *cell\cells\cells()
			result+_MyTable_Table_Draw_CellText(bx,by+result,addx,addy,*font.strMyTableFont,fixed,selected,checkboxes,disabled,idx,*cell\cells\cells(),cw)
		Next
	EndIf
	ProcedureReturn result
EndProcedure

Procedure _MyTable_Table_Draw_Row(*this.strMyTableRow,by,cols,*font.strMyTableFont,width.i,height.i,scrollx.i,scrolly.i,zebra.b,fixed.b)	
	Protected *lastfont.strMyTableFont=*font.strMyTableFont
	Protected bx=-scrollx
	Protected hierarchical.b=_MyTable_IsHierarchical(*this\table)
	Protected checkboxes.b=#False
	Protected border.b=_MyTable_IsBorder(*this\table)
	Protected callback.b=_MyTable_IsCallback(*this\table)
	Protected alwaysexpanded.b=_MyTable_IsHierarchical_Always_Expanded(*this)
	Protected markmouseover.b=_MyTable_IsMark_Mouse_Over(*this\table)
	Protected Fullrowselect.b=_MyTable_IsFullrowselect(*this\table)
	Protected ElementSelected.b=_MyTable_IsElement_Selected(*this)
	Protected *cell.strMyTableCell=0
	
	Protected idx=0
	Protected start=1	
	Protected fwidth.i=0
	Protected cc=0
	
	If *this\dirty
		*this\calcheight=DesktopScaledY(*this\height)
		*this\dirty=#False
	EndIf
	
	If *this\table\fixedcols
		ForEach *this\table\cols()
			If *this\table\fixedcols>ListIndex(*this\table\cols())
				fwidth+*this\table\cols()\calcwidth
			EndIf
		Next
	EndIf
	
	Protected bElementSelected.b=#False
	If fixed
		
		If ElementSelected
			ForEach *this\table\selectedCells()
				If *this\table\selectedCells()
					*cell=Val(MapKey(*this\table\selectedCells()))
					If *cell\row=*this
						bElementSelected=#True
						Break
					EndIf
				EndIf
			Next
			
			If Not bElementSelected
				ForEach *this\table\tempselectedCells()
					If *this\table\tempselectedCells()
						*cell=Val(MapKey(*this\table\tempselectedCells()))
						If *cell\row=*this
							bElementSelected=#True
							Break
						EndIf
					EndIf
				Next
			EndIf
		EndIf
		bx=0		
	Else
		bx+fwidth
		start+*this\table\fixedcols
	EndIf
	
	If callback And *this\dirty And *this\table\callback
		*this\table\callback(*this)
	EndIf
	Protected selected.b=#False
	Protected mselected.b=#False
	
	Protected cw,ch
	
	For idx=start To cols
		
		
		DrawingMode(#PB_2DDrawing_Default)			
		*cell=_MyTableGetOrAddCell(*this,idx-1,#True)
		Protected *col.strMyTableCol=*cell\col
		cw=*col\calcwidth
		If *cell\colspan>1
			Protected g
			For g=2 To *cell\colspan
				If g<=cols
					SelectElement(*this\table\cols(),*col\listindex+(g-1))
					cw+*this\table\cols()\calcwidth
				EndIf
			Next
		EndIf
		ch=*this\calcheight
		
		If cw>0 And (bx+cw)>=0
			Protected customdraw.b=#False
			
			checkboxes=_MyTable_IsCheckboxes(*this)
			Protected tborder=_MyTable_GetDefaultBorder(*cell)
			
			selected=Bool(_MyTable_IsSelected(*this))
			selected=Bool(selected Or _MyTable_IsSelected(*cell))
			selected=Bool(selected Or _MyTable_IsSelected(*cell\col))
			selected=Bool(selected Or _MyTable_IsSelected(*cell\row))
			
			Protected Disabled.b=_MyTable_IsDisabled(*cell)
			
			mselected=#False
			If markmouseover And Not selected
				mselected=Bool(mselected Or Bool(*this\table\mvcell=*cell))		
				If Fullrowselect
					mselected=Bool(mselected Or Bool(*this\table\mvrow=*this))
				EndIf
			EndIf
			
			
			
			ClipOutput(bx,by,cw,ch)
			*cell\startx=bx
			*cell\starty=by
			If *this\table\eventCustomCellDraw
				customdraw=*this\table\eventCustomCellDraw(*cell,bx,by,cw,ch)
			EndIf
			
			If Not customdraw
				If disabled
					Box(bx,by,cw,ch,_MyTable_GetDisabledBackColor(*cell))
				ElseIf bElementSelected
					Box(bx,by,cw,ch,_MyTable_GetElementSelectedBackColor(*cell))
				ElseIf selected
					Box(bx,by,cw,ch,_MyTable_GetSelectedBackColor(*cell))
				Else
					If mselected
						Box(bx,by,cw,ch,_MyTable_GetMouseOverBackColor(*cell))
					ElseIf fixed
						Box(bx,by,cw,ch,_MyTable_GetFixedBackColor(*cell))
					Else
						If zebra
							Box(bx,by,cw,ch,_MyTable_GetZebraBackColor(*cell))
						Else
							Box(bx,by,cw,ch,_MyTable_GetDefaultBackColor(*cell))
						EndIf
					EndIf
				EndIf
				
				
				Protected addx=DesktopScaledX(2)
				Protected addy=0
				
				
				If hierarchical
					If idx=1
						addx+*this\level*MyTableW20
						DrawingMode(#PB_2DDrawing_AlphaClip)
						If *this\rows
							If ListSize(*this\rows\rows())>0
								If Not alwaysexpanded
									If *this\expanded
										DrawImage(ImageID(*this\table\DefaultImageMinusArrow),bx+addx,by)
									Else
										DrawImage(ImageID(*this\table\DefaultImagePlusArrow),bx+addx,by)
									EndIf
								EndIf
							EndIf
						EndIf
						DrawingMode(#PB_2DDrawing_Default)
						addx+MyTableW20
					EndIf
				EndIf
				
				If checkboxes
					If idx=1
						DrawingMode(#PB_2DDrawing_AlphaClip)				
						If *this\checked
							DrawImage(ImageID(*this\table\DefaultImageCheckBoxChecked),bx+addx,by+MyTableH2)
						Else
							DrawImage(ImageID(*this\table\DefaultImageCheckBox),bx+addx,by+MyTableH2)
						EndIf				
						DrawingMode(#PB_2DDrawing_Default)
						addx+MyTableW20
						
					EndIf
					
				EndIf
				checkboxes=_MyTable_IsCheckboxes(*cell)
				
				If idx=1
					If *this\image And *this\image\orig And IsImage(*this\image\orig)
						addx+DesktopScaledX(2)
						If Not *this\image\sized
							*this\image\sized=CopyImage(*this\image\orig,#PB_Any)
							If *this\image\resize
								ResizeImage(*this\image\sized,ch-MyTableW8,ch-MyTableH8)
							Else
								ResizeImage(*this\image\sized,*this\table\calcdefaultrowheight-MyTableW8,*this\table\calcdefaultrowheight-MyTableH8)
							EndIf
						EndIf
						DrawingMode(#PB_2DDrawing_AlphaClip)
						DrawImage(ImageID(*this\image\sized),bx+addx,by+addy+MyTableW4)
						DrawingMode(#PB_2DDrawing_Default)
						If *this\image\resize
							addx+ch
						Else
							addx+*this\table\calcdefaultrowheight
						EndIf
					EndIf
				EndIf
				
				If *cell\imageLeft And *cell\imageLeft\orig And IsImage(*cell\imageLeft\orig)
					addx+DesktopScaledX(2)
					If Not *cell\imageLeft\sized
						*cell\imageLeft\sized=CopyImage(*cell\imageLeft\orig,#PB_Any)
						If *cell\imageLeft\resize
							ResizeImage(*cell\imageLeft\sized,ch-MyTableW8,ch-MyTableH8)
						Else
							ResizeImage(*cell\imageLeft\sized,*this\table\calcdefaultrowheight-MyTableW8,*this\table\calcdefaultrowheight-MyTableH8)
						EndIf
					EndIf
					DrawingMode(#PB_2DDrawing_AlphaClip)
					DrawImage(ImageID(*cell\imageLeft\sized),bx+addx,by+addy+MyTableW4)
					DrawingMode(#PB_2DDrawing_Default)
					If *cell\imageLeft\resize
						addx+ch
					Else
						addx+*this\table\calcdefaultrowheight
					EndIf
				EndIf
				
				
				If *cell\imageRight And *cell\imageRight\orig And IsImage(*cell\imageRight\orig)				
					If Not *cell\imageRight\sized
						*cell\imageRight\sized=CopyImage(*cell\imageRight\orig,#PB_Any)
						If *cell\imageRight\resize
							ResizeImage(*cell\imageRight\sized,ch-MyTableW8,ch-MyTableH8)
						Else
							ResizeImage(*cell\imageRight\sized,*this\table\calcdefaultrowheight-MyTableW8,*this\table\calcdefaultrowheight-MyTableH8)
						EndIf
					EndIf
				EndIf
				
				If checkboxes
					If idx>1
						DrawingMode(#PB_2DDrawing_AlphaClip)
						If *cell\checked
							DrawImage(ImageID(*this\table\DefaultImageCheckBoxChecked),bx+addx,by+MyTableH2)
						Else
							DrawImage(ImageID(*this\table\DefaultImageCheckBox),bx+addx,by+MyTableH2)
						EndIf
						DrawingMode(#PB_2DDrawing_Default)
						addx+MyTableW20
					EndIf			
				EndIf
				
				
				_MyTable_Table_Draw_CellText(bx,by,addx,addy,*font.strMyTableFont,fixed,selected,checkboxes,disabled,idx,*cell,cw)
				
				
				If *cell\imageRight And *cell\imageRight\orig And IsImage(*cell\imageRight\orig)
					DrawingMode(#PB_2DDrawing_AlphaClip)				
					If *cell\imageRight\resize					
						DrawImage(ImageID(*cell\imageRight\sized),bx+cw-ch,by+addy+MyTableW4)
					Else
						DrawImage(ImageID(*cell\imageRight\sized),bx+cw-*this\table\calcdefaultrowheight,by+addy+MyTableW4)
					EndIf
					DrawingMode(#PB_2DDrawing_Default)
				EndIf
				
				If border
					Protected bw=0
					Protected c=0
					Protected bcolor.q=0
					DrawingMode(#PB_2DDrawing_Default)
					If Bool(tborder & #MYTABLE_STYLE_BORDER_TOP)
						If disabled
							bcolor=_MyTable_GetDisabledBorderColorTop(*cell)
							c=_MyTable_GetDisabledBorderWidthTop(*cell)
						ElseIf selected
							bcolor=_MyTable_GetSelectedBorderColorTop(*cell)
							c=_MyTable_GetSelectedBorderWidthTop(*cell)
						ElseIf elementselected
							bcolor=_MyTable_GetElementSelectedBorderColorTop(*cell)
							c=_MyTable_GetElementSelectedBorderWidthTop(*cell)
						Else
							bcolor=_MyTable_GetDefaultBorderColorTop(*cell)
							c=_MyTable_GetDefaultBorderWidthTop(*cell)
						EndIf
						c=DesktopScaledY(c)
						Box(bx,by,cw,c,bcolor)
					EndIf
					
					If Bool(tborder &  #MYTABLE_STYLE_BORDER_RIGHT)
						If disabled
							bcolor=_MyTable_GetDisabledBorderColorRight(*cell)
							c=_MyTable_GetDisabledBorderWidthRight(*cell)
						ElseIf selected
							bcolor=_MyTable_GetSelectedBorderColorRight(*cell)
							c=_MyTable_GetSelectedBorderWidthRight(*cell)
						ElseIf elementselected
							bcolor=_MyTable_GetElementSelectedBorderColorRight(*cell)
							c=_MyTable_GetElementSelectedBorderWidthRight(*cell)
						Else
							bcolor=_MyTable_GetDefaultBorderColorRight(*cell)
							c=_MyTable_GetDefaultBorderWidthRight(*cell)
						EndIf
						c=DesktopScaledX(c)
						Box(bx+cw-c,by,cw,ch,bcolor)
					EndIf
					If Bool(tborder &  #MYTABLE_STYLE_BORDER_BOTTOM)
						If disabled
							bcolor=_MyTable_GetDisabledBorderColorBottom(*cell)
							c=_MyTable_GetDisabledBorderWidthBottom(*cell)
						ElseIf selected
							bcolor=_MyTable_GetSelectedBorderColorBottom(*cell)
							c=_MyTable_GetSelectedBorderWidthBottom(*cell)
						ElseIf elementselected
							bcolor=_MyTable_GetElementSelectedBorderColorBottom(*cell)
							c=_MyTable_GetElementSelectedBorderWidthBottom(*cell)
						Else
							bcolor=_MyTable_GetDefaultBorderColorBottom(*cell)
							c=_MyTable_GetDefaultBorderWidthBottom(*cell)
						EndIf
						c=DesktopScaledY(c)
						Box(bx,by+ch-c,cw,c,bcolor)
					EndIf
					If Bool(tborder &  #MYTABLE_STYLE_BORDER_LEFT)
						If disabled
							bcolor=_MyTable_GetDisabledBorderColorLeft(*cell)
							c=_MyTable_GetDisabledBorderWidthLeft(*cell)
						ElseIf selected
							bcolor=_MyTable_GetSelectedBorderColorLeft(*cell)
							c=_MyTable_GetSelectedBorderWidthLeft(*cell)
						ElseIf elementselected
							bcolor=_MyTable_GetElementSelectedBorderColorLeft(*cell)
							c=_MyTable_GetElementSelectedBorderWidthLeft(*cell)
						Else
							bcolor=_MyTable_GetDefaultBorderColorLeft(*cell)
							c=_MyTable_GetDefaultBorderWidthLeft(*cell)
						EndIf
						c=DesktopScaledX(c)
						Box(bx,by,c,ch,bcolor)
					EndIf
					
				EndIf
			EndIf
			UnclipOutput()						
		EndIf
		bx+cw
		If bx>=width
			Break
		EndIf		
		If *cell\colspan>1
			idx+*cell\colspan-1
		EndIf
	Next
	*this\dirty=#False
	ProcedureReturn ch
EndProcedure

Procedure _MyTable_Table_Redraw(*this.strMyTableTable)
	If *this And *this\canvas
		_MyTable_Table_ClearMaps(*this)
		Protected redraw.b=Bool(*this\dirty And *this\redraw And Not *this\batch)
		Protected header.b=_MyTable_IsHeader(*this)
		Protected pages.b=_MyTable_IsPages(*this)
		Protected title.b=_MyTable_IsTitle(*this)
		Protected zebra.b=_MyTable_IsZebra(*this)
		
		
		If *this\application
			redraw=Bool(redraw And *this\application\redraw)
		EndIf
		redraw=Bool(redraw And Not *this\drawing)
		If redraw
			_callcountStart()
			If IsImage(*this\canvas)
				StartDrawing(ImageOutput(*this\canvas))
			EndIf
			If IsGadget(*this\canvas)
				StartDrawing(CanvasOutput(*this\canvas))
			EndIf
			*this\drawing=#True
			Protected *font.strMyTableFont=_MyTable_GetDefaultFont(*this)
			Protected backcolor.q=_MyTable_GetDefaultBackColor(*this)
			Protected frontcolor.q=_MyTable_GetDefaultFrontColor(*this)
			
			Protected height=OutputHeight()
			Protected width=OutputWidth()
			
			Protected scrollx.i=*this\hscroll
			Protected scrolly.i=*this\vscroll
			If IsGadget(scrollx)
				scrollx=GetGadgetState(scrollx)
			EndIf
			If IsGadget(scrolly)
				scrolly=GetGadgetState(scrolly)
			EndIf
			
			scrollx=DesktopScaledX(scrollx)
			scrolly=DesktopScaledY(scrolly)
			
			BackColor(backcolor)
			FrontColor(frontcolor)
			DrawingFont(*font\fontid)
			
			If backcolor<>frontcolor
				DrawingMode(#PB_2DDrawing_Gradient)
				LinearGradient(0,0,width,height)
			EndIf
			Box(0,0,width,height)
			
			Protected by=-scrolly
			If header
				by+*this\calcheaderheight
			EndIf
			
			If Title
				by+*this\calctitleHeight
			EndIf
			
			Protected *row.strMyTableRow=0
			
			If ListSize(*this\expRows())>0 Or ListSize(*this\expRowsPage())>0
				Protected c=ListSize(*this\cols())
				If pages
					ForEach *this\expRowsPage()
						*row=*this\expRowsPage()
						
						If by+*row\calcheight>=0
							DrawingFont(*font\fontid)
							_MyTable_Table_Draw_Row(*row,by,c,*font,width,height,scrollx,scrolly,Bool(ListIndex(*this\expRowsPage()) % 2 = 1),#False)
							If *this\fixedcols
								_MyTable_Table_Draw_Row(*row,by,*this\fixedcols,*font,width,height,scrollx,scrolly,Bool(ListIndex(*this\expRowsPage()) % 2 = 1),#True)
							EndIf
						EndIf
						by+*row\calcheight
						
						
						If by>height
							Break
						EndIf
					Next
				Else
					ForEach *this\expRows()
						*row=*this\expRows()
						
						If by+*row\calcheight>=0
							DrawingFont(*font\fontid)
							Protected tz.b=zebra
							If tz
								tz=Bool(ListIndex(*this\expRows()) % 2 = 1)
							EndIf
							_MyTable_Table_Draw_Row(*row,by,c,*font,width,height,scrollx,scrolly,tz,#False)
							If *this\fixedcols
								_MyTable_Table_Draw_Row(*row,by,*this\fixedcols,*font,width,height,scrollx,scrolly,tz,#True)
							EndIf
						EndIf
						by+*row\calcheight
						
						If by>height
							Break
						EndIf
					Next
				EndIf
			Else
				DrawingMode(#PB_2DDrawing_Transparent)
				*font=_MyTable_GetEmptyFont(*this)
				If *font
					DrawingFont(*font\fontid)
				EndIf
				_MyTableDrawTextCompleteCenter(by,*this\emptytext,_MyTable_GetEmptyForeColor(*this),width)
			EndIf
			
			by=0
			If Title
				by=*this\calctitleHeight
			EndIf
			
			*font=_MyTable_GetDefaultFont(*this)
			If *font
				DrawingFont(*font\fontid)
			EndIf
			If header				
				_MyTable_Table_Draw_Header(*this,by,*font,width,height,scrollx,scrolly,#False)
				If *this\fixedcols
					_MyTable_Table_Draw_Header(*this,by,*font,width,height,scrollx,scrolly,#True)
				EndIf
			EndIf
			
			If title
				DrawingMode(#PB_2DDrawing_Default)
				Box(0,0,width,*this\calctitleHeight,_MyTable_GetTitleBackColor(*this))
				Protected addx=0
				Protected addy=0			
				
				If *this\titleStyle\halign=#MYTABLE_STYLE_HALIGN_CENTER
					addx=width/2-*this\textwidth/2
				ElseIf *this\titleStyle\halign=#MYTABLE_STYLE_HALIGN_RIGHT
					addx=width - *this\textwidth - MyTableW8
				Else
					addx=DesktopScaledX(2)
				EndIf
				
				If *this\titleStyle\valign=#MYTABLE_STYLE_VALIGN_MIDDLE
					addy=*this\calctitleHeight/2 - *this\textheight/2
				ElseIf *this\titleStyle\valign=#MYTABLE_STYLE_VALIGN_BOTTOM
					addy=*this\calctitleHeight-*this\textheight-MyTableH1
				Else
					addy=DesktopScaledY(1)
				EndIf
				*font=_MyTable_GetTitleFont(*this)
				If *font				
					DrawingFont(*font\fontid)
				EndIf
				DrawingMode(#PB_2DDrawing_Transparent)
				_MyTableDrawText(addx,addy,*this\title,_MyTable_GetTitleForeColor(*this),width)
			EndIf
			
			If IsGadget(*this\vscroll)
				BackColor(backcolor)
				FrontColor(frontcolor)
				DrawingMode(#PB_2DDrawing_Default)
				Box(width-DesktopScaledX(GadgetWidth(*this\vscroll)),
				    height-DesktopScaledY(GadgetHeight(*this\hscroll)),
				    DesktopScaledX(GadgetWidth(*this\vscroll)),
				    DesktopScaledY(GadgetHeight(*this\hscroll)))
			EndIf
			*this\dirty=#False
			*this\drawing=#False
			StopDrawing()
			_callcountEnde()
		EndIf
	EndIf
EndProcedure

Procedure.i _MyTable_Table_PredrawSub(*this.strMyTableTable,*row.strMyTableRow,pages.b)
	Protected result.i=0
	If *row\rows
		ForEach *row\rows\rows()
			If pages
				AddElement(*this\expRowsPage())
				*this\expRowsPage()=*row\rows\rows()
				*row\rows\rows()\explistindex=ListIndex(*this\expRowsPage())
			Else
				AddElement(*this\expRows())
				*this\expRows()=*row\rows\rows()
				*row\rows\rows()\explistindex=ListIndex(*this\expRows())
			EndIf
			result+*row\rows\rows()\height			
			If *row\rows\rows()\expanded And *row\rows\rows()\rows And ListSize(*row\rows\rows()\rows\rows())>0
				result+_MyTable_Table_PredrawSub(*this,*row\rows\rows(),pages)
			EndIf
		Next
	EndIf
	ProcedureReturn result
EndProcedure

Procedure _MyTable_Table_Predraw(*this.strMyTableTable,force.b=#False)
	Protected result.i=0
	If *this
		If ((*this\redraw And *this\dirty) Or force) And Not *this\drawing And Not *this\batch
			_callcountStart()
			ClearList(*this\expRows())
			ClearList(*this\expRowsPage())
			Protected h=0
			Protected w=0
			Protected cc=0
			Protected ph=0
			Protected hierarchical.b=_MyTable_IsHierarchical(*this)
			Protected header.b=_MyTable_IsHeader(*this)
			Protected pages.b=_MyTable_IsPages(*this)
			Protected title.b=_MyTable_IsTitle(*this)
			
			If title
				If *this\title=""
					*this\textheight=0
					*this\textwidth=0
				Else
					If *this\dirty Or *this\textheight=0 Or *this\textwidth=0
						If Not *this\drawing
							If IsGadget(*this\canvas)
								StartDrawing(CanvasOutput(*this\canvas))
							EndIf
							If IsImage(*this\canvas)
								StartDrawing(ImageOutput(*this\canvas))
							EndIf
						EndIf
						Protected *titleFont.strMyTableFont=_MytAble_GetTitleFont(*this)
						DrawingFont(*titleFont\fontid)						
						*this\textheight=_MyTableTextHeight(*this\title)
						*this\textwidth=_MyTableTextWidth(*this\title)
						If Not *this\drawing
							StopDrawing()
						EndIf
					EndIf
				EndIf
				h+*this\titleHeight
				ph+*this\titleHeight
			EndIf
			
			If header
				h+*this\headerheight
				ph+*this\headerheight
			EndIf
			If pages
				If *this\pageElements=0
					*this\pageElements=1
				EndIf
				cc=*this\pageElements
				Protected max=Round(ListSize(*this\rows())/cc,#PB_Round_Up)
				If *this\page=0
					*this\page=1
				EndIf
				If *this\page>max
					*this\page=max
				EndIf
				
				
			EndIf
			
			ForEach *this\rows()
				AddElement(*this\expRows())
				*this\expRows()=*this\rows()
				
				
				h+*this\rows()\height
				If pages
					If cc And max And *this\page And ListIndex(*this\rows())>=((*this\page-1) * cc)
						ph+*this\rows()\height
						AddElement(*this\expRowsPage())
						*this\expRowsPage()=*this\rows()
						*this\rows()\explistindex=ListIndex(*this\expRowsPage())
						cc-1
					EndIf
				Else
					*this\rows()\explistindex=ListIndex(*this\expRows())
				EndIf
				If hierarchical
					If *this\rows()\expanded And *this\rows()\rows And ListSize(*this\rows()\rows\rows())>0
						h+_MyTable_Table_PredrawSub(*this,*this\rows(),pages)
						If pages
							ph+_MyTable_Table_PredrawSub(*this,*this\expRowsPage(),pages)
						EndIf
					EndIf
				EndIf
			Next
			
			result=DesktopUnscaledY(h)
			
			Protected cw=0
			Protected ch=0
			
			If IsGadget(*this\canvas)
				cw=GadgetWidth(*this\canvas)
				ch=GadgetHeight(*this\canvas)
			EndIf
			If IsImage(*this\canvas)
				cw=ImageWidth(*this\canvas)
				ch=ImageHeight(*this\canvas)
			EndIf
			
			
			Protected cs.i=0
			ForEach *this\cols()
				If *this\cols()\stretched
					cs+1
				Else
					w+*this\cols()\width
				EndIf
			Next
			
			If pages
				h=ph
			EndIf
			
			w-cw
			h-ch
			*this\maxhscroll=w
			If *this\maxhscroll<0
				*this\maxhscroll=0
			EndIf
			
			
			If IsGadget(*this\hscroll)
				
				If h>0
					w+GadgetWidth(*this\vscroll)
					ResizeGadget(*this\hscroll,#PB_Ignore,#PB_Ignore,cw-GadgetWidth(*this\vscroll),#PB_Ignore)
				ElseIf h=0
					ResizeGadget(*this\hscroll,#PB_Ignore,#PB_Ignore,cw,#PB_Ignore)
				Else
					ResizeGadget(*this\hscroll,#PB_Ignore,#PB_Ignore,cw-GadgetWidth(*this\vscroll),#PB_Ignore)
				EndIf
				
				If cs>0
					cc=Abs(w)/cs
					Protected dcc=DesktopScaledX(cc)
					If cc>0
						ForEach *this\cols()
							If *this\cols()\stretched
								*this\cols()\width=cc
								*this\cols()\calcwidth=dcc
							EndIf
						Next
					Else
						ForEach *this\cols()
							If *this\cols()\stretched
								*this\cols()\width=0
								*this\cols()\calcwidth=0
							EndIf
						Next
					EndIf
				EndIf
				
				If w<0
					w=0
				EndIf
				
				If w>0
					HideGadget(*this\hscroll,#False)										
					SetGadgetAttribute(*this\hscroll,#PB_ScrollBar_Maximum,w+cw-1)
				Else					
					SetGadgetAttribute(*this\hscroll,#PB_ScrollBar_Maximum,0)
					HideGadget(*this\hscroll,#True)
					SetGadgetState(*this\hscroll,0)
				EndIf
				SetGadgetAttribute(*this\hscroll,#PB_ScrollBar_PageLength,cw)
			Else
				w-*this\hscroll
			EndIf
			
			
			*this\maxvscroll=h
			If *this\maxvscroll<0
				*this\maxvscroll=0
			EndIf
			If IsGadget(*this\vscroll)
				
				If w>0					
					h+GadgetHeight(*this\hscroll)		
					ResizeGadget(*this\vscroll,#PB_Ignore,#PB_Ignore,#PB_Ignore,ch-GadgetHeight(*this\hscroll))					
				ElseIf w=0
					ResizeGadget(*this\vscroll,#PB_Ignore,#PB_Ignore,#PB_Ignore,ch)
				Else
					ResizeGadget(*this\vscroll,#PB_Ignore,#PB_Ignore,#PB_Ignore,ch-GadgetHeight(*this\hscroll))
				EndIf
				
				If h>0
					HideGadget(*this\vscroll,#False)				
					SetGadgetAttribute(*this\vscroll,#PB_ScrollBar_Maximum,h+ch-1)
				Else
					SetGadgetAttribute(*this\vscroll,#PB_ScrollBar_Maximum,0)
					HideGadget(*this\vscroll,#True)
					SetGadgetState(*this\vscroll,0)
				EndIf
				
				SetGadgetAttribute(*this\vscroll,#PB_ScrollBar_PageLength,ch)
			Else
				h-*this\vscroll
			EndIf
			
			
			_callcountEnde()
		EndIf
	EndIf
	ProcedureReturn result
EndProcedure

Procedure.b _MyTable_Table_GetRedraw(*this.strMyTableTable)
	If *this
		ProcedureReturn *this\redraw
	EndIf
EndProcedure

Procedure _MyTable_Table_SetRedraw(*this.strMyTableTable,value.b)
	If *this
		*this\redraw=value
		*this\dirty=#True
		If value
			_MyTable_Table_Predraw(*this)
			_MyTable_Table_Redraw(*this)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Table_Recalc(*this.strMyTableTable)
	If *this
		Protected recalc.b=*this\recalc
		If *this\application
			recalc=Bool(recalc And *this\application\recalc)
		EndIf
		If recalc And Not *this\drawing
			_callcountStart()
			
			
			_callcountEnde()
		EndIf
		
		_MyTable_Table_Redraw(*this)
	EndIf
EndProcedure

Procedure.b _MyTable_Table_GetRecalc(*this.strMyTableTable)
	If *this
		ProcedureReturn *this\recalc
	EndIf
EndProcedure

Procedure _MyTable_Table_SetRecalc(*this.strMyTableTable,value.b)
	If *this
		*this\recalc=value
		If value
			_MyTable_Table_Recalc(*this)
		EndIf
	EndIf
EndProcedure


Procedure _MyTable_Table_GetHeaderHeight(*this.strMyTableTable)
	If *this
		ProcedureReturn *this\headerheight
	EndIf
EndProcedure

Procedure _MyTable_Table_GetTitleHeight(*this.strMyTableTable)
	If *this
		ProcedureReturn *this\headerheight
	EndIf
EndProcedure

Procedure _MyTable_Table_GetDefaultRowHeight(*this.strMyTableTable)
	If *this
		ProcedureReturn *this\defaultrowheight
	EndIf
EndProcedure

Procedure _MyTable_Table_SetHeaderHeight(*this.strMyTableTable,value.i)
	If *this
		*this\headerheight=value
		*this\calcheaderheight=DesktopScaledY(*this\headerheight)
		*this\dirty=#True
		ForEach *this\cols()
			*this\cols()\dirty=#True
			If IsImage(*this\cols()\image\sized)
				FreeImage(*this\cols()\image\sized)
			EndIf
			*this\cols()\image\sized=0
		Next
		_MyTable_Table_Predraw(*this)
		_MyTable_Table_Redraw(*this)
	EndIf
EndProcedure

Procedure _MyTable_Table_SetTitleHeight(*this.strMyTableTable,value.i)
	If *this
		*this\titleheight=value
		*this\calctitleheight=DesktopScaledY(*this\titleheight)
		*this\dirty=#True
		_MyTable_Table_Predraw(*this)
		_MyTable_Table_Redraw(*this)
	EndIf
EndProcedure

Procedure _MyTable_Table_SetDefaultRowHeight(*this.strMyTableTable,value.i)
	If *this
		Protected old.i=*this\defaultrowheight
		*this\defaultrowheight=value
		*this\calcdefaultrowheight=DesktopScaledY(*this\defaultrowheight)
		*this\dirty=#True
		ForEach *this\rows()
			*this\rows()\dirty=#True
			If IsImage(*this\rows()\image\sized)
				FreeImage(*this\rows()\image\sized)
			EndIf
			*this\rows()\image\sized=0
			If *this\rows()\height=old
				*this\rows()\height=value
				*this\rows()\calcheight=*this\calcdefaultrowheight
			EndIf
		Next
		_MyTable_Table_Predraw(*this)
		_MyTable_Table_Redraw(*this)
	EndIf
EndProcedure

Procedure _MyTable_Table_DeleteRow(*this.strMyTableTable,idx.i)
	If *this
		If ListSize(*this\rows())>idx
			_MyTable_Row_Delete(SelectElement(*this\rows(),idx))
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Table_DeleteCol(*this.strMyTableTable,idx.i)
	If *this
		If ListSize(*this\cols())>idx
			_MyTable_Col_Delete(SelectElement(*this\cols(),idx))
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Table_GetRow(*this.strMyTableTable,row.i)
	If *this
		If ListSize(*this\rows())>row			
			ProcedureReturn SelectElement(*this\rows(),row)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Table_GetCol(*this.strMyTableTable,col.i)
	If *this
		If ListSize(*this\cols())>col
			ProcedureReturn SelectElement(*this\cols(),col)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Table_GetApplication(*this.strMyTableTable)
	If *this		
		ProcedureReturn *this\application
	EndIf
EndProcedure

Procedure _MyTable_Table_GetCell(*this.strMyTableTable,row.i,col.i)
	If *this
		If ListSize(*this\cols())>col And ListSize(*this\rows())>row
			ProcedureReturn _MyTableGetOrAddCell(SelectElement(*this\rows(),row),col,#False)
		EndIf
	EndIf
EndProcedure

_MyTable_GetStylesTable()

Procedure _MyTable_Table_RowCount(*this.strMyTableTable)
	If *this
		ProcedureReturn ListSize(*this\rows())
	EndIf
EndProcedure

Procedure _MyTable_Table_VisibleRowCount(*this.strMyTableTable)
	If *this
		_MyTable_Table_Predraw(*this)
		ProcedureReturn ListSize(*this\expRows())
	EndIf
EndProcedure

Procedure _MyTable_Table_ColCount(*this.strMyTableTable)
	If *this
		ProcedureReturn ListSize(*this\cols())
	EndIf
EndProcedure

Procedure _MyTable_Table_ClearMaps(*this.strMyTableTable)
	If *this
		If *this\selectall
			ClearMap(*this\selectedcells())
			ClearMap(*this\selectedrows())
			ClearMap(*this\selectedcols())
			ClearMap(*this\tempselectedcells())
			ClearMap(*this\tempselectedrows())
			ClearMap(*this\tempselectedcols())
		Else
			ForEach *this\selectedcells()
				If Not *this\selectedcells()
					DeleteMapElement(*this\selectedcells())
				EndIf
			Next
			ForEach *this\selectedrows()
				If Not *this\selectedrows()
					DeleteMapElement(*this\selectedrows())
				EndIf
			Next
			ForEach *this\selectedcols()
				If Not *this\selectedcols()
					DeleteMapElement(*this\selectedcols())
				EndIf
			Next
			ForEach *this\tempselectedcells()
				If Not *this\tempselectedcells()
					DeleteMapElement(*this\tempselectedcells())
				EndIf
			Next
			ForEach *this\tempselectedrows()
				If Not *this\tempselectedrows()
					DeleteMapElement(*this\tempselectedrows())
				EndIf
			Next
			ForEach *this\tempselectedcols()
				If Not *this\tempselectedcols()
					DeleteMapElement(*this\tempselectedcols())
				EndIf
			Next
		EndIf
	EndIf
EndProcedure

Procedure.b _MyTable_Table_GetSelected(*this.strMyTableTable)
	If *this
		ProcedureReturn *this\selectall
	EndIf
EndProcedure

Procedure _MyTable_Table_SetSelected(*this.strMyTableTable,value.b)
	If *this
		*this\selectall=value
		*this\dirty=#True
		_MyTable_Table_Redraw(*this)
	EndIf
EndProcedure




Procedure _MyTable_Table_BindCallback(*this.strMyTableTable,callback.MyTableProtoCallback)
	If *this
		*this\callback=callback
	EndIf
EndProcedure

Procedure _MyTable_Table_GetSelectedRows(*this.strMyTableTable,List rows.i())
	If *this
		ClearList(rows())
		ForEach *this\selectedRows()
			If *this\selectedRows()
				AddElement(rows())
				rows()=Val(MapKey(*this\selectedRows()))
			EndIf			
		Next
		ProcedureReturn ListSize(rows())
	EndIf
EndProcedure

Procedure _MyTable_Table_GetSelectedCells(*this.strMyTableTable,List cells.i())
	If *this
		ClearList(cells())
		ForEach *this\selectedCells()
			If *this\selectedCells()
				AddElement(cells())
				cells()=Val(MapKey(*this\selectedCells()))
			EndIf
		Next
		ProcedureReturn ListSize(cells())
	EndIf
EndProcedure

Procedure _MyTable_Table_GetSelectedCols(*this.strMyTableTable,List cols.i())
	If *this
		ClearList(cols())
		ForEach *this\selectedCols()
			If *this\selectedCols()
				AddElement(cols())
				cols()=Val(MapKey(*this\selectedCols()))
			EndIf
		Next
		ProcedureReturn ListSize(cols())
	EndIf
EndProcedure

Procedure _MyTable_Table_ScrollToPos(*this.strMyTableTable,row.i,setSelect.b=#False)
	If *this		
		If ListSize(*this\expRows())>row
			SelectElement(*this\expRows(),row)
			_MyTable_Row_ScrollTo(*this\expRows(),setSelect)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Table_ScrollToCellPos(*this.strMyTableTable,row.i,col.i,setSelect.b=#False)
	If *this	
		Protected fullrow.b=_MyTable_IsFullrowselect(*this)
		If fullrow
			_MyTable_Table_ScrollToPos(*this,row,setSelect)
		Else
			_MyTable_Table_Predraw(*this,#True)
			If ListSize(*this\expRows())>row And ListSize(*this\cols())>col
				SelectElement(*this\expRows(),row)
				_MyTable_Cell_ScrollTo(_MyTableGetOrAddCell(*this\expRows(),col,#False),setSelect,#False)
				*this\dirty=#True
				_MyTable_Table_Redraw(*this)
			EndIf
		EndIf
	EndIf
EndProcedure



Procedure _MyTable_Table_AutosizeRows(*this.strMyTableTable)
	If *this
		_callcountStart()
		Protected thisdrawing.b=#False
		If Not *this\drawing
			If IsImage(*this\canvas)
				StartDrawing(ImageOutput(*this\canvas))
			EndIf
			If IsGadget(*this\canvas)
				StartDrawing(CanvasOutput(*this\canvas))
			EndIf
			*this\drawing=#True
			thisdrawing=#True
		EndIf
		
		ForEach *this\rows()
			_MyTable_Row_Autosize(*this\rows())
		Next
		
		If thisdrawing
			StopDrawing()
			*this\drawing=#False
		EndIf
		_callcountEnde()
		*this\dirty=#True
		_MyTable_Table_Predraw(*this)
		_MyTable_Table_Redraw(*this)
	EndIf
EndProcedure

Procedure _MyTable_Table_AutosizeCols(*this.strMyTableTable)
	If *this
		_callcountStart()
		Protected thisdrawing.b=#False
		If Not *this\drawing
			If IsImage(*this\canvas)
				StartDrawing(ImageOutput(*this\canvas))
			EndIf
			If IsGadget(*this\canvas)
				StartDrawing(CanvasOutput(*this\canvas))
			EndIf
			*this\drawing=#True
			thisdrawing=#True
		EndIf
		
		
		Protected lastfont.i=0
		
		
		ForEach *this\cols()
			_MyTable_Col_Autosize(*this\cols())
		Next
		
		If thisdrawing
			StopDrawing()
			*this\drawing=#False
		EndIf
		_callcountEnde()
		*this\dirty=#True
		_MyTable_Table_Predraw(*this)
		_MyTable_Table_Redraw(*this)
	EndIf
EndProcedure

Procedure _MyTable_Table_AutosizeHeader(*this.strMyTableTable)
	If *this
		_callcountStart()
		Protected thisdrawing.b=#False
		If Not *this\drawing
			If IsImage(*this\canvas)
				StartDrawing(ImageOutput(*this\canvas))
			EndIf
			If IsGadget(*this\canvas)
				StartDrawing(CanvasOutput(*this\canvas))
			EndIf
			*this\drawing=#True
			thisdrawing=#True
		EndIf
		
		Protected headerheight.i=*this\headerheight
		Protected calcheaderheight.i=*this\calcheaderheight
		Protected *lastfont.strMyTableFont=0
		
		ForEach *this\cols()
			If (*this\cols()\textheight=0 And *this\cols()\text<>"") Or *this\cols()\dirty
				Protected *nfont.strMyTableFont=_MyTable_GetDefaultFont(*this\cols())
				If *nfont<>*lastfont
					DrawingFont(*nfont\fontid)
					*lastfont=*nfont
				EndIf
				*this\cols()\textheight=_MyTableTextHeight(*this\cols()\text)
			EndIf
			If (*this\cols()\textheight+MyTableH4)>calcheaderheight
				calcheaderheight=*this\cols()\textheight+MyTableH4
			EndIf
		Next
		
		If calcheaderheight>*this\calcheaderheight
			*this\calcheaderheight=calcheaderheight+MyTableH4
		EndIf
		*this\headerheight=DesktopUnscaledY(*this\calcheaderheight)
		
		
		If thisdrawing
			StopDrawing()
			*this\drawing=#False
		EndIf
		_callcountEnde()
		*this\dirty=#True
		_MyTable_Table_Predraw(*this)
		_MyTable_Table_Redraw(*this)
	EndIf
EndProcedure

Procedure _MyTable_Table_Autosize(*this.strMyTableTable)
	If *this
		_callcountStart()
		Protected thisdrawing.b=#False
		If Not *this\drawing
			If IsImage(*this\canvas)
				StartDrawing(ImageOutput(*this\canvas))
			EndIf
			If IsGadget(*this\canvas)
				StartDrawing(CanvasOutput(*this\canvas))
			EndIf
			*this\drawing=#True
			thisdrawing=#True
		EndIf
		_MyTable_Table_AutosizeHeader(*this)
		_MyTable_Table_AutosizeCols(*this)
		_MyTable_Table_AutosizeRows(*this)		
		If thisdrawing
			StopDrawing()
			*this\drawing=#False
		EndIf
		_callcountEnde()
		*this\dirty=#True
		_MyTable_Table_Predraw(*this)
		_MyTable_Table_Redraw(*this)
		
	EndIf
EndProcedure

