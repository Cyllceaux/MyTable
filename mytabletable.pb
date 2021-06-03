;/ ===========================
;/ =   mytabletable.pb       =
;/ ===========================
;/
;/ [ PB V5.7x / 64Bit / all OS / DPI ]
;/
;/ © 2021 Cyllceaux (06/2021)
;/


;{ ===== MIT License =====
;
; Copyright (c) 2021 Silko Pillasch
;
; Permission is hereby granted, free of charge, to any person obtaining a copy
; of this software and associated documentation files (the "Software"), to deal
; in the Software without restriction, including without limitation the rights
; to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
; copies of the Software, and to permit persons to whom the Software is
; furnished to do so, subject to the following conditions:
; 
; The above copyright notice and this permission notice shall be included in all
; copies or substantial portions of the Software.
;
; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
; SOFTWARE.
;}


Procedure _MyTable_Table_GetCell(*this.strMyTableTable,row.i,col.i)
	If *this
		Protected *row.strMyTableRow=SelectElement(*this\rows(),row)
		ProcedureReturn _MyTableGetOrAddCell(*this\rows(),col)			
	EndIf
EndProcedure

Procedure _MyTable_Table_GetRow(*this.strMyTableTable,row.i)
	If *this
		ProcedureReturn SelectElement(*this\rows(),row)	
	EndIf
EndProcedure

Procedure _MyTable_Table_GetCol(*this.strMyTableTable,col.i)
	If *this
		ProcedureReturn SelectElement(*this\cols(),col)	
	EndIf
EndProcedure

Procedure _MyTable_Table_GetType(*this.strMyTableTable)
	ProcedureReturn *this\type
EndProcedure

Procedure _MyTable_Table_GetCanvas(*this.strMyTableTable)
	ProcedureReturn *this\canvas
EndProcedure

Procedure.s _MyTable_Table_GetTooltip(*this.strMyTableTable,row.i,col.i)
	If *this
		Protected *row.strMyTableRow=SelectElement(*this\rows(),row)
		Protected *cell.strMyTableCell=_MyTableGetOrAddCell(*this\rows(),col)		
		ProcedureReturn _MyTable_Cell_GetTooltip(*cell)
	EndIf
EndProcedure

Procedure _MyTable_Table_SetCellTooltip(*this.strMyTableTable,row.i,col.i,tooltip.s)		
	If *this
		Protected *row.strMyTableRow=SelectElement(*this\rows(),row)
		Protected *cell.strMyTableCell=_MyTableGetOrAddCell(*this\rows(),col)
		_MyTable_Cell_SetTooltip(*cell,Tooltip)
	EndIf
EndProcedure

Procedure _MyTable_Table_AutosizeCol(*this.strMyTableTable,col.i=#PB_Ignore)
	_MyTable_Table_AutosizeColExp(*this,col)
EndProcedure

Procedure _MyTable_Table_AutosizeColExp(*this.strMyTableTable,col.i=#PB_Ignore,force.b=#True)
	Protected *row.strMyTableRow=0
	
	Static NewMap all.b()
	
	If *this
		
		If col=#PB_Ignore
			_callcountStart(autosizecol)
			Protected c=ListSize(*this\cols())-1
			Protected i=0
			all(Str(*this.strMyTableTable))=#True
			StartDrawing(CanvasOutput(*this\canvas))
			_MyTable_Table_RecalcExp(*this,force)
			
			For i=0 To c
				_MyTable_Table_AutosizeCol(*this.strMyTableTable,i)
			Next
			
			StopDrawing()
			
			all(Str(*this.strMyTableTable))=#False
		Else
			_callcountStart(autosizecol)
			If all(Str(*this.strMyTableTable))=#False
				StartDrawing(CanvasOutput(*this\canvas))
				_MyTable_Table_RecalcExp(*this,force)
			EndIf
			DrawingFont(*this\font)
			
			
			Protected w=0
			
			Protected *col.strMyTableCol=SelectElement(*this\cols(),col)
			
			Protected font=*this\font
			
			
			If *col\textwidth=0
				w=_MyTableTextWidth(*col\text)
				*col\textwidth=w
				*col\dirty=#True
			Else
				w=*col\textwidth
			EndIf
			
			
			Protected hasimage.b=#False
			
			
			ForEach *this\expRows()
				*row=*this\expRows()
				If *row\image
					hasimage=#True
				EndIf
				
				
				
				
				Protected *cell.strMyTableCell=_MyTableGetOrAddCell(*row,col,force)
				
				
				If *cell
					If *cell\font
						If *cell\font<>font
							font=*cell\font
							DrawingFont(font)
						EndIf
					Else
						If *row\font
							If *row\font<>font
								font=*row\font
								DrawingFont(font)
							EndIf
						Else
							If *col\font
								If *col\font<>font
									font=*col\font
									DrawingFont(font)
								EndIf
							Else
								If *this\font<>font
									font=*this\font
									DrawingFont(font)
								EndIf
							EndIf
						EndIf
					EndIf
					
					If *cell\textwidth=0
						If Bool(*col\flags & #MYTABLE_COLUMN_FLAGS_BOOLEAN)
							*cell\textwidth=MyTableW20
						Else
							*cell\textwidth=_MyTableTextWidth(*cell\text)
						EndIf
					EndIf
					If *cell\textheight=0
						If Bool(*col\flags & #MYTABLE_COLUMN_FLAGS_BOOLEAN)
							*cell\textheight=MyTableW20
						Else
							*cell\textheight=_MyTableTextHeight(*cell\text)
						EndIf
					EndIf
					Protected dux=DesktopUnscaledX(*cell\textwidth)
					If dux>w
						w=dux
					EndIf
				EndIf
			Next
			*col\width=w+8
			*col\dirty=#True
			
			Protected sortable.b=Bool(Bool(*this\flags & #MYTABLE_TABLE_FLAGS_SORTABLE) Or Bool(*col\flags & #MYTABLE_COLUMN_FLAGS_SORTABLE))
			If col=0
				Protected hierarchical.b=Bool(Bool(*this\flags & #MYTABLE_TABLE_FLAGS_HIERARCHICAL) Or Bool(*this\flags & #MYTABLE_TABLE_FLAGS_HIERARCHICAL_ARROW))
				Protected checkboxes.b=Bool(*this\flags & #MYTABLE_TABLE_FLAGS_CHECKBOX)
				
				If hasimage
					*col\width+20				
				EndIf
				If hierarchical
					*col\width+20				
				EndIf
				If checkboxes
					*col\width+20				
				EndIf
			EndIf
			If sortable
				*col\width+20				
			EndIf
			
			
			*col\calcwidth=DesktopScaledX(*col\width)
			If all(Str(*this.strMyTableTable))=#False
				StopDrawing()
				
			EndIf
		EndIf
		If Not all(Str(*this.strMyTableTable))
			_callcountEnde(autosizecol)
			*this\dirty=#True
			_MyTable_Table_Redraw(*this)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Table_AutosizeHeader(*this.strMyTableTable,col.i=#PB_Ignore,force.b=#True)
	Protected *row.strMyTableRow=0
	
	Static NewMap all.b()
	
	If *this
		
		If col=#PB_Ignore
			_callcountStart(autosizeheader)
			Protected c=ListSize(*this\cols())-1
			Protected i=0
			*this\headerheight=0
			all(Str(*this.strMyTableTable))=#True
			StartDrawing(CanvasOutput(*this\canvas))
			_MyTable_Table_RecalcExp(*this,force)
			For i=0 To c
				_MyTable_Table_AutosizeHeader(*this.strMyTableTable,i)
			Next
			StopDrawing()
			
			all(Str(*this.strMyTableTable))=#False
		Else
			_callcountStart(autosizecol)
			If all(Str(*this.strMyTableTable))=#False
				StartDrawing(CanvasOutput(*this\canvas))		
				_MyTable_Table_RecalcExp(*this,force)
			EndIf
			DrawingFont(*this\font)
			
			
			
			Protected *col.strMyTableCol=SelectElement(*this\cols(),col)
			If *col\font
				DrawingFont(*col\font)
			EndIf
			
			*col\textwidth=_MyTableTextWidth(*col\text)		
			*col\calcwidth=DesktopScaledX(*col\textwidth)
			
			*col\dirty=#True
			
			*col\textheight=_MyTableTextHeight(*col\text)+2			
			*col\calcheight=DesktopScaledY(*col\textheight)
			
			
			
			If *this\headerheight=<(*col\textheight)
				*this\headerheight=*col\textheight
			EndIf
			If all(Str(*this.strMyTableTable))=#False
				StopDrawing()
				
			EndIf
		EndIf
		If Not all(Str(*this.strMyTableTable))
			_callcountEnde(autosizeheader)
			*this\dirty=#True
			_MyTable_Table_Recalc(*this)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Table_AutosizeRow(*this.strMyTableTable,row.i=#PB_Ignore)
	Static NewMap all.b()
	
	If *this
		
		If row=#PB_Ignore
			_callcountStart(autosizerow)
			Protected c=ListSize(*this\rows())-1
			Protected i=0
			all(Str(*this.strMyTableTable))=#True
			For i=0 To c
				_MyTable_Table_AutosizeRow(*this.strMyTableTable,i)
			Next
			all(Str(*this.strMyTableTable))=#False
		Else
			
			Protected *row.strMyTableRow=SelectElement(*this\rows(),row)
			
			*row\dirty=#True
			*row\height=0
			ForEach *row\cells()
				If DesktopUnscaledY(*row\cells()\textheight)>*row\height
					*row\height=DesktopUnscaledY(*row\cells()\textheight)
				EndIf
			Next
			*row\height+4
			*row\calcheight=DesktopScaledY(*row\height)
			
			
		EndIf
		If Not all(Str(*this.strMyTableTable))
			_callcountEnde(autosizerow)
			*this\dirty=#True
			_MyTable_Table_Recalc(*this)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Table_Recalc(*this.strMyTableTable)		
	If *this
		If Not *this\batch
			*this\dirty=#True
			CompilerIf Defined(MYTABLE_FORMULA,#PB_Module)
				If *this\recalc
					_MyTableFormulaCalcTable(*this)
				EndIf
			CompilerEndIf
			_MyTable_Table_RecalcExp(*this)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Table_AddDirtyRows(*this.strMyTableTable,rows.i)
	If *this
		_callcountStart(addtabledirtyrows)
		Protected i=0
		Protected *row.strMyTableRow=0
		
		LastElement(*this\rows())
		For i=1 To rows
			*row=AddElement(*this\rows())
			*row\listindex=ListIndex(*this\rows())
			_MyTableAddDirtyRow(*this,*row)				
		Next
		
		*this\dirty=#True
		_callcountEnde(addtabledirtyrows)
		_MyTable_Table_Recalc(*this)
	EndIf	
EndProcedure



Procedure _MyTable_Table_AddRow(*this.strMyTableTable,text.s,sep.s="|",id.q=#PB_Ignore,image.i=0,*data=0,checked.b=#False,expanded.b=#False,tooltip.s="")
	If *this
		Protected *row.strMyTableRow=0
		Protected *cell.strMyTableCell=0
		Protected *col.strMyTableCol=0
		
		
		LastElement(*this\rows())
		*row=AddElement(*this\rows())
		
		With *row
			*row\listindex=ListIndex(*this\rows())
			\vtable=?vtable_row
			\height=*this\rowheight
			\brow=#True
			\checked=checked
			\expanded=expanded
			\data=*data
			\image=image
			\type=#MYTABLE_TYPE_ROW
			\tooltip=tooltip
			If IsImage(image)				
				\sclaedimage=CopyImage(image,#PB_Any)
				ResizeImage(\sclaedimage,MyTableW16,MyTableH16)
			EndIf
			If id=#PB_Ignore Or id<=*this\lastRowid
				*this\lastRowid+1
				\id=*this\lastRowid
			Else
				\id=id
				*this\lastRowid=id
			EndIf
			\dirty=#True
			\table=*this
			
			
			Protected i=0
			
			If text<>""
				Protected c=CountString(text,sep)+1
				If c=1
					*cell=_MyTableGetOrAddCell(*row,0)
					_MyTableFillCellText(*cell,text)
				Else
					For i=1 To c
						*cell=_MyTableGetOrAddCell(*row,i-1)
						_MyTableFillCellText(*cell,StringField(text,i,sep))
					Next
				EndIf
			EndIf
		EndWith
		*this\rowsById(Str(*row\id))=*row
		*this\dirty=#True
		_MyTable_Table_Recalc(*this)
		ProcedureReturn *row
	EndIf
EndProcedure

Procedure _MyTable_Table_AddColumn(*this.strMyTableTable,text.s,width.i,flags.i=#MYTABLE_COLUMN_FLAGS_DEFAULT,image.i=0,*data=0,sort.i=0,tooltip.s="")
	If *this
		_callcountStart(addcol)
		LastElement(*this\cols())
		Protected *col.strMyTableCol=AddElement(*this\cols())
		With *col
			\vtable=?vtable_col
			\text=text
			\width=width
			\flags=flags
			\image=image
			\data=*data
			\sort=sort
			\dirty=#True
			\tooltip=tooltip
			\type=#MYTABLE_TYPE_COL
			\listindex=ListIndex(*this\cols())
			If Bool(flags & #MYTABLE_COLUMN_FLAGS_DATE)
				\format="%dd.%mm.%yyyy"
			EndIf
			If Bool(flags & #MYTABLE_COLUMN_FLAGS_DATE_TIME)
				\format="%dd.%mm.%yyyy %hh:%ii:%ss"
			EndIf
			If Bool(flags & #MYTABLE_COLUMN_FLAGS_TIME)
				\format="%hh:%ii"
			EndIf
			If Bool(flags & #MYTABLE_COLUMN_FLAGS_TIME_LONG)
				\format="%hh:%ii:%ss"
			EndIf
			\table=*this
			*this\lastColid+1
			\id=*this\lastColid
			CompilerIf Defined(MYTABLE_GRID,#PB_Module)
				If *this\datagrid And text=""
					\text=_MyTableGridColumnName(ListSize(*this\cols()))
				EndIf
			CompilerEndIf
		EndWith
		*this\colsById(Str(*col\id))=*col
		*this\dirty=#True
		_callcountEnde(addcol)
		_MyTable_Table_Recalc(*this)			
		ProcedureReturn *col
	EndIf
	
EndProcedure

Procedure _MyTable_Table_ClearRows(*this.strMyTableTable)
	If *this
		ClearList(*this\rows())
		ClearMap(*this\rowsById())
		*this\dirty=#True
		*this\lastRowid=0
		_MyTable_Table_Recalc(*this)
	EndIf
EndProcedure

Procedure _MyTable_Table_ClearCols(*this.strMyTableTable)
	If *this
		ClearList(*this\cols())
		ClearMap(*this\colsById())
		*this\dirty=#True
		*this\lastColid=0
		ForEach *this\rows()
			ClearList(*this\rows()\cells())
			*this\rows()\dirty=#True
		Next
		_MyTable_Table_Recalc(*this)
	EndIf
EndProcedure

Procedure _MyTable_Table_DeleteCol(*this.strMyTableTable,col.i)
	If *this
		_MyTable_Col_Delete(SelectElement(*this\cols(),col))
	EndIf
EndProcedure

Procedure _MyTable_Table_DeleteRow(*this.strMyTableTable,row.i)
	If *this
		_MyTable_Col_Delete(SelectElement(*this\rows(),row))
	EndIf
EndProcedure

Procedure _MyTable_Table_RecalcExp(*this.strMyTableTable,force.b=#False)
	If *this
		If Not *this\batch
			If (*this\dirty And *this\redraw) Or force
				_MyTableClearMaps(*this)
				_callcountStart(recalc)
				With *this
					Protected laststretch.b=Bool(\flags & #MYTABLE_TABLE_FLAGS_LAST_STRETCH)
					Protected allrowcount.b=Bool(\flags & #MYTABLE_TABLE_FLAGS_ALL_ROW_COUNT)
					Protected noheader.b=Bool(\flags & #MYTABLE_TABLE_FLAGS_NO_HEADER)
					Protected callback.b=Bool(\flags & #MYTABLE_TABLE_FLAGS_CALLBACK)
					Protected hierarchical.b=Bool(Bool(*this\flags & #MYTABLE_TABLE_FLAGS_HIERARCHICAL) Or Bool(*this\flags & #MYTABLE_TABLE_FLAGS_HIERARCHICAL_ARROW))
					
					Protected *lastCol.strMyTableCol=0
					Protected w=0
					Protected idx=0
					ForEach \cols()
						Protected *col.strMyTableCol=\cols()
						*lastCol=*col
						If *col\dirty
							*col\calcheight=DesktopScaledY(\headerheight)
							*col\calcwidth=DesktopScaledX(*col\width)
							*col\dirty=#False						
						EndIf
						w+*col\calcwidth					
					Next			
					
					ClearList(*this\expRows())
					*this\expheight=0
					
					ForEach \rows()
						Protected *row.strMyTableRow=\rows()
						AddElement(*this\expRows()):*this\expRows()=*row		
						If *row\dirty
							*row\calcheight=DesktopScaledY(*row\height)
							*row\calcwidth=w
							If Not callback
								*row\dirty=#False
							EndIf
						EndIf
						If *row\expanded And hierarchical
							_MyTableRecalcExp(*row,w)
						EndIf
						*this\expheight+*row\calcheight
					Next
					
					If w>\lastw
						SetGadgetAttribute(\hscroll,#PB_ScrollBar_Maximum,w-\lastw)				
					EndIf
					\bhs=Bool(w>\lastw)
					HideGadget(\hscroll,Bool(w<=\lastw))	
					If Not \bhs
						SetGadgetState(\hscroll,0)
					EndIf
					
					Protected h=ListSize(\expRows())
					If Not allrowcount					
						If \bhs
							h-(GadgetHeight(\canvas)-GadgetHeight(\hscroll))/\rowheight
						Else
							h-GadgetHeight(\canvas)/\rowheight
						EndIf
					EndIf
					
					If Not noheader
						h+1
					EndIf
					
					
					\bvs=Bool(h>0)
					HideGadget(\vscroll,Bool(h<=0))	
					SetGadgetAttribute(\vscroll,#PB_ScrollBar_Maximum,h)
					
					
					If laststretch And *col 
						*col\calcheight=DesktopScaledY(\headerheight)
						*col\calcwidth=DesktopScaledX(GadgetWidth(\canvas))
						If \bvs
							*col\calcwidth-DesktopScaledX(GadgetWidth(\vscroll))	
						EndIf
						*col\dirty=#True
					EndIf
					
					
				EndWith
				_callcountEnde(recalc)
				_MyTable_Table_Redraw(*this)
			EndIf
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Table_Redraw(*this.strMyTableTable)
	If *this
		If Not *this\batch
			With *this
				Protected redraw.b=Bool(\redraw And \dirty And Not \drawing)
				If *this\application
					redraw=Bool(redraw And *this\application\redraw)
				EndIf
				If redraw
					\drawing=#True
					_MyTableClearMaps(*this)
					_callcountStart(redraw)
					
					Protected grid.b=Bool(\flags & #MYTABLE_TABLE_FLAGS_GRID)
					Protected hierarchical.b=Bool(Bool(*this\flags & #MYTABLE_TABLE_FLAGS_HIERARCHICAL) Or Bool(*this\flags & #MYTABLE_TABLE_FLAGS_HIERARCHICAL_ARROW))
					Protected checkboxes.b=Bool(\flags & #MYTABLE_TABLE_FLAGS_CHECKBOX)
					Protected laststretch.b=Bool(\flags & #MYTABLE_TABLE_FLAGS_LAST_STRETCH)
					Protected noheader.b=Bool(\flags & #MYTABLE_TABLE_FLAGS_NO_HEADER)
					Protected fullrowselect.b=Bool(\flags & #MYTABLE_TABLE_FLAGS_FULL_ROW_SELECT Or ListSize(*this\cols())=1)
					Protected idx=0
					
					Protected w=GadgetWidth(\canvas)
					Protected h=GadgetHeight(\canvas)
					
					Protected *row.strMyTableRow=0
					
					If \bhs
						h-GadgetHeight(\hscroll)
					EndIf
					
					If \bvs
						w-GadgetWidth(\vscroll)
					EndIf
					
					w=DesktopScaledX(w)
					h=DesktopScaledY(h)
					
					
					
					StartDrawing(CanvasOutput(\canvas))
					DrawingMode(#PB_2DDrawing_AlphaClip)
					DrawingFont(\font)
					
					Box(0,0,OutputWidth(),OutputHeight(),\background)
					
					Protected bx=-GetGadgetState(\hscroll)
					Protected by=0
					
					Protected firstcol.b=#True
					
					If Not noheader
						ForEach \cols()
							Protected *col.strMyTableCol=\cols()
							
							bx+_MyTableDrawHeader(*col,bx,#False)
							firstcol=#False
							If bx>=w
								Break
							EndIf
						Next
						
						If *this\fixedcolumns>0
							bx=0
							firstcol=#True
							For idx=1 To *this\fixedcolumns
								*col=SelectElement(\cols(),idx-1)
								bx+_MyTableDrawHeader(*col,bx,#True)
								firstcol=#False
							Next
						EndIf
						
						by=DesktopScaledY(\headerheight)
					EndIf
					
					
					Protected c=ListSize(\expRows())-1
					Protected i=0
					
					For i=GetGadgetState(\vscroll) To c
						SelectElement(\expRows(),i)				
						*row=\expRows()
						bx=-GetGadgetState(\hscroll)
						by+_MyTableDrawRow(*row,w,bx,by,#False,fullrowselect,grid,hierarchical,checkboxes)
						If by>=h
							Break
						EndIf
					Next
					
					If *this\fixedcolumns>0
						by=DesktopScaledY(\headerheight)
						For i=GetGadgetState(\vscroll) To c
							SelectElement(\expRows(),i)				
							*row=\expRows()
							by+_MyTableDrawRow(*row,w,0,by,#True,fullrowselect,grid,hierarchical,checkboxes)
							If by>=h
								Break
							EndIf
						Next
					EndIf
					
					
					
					StopDrawing()
					\drawing=#False
					_callcountEnde(redraw)
					\dirty=#False
				EndIf			
			EndWith
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Table_UnRegister(*this.strMyTableTable)		
	If *this
		With *this
			UnbindGadgetEvent(\canvas,@MyTableEvtResize(),#PB_EventType_Resize)
			UnbindGadgetEvent(\hscroll,@MyTableEvtScroll())
			UnbindGadgetEvent(\vscroll,@MyTableEvtScroll())
			
			UnbindGadgetEvent(\canvas,@MyTableEvtMouseDown(),#PB_EventType_MouseWheel)
			UnbindGadgetEvent(\canvas,@MyTableEvtMouseDown(),#PB_EventType_LeftClick)
			UnbindGadgetEvent(\canvas,@MyTableEvtDouble(),#PB_EventType_LeftDoubleClick)
			UnbindGadgetEvent(\canvas,@MyTableEvtKeyDown(),#PB_EventType_KeyDown)
		EndWith
		If IsGadget(*this\editorgadget)
			FreeGadget(*this\editorgadget)
		EndIf
		If IsWindow(*this\editorwindow)
			CloseWindow(*this\editorwindow)
		EndIf
	EndIf
	If *this\application
		ForEach *this\application\tables()
			If *this\application\tables()=*this
				DeleteElement(*this\application\tables())
				Break
			EndIf
		Next
	Else
		FreeStructure(*this)
	EndIf
EndProcedure


Procedure _MyTable_Table_SetCellValue(*this.strMyTableTable,row.i,col.i,value.d)
	If *this
		Protected *row.strMyTableRow=SelectElement(*this\rows(),row)
		Protected *cell.strMyTableCell=_MyTableGetOrAddCell(*this\rows(),col)
		_MyTable_Cell_SetValue(*cell,Value)
	EndIf
EndProcedure

Procedure.d _MyTable_Table_GetCellValue(*this.strMyTableTable,row.i,col.i)
	If *this
		Protected *row.strMyTableRow=SelectElement(*this\rows(),row)
		Protected *cell.strMyTableCell=_MyTableGetOrAddCell(*this\rows(),col)
		ProcedureReturn _MyTable_Cell_GetValue(*cell)
	EndIf
EndProcedure

Procedure _MyTable_Table_GetCellImage(*this.strMyTableTable,row.i,col.i)
	If *this
		Protected *row.strMyTableRow=SelectElement(*this\rows(),row)
		Protected *cell.strMyTableCell=_MyTableGetOrAddCell(*this\rows(),col)
		ProcedureReturn _MyTable_Cell_GetImage(*cell)
	EndIf
EndProcedure

Procedure _MyTable_Table_SetCellText(*this.strMyTableTable,row.i,col.i,text.s)
	If *this
		Protected *row.strMyTableRow=SelectElement(*this\rows(),row)
		Protected *cell.strMyTableCell=_MyTableGetOrAddCell(*this\rows(),col)
		_MyTable_Cell_SetText(*cell,text)
	EndIf
EndProcedure

Procedure _MyTable_Table_SetCellBorder(*this.strMyTableTable,row.i,col.i,border.i=#MYTABLE_BORDER_DEFAULT,width.i=#PB_Ignore,color.q=#PB_Ignore)
	If *this
		Protected *row.strMyTableRow=SelectElement(*this\rows(),row)
		Protected *cell.strMyTableCell=_MyTableGetOrAddCell(*this\rows(),col)
		_MyTable_Cell_SetBorder(*cell,border,width,color)
	EndIf
EndProcedure

Procedure _MyTable_Table_SetCellBorderStyle(*this.strMyTableTable,row.i,col.i,border.i=#MYTABLE_BORDER_DEFAULT,width.i=#PB_Ignore,color.q=#PB_Ignore)
	If *this
		Protected *row.strMyTableRow=SelectElement(*this\rows(),row)
		Protected *cell.strMyTableCell=_MyTableGetOrAddCell(*this\rows(),col)
		_MyTable_Cell_SetBorderStyle(*cell,border,width,color)
	EndIf
EndProcedure

Procedure _MyTable_Table_SetCellImage(*this.strMyTableTable,row.i,col.i,image.i)
	If *this
		Protected *row.strMyTableRow=SelectElement(*this\rows(),row)
		Protected *cell.strMyTableCell=_MyTableGetOrAddCell(*this\rows(),col)
		_MyTable_Cell_SetImage(*cell,image)
	EndIf
EndProcedure

Procedure.s _MyTable_Table_GetCellText(*this.strMyTableTable,row.i,col.i)
	If *this
		Protected *row.strMyTableRow=SelectElement(*this\rows(),row)
		Protected *cell.strMyTableCell=_MyTableGetOrAddCell(*this\rows(),col)
		ProcedureReturn _MyTable_Cell_GetText(*cell)
	EndIf
EndProcedure

Procedure.s _MyTable_Table_GetCellTooltip(*this.strMyTableTable,row.i,col.i)
	If *this
		Protected *row.strMyTableRow=SelectElement(*this\rows(),row)
		Protected *cell.strMyTableCell=_MyTableGetOrAddCell(*this\rows(),col)
		ProcedureReturn _MyTable_Cell_GetText(*cell)
	EndIf
EndProcedure

Procedure _MyTable_Table_SetEventCellSelected(*this.strMyTableTable,event.MyTableProtoEventCellSelected)		
	If *this
		*this\evtCellSelect=event
	EndIf
EndProcedure


Procedure _MyTable_Table_SetEventRowSelected(*this.strMyTableTable,event.MyTableProtoEventRowSelected)
	
	If *this
		*this\evtRowSelect=event
	EndIf
EndProcedure



Procedure _MyTable_Table_SetEventRowChecked(*this.strMyTableTable,event.MyTableProtoEventRowChecked)
	
	If *this
		*this\evtRowChecked=event
	EndIf
EndProcedure

Procedure _MyTable_Table_SetEventRowRightClick(*this.strMyTableTable,event.MyTableProtoEventRowRightClick)
	
	If *this
		*this\evtRowRightClick=event
	EndIf
EndProcedure

Procedure _MyTable_Table_SetEventColRightClick(*this.strMyTableTable,event.MyTableProtoEventColRightClick)
	
	If *this
		*this\evtColRightClick=event
	EndIf
EndProcedure

Procedure _MyTable_Table_SetEventCellChecked(*this.strMyTableTable,event.MyTableProtoEventCellChecked)
	
	If *this
		*this\evtCellChecked=event
	EndIf
EndProcedure

Procedure _MyTable_Table_SetEventCellRightClick(*this.strMyTableTable,event.MyTableProtoEventCellRightClick)
	
	If *this
		*this\evtCellRightClick=event
	EndIf
EndProcedure

Procedure _MyTable_Table_SetEventCellChangedText(*this.strMyTableTable,event.MyTableProtoEventCellChangedText)
	
	If *this
		*this\evtCellChangedText=event
	EndIf
EndProcedure

Procedure _MyTable_Table_SetEventCellChangedValue(*this.strMyTableTable,event.MyTableProtoEventCellChangedValue)
	
	If *this
		*this\evtCellChangedValue=event
	EndIf
EndProcedure

Procedure _MyTable_Table_SetEventCallback(*this.strMyTableTable,event.MyTableProtoEventCallback)
	
	If *this
		*this\evtCallback=event
	EndIf
EndProcedure

Procedure _MyTable_Table_GetRowCount(*this.strMyTableTable)
	
	If *this
		ProcedureReturn ListSize(*this\expRows())
	EndIf
EndProcedure

Procedure _MyTable_Table_GetFlags(*this.strMyTableTable)
	
	If *this
		ProcedureReturn *this\flags
	EndIf
EndProcedure

Procedure _MyTable_Table_GetApplication(*this.strMyTableTable)
	
	If *this
		ProcedureReturn *this\application
	EndIf
EndProcedure

Procedure _MyTable_Table_GetDefaultRowHeight(*this.strMyTableTable)
	
	If *this
		ProcedureReturn *this\rowheight
	EndIf
EndProcedure

Procedure _MyTable_Table_GetData(*this.strMyTableTable)
	
	If *this
		ProcedureReturn *this\data
	EndIf
EndProcedure


Procedure _MyTable_Table_GetColCount(*this.strMyTableTable)
	
	If *this
		ProcedureReturn ListSize(*this\cols())
	EndIf
EndProcedure

Procedure.s _MyTable_Table_GetName(*this.strMyTableTable)
	
	If *this
		ProcedureReturn *this\name
	EndIf
EndProcedure

Procedure _MyTable_Table_GetFixedColumns(*this.strMyTableTable)
	
	If *this
		ProcedureReturn *this\fixedcolumns
	EndIf
EndProcedure


Procedure _MyTable_Table_SetRedraw(*this.strMyTableTable,redraw.b)
	
	If *this
		*this\redraw=redraw
		*this\dirty=#True
		_MyTable_Table_Recalc(*this)
	EndIf
EndProcedure

CompilerIf Defined(MYTABLE_FORMULA,#PB_Module)
	Procedure _MyTable_Table_SetRecalc(*this.strMyTableTable,recalc.b)
		
		If *this
			*this\recalc=recalc
			*this\dirty=#True
			_MyTable_Table_Recalc(*this)
		EndIf
	EndProcedure
CompilerEndIf

Procedure _MyTable_Table_SetFlags(*this.strMyTableTable,flags.i)
	
	If *this
		If *this\flags<>flags And Not *this\datagrid
			*this\flags=flags
			*this\dirty=#True
			_MyTable_Table_Recalc(*this)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Table_SetName(*this.strMyTableTable,name.s)
	
	If *this
		If *this\name<>name
			*this\name=name
		EndIf
	EndIf
EndProcedure


Procedure _MyTable_Table_SetDefaultRowHeight(*this.strMyTableTable,rowheight.i)
	
	If *this
		Protected old=*this\rowheight
		If *this\rowheight<>rowheight
			*this\rowheight=rowheight
			*this\dirty=#True
			ForEach *this\rows()
				*this\rows()\dirty=#True
				If *this\rows()\height<=old
					*this\rows()\height=rowheight
				EndIf
			Next
			_MyTable_Table_Recalc(*this)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Table_SetRowHeight(*this.strMyTableTable,row.i,rowheight.i)
	
	If *this
		_MyTable_Row_SetRowHeight(SelectElement(*this\rows(),row),rowheight)
	EndIf
EndProcedure

Procedure _MyTable_Table_GetRowHeight(*this.strMyTableTable,row.i)
	
	If *this
		ProcedureReturn _MyTable_Row_GetRowHeight(SelectElement(*this\rows(),row))
	EndIf
EndProcedure

Procedure _MyTable_Table_SetData(*this.strMyTableTable,*data)
	
	If *this
		*this\data=*data
	EndIf
EndProcedure

Procedure _MyTable_Table_SetFixedColumns(*this.strMyTableTable,columns.i)
	
	If *this
		*this\fixedcolumns=columns
	EndIf
EndProcedure

Procedure _MyTable_Table_SetCustomCellEdit(*this.strMyTableTable,col.i,evtCustomEditCell.MyTableProtoEventCustomEditCell,evtCancelCustomEditCell.MyTableProtoEventCancelCustomEditCell)
	If *this
		Protected *col.strMyTableCol=SelectElement(*this\cols(),col)
		*col\evtCustomEditCell=evtCustomEditCell
		*col\evtCancelCustomEditCell=evtCancelCustomEditCell
		
	EndIf
EndProcedure

Procedure _MyTable_Table_SetSelectedbackground(*this.strMyTableTable,color.q)
	
	If *this
		If *this\selectedbackground<>color
			*this\selectedbackground=color
			*this\dirty=#True
			_MyTable_Table_Redraw(*this)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Table_SetBackground(*this.strMyTableTable,color.q)
	
	If *this
		If *this\background<>color
			*this\background=color
			*this\dirty=#True
			_MyTable_Table_Redraw(*this)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Table_SetBackgroundFixed(*this.strMyTableTable,color.q)
	
	If *this
		If *this\backgroundfixed<>color
			*this\backgroundfixed=color
			*this\dirty=#True
			_MyTable_Table_Redraw(*this)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Table_SetHeaderBackgroundMarked(*this.strMyTableTable,color.q)
	
	If *this
		If *this\headerbackgroundmarked<>color
			*this\headerbackgroundmarked=color
			*this\dirty=#True
			_MyTable_Table_Redraw(*this)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Table_SetHeaderbackground1(*this.strMyTableTable,color.q)
	
	If *this
		If *this\headerbackground1<>color
			*this\headerbackground1=color
			*this\dirty=#True
			_MyTable_Table_Redraw(*this)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Table_SetHeaderbackground2(*this.strMyTableTable,color.q)
	
	If *this
		If *this\headerbackground2<>color
			*this\headerbackground2=color
			*this\dirty=#True
			_MyTable_Table_Redraw(*this)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Table_SetHeaderbackgroundFixed(*this.strMyTableTable,color.q)
	
	If *this
		If *this\headerbackgroundfixed<>color
			*this\headerbackgroundfixed=color
			*this\dirty=#True
			_MyTable_Table_Redraw(*this)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Table_SetForecolor(*this.strMyTableTable,color.q)
	
	If *this
		If *this\forecolor<>color
			*this\forecolor=color
			*this\dirty=#True
			_MyTable_Table_Redraw(*this)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Table_SetHeaderforecolor(*this.strMyTableTable,color.q)
	
	If *this
		If *this\headerforecolor<>color
			*this\headerforecolor=color
			*this\dirty=#True
			_MyTable_Table_Redraw(*this)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Table_SetSelectedforecolor(*this.strMyTableTable,color.q)
	
	If *this
		If *this\selectedforecolor<>color
			*this\selectedforecolor=color
			*this\dirty=#True
			_MyTable_Table_Redraw(*this)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Table_SetFont(*this.strMyTableTable,font.i)
	
	If *this
		If *this\font<>font
			*this\font=font
			*this\dirty=#True
			ForEach *this\cols()
				*this\cols()\dirty=#True
				*this\cols()\textheight=0
				*this\cols()\textwidth=0
			Next
			ForEach *this\rows()
				ForEach *this\rows()\cells()
					*this\rows()\cells()\dirty=#True
					*this\rows()\cells()\textheight=0
					*this\rows()\cells()\textwidth=0
				Next
			Next
			_MyTable_Table_Recalc(*this)
		EndIf
	EndIf
EndProcedure

Procedure.q _MyTable_Table_GetSelectedbackground(*this.strMyTableTable)
	
	If *this
		ProcedureReturn *this\selectedbackground
	EndIf
EndProcedure

Procedure.q _MyTable_Table_GetBackground(*this.strMyTableTable)
	
	If *this
		ProcedureReturn *this\background
	EndIf
EndProcedure

Procedure.q _MyTable_Table_GetBackgroundFixed(*this.strMyTableTable)
	
	If *this
		ProcedureReturn *this\backgroundfixed
	EndIf
EndProcedure

Procedure.q _MyTable_Table_GetHeaderbackground1(*this.strMyTableTable)
	
	If *this
		ProcedureReturn *this\headerbackground1
	EndIf
EndProcedure

Procedure.q _MyTable_Table_GetHeaderbackground2(*this.strMyTableTable)
	
	If *this
		ProcedureReturn *this\headerbackground2
	EndIf
EndProcedure

Procedure.q _MyTable_Table_GetHeaderbackgroundFixed(*this.strMyTableTable)
	
	If *this
		ProcedureReturn *this\headerbackgroundfixed
	EndIf
EndProcedure

Procedure.q _MyTable_Table_GetHeaderbackgroundMarked(*this.strMyTableTable)
	
	If *this
		ProcedureReturn *this\headerbackgroundmarked
	EndIf
EndProcedure

Procedure.q _MyTable_Table_GetForecolor(*this.strMyTableTable)
	
	If *this
		ProcedureReturn *this\forecolor
	EndIf
EndProcedure

Procedure.q _MyTable_Table_GetHeaderforecolor(*this.strMyTableTable)
	
	If *this
		ProcedureReturn *this\headerforecolor
	EndIf
EndProcedure

Procedure.q _MyTable_Table_GetSelectedforecolor(*this.strMyTableTable)
	
	If *this
		ProcedureReturn *this\selectedforecolor
	EndIf
EndProcedure

Procedure _MyTable_Table_GetFont(*this.strMyTableTable)
	
	If *this
		ProcedureReturn *this\font
	EndIf
EndProcedure

Procedure _MyTable_Table_Dirty(*this.strMyTableTable)
	*this\dirty=#True
EndProcedure
