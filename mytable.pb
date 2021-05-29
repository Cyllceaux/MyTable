;/ ===========================
;/ =   mytable.pb            =
;/ ===========================
;/
;/ [ PB V5.7x / 64Bit / all OS / DPI ]
;/
;/ © 2021 Cyllceaux (05/2021)
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


Module MyTable
	
	EnableExplicit
	
	Macro MM
		"
	EndMacro
	
	
	Macro _callcountStart(sname)
		CompilerIf #PB_Compiler_Debugger And Defined(MYTABLE_DEBUG,#PB_Module)
			Static NewMap callcount.i()
			Static NewMap callms.i()
			Static NewMap callmssum.i()					
			callms(MM#sname#MM+"_"+Str(_MyTableDebugGetCanvas(*this)))=ElapsedMilliseconds()		
			
		CompilerEndIf
	EndMacro
	
	Macro _callcountEnde(sname)
		CompilerIf #PB_Compiler_Debugger And Defined(MYTABLE_DEBUG,#PB_Module)
			Protected _#sname#ms=ElapsedMilliseconds()-callms(MM#sname#MM+"_"+Str(_MyTableDebugGetCanvas(*this)))
			callcount(MM#sname#MM+"_"+Str(_MyTableDebugGetCanvas(*this)))+1
			callmssum(MM#sname#MM+"_"+Str(_MyTableDebugGetCanvas(*this)))+_#sname#ms
			
			Protected tname.s=""
			If _MyTableDebugGetName(*this)=""
				tname=Str(_MyTableDebugGetCanvas(*this))
			Else
				tname=_MyTableDebugGetName(*this)
			EndIf
			
			Protected debugline.s=LSet(tname+":",16," ")
			debugline + LSet(MM#sname#MM+": "+callcount(MM#sname#MM+"_"+Str(_MyTableDebugGetCanvas(*this))),20," ")
			
			
			If _#sname#ms>MYTABLE_DEBUG_MS_MAX::#MYTABLE_DEBUG_MS_MAX
				DebuggerWarning(MM#sname#MM+" für "+tname+" > "+Str(MYTABLE_DEBUG_MS_MAX::#MYTABLE_DEBUG_MS_MAX)+"ms ( "+Str(_#sname#ms)+" )")
			EndIf
			debugline + Str(_#sname#ms)+"ms / "+Str(callmssum(MM#sname#MM+"_"+Str(_MyTableDebugGetCanvas(*this))))+"ms / " +Str(callmssum(MM#sname#MM+"_"+Str(_MyTableDebugGetCanvas(*this)))/callcount(MM#sname#MM+"_"+Str(_MyTableDebugGetCanvas(*this))))+ "ms"
			Debug debugline,MYTABLE_DEBUG_LEVEL::#MYTABLE_DEBUG_LEVEL
		CompilerEndIf
	EndMacro
	
	
	
	Global MyTableW1=DesktopScaledX(1)
	Global MyTableW2=DesktopScaledX(2)
	Global MyTableW4=DesktopScaledX(4)
	Global MyTableW7=DesktopScaledX(7)
	Global MyTableW8=DesktopScaledX(8)
	Global MyTableW10=DesktopScaledX(10)
	Global MyTableW12=DesktopScaledX(12)
	Global MyTableW14=DesktopScaledX(14)
	Global MyTableW16=DesktopScaledX(16)
	Global MyTableW20=DesktopScaledX(20)
	Global MyTableH2=DesktopScaledY(2)
	Global MyTableH4=DesktopScaledY(4)
	Global MyTableH6=DesktopScaledY(6)
	Global MyTableH7=DesktopScaledY(7)
	Global MyTableH8=DesktopScaledY(8)
	Global MyTableH10=DesktopScaledY(10)
	Global MyTableH12=DesktopScaledY(12)
	Global MyTableH14=DesktopScaledY(14)
	Global MyTableH16=DesktopScaledY(16)
	
	Global MyTableDefaultImageSortAsc=CreateImage(#PB_Any,MyTableW16,MyTableH16,32,#PB_Image_Transparent)
	Global MyTableDefaultImageSortDesc=CreateImage(#PB_Any,MyTableW16,MyTableH16,32,#PB_Image_Transparent)
	Global MyTableDefaultImagePlus=CreateImage(#PB_Any,MyTableW16,MyTableH16,32,#PB_Image_Transparent)
	Global MyTableDefaultImageMinus=CreateImage(#PB_Any,MyTableW16,MyTableH16,32,#PB_Image_Transparent)
	Global MyTableDefaultImageCheckBox=CreateImage(#PB_Any,MyTableW16,MyTableH16,32,#PB_Image_Transparent)
	Global MyTableDefaultImageCheckBoxChecked=CreateImage(#PB_Any,MyTableW16,MyTableH16,32,#PB_Image_Transparent)
	Global MyTableDefaultImagePlusArrow=CreateImage(#PB_Any,MyTableW16,MyTableH16,32,#PB_Image_Transparent)
	Global MyTableDefaultImageMinusArrow=CreateImage(#PB_Any,MyTableW16,MyTableH16,32,#PB_Image_Transparent)
	
	
	StartDrawing(ImageOutput(MyTableDefaultImageSortAsc))
	DrawingMode(#PB_2DDrawing_AlphaBlend)
	LineXY(MyTableW2,MyTableH8,MyTableW8,MyTableH2,RGBA(0,0,0,255))
	LineXY(MyTableW8,MyTableH2,MyTableW14,MyTableH8,RGBA(0,0,0,255))
	LineXY(MyTableW2,MyTableH8,MyTableW14,MyTableH8,RGBA(0,0,0,255))
	StopDrawing()
	
	StartDrawing(ImageOutput(MyTableDefaultImageSortDesc))
	DrawingMode(#PB_2DDrawing_AlphaBlend)
	LineXY(MyTableW2,MyTableH8,MyTableW8,MyTableH14,RGBA(0,0,0,255))
	LineXY(MyTableW8,MyTableH14,MyTableW14,MyTableH8,RGBA(0,0,0,255))
	LineXY(MyTableW2,MyTableH8,MyTableW14,MyTableH8,RGBA(0,0,0,255))
	StopDrawing()
	
	StartDrawing(ImageOutput(MyTableDefaultImagePlus))
	DrawingMode(#PB_2DDrawing_Outlined|#PB_2DDrawing_AlphaBlend)
	Box(MyTableW2,MyTableH2,MyTableW12,MyTableH12,RGBA(0,0,0,255))
	LineXY(MyTableW4,MyTableH7,MyTableW10,MyTableH7,RGBA(0,0,0,255))
	LineXY(MyTableW7,MyTableH4,MyTableW7,MyTableH10,RGBA(0,0,0,255))
	StopDrawing()
	
	StartDrawing(ImageOutput(MyTableDefaultImageMinus))
	DrawingMode(#PB_2DDrawing_Outlined|#PB_2DDrawing_AlphaBlend)
	Box(MyTableW2,MyTableH2,MyTableW12,MyTableH12,RGBA(0,0,0,255))
	LineXY(MyTableW4,MyTableH7,MyTableW10,MyTableH7,RGBA(0,0,0,255))
	StopDrawing()
	
	StartDrawing(ImageOutput(MyTableDefaultImageCheckBox))
	DrawingMode(#PB_2DDrawing_Outlined|#PB_2DDrawing_AlphaBlend)
	Box(MyTableW2,MyTableH2,MyTableW12,MyTableH12,RGBA(0,0,0,255))
	StopDrawing()
	
	StartDrawing(ImageOutput(MyTableDefaultImageCheckBoxChecked))
	DrawingMode(#PB_2DDrawing_Outlined|#PB_2DDrawing_AlphaBlend)
	Box(MyTableW2,MyTableH2,MyTableW12,MyTableH12,RGBA(0,0,0,255))
	LineXY(MyTableW4,MyTableH4,MyTableW12,MyTableH12,RGBA(0,0,0,255))
	LineXY(MyTableW4,MyTableH12,MyTableW12,MyTableH4,RGBA(0,0,0,255))
	StopDrawing()
	
	StartDrawing(ImageOutput(MyTableDefaultImagePlusArrow))
	DrawingMode(#PB_2DDrawing_AlphaBlend)
	LineXY(MyTableW8,MyTableH4,MyTableW12,MyTableH8,RGBA(0,0,0,255))
	LineXY(MyTableW8,MyTableH12,MyTableW12,MyTableH8,RGBA(0,0,0,255))
	StopDrawing()
	
	StartDrawing(ImageOutput(MyTableDefaultImageMinusArrow))
	DrawingMode(#PB_2DDrawing_AlphaBlend)
	LineXY(MyTableW4,MyTableH6,MyTableW8,MyTableH10,RGBA(0,0,0,255))
	LineXY(MyTableW8,MyTableH10,MyTableW12,MyTableH6,RGBA(0,0,0,255))
	StopDrawing()
	
	
	
	Structure _strMyTableAObject
		vtable.i
		type.i
		flags.i
		
		selectedbackground.q
		background.q
		backgroundfixed.q		
		forecolor.q
		selectedforecolor.q
		font.i
	EndStructure
	
	Structure strMyTableAObject Extends _strMyTableAObject
		brow.b
		*data
		image.i
		sclaedimage.i
		calcwidth.i
		calcheight.i
		dirty.b
		textwidth.i
		textheight.i
		*table.strMyTableTable
		tooltip.s
	EndStructure
	
	Structure strMyTableCell Extends strMyTableAObject
		text.s
		value.d
		checked.b
		format.s
		*row.strMyTableRow
		*col.strMyTableCol	
		startx.i
		starty.i
		CompilerIf Defined(MYTABLE_FORMULA,#PB_Module)
			formula.s
			calced.b
		CompilerEndIf
	EndStructure
	
	Structure strMyTableRow Extends strMyTableAObject
		listindex.q
		List cells.strMyTableCell()
		List rows.strMyTableRow()
		id.q	
		checked.b
		expanded.b
		sort.s	
		dsort.d
		level.i
		height.i
	EndStructure
	
	Enumeration _menu_evt
		#MYTABLE_NONE
		#MYTABLE_RETURN
		#MYTABLE_ESC
	EndEnumeration
	
	
	Structure strMyTableCol Extends strMyTableAObject
		listindex.q
		id.q
		text.s	
		width.i
		sort.i		
		format.s
		canNull.b
		evtCustomEditCell.MyTableProtoEventCustomEditCell	
		evtCancelCustomEditCell.MyTableProtoEventCancelCustomEditCell
	EndStructure
	
	
	Structure strMyTableTable Extends _strMyTableAObject
		*application.strMyTableApplication
		name.s
		window.i
		canvas.i
		vscroll.i
		hscroll.i
		List rows.strMyTableRow()
		Map rowsById.i()
		List cols.strMyTableCol()	
		Map colsById.i()
		redraw.b
		dirty.b
		lastw.i
		lasth.i
		lastRowid.q
		lastColid.q
		rowheight.i
		headerheight.i
		bvs.b
		bhs.b
		Map selected.b()
		datagrid.b
		CompilerIf Defined(MYTABLE_FORMULA,#PB_Module)
			Map formulaCells.b()
			Map forms.i()
		CompilerEndIf
		Map tempselected.b()
		List expRows.i()
		expheight.i
		
		editorgadget.i
		editorwindow.i
		*editcell.strMyTableCell
		*lastcell.strMyTableCell
		*lastrow.strMyTableCell
		*lastcol.strMyTableCell
		menu.i
		
		evtRowSelect.MyTableProtoEventRowSelected
		evtCellSelect.MyTableProtoEventCellSelected
		evtRowChecked.MyTableProtoEventRowChecked
		evtRowRightClick.MyTableProtoEventRowRightClick
		evtColRightClick.MyTableProtoEventColRightClick
		evtCellChecked.MyTableProtoEventCellChecked
		evtCellRightClick.MyTableProtoEventCellRightClick
		evtCellChangedText.MyTableProtoEventCellChangedText
		evtCellChangedValue.MyTableProtoEventCellChangedValue
		evtCallback.MyTableProtoEventCallback
		
		
		
		
		fixedcolumns.i
		resizecol.b
		oldx.i
		*colResize.strMyTableCol
		resizerow.b
		oldy.i
		*rowResize.strMyTableRow
		
		*data
		
		sortImageAsc.i
		sortImageDesc.i
		
		checkboxImage.i
		checkboxImageChecked.i
		
		treeImage.i
		treeImageExpanded.i
		
		drawing.b
		
		headerbackground1.q
		headerbackground2.q
		headerbackgroundfixed.q
		headerforecolor.q
	EndStructure
	
	Structure strMyTableApplication
		vtable.i
		List tables.strMyTableTable()		
	EndStructure
	
	Structure strMyTableRowCol
		row.i
		col.i
	EndStructure
	
	CompilerIf Defined(MYTABLE_EXPORT_JSON,#PB_Module) Or Defined(MYTABLE_EXPORT_XML,#PB_Module)
		Structure strMyTableExportRow
			List cells.s()
		EndStructure
		
		Structure strMyTableExportTable
			List cols.s()
			List rows.strMyTableExportRow()
		EndStructure
		
		Declare _MyTableExportInit(canvas)
		Declare _MyTableImport(*this.strMyTableTable,*table.strMyTableExportTable,add.b)
	CompilerEndIf
	
	
	XIncludeFile "declare.pb"
	
	CompilerIf Defined(MYTABLE_FORMULA,#PB_Module)
		XIncludeFile "mytablecalc.pbi"
	CompilerEndIf
	
	
	Procedure _MyTableEditSetPos(Gadget, Position)
		CompilerSelect #PB_Compiler_OS
			CompilerCase #PB_OS_Windows
				SendMessage_(GadgetID(Gadget), #EM_SETSEL, Position, Position)
		CompilerEndSelect
	EndProcedure
	
	CompilerIf Defined(MYTABLE_EXPORT_JSON,#PB_Module) Or Defined(MYTABLE_EXPORT_XML,#PB_Module)
		Procedure _MyTableExportInit(canvas)
			Protected *this.strMyTableTable=GetGadgetData(canvas)
			_callcountStart(exportData)
			Protected *result.strMyTableExportTable=0
			Protected *cell.strMyTableCell=0
			Protected *row.strMyTableRow=0
			
			If *this
				*result=AllocateStructure(strMyTableExportTable)
				If Not *this\datagrid
					ForEach *this\cols()
						AddElement(*result\cols()):*result\cols()=*this\cols()\text
					Next
				EndIf
				Protected c=ListSize(*this\cols())-1
				Protected idx=0
				Protected start=0
				If *this\datagrid
					start=1
				EndIf
				ForEach *this\rows()
					*row=*this\rows()
					Protected *exportrow.strMyTableExportRow=AddElement(*result\rows())
					For idx=start To c					
						*cell=_MyTableGetOrAddCell(*this\rows(),idx)
						AddElement(*exportrow\cells()):*exportrow\cells()=*cell\text
					Next
				Next
			EndIf
			_callcountEnde(exportData)
			ProcedureReturn *result
		EndProcedure
		
		Procedure _MyTableImport(*this.strMyTableTable,*table.strMyTableExportTable,add.b)
			If *table And *this
				_callcountStart(ImportData)
				Protected *row.strMyTableRow=0
				Protected *cell.strMyTableCell=0
				Protected *exprow.strMyTableExportRow=0
				Protected redraw.b=*this\redraw
				*this\redraw=#False
				If Not add
					_MyTable_Table_ClearRows(*this)
					_MyTable_Table_ClearCols(*this)
					If *this\datagrid
						_MyTable_Table_AddColumn(*this," ",100,#MYTABLE_COLUMN_FLAGS_RIGHT|#MYTABLE_COLUMN_FLAGS_NO_RESIZEABLE|#MYTABLE_COLUMN_FLAGS_NO_EDITABLE|#MYTABLE_COLUMN_FLAGS_INTEGER)
						If ListSize(*table\rows())>0
							*exprow=FirstElement(*table\rows())
							ForEach *exprow\cells()
								_MyTable_Table_AddColumn(*this,"",100)
							Next
						EndIf
					Else
						ForEach *table\cols()
							_MyTable_Table_AddColumn(*this,*table\cols(),100)
						Next
					EndIf					
				EndIf
				ForEach *table\rows()
					_MyTable_Table_AddRow(*this,"")
					*row=LastElement(*this\rows())
					ForEach *table\rows()\cells()
						*cell=_MyTableGetOrAddCell(*row)
						_MyTableFillCellText(*cell,*table\rows()\cells())
					Next
				Next
				
				*this\redraw=redraw
				_callcountEnde(ImportData)
				_MyTable_Table_Recalc(*this)
				
			EndIf
		EndProcedure
		
	CompilerEndIf
	
	
	
	
	Procedure _MyTableGetRowCol(*this.strMyTableTable,down.b,up.b,move.b)
		
		If *this
			Protected noheader.b=Bool(*this\flags & #MYTABLE_TABLE_FLAGS_NO_HEADER)
			Protected fullrow.b=Bool(*this\flags & #MYTABLE_TABLE_FLAGS_FULL_ROW_SELECT Or ListSize(*this\cols())=1)
			Protected colresizeable.b=Bool(*this\flags & #MYTABLE_TABLE_FLAGS_COL_RESIZEABLE)
			Protected rowresizeable.b=Bool(*this\flags & #MYTABLE_TABLE_FLAGS_ROW_RESIZEABLE)
			
			Protected mx=GetGadgetAttribute(*this\canvas,#PB_Canvas_MouseX)+GetGadgetState(*this\hscroll)
			Protected my=GetGadgetAttribute(*this\canvas,#PB_Canvas_MouseY)
			Protected ms=GetGadgetAttribute(*this\canvas,#PB_Canvas_WheelDelta)
			Protected control.b=Bool(GetGadgetAttribute(*this\canvas,#PB_Canvas_Modifiers) & #PB_Canvas_Control)
			Protected shift.b=Bool(GetGadgetAttribute(*this\canvas,#PB_Canvas_Modifiers) & #PB_Canvas_Shift)
			
			Protected leftbutton.b=Bool(GetGadgetAttribute(*this\canvas,#PB_Canvas_Buttons) & #PB_Canvas_LeftButton)
			Protected rightbutton.b=Bool(GetGadgetAttribute(*this\canvas,#PB_Canvas_Buttons) & #PB_Canvas_RightButton)
			
			Protected h=DesktopScaledY(GadgetHeight(*this\canvas))
			
			
			Protected *row.strMyTableRow=0
			Protected *col.strMyTableCol=0
			Protected row=0
			Protected hh=0
			Protected idx=0
			Protected cc=ListSize(*this\expRows()) 
			Protected col=0
			Protected fw.b=#False
			
			SetGadgetAttribute(*this\canvas,#PB_Canvas_Cursor,#PB_Cursor_Default)
			
			
			If Not noheader
				If my<=DesktopScaledY(*this\headerheight)
					row-1
				EndIf
				hh+DesktopScaledY(*this\headerheight)
			EndIf
			
			If row=0
				For idx=GetGadgetState(*this\vscroll) To (cc-1)
					SelectElement(*this\expRows(),idx)
					*row=*this\expRows()					
					hh+*row\calcheight
					If rowresizeable
						If (hh+MyTableH2)>=my And (hh-MyTableH2)<=my
							SetGadgetAttribute(*this\canvas,#PB_Canvas_Cursor,#PB_Cursor_UpDown)
							If leftbutton And down
								*this\resizerow=#True
								*this\rowResize=*row
								*this\oldy=GetGadgetAttribute(*this\canvas,#PB_Canvas_MouseY)
							EndIf
							ProcedureReturn #False
							Break
						EndIf
					EndIf
					
					If hh>=my
						row=idx
						Break
					EndIf
					
					If hh>=h
						Break
					EndIf
				Next
			EndIf
			
			
			If *this\fixedcolumns>0
				mx=GetGadgetAttribute(*this\canvas,#PB_Canvas_MouseX)
				ForEach *this\cols()
					*col=*this\cols()
					If ListIndex(*this\cols())<*this\fixedcolumns
						mx-*col\calcwidth
						If mx>=-MyTableW2 And mx<=MyTableW2
							fw=#True
							If Not Bool(*col\flags & #MYTABLE_COLUMN_FLAGS_NO_RESIZEABLE)
								If Bool(*col\flags & #MYTABLE_COLUMN_FLAGS_RESIZEABLE) Or colresizeable
									SetGadgetAttribute(*this\canvas,#PB_Canvas_Cursor,#PB_Cursor_LeftRight)
									If leftbutton And down
										*this\resizecol=#True
										*this\oldx=GetGadgetAttribute(*this\canvas,#PB_Canvas_MouseX)
										*this\colResize=*this\cols()
									EndIf				
									ProcedureReturn #False
								EndIf				
							EndIf
						ElseIf mx<=0
							fw=#True
							Break
						Else
							col+1
						EndIf
					EndIf
				Next
				
			EndIf
			
			If Not fw
				mx=GetGadgetAttribute(*this\canvas,#PB_Canvas_MouseX)+GetGadgetState(*this\hscroll)
				col=0
				ForEach *this\cols()
					*col=*this\cols()
					mx-*col\calcwidth
					If mx>=-MyTableW2 And mx<=MyTableW2
						If Not Bool(*col\flags & #MYTABLE_COLUMN_FLAGS_NO_RESIZEABLE)
							If Bool(*col\flags & #MYTABLE_COLUMN_FLAGS_RESIZEABLE) Or colresizeable
								SetGadgetAttribute(*this\canvas,#PB_Canvas_Cursor,#PB_Cursor_LeftRight)
								If leftbutton And down
									*this\resizecol=#True
									*this\oldx=GetGadgetAttribute(*this\canvas,#PB_Canvas_MouseX)
									*this\colResize=*this\cols()							
								EndIf
								ProcedureReturn #False
							EndIf
						EndIf
					ElseIf mx<=0
						
						Break
					Else
						col+1
					EndIf
				Next			
			EndIf
			
		EndIf
		
		If col>=ListSize(*this\cols())
			col=-1
		EndIf
		If row>=ListSize(*this\expRows())
			row=-1
		EndIf
		
		Protected *result.strMyTableRowCol=AllocateStructure(strMyTableRowCol)
		*result\col=col
		*result\row=row		
		ProcedureReturn *result
	EndProcedure
	
	Procedure _MyTableSelectCell(*cell.strMyTableCell,control.b,shift.b,multiselect.b,temp.b)
		Protected *this.strMyTableTable=*cell\table
		If (Not control And Not shift) Or Not multiselect
			If Not temp
				ClearMap(*this\selected())
			EndIf
		EndIf	
		
		
		ClearMap(*this\tempselected())
		
		
		If Not temp
			*this\lastcell=*cell
		EndIf
		If shift And multiselect
			Protected *tr.strMyTableCell=0
			If *this\lastcell
				*tr=*this\lastcell			
			Else
				ForEach *this\selected()
					If *this\selected() And Val(MapKey(*this\selected()))<>*cell
						Protected *o.strMyTableAObject=Val(MapKey(*this\selected()))
						If *o\type=#MYTABLE_TYPE_CELL
							*tr=*o
						EndIf
					EndIf
				Next
			EndIf
			If *tr
				Protected min=0
				Protected max=0
				Protected idx=0
				ForEach *tr\row\cells()
					If *tr\row\cells()=*tr
						idx=ListIndex(*tr\row\cells())
						min=idx
						max=idx
						Break
					EndIf
				Next
				
				ForEach *cell\row\cells()
					If *cell\row\cells()=*cell
						idx=ListIndex(*cell\row\cells())
						If idx<min:min=idx:EndIf
						If idx>max:max=idx:EndIf
						Break
					EndIf
				Next
				
				Protected selecte.b=#False
				Protected ende.b=#False
				ForEach *this\rows()
					If *this\rows()=*tr\row
						selecte=Bool(selecte=#False)
						ende=Bool(selecte=#False)
					EndIf
					If *this\rows()=*cell\row
						selecte=Bool(selecte=#False)
						ende=Bool(selecte=#False)
					EndIf
					
					If selecte Or *this\rows()=*cell\row Or *this\rows()=*tr\row
						For idx=min To max
							Protected *tc.strMyTableCell=_MyTableGetOrAddCell(*this\rows(),idx,#True)	
							If temp 
								
								*this\tempselected(Str(*tc))=Bool(*this\tempselected(Str(*tc))=#False)
							Else
								*this\selected(Str(*tc))=#True
								If *this\evtCellSelect
									*this\evtCellSelect(*tc)
								EndIf
							EndIf
						Next
					EndIf
					
					If ende
						Break
					EndIf
				Next
			Else
				If temp	
					*this\tempselected(Str(*cell))=Bool(*this\tempselected(Str(*cell))=#False)
				Else
					*this\selected(Str(*cell))=Bool(*this\selected(Str(*cell))=#False)
					If *this\evtCellSelect
						*this\evtCellSelect(*cell)
					EndIf
				EndIf
			EndIf
		Else
			If temp	
				*this\tempselected(Str(*cell))=Bool(*this\tempselected(Str(*cell))=#False)
			Else
				*this\selected(Str(*cell))=Bool(*this\selected(Str(*cell))=#False)
				If *this\evtCellSelect
					*this\evtCellSelect(*cell)
				EndIf
			EndIf
		EndIf
	EndProcedure
	
	CompilerIf #PB_Compiler_Debugger And Defined(MYTABLE_DEBUG,#PB_Module)
		Procedure _MyTableDebugGetCanvas(*element._strMyTableAObject)
			Select *element\type
				Case #MYTABLE_TYPE_TABLE
					Protected *table.strMyTableTable=*element
					ProcedureReturn *table\canvas
				Case #MYTABLE_TYPE_ROW
					Protected *row.strMyTableRow=*element
					ProcedureReturn *row\table\canvas
				Case #MYTABLE_TYPE_COL
					Protected *col.strMyTableCol=*element
					ProcedureReturn *col\table\canvas
				Case #MYTABLE_TYPE_CELL
					Protected *cell.strMyTableCell=*element
					ProcedureReturn *cell\table\canvas
			EndSelect
		EndProcedure
		
		Procedure.s _MyTableDebugGetName(*element._strMyTableAObject)
			Select *element\type
				Case #MYTABLE_TYPE_TABLE
					Protected *table.strMyTableTable=*element
					ProcedureReturn *table\name
				Case #MYTABLE_TYPE_ROW
					Protected *row.strMyTableRow=*element
					ProcedureReturn *row\table\name
				Case #MYTABLE_TYPE_COL
					Protected *col.strMyTableCol=*element
					ProcedureReturn *col\table\name
				Case #MYTABLE_TYPE_CELL
					Protected *cell.strMyTableCell=*element
					ProcedureReturn *cell\table\name
			EndSelect
		EndProcedure
	CompilerEndIf
	
	Procedure _MyTableSelectCol(*col.strMyTableCol,control.b,shift.b,multiselect.b,temp.b)
		Protected *this.strMyTableTable=*col\table
		If Not temp
			*this\lastcol=*col
		EndIf
		ClearMap(*this\tempselected())
		If (Not control And Not shift) Or Not multiselect
			ClearMap(*this\selected())
		EndIf
		If shift And multiselect
			Protected *tr.strMyTableCol=0
			ForEach *this\selected()
				If *this\selected() And Val(MapKey(*this\selected()))<>*col
					Protected *o.strMyTableAObject=Val(MapKey(*this\selected()))
					If *o\type=#MYTABLE_TYPE_COL
						*tr=*o
					EndIf
				EndIf
			Next
			If *tr
				Protected selecte.b=#False
				Protected ende.b=#False
				ForEach *this\cols()
					If *this\cols()=*tr
						selecte=Bool(selecte=#False)
						ende=Bool(selecte=#False)
					EndIf
					If *this\cols()=*col
						selecte=Bool(selecte=#False)
						ende=Bool(selecte=#False)
					EndIf
					If (selecte And *this\cols()<>*tr) Or *this\cols()=*col
						If temp
							*this\tempselected(Str(*this\cols()))=Bool(*this\tempselected(Str(*this\cols()))=#False)
						Else
							*this\selected(Str(*this\cols()))=Bool(*this\selected(Str(*this\cols()))=#False)
						EndIf		
					EndIf
					If ende
						Break
					EndIf
				Next
			Else
				If temp
					*this\tempselected(Str(*col))=Bool(*this\tempselected(Str(*col))=#False)
				Else
					*this\selected(Str(*col))=Bool(*this\selected(Str(*col))=#False)
				EndIf
			EndIf
		Else
			If temp
				*this\tempselected(Str(*col))=Bool(*this\tempselected(Str(*col))=#False)
			Else
				*this\selected(Str(*col))=Bool(*this\selected(Str(*col))=#False)
			EndIf
		EndIf
	EndProcedure
	
	Procedure _MyTableSelectRow(*row.strMyTableRow,control.b,shift.b,multiselect.b,temp.b)
		Protected *this.strMyTableTable=*row\table
		If Not temp
			*this\lastrow=*row
		EndIf
		ClearMap(*this\tempselected())
		If (Not control And Not shift) Or Not multiselect
			ClearMap(*this\selected())
		EndIf
		If shift And multiselect
			Protected *tr.strMyTableRow=0
			ForEach *this\selected()
				If *this\selected() And Val(MapKey(*this\selected()))<>*row
					Protected *o.strMyTableAObject=Val(MapKey(*this\selected()))
					If *o\type=#MYTABLE_TYPE_ROW
						*tr=*o
					EndIf
				EndIf
			Next
			If *tr
				Protected selecte.b=#False
				Protected ende.b=#False
				ForEach *this\rows()
					If *this\rows()=*tr
						selecte=Bool(selecte=#False)
						ende=Bool(selecte=#False)
					EndIf
					If *this\rows()=*row
						selecte=Bool(selecte=#False)
						ende=Bool(selecte=#False)
					EndIf
					If (selecte And *this\rows()<>*tr) Or *this\rows()=*row
						If temp
							*this\tempselected(Str(*this\rows()))=Bool(*this\tempselected(Str(*this\rows()))=#False)
						Else
							*this\selected(Str(*this\rows()))=Bool(*this\selected(Str(*this\rows()))=#False)
							If *this\evtRowSelect
								*this\evtRowSelect(*this\rows())
							EndIf
						EndIf		
					EndIf
					If ende
						Break
					EndIf
				Next
			Else
				If temp
					*this\tempselected(Str(*row))=Bool(*this\tempselected(Str(*row))=#False)
				Else
					*this\selected(Str(*row))=Bool(*this\selected(Str(*row))=#False)
					If *this\evtRowSelect
						*this\evtRowSelect(*row)
					EndIf
				EndIf
			EndIf
		Else
			If temp
				*this\tempselected(Str(*row))=Bool(*this\tempselected(Str(*row))=#False)
			Else
				*this\selected(Str(*row))=Bool(*this\selected(Str(*row))=#False)
				If *this\evtRowSelect
					*this\evtRowSelect(*row)
				EndIf
			EndIf
		EndIf
	EndProcedure
	
	Procedure _MyTableFillCellText(*cell.strMyTableCell,text.s,override.b=#True)
		Protected flags=*cell\flags
		If Not flags
			flags=*cell\col\flags
		EndIf
		
		*cell\text=text	
		
		CompilerIf Defined(MYTABLE_FORMULA,#PB_Module)
			If override
				*cell\formula=""
				*cell\calced=#True
			EndIf
		CompilerEndIf
		If text=""
			*cell\col\canNull=#True
		EndIf
		
		Protected format.s=*cell\format
		If format=""
			format=*cell\col\format
		EndIf
		
		If Bool(flags & #MYTABLE_COLUMN_FLAGS_DEFAULT_DATE_TIME)
			*cell\value=ParseDate(format,*cell\text)
		ElseIf Bool(flags & #MYTABLE_COLUMN_FLAGS_INTEGER)
			*cell\value=Val(*cell\text)
		ElseIf Bool(flags & #MYTABLE_COLUMN_FLAGS_DOUBLE)
			*cell\value=ValD(*cell\text)
		ElseIf Bool(flags & #MYTABLE_COLUMN_FLAGS_BOOLEAN)
			*cell\value=Bool(*cell\text="1" Or 
			                 LCase(*cell\text)="x" Or 
			                 LCase(*cell\text)="#true" Or
			                 LCase(*cell\text)="true" Or
			                 LCase(*cell\text)="yes")
			*cell\checked=*cell\value
		EndIf
		CompilerIf Defined(MYTABLE_FORMULA,#PB_Module)
			If override
				_MyTableFormulaCalcTable(*cell\table)
			EndIf
		CompilerEndIf
	EndProcedure
	
	Procedure _MyTableFillCellValue(*cell.strMyTableCell,value.d,override.b=#True)
		Protected flags=*cell\flags
		If Not flags
			flags=*cell\col\flags
		EndIf
		
		Protected format.s=*cell\format
		If format=""
			format=*cell\col\format
		EndIf
		
		*cell\value=value
		CompilerIf Defined(MYTABLE_FORMULA,#PB_Module)
			If override
				*cell\formula=""
				*cell\calced=#True
			EndIf
		CompilerEndIf
		If value=0 And Not *cell\col\canNull
			*cell\text=""
			*cell\checked=*cell\value
		Else
			If Bool(flags & #MYTABLE_COLUMN_FLAGS_DEFAULT_DATE_TIME)
				If value=0
					*cell\text=""
				Else
					*cell\text=FormatDate(format,*cell\value)
				EndIf
			ElseIf Bool(flags & #MYTABLE_COLUMN_FLAGS_INTEGER)
				*cell\text=Str(value)
			ElseIf Bool(flags & #MYTABLE_COLUMN_FLAGS_DOUBLE)
				*cell\text=FormatNumber(value)
			ElseIf Bool(flags & #MYTABLE_COLUMN_FLAGS_BOOLEAN)
				*cell\checked=*cell\value
				*cell\text=Str(value)
			EndIf
		EndIf
		CompilerIf Defined(MYTABLE_FORMULA,#PB_Module)
			If override
				_MyTableFormulaCalcTable(*cell\table)
			EndIf
		CompilerEndIf
	EndProcedure
	
	Procedure _MyTableStopEditCell(*this.strMyTableTable)
		If *this			
			If *this\editcell
				If *this\editcell\col\evtCancelCustomEditCell
					*this\editcell\col\evtCancelCustomEditCell(*this\editcell)
					*this\dirty=#True
					If *this\evtCellSelect
						*this\evtCellSelect(*this\editcell)
					EndIf
					*this\editcell=0
					_MyTable_Table_Recalc(*this)
				EndIf
			ElseIf IsWindow(*this\editorwindow)
				Protected *cell.strMyTableCell=GetGadgetData(*this\editorgadget)
				If *cell
					Protected *col.strMyTableCol=0
					Protected *row.strMyTableRow=0
					If *cell
						*col=*cell\col
						*row=*cell\row
						
						Protected s.s=GetGadgetText(*this\editorgadget)
						Protected sold.s=*cell\text
						If s<>*cell\text				
							*cell\dirty=#True
							*cell\textwidth=0					
							*cell\textheight=0				
							
							CompilerIf Defined(MYTABLE_FORMULA,#PB_Module)
								_MyTableFillCellFormula(*cell,s)
							CompilerElse
								_MyTableFillCellText(*cell,s)
							CompilerEndIf
							If *this\evtCellChangedText
								*this\evtCellChangedText(*cell,sold)
							EndIf
							*this\dirty=#True
							If *this\evtCellSelect
								*this\evtCellSelect(*cell)
							EndIf
							_MyTable_Table_Redraw(*this)
						EndIf
						
						RemoveKeyboardShortcut(*this\editorwindow,#PB_Shortcut_Return)
						RemoveKeyboardShortcut(*this\editorwindow,#PB_Shortcut_Escape)
						CloseWindow(*this\editorwindow)
						*this\editorwindow=0
					EndIf
				EndIf
			EndIf
		EndIf
	EndProcedure
	
	Procedure _MyTableEditCell(*cell.strMyTableCell,defaultIfEmpty.s="")
		If *cell
			Protected *col.strMyTableCol=*cell\col
			Protected *row.strMyTableRow=*cell\row
			Protected *this.strMyTableTable=*cell\table
			
			If Not Bool(*col\flags & #MYTABLE_COLUMN_FLAGS_NO_EDITABLE) And Not Bool(*this\flags & #MYTABLE_TABLE_FLAGS_READONLY)
				If Bool(*col\flags & #MYTABLE_COLUMN_FLAGS_EDITABLE) Or Bool(*this\flags & #MYTABLE_TABLE_FLAGS_EDITABLE)
					If Bool(*col\flags & #MYTABLE_COLUMN_FLAGS_BOOLEAN)
						*cell\checked=Bool(*cell\checked=#False)
						*cell\value=*cell\checked
						*cell\text=Str(*cell\checked)
						*cell\textwidth=0
						*cell\textheight=0
						*cell\dirty=#True
						*this\dirty=#True
						If *this\evtCellChecked
							*this\evtCellChecked(*cell)
						EndIf
						_MyTable_Table_Redraw(*this)
					Else
						If IsWindow(*this\editorwindow)
							CloseWindow(*this\editorwindow)					
						EndIf
						If *col\evtCustomEditCell
							
							*col\evtCustomEditCell(*cell,
							                       DesktopUnscaledX(*cell\startx+2)+WindowX(*this\window,#PB_Window_InnerCoordinate)+GadgetX(*this\canvas,#PB_Gadget_WindowCoordinate),
							                       DesktopUnscaledY(*cell\starty+2)+WindowY(*this\window,#PB_Window_InnerCoordinate)+GadgetY(*this\canvas,#PB_Gadget_WindowCoordinate),
							                       DesktopUnscaledX(*col\calcwidth),
							                       DesktopUnscaledY(*row\calcheight))
							*this\editcell=*cell
						Else
							*this\editorwindow=OpenWindow(#PB_Any,
							                              DesktopUnscaledX(*cell\startx+2)+WindowX(*this\window,#PB_Window_InnerCoordinate)+GadgetX(*this\canvas,#PB_Gadget_WindowCoordinate),
							                              DesktopUnscaledY(*cell\starty+2)+WindowY(*this\window,#PB_Window_InnerCoordinate)+GadgetY(*this\canvas,#PB_Gadget_WindowCoordinate),
							                              DesktopUnscaledX(*col\calcwidth),
							                              DesktopUnscaledY(*row\calcheight),
							                              "",
							                              #PB_Window_BorderLess,
							                              GadgetID(*this\canvas))
							*this\editorgadget=EditorGadget(#PB_Any,
							                                0,
							                                0,
							                                WindowWidth(*this\editorwindow),
							                                WindowHeight(*this\editorwindow),
							                                #PB_Editor_WordWrap)		
							CompilerIf Defined(MYTABLE_FORMULA,#PB_Module)
								If *cell\formula=""
									*cell\formula=defaultIfEmpty
								EndIf
								If Bool(*this\flags & #MYTABLE_TABLE_FLAGS_FORMULA) And *cell\formula<>""
									SetGadgetText(*this\editorgadget,*cell\formula)
								Else
									SetGadgetText(*this\editorgadget,*cell\text)
								EndIf
							CompilerElse
								If *cell\text=""
									*cell\text=defaultIfEmpty
								EndIf
								SetGadgetText(*this\editorgadget,*cell\text)
							CompilerEndIf
							_MyTableEditSetPos(*this\editorgadget,Len(GetGadgetText(*this\editorgadget)))
							HideGadget(*this\editorgadget,#False)
							SetActiveGadget(*this\editorgadget)
							SetGadgetData(*this\editorgadget,*cell)
							SetWindowData(*this\editorwindow,*cell)
							
							AddKeyboardShortcut(*this\editorwindow,#PB_Shortcut_Return,#MYTABLE_RETURN)
							AddKeyboardShortcut(*this\editorwindow,#PB_Shortcut_Escape,#MYTABLE_ESC)
							
							BindMenuEvent(*this\menu,#MYTABLE_RETURN,@MyTableEvtReturn())
							BindMenuEvent(*this\menu,#MYTABLE_ESC,@MyTableEvtEsc())		
							
							BindGadgetEvent(*this\editorgadget,@MyTableEvtLostFocus(),#PB_EventType_LostFocus)
							*this\editcell=0
						EndIf
					EndIf
				EndIf
			EndIf
		EndIf
	EndProcedure
	
	Procedure _MyTableTextHeight(text.s)
		ProcedureReturn TextHeight(text) * (CountString(text,#CRLF$)+1)
	EndProcedure
	
	Procedure _MyTableTextWidth(text.s)
		Protected result.i=0
		Protected c=CountString(text,#CRLF$)		
		If c>0
			c+1
			Protected idx=0
			For idx=1 To c
				Protected v=TextWidth(StringField(text,idx,#CRLF$))
				If v>result
					result=v
				EndIf
			Next
		Else
			result=TextWidth(text)
		EndIf
		ProcedureReturn result
	EndProcedure
	
	Procedure _MyTableDrawText(x,y,text.s,color.q)
		Protected c=CountString(text,#CRLF$)
		If c>0
			c+1
			Protected i=0
			Protected yc=0
			For i=1 To c
				Protected line.s=StringField(text,i,#CRLF$)
				DrawText(x,y+yc,line,color)
				If line=""
					yc+_MyTableTextHeight("Q")
				Else
					yc+_MyTableTextHeight(line)
				EndIf
			Next
		Else
			DrawText(x,y,text,color)
		EndIf
	EndProcedure
	
	Procedure _MyTableRowExpand(*row.strMyTableRow,expanded.b)	
		*row\expanded=expanded
		ForEach *row\rows()
			_MyTableRowExpand(*row\rows(),expanded)
		Next
	EndProcedure
	
	Procedure _MyTableDrawRow(*row.strMyTableRow,w,bx.i,by.i,fixed.b,fullrowselect.b,grid.b,hierarchical.b,checkboxes.b)
		Protected *this.strMyTableTable=*row\table
		Protected *cell.strMyTableCell=0
		Protected *col.strMyTableCol=0
		Protected flags=0
		Protected font=*this\font
		
		Protected selectedbackground.q=*this\selectedbackground
		Protected background.q=*this\background
		Protected backgroundfixed.q=*this\backgroundfixed
		Protected forecolor.q=*this\forecolor
		Protected selectedforecolor.q=*this\selectedforecolor
		
		
		
		
		While ListSize(*row\cells())<ListSize(*this\cols())
			_MyTableGetOrAddCell(*row,-1)
		Wend
		If Bool(*this\flags & #MYTABLE_TABLE_FLAGS_CALLBACK) And *row\dirty And *this\evtCallback
			*this\evtCallback(*row)
			ForEach *row\cells()			
				*cell=*row\cells()
				_MyTableFillCellText(*cell,*cell\text)			
			Next
			*row\dirty=#False
		EndIf
		Protected idx=0
		Protected firstcol.b=#True
		ForEach *row\cells()
			*cell=*row\cells()
			*col=*cell\col
			
			selectedbackground=*this\selectedbackground
			background=*this\background
			backgroundfixed=*this\backgroundfixed
			forecolor=*this\forecolor
			selectedforecolor=*this\selectedforecolor
			
			If *row\selectedbackground
				selectedbackground=*row\selectedbackground
			EndIf
			If *row\background
				background=*row\background
			EndIf
			If *row\backgroundfixed
				backgroundfixed=*row\backgroundfixed
			EndIf
			If *row\forecolor
				forecolor=*row\forecolor
			EndIf
			If *row\selectedforecolor
				selectedforecolor=*row\selectedforecolor
			EndIf
			
			If *col\selectedbackground
				selectedbackground=*col\selectedbackground
			EndIf
			If *col\background
				background=*col\background
			EndIf
			If *col\backgroundfixed
				backgroundfixed=*col\backgroundfixed
			EndIf
			If *col\forecolor
				forecolor=*col\forecolor
			EndIf
			If *col\selectedforecolor
				selectedforecolor=*col\selectedforecolor
			EndIf
			
			If *cell\selectedbackground
				selectedbackground=*cell\selectedbackground
			EndIf
			If *cell\background
				background=*cell\background
			EndIf
			If *cell\backgroundfixed
				backgroundfixed=*cell\backgroundfixed
			EndIf
			If *cell\forecolor
				forecolor=*cell\forecolor
			EndIf
			If *cell\selectedforecolor
				selectedforecolor=*cell\selectedforecolor
			EndIf
			
			If background<>*this\background
				DrawingMode(#PB_2DDrawing_Default)
				Box(bx,by,*col\calcwidth,*row\calcheight,background)
			EndIf
			
			
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
			
			flags=*cell\flags
			
			If Not flags
				flags=*col\flags
			EndIf
			
			If ListIndex(*row\cells())>=*this\fixedcolumns And fixed
				Break
			EndIf
			If *cell\textheight=0
				If Bool(flags & #MYTABLE_COLUMN_FLAGS_BOOLEAN)
					*cell\textheight=MyTableW20
				Else
					*cell\textheight=_MyTableTextHeight(*cell\text)
				EndIf
			EndIf
			If *cell\textwidth=0
				If Bool(flags & #MYTABLE_COLUMN_FLAGS_BOOLEAN)
					*cell\textwidth=MyTableW20
				Else
					*cell\textwidth=_MyTableTextWidth(*cell\text)
				EndIf
			EndIf
			
			Protected selected.b=#False
			If fixed
				Box(bx,by,*col\calcwidth-MyTableW1,*row\calcheight,backgroundfixed)	
			EndIf
			If *this\selected(Str(*row)) Or 
			   *this\selected(Str(*cell)) Or 
			   *this\selected(Str(*col)) Or 
			   *this\tempselected(Str(*row)) Or 
			   *this\tempselected(Str(*cell)) Or 
			   *this\tempselected(Str(*col))
				Box(bx,by,*col\calcwidth,*row\calcheight,selectedbackground)	
				selected=#True
			EndIf
			*cell\startx=bx
			*cell\starty=by
			
			DrawingMode(#PB_2DDrawing_Outlined)	
			If grid
				Box(bx,by,*col\calcwidth-MyTableW1,*row\calcheight,*this\headerbackground2)
			EndIf
			
			Protected foi.i=0
			Protected coi.i=0
			Protected cob.i=0
			
			Protected valw=0
			If Bool(flags & #MYTABLE_COLUMN_FLAGS_MIDDLE)
				valw=*row\calcheight/2-*cell\textheight/2
			ElseIf Bool(flags & #MYTABLE_COLUMN_FLAGS_BOTTOM)
				valw=*row\calcheight-*cell\textheight
			Else
				valw=MyTableH2
			EndIf
			
			If firstcol And hierarchical
				foi=MyTableW20 * (*row\level+1)
				If ListSize(*row\rows())>0
					If *row\expanded
						DrawAlphaImage(ImageID(*this\treeImageExpanded),bx+foi-MyTableW20,by+valw)
					Else
						DrawAlphaImage(ImageID(*this\treeImage),bx+foi-MyTableW20,by+valw)					
					EndIf
				EndIf
			EndIf
			
			If firstcol And checkboxes
				coi=MyTableW20
				If *row\checked
					DrawAlphaImage(ImageID(*this\checkboxImage),bx+foi,by+valw)
				Else
					DrawAlphaImage(ImageID(*this\checkboxImageChecked),bx+foi,by+valw)
				EndIf
			EndIf
			
			
			If firstcol And IsImage(*row\sclaedimage)
				cob+MyTableW20
				
				DrawAlphaImage(ImageID(*row\sclaedimage),bx+foi+coi,by+valw)
			EndIf
			
			
			
			ClipOutput(bx,by,*col\calcwidth,*row\calcheight)
			DrawingMode(#PB_2DDrawing_Transparent)			
			
			
			If Bool(flags & #MYTABLE_COLUMN_FLAGS_IMAGE)
				If IsImage(*cell\image)
					If Bool(flags & #MYTABLE_COLUMN_FLAGS_CENTER)
						DrawAlphaImage(ImageID(*cell\image),bx+MyTableW2+*col\calcwidth/2-*cell\textwidth/2,by+valw)
					ElseIf Bool(flags & #MYTABLE_COLUMN_FLAGS_RIGHT)
						DrawAlphaImage(ImageID(*cell\image),bx+*col\calcwidth-*cell\textwidth-MyTableW4,by+valw)
					Else
						DrawAlphaImage(ImageID(*cell\image),bx+MyTableW2+foi,by+valw)
					EndIf	
				EndIf
			ElseIf Bool(flags & #MYTABLE_COLUMN_FLAGS_BOOLEAN)
				Protected img=0
				If *cell\checked
					img=*this\checkboxImageChecked
				Else
					img=*this\checkboxImage
				EndIf
				
				If Bool(flags & #MYTABLE_COLUMN_FLAGS_CENTER)
					DrawAlphaImage(ImageID(img),bx+MyTableW2+*col\calcwidth/2-*cell\textwidth/2,by+valw)
				ElseIf Bool(flags & #MYTABLE_COLUMN_FLAGS_RIGHT)
					DrawAlphaImage(ImageID(img),bx+*col\calcwidth-*cell\textwidth-MyTableW4,by+valw)
				Else
					DrawAlphaImage(ImageID(img),bx+MyTableW2+foi,by+valw)
				EndIf					
			Else
				Protected color=forecolor
				If selected
					color=selectedforecolor
				EndIf
				If Bool(flags & #MYTABLE_COLUMN_FLAGS_CENTER)
					_MyTableDrawText(bx+*col\calcwidth/2-*cell\textwidth/2,by+valw,*cell\text,color)
				ElseIf Bool(flags & #MYTABLE_COLUMN_FLAGS_RIGHT)
					_MyTableDrawText(bx+*col\calcwidth-*cell\textwidth-MyTableW4,by+valw,*cell\text,color)
				Else
					_MyTableDrawText(bx+MyTableW2+foi+coi+cob,by+valw,*cell\text,color)
				EndIf					
			EndIf
			DrawingMode(#PB_2DDrawing_AlphaClip)
			UnclipOutput()					
			bx+*col\calcwidth
			If bx>=w
				Break
			EndIf
			firstcol=#False
		Next
		ProcedureReturn *row\calcheight
	EndProcedure
	
	Procedure _MyTableDrawHeader(*col.strMyTableCol,bx.i,fixed.b)
		Protected *this.strMyTableTable=*col\table
		
		If *col\font
			DrawingFont(*col\font)
		Else
			DrawingFont(*col\table\font)
		EndIf
		
		If *col\textwidth=0
			*col\textwidth=_MyTableTextWidth(*col\text)
		EndIf
		If *col\textheight=0
			*col\textheight=_MyTableTextHeight(*col\text)
		EndIf
		Protected soi.i=0
		
		If *col\sort<>0
			soi=MyTableW20
		EndIf
		
		
		Box(bx,0,*col\calcwidth,*col\table\headerheight,*this\headerbackground1)
		If fixed
			Box(bx,0,*col\calcwidth-MyTableW2,*col\table\headerheight-MyTableH2,*this\headerbackgroundfixed)
		Else
			If *this\selected(Str(*col)) Or *this\tempselected(Str(*col))
				Box(bx,0,*col\calcwidth-MyTableW2,*col\table\headerheight-MyTableH2,*this\selectedbackground)
			Else
				Box(bx,0,*col\calcwidth-MyTableW2,*col\table\headerheight-MyTableH2,*this\headerbackground2)
			EndIf
		EndIf
		
		ClipOutput(bx,0,*col\calcwidth,*col\table\headerheight)
		DrawingMode(#PB_2DDrawing_Transparent)					
		If Bool(*col\flags & #MYTABLE_COLUMN_FLAGS_CENTER) Or *this\datagrid
			_MyTableDrawText(bx+(*col\calcwidth/2-(*col\textwidth+soi)/2),0,*col\text,*this\headerforecolor)
		ElseIf Bool(*col\flags & #MYTABLE_COLUMN_FLAGS_RIGHT)
			_MyTableDrawText(bx+*col\calcwidth-*col\textwidth-MyTableW4-soi,0,*col\text,*this\headerforecolor)
		Else
			_MyTableDrawText(bx+MyTableW2,0,*col\text,*this\headerforecolor)
		EndIf					
		DrawingMode(#PB_2DDrawing_AlphaClip)
		UnclipOutput()		
		Select *col\sort
			Case -1
				DrawAlphaImage(ImageID(*this\sortImageDesc),bx+*col\calcwidth-soi,0)
			Case 1
				DrawAlphaImage(ImageID(*this\sortImageAsc),bx+*col\calcwidth-soi,0)
		EndSelect
		ProcedureReturn *col\calcwidth
	EndProcedure
	
	
	
	Procedure _MyTableRecalcExp(*parent.strMyTableRow,w)
		Protected *this.strMyTableTable=*parent\table
		ForEach *parent\rows()
			Protected *row.strMyTableRow=*parent\rows()
			AddElement(*this\expRows()):*this\expRows()=*row
			If *row\dirty
				*row\calcheight=DesktopScaledY(*row\height)
				*row\calcwidth=w
				*row\dirty=#False
			EndIf
			If *row\expanded
				_MyTableRecalcExp(*row,w)
			EndIf
			*this\expheight+*row\calcheight
		Next
	EndProcedure
	
	Procedure _MyTableClearMaps(*this.strMyTableTable)
		If *this
			ForEach *this\selected()
				If Not *this\selected()
					DeleteMapElement(*this\selected())
				EndIf
			Next
			
			CompilerIf Defined(MYTABLE_FORMULA,#PB_Module)
				ForEach *this\formulaCells()
					If Not *this\formulaCells()
						DeleteMapElement(*this\formulaCells())
					EndIf
				Next
			CompilerEndIf
		EndIf		
	EndProcedure
	
	
	
	Procedure.b _MyTableSort(*this.strMyTableTable,col.i)
		Protected result.b=#False
		If *this
			ForEach *this\cols()
				If ListIndex(*this\cols())<>col
					*this\cols()\sort=0
				EndIf
			Next
			Protected *col.strMyTableCol=SelectElement(*this\cols(),col)
			Protected sortable.b=Bool(Bool(*this\flags & #MYTABLE_TABLE_FLAGS_SORTABLE) Or Bool(*col\flags & #MYTABLE_COLUMN_FLAGS_SORTABLE))
			If sortable 
				_callcountStart(sort)
				result=#True
				Protected bdsort.b=Bool(Bool(*col\flags & #MYTABLE_COLUMN_FLAGS_BOOLEAN) Or 
				                        Bool(*col\flags & #MYTABLE_COLUMN_FLAGS_DEFAULT_DATE_TIME) Or 
				                        Bool(*col\flags & #MYTABLE_COLUMN_FLAGS_INTEGER) Or 
				                        Bool(*col\flags & #MYTABLE_COLUMN_FLAGS_DOUBLE))
				ForEach *this\rows()
					Protected *row.strMyTableRow=*this\rows()
					Protected *cell.strMyTableCell=_MyTableGetOrAddCell(*row,col)
					If bdsort
						*row\dsort=*cell\value
					Else
						*row\sort=*cell\text
					EndIf
				Next
				Select *col\sort
					Case -1
						*col\sort=0				
						SortStructuredList(*this\rows(),#PB_Sort_Ascending,OffsetOf(strMyTableRow\id),TypeOf(strMyTableRow\id))				
					Case 0
						*col\sort=1
						If bdsort
							SortStructuredList(*this\rows(),#PB_Sort_Ascending,OffsetOf(strMyTableRow\dsort),TypeOf(strMyTableRow\dsort))
						Else
							SortStructuredList(*this\rows(),#PB_Sort_Ascending,OffsetOf(strMyTableRow\sort),TypeOf(strMyTableRow\sort))
						EndIf
					Case 1
						*col\sort=-1
						If bdsort
							SortStructuredList(*this\rows(),#PB_Sort_Descending,OffsetOf(strMyTableRow\dsort),TypeOf(strMyTableRow\dsort))
						Else
							SortStructuredList(*this\rows(),#PB_Sort_Descending,OffsetOf(strMyTableRow\sort),TypeOf(strMyTableRow\sort))
						EndIf
				EndSelect
				_callcountEnde(sort)
			EndIf
		EndIf
		ProcedureReturn result
	EndProcedure
	
	Procedure _MyTableResize(*this.strMyTableTable)
		If *this
			With *this
				Protected w=GadgetWidth(\canvas)
				Protected h=GadgetHeight(\canvas)
				If w<>\lastw Or h<>\lasth Or \dirty
					_callcountStart(resize)
					\lasth=h
					\lastw=w
					ResizeGadget(\vscroll,
					             \lastw-GadgetWidth(\vscroll),
					             #PB_Ignore,
					             #PB_Ignore,
					             \lasth-GadgetHeight(\hscroll))
					
					ResizeGadget(\hscroll,
					             #PB_Ignore,
					             \lasth-GadgetHeight(\hscroll),
					             \lastw-GadgetWidth(\vscroll),
					             #PB_Ignore)
					\dirty=#True
					_callcountEnde(resize)
					_MyTable_Table_Recalc(*this)
				EndIf
			EndWith
		EndIf
	EndProcedure
	
	Procedure _MyTableAddDirtyRow(*this.strMyTableTable,*row.strMyTableRow)
		*row\vtable=?vtable_row
		*row\dirty=#True
		*row\table=*this
		*this\lastRowid+1
		*row\id=*this\lastRowid	
		*row\type=#MYTABLE_TYPE_ROW
		*row\height=*this\rowheight
	EndProcedure
	
	Procedure _MyTableGetOrAddCell(*row.strMyTableRow,col.i=-1,force.b=#False)
		Protected *this.strMyTableTable=*row\table
		Protected *cell.strMyTableCell=0
		Protected bgrid.b=Bool(*this\datagrid And Not force)
		If col=-1
			LastElement(*row\cells())
			col=ListSize(*row\cells())
			*cell=AddElement(*row\cells())
			*cell\row=*row
			*cell\table=*this
			*cell\type=#MYTABLE_TYPE_CELL
			*cell\col=SelectElement(*this\cols(),col)
			*cell\vtable=?vtable_cell
		Else
			col+bgrid
			If col<ListSize(*this\cols())
				While col>=ListSize(*row\cells())
					*cell=_MyTableGetOrAddCell(*row,-1)
				Wend
				If Not *cell
					*cell=SelectElement(*row\cells(),col)
					If *cell=0
						ProcedureReturn _MyTableGetOrAddCell(*row,-1)
					EndIf
				EndIf
			EndIf
		EndIf
		ProcedureReturn *cell
	EndProcedure
	
	Procedure MyTableEvtResize()
		Protected *this.strMyTableTable=GetGadgetData(EventGadget())
		If *this
			*this\dirty=#True
			_MyTableResize(*this)
		EndIf
	EndProcedure
	
	Procedure MyTableEvtDialogResize()
		Protected *this.strMyTableTable=GetGadgetData(EventGadget())
		If *this
			With *this
				Protected w=GadgetWidth(\canvas)
				Protected h=GadgetHeight(\canvas)
				If w<>\lastw Or h<>\lasth Or \dirty				
					\lasth=h
					\lastw=w
					\dirty=#True
					_MyTable_Table_Recalc(*this)
				EndIf
			EndWith
		EndIf
	EndProcedure
	
	
	Procedure MyTableEvtScroll()
		Protected *this.strMyTableTable=GetGadgetData(EventGadget())
		If *this
			*this\dirty=#True
			_MyTable_Table_Redraw(*this)
		EndIf
	EndProcedure
	
	Procedure MyTableEvtReturn()
		Protected *cell.strMyTableCell=GetGadgetData(GetActiveGadget())
		If *cell And *cell\type=#MYTABLE_TYPE_CELL
			_MyTableStopEditCell(*cell\table)
		EndIf
	EndProcedure
	
	Procedure MyTableEvtEsc()
		Protected *cell.strMyTableCell=GetGadgetData(GetActiveGadget())
		If *cell And *cell\type=#MYTABLE_TYPE_CELL
			_MyTableStopEditCell(*cell\table)
		EndIf
	EndProcedure
	
	Procedure MyTableEvtMouseUp()
		Protected *this.strMyTableTable=GetGadgetData(EventGadget())
		If *this
			*this\resizecol=#False
			*this\resizerow=#False
			*this\oldx=0
			*this\oldy=0
			*this\colResize=0
			*this\rowResize=0
			*this\lastcell=0
			*this\lastrow=0
			*this\lastcol=0
			If MapSize(*this\tempselected())>0
				ForEach *this\tempselected()
					*this\selected(MapKey(*this\tempselected()))=*this\tempselected()
				Next
				ClearMap(*this\tempselected())
				*this\dirty=#True
				_MyTable_Table_Redraw(*this)
			EndIf
			ClearMap(*this\tempselected())
		EndIf
	EndProcedure
	
	Procedure MyTableEvtKeyDown()
		Protected *this.strMyTableTable=GetGadgetData(EventGadget())
		If *this
			Protected fullrowselect.b=Bool(*this\flags & #MYTABLE_TABLE_FLAGS_FULL_ROW_SELECT Or ListSize(*this\cols())=1)
			Protected multiselect.b=Bool(*this\flags & #MYTABLE_TABLE_FLAGS_MULTISELECT)
			Protected checkboxes.b=Bool(*this\flags & #MYTABLE_TABLE_FLAGS_CHECKBOX)
			Protected hierarchical.b=Bool(Bool(*this\flags & #MYTABLE_TABLE_FLAGS_HIERARCHICAL) Or Bool(*this\flags & #MYTABLE_TABLE_FLAGS_HIERARCHICAL_ARROW))		
			Protected control.b=Bool(GetGadgetAttribute(*this\canvas,#PB_Canvas_Modifiers) & #PB_Canvas_Control)
			Protected shift.b=Bool(GetGadgetAttribute(*this\canvas,#PB_Canvas_Modifiers) & #PB_Canvas_Shift)		
			Protected redraw.b=#False
			Protected recalc.b=#False
			Protected *row.strMyTableRow=0
			Protected *cell.strMyTableCell=0
			Protected *col.strMyTableCol=0
			Protected *obj._strMyTableAObject=0
			Protected listidx=-1,colidx=-1
			Protected NewList selected.i()
			
			Select GetGadgetAttribute(*this\canvas,#PB_Canvas_Key)
					CompilerIf Defined(MYTABLE_FORMULA,#PB_Module)
					Case #PB_Shortcut_0
						If shift
							_MyTableClearMaps(*this)
							If Not fullrowselect
								ForEach *this\selected()
									*cell=Val(MapKey(*this\selected()))
									_MyTableEditCell(*cell,"=")
									
									Break
								Next
							EndIf
						EndIf
					Case #PB_Shortcut_Return,#PB_Shortcut_F2,#PB_Shortcut_Execute	
					CompilerElse
					Case #PB_Shortcut_Return,#PB_Shortcut_F2
					CompilerEndIf
					_MyTableClearMaps(*this)
					If Not fullrowselect
						ForEach *this\selected()
							*cell=Val(MapKey(*this\selected()))
							_MyTableEditCell(*cell)
							
							Break
						Next
					EndIf
					
					
				Case #PB_Shortcut_Multiply
					If hierarchical And fullrowselect
						_MyTableClearMaps(*this)
						ForEach *this\selected()
							If *this\selected()
								*row=Val(MapKey(*this\selected()))
								_MyTableRowExpand(*row,#True)						
							EndIf
						Next
						recalc=#True
					EndIf
				Case #PB_Shortcut_Divide
					If hierarchical And fullrowselect
						_MyTableClearMaps(*this)
						ForEach *this\selected()
							If *this\selected()
								*row=Val(MapKey(*this\selected()))
								_MyTableRowExpand(*row,#False)						
							EndIf
						Next
						recalc=#True
					EndIf
				Case #PB_Shortcut_Add
					If hierarchical And fullrowselect
						_MyTableClearMaps(*this)
						ForEach *this\selected()
							If *this\selected()
								*row=Val(MapKey(*this\selected()))
								*row\expanded=#True							
							EndIf
						Next
						recalc=#True
					EndIf
				Case #PB_Shortcut_Subtract
					If hierarchical And fullrowselect
						_MyTableClearMaps(*this)
						ForEach *this\selected()
							If *this\selected()
								*row=Val(MapKey(*this\selected()))
								*row\expanded=#False
							EndIf
						Next
						recalc=#True
					EndIf
				Case #PB_Shortcut_Space
					If checkboxes And fullrowselect
						_MyTableClearMaps(*this)
						ForEach *this\selected()
							If *this\selected()
								*row=Val(MapKey(*this\selected()))
								*row\checked=Bool(*row\checked=#False)
							EndIf
						Next
						redraw=#True
					EndIf				
				Case #PB_Shortcut_Left
					_MyTableClearMaps(*this)
					If ListSize(*this\expRows())>0
						If MapSize(*this\selected())>0
							If Not fullrowselect
								ForEach *this\selected()
									listidx=-1
									*obj=Val(MapKey(*this\selected()))
									If *obj\type=#MYTABLE_TYPE_ROW
										*row=*obj
									Else
										*cell=*obj
										*row=*cell\row
									EndIf
									ForEach *row\cells()
										If *row\cells()=*cell
											listidx=ListIndex(*row\cells())
											Break
										EndIf
									Next
									listidx-1
									If *this\datagrid And listidx<=0
										AddElement(selected())
										selected()=*row			
									Else
										If listidx>-1				
											*cell=_MyTableGetOrAddCell(*row,listidx,#True)
											AddElement(selected())
											selected()=*cell
										Else
											*cell=_MyTableGetOrAddCell(*row,0,#True)
											AddElement(selected())
											selected()=*cell
										EndIf
									EndIf
								Next
								ClearMap(*this\selected())
								ForEach selected()
									*obj=selected()
									*this\selected(Str(*obj))=#True
									If *this\evtCellSelect And *obj\type=#MYTABLE_TYPE_CELL
										*this\evtCellSelect(*obj)
									EndIf
									If *this\evtRowSelect And *obj\type=#MYTABLE_TYPE_ROW
										*this\evtRowSelect(*obj)
									EndIf
								Next
								redraw=#True
							EndIf
						Else
							If Not fullrowselect						
								SelectElement(*this\expRows(),0)
								*row=*this\expRows()
								*cell=_MyTableGetOrAddCell(*row,ListSize(*row\cells())-1,#True)
								*this\selected(Str(*cell))=#True
								If *this\evtCellSelect
									*this\evtCellSelect(*cell)
								EndIf
								redraw=#True
							EndIf
						EndIf					
					EndIf
				Case #PB_Shortcut_Right
					_MyTableClearMaps(*this)
					If ListSize(*this\expRows())>0
						If MapSize(*this\selected())>0
							If Not fullrowselect
								ForEach *this\selected()
									listidx=-1
									*obj=Val(MapKey(*this\selected()))
									If *obj\type=#MYTABLE_TYPE_ROW
										*row=*obj
									Else
										*cell=*obj
										*row=*cell\row
									EndIf
									ForEach *row\cells()
										If *row\cells()=*cell
											listidx=ListIndex(*row\cells())
											Break
										EndIf
									Next
									If *this\datagrid And listidx=-1
										listidx+1
									EndIf
									listidx+1
									If listidx<ListSize(*row\cells())									
										*cell=_MyTableGetOrAddCell(*row,listidx,#True)
									EndIf
									AddElement(selected())
									selected()=*cell
								Next
								ClearMap(*this\selected())
								ForEach selected()
									*obj=selected()
									*this\selected(Str(*obj))=#True
									If *this\evtCellSelect And *obj\type=#MYTABLE_TYPE_CELL
										*this\evtCellSelect(*obj)
									EndIf
									If *this\evtRowSelect And *obj\type=#MYTABLE_TYPE_ROW
										*this\evtRowSelect(*obj)
									EndIf
								Next
								redraw=#True
							EndIf
						Else
							If Not fullrowselect
								SelectElement(*this\expRows(),0)
								*obj=*this\expRows()
								*this\selected(Str(*obj))=#True
								If *this\evtCellSelect And *obj\type=#MYTABLE_TYPE_CELL
									*this\evtCellSelect(*obj)
								EndIf
								If *this\evtRowSelect And *obj\type=#MYTABLE_TYPE_ROW
									*this\evtRowSelect(*obj)
								EndIf
								redraw=#True
							EndIf
						EndIf
						
					EndIf
				Case #PB_Shortcut_Up
					_MyTableClearMaps(*this)
					If ListSize(*this\expRows())>0
						If MapSize(*this\selected())>0
							
							ForEach *this\selected()
								*obj=Val(MapKey(*this\selected()))
								If *obj\type=#MYTABLE_TYPE_ROW
									*row=*obj
									listidx=-1
									ForEach *this\expRows()
										If *this\expRows()=*row
											listidx=ListIndex(*this\expRows())
											Break
										EndIf
									Next
									listidx-1
									If listidx>-1
										SelectElement(*this\expRows(),listidx)									
										*row=*this\expRows()
									EndIf
									AddElement(selected())								
									selected()=*row
								Else
									*cell=*obj
									*row=*cell\row
									
									listidx=-1
									colidx=-1
									ForEach *row\cells()
										If *row\cells()=*cell
											colidx=ListIndex(*row\cells())
											Break
										EndIf
									Next
									ForEach *this\expRows()
										If *this\expRows()=*row
											listidx=ListIndex(*this\expRows())
											Break
										EndIf
									Next
									listidx-1
									If listidx>-1
										SelectElement(*this\expRows(),listidx)
										*row=*this\expRows()
										*cell=_MyTableGetOrAddCell(*row,colidx,#True)
									EndIf								
									AddElement(selected())
									selected()=*cell
								EndIf
							Next
							ClearMap(*this\selected())
							ForEach selected()
								*obj=selected()
								*this\selected(Str(*obj))=#True
								If *this\evtCellSelect And *obj\type=#MYTABLE_TYPE_CELL
									*this\evtCellSelect(*obj)
								EndIf
								If *this\evtRowSelect And *obj\type=#MYTABLE_TYPE_ROW
									*this\evtRowSelect(*obj)
								EndIf
							Next
							redraw=#True
							
						Else
							If fullrowselect
								SelectElement(*this\expRows(),ListSize(*this\expRows())-1)
								*row=*this\expRows()
								*this\selected(Str(*row))=#True
								If *this\evtRowSelect
									*this\evtRowSelect(*row)
								EndIf
								redraw=#True
							Else
								SelectElement(*this\expRows(),ListSize(*this\expRows())-1)
								*row=*this\expRows()
								*cell=_MyTableGetOrAddCell(*row,0,#True)
								*this\selected(Str(*cell))=#True
								If *this\evtCellSelect
									*this\evtCellSelect(*cell)
								EndIf
								redraw=#True
							EndIf
						EndIf
						
					EndIf
				Case #PB_Shortcut_Down
					_MyTableClearMaps(*this)
					If ListSize(*this\expRows())>0
						If MapSize(*this\selected())>0
							
							ForEach *this\selected()
								*obj=Val(MapKey(*this\selected()))
								If *obj\type=#MYTABLE_TYPE_ROW
									*row=*obj
									listidx=-1
									ForEach *this\expRows()
										If *this\expRows()=*row
											listidx=ListIndex(*this\expRows())
											Break
										EndIf
									Next
									listidx+1
									If listidx<ListSize(*this\expRows())
										SelectElement(*this\expRows(),listidx)									
										*row=*this\expRows()
									EndIf
									AddElement(selected())
									selected()=*row
								Else
									*cell=*obj
									*row=*cell\row
									
									listidx=-1
									colidx=-1
									ForEach *row\cells()
										If *row\cells()=*cell
											colidx=ListIndex(*row\cells())
											Break
										EndIf
									Next
									ForEach *this\expRows()
										If *this\expRows()=*row
											listidx=ListIndex(*this\expRows())
											Break
										EndIf
									Next
									listidx+1
									If listidx<ListSize(*this\expRows())
										SelectElement(*this\expRows(),listidx)
										*row=*this\expRows()
										*cell=_MyTableGetOrAddCell(*row,colidx,#True)
									EndIf								
									AddElement(selected())
									selected()=*cell
								EndIf
							Next
							ClearMap(*this\selected())
							ForEach selected()
								*obj=selected()
								*this\selected(Str(*obj))=#True
								If *this\evtCellSelect And *obj\type=#MYTABLE_TYPE_CELL
									*this\evtCellSelect(*obj)
								EndIf
								If *this\evtRowSelect And *obj\type=#MYTABLE_TYPE_ROW
									*this\evtRowSelect(*obj)
								EndIf
							Next
							redraw=#True
							
						Else
							If fullrowselect
								SelectElement(*this\expRows(),0)
								*row=*this\expRows()
								*this\selected(Str(*row))=#True
								If *this\evtRowSelect
									*this\evtRowSelect(*row)
								EndIf
								redraw=#True
							Else
								SelectElement(*this\expRows(),0)
								*row=*this\expRows()
								*cell=_MyTableGetOrAddCell(*row,0,#True)
								*this\selected(Str(*cell))=#True
								If *this\evtCellSelect
									*this\evtCellSelect(*cell)
								EndIf
								redraw=#True
							EndIf
						EndIf					
					EndIf
			EndSelect
			If recalc
				*this\dirty=#True
				_MyTable_Table_Recalc(*this)
			ElseIf redraw
				*this\dirty=#True
				_MyTable_Table_Redraw(*this)
			EndIf
		EndIf
		FreeList(selected())
	EndProcedure
	
	Procedure MyTableEvtMouseMove()
		Protected *this.strMyTableTable=GetGadgetData(EventGadget())
		If *this
			Protected mx=GetGadgetAttribute(*this\canvas,#PB_Canvas_MouseX)+GetGadgetState(*this\hscroll)
			Protected my=GetGadgetAttribute(*this\canvas,#PB_Canvas_MouseY)
			Protected noheader.b=Bool(*this\flags & #MYTABLE_TABLE_FLAGS_NO_HEADER)
			Protected resizerow.b=Bool(*this\flags & #MYTABLE_TABLE_FLAGS_ROW_RESIZEABLE)
			Protected resizecol.b=Bool(*this\flags & #MYTABLE_TABLE_FLAGS_COL_RESIZEABLE)
			Protected fullrow.b=Bool(*this\flags & #MYTABLE_TABLE_FLAGS_FULL_ROW_SELECT Or ListSize(*this\cols())=1)
			Protected leftbutton.b=Bool(GetGadgetAttribute(*this\canvas,#PB_Canvas_Buttons) & #PB_Canvas_LeftButton)
			Protected rightbutton.b=Bool(GetGadgetAttribute(*this\canvas,#PB_Canvas_Buttons) & #PB_Canvas_RightButton)
			Protected multiselect.b=Bool(*this\flags & #MYTABLE_TABLE_FLAGS_MULTISELECT)
			
			Protected idx=0
			Protected hh=0
			
			Protected *row.strMyTableRow=0
			Protected *col.strMyTableCol=0
			Protected *cell.strMyTableCell=0
			
			Protected col=-1
			Protected row=-1
			
			Protected h=DesktopScaledY(GadgetHeight(*this\canvas))
			
			GadgetToolTip(*this\canvas,"")
			
			
			Protected *rowcol.strMyTableRowCol=_MyTableGetRowCol(*this,#False,#False,#True)
			
			If multiselect And *rowcol And leftbutton
				If (fullrow Or (*this\datagrid And *rowcol\col=0)) And *this\lastrow And *rowcol\row>-1
					*row=SelectElement(*this\rows(),*rowcol\row)
					If *row<>*this\lastrow
						_MyTableSelectRow(*row,#False,#True,multiselect,#True)
						*this\dirty=#True
						_MyTable_Table_Redraw(*this)
					EndIf
				EndIf
				
				If *this\lastcol And *rowcol\col>-1
					*col=SelectElement(*this\cols(),*rowcol\col)
					If *col<>*this\lastcol
						_MyTableSelectCol(*col,#False,#True,multiselect,#True)
						*this\dirty=#True
						_MyTable_Table_Redraw(*this)
					EndIf
				EndIf
				
				If *this\lastcell And *rowcol\col>-1 And *rowcol\row>-1
					*row=SelectElement(*this\rows(),*rowcol\row)
					*cell=SelectElement(*row\cells(),*rowcol\col)
					If *cell<>*this\lastcell
						_MyTableSelectCell(*cell,#False,#True,multiselect,#True)
						*this\dirty=#True
						_MyTable_Table_Redraw(*this)
					EndIf
				EndIf
				
				*row=0
				*col=0
				*cell=0
			EndIf
			
			If *this\resizecol
				Protected newx=GetGadgetAttribute(*this\canvas,#PB_Canvas_MouseX)-*this\oldx
				SetGadgetAttribute(*this\canvas,#PB_Canvas_Cursor,#PB_Cursor_LeftRight)
				*this\colResize\width+DesktopUnscaledX(newx)
				If *this\colResize\width<0
					*this\colResize\width=0
				EndIf
				*this\colResize\dirty=#True
				*this\oldx=GetGadgetAttribute(*this\canvas,#PB_Canvas_MouseX)
				*this\dirty=#True
				_MyTable_Table_Recalc(*this)    					
			EndIf
			
			If *this\resizerow
				Protected newy=GetGadgetAttribute(*this\canvas,#PB_Canvas_MouseY)-*this\oldy
				SetGadgetAttribute(*this\canvas,#PB_Canvas_Cursor,#PB_Cursor_UpDown)
				*this\rowResize\height+DesktopUnscaledY(newy)
				If *this\rowResize\height<0
					*this\rowResize\height=0
				EndIf
				*this\rowResize\dirty=#True
				*this\oldy=GetGadgetAttribute(*this\canvas,#PB_Canvas_MouseY)
				*this\dirty=#True
				_MyTable_Table_Recalc(*this)    					
			EndIf
			
			If *rowcol
				row=*rowcol\row
				col=*rowcol\col
				
				If row=-1 And col>0
					*col=SelectElement(*this\cols(),col)
					GadgetToolTip(*this\canvas,*col\tooltip)
				ElseIf row>-1
					SelectElement(*this\expRows(),row)
					*row=*this\expRows()
					If fullrow
						GadgetToolTip(*this\canvas,*row\tooltip)
					Else
						If col>-1
							*cell=_MyTableGetOrAddCell(*row,col)
							If *cell
								GadgetToolTip(*this\canvas,*cell\tooltip)
							EndIf
						EndIf
					EndIf
				EndIf
				
			EndIf
			
			If *rowcol
				FreeStructure(*rowcol)
			EndIf
		EndIf
	EndProcedure
	
	Procedure MyTableEvtMouseDown()
		Protected *this.strMyTableTable=GetGadgetData(EventGadget())
		If *this
			
			*this\lastcell=0
			*this\lastrow=0
			*this\lastcol=0
			ClearMap(*this\tempselected())
			
			
			Protected noheader.b=Bool(*this\flags & #MYTABLE_TABLE_FLAGS_NO_HEADER)
			Protected fullrow.b=Bool(*this\flags & #MYTABLE_TABLE_FLAGS_FULL_ROW_SELECT Or ListSize(*this\cols())=1)
			Protected checkboxes.b=Bool(*this\flags & #MYTABLE_TABLE_FLAGS_CHECKBOX)
			Protected hierarchical.b=Bool(Bool(*this\flags & #MYTABLE_TABLE_FLAGS_HIERARCHICAL) Or Bool(*this\flags & #MYTABLE_TABLE_FLAGS_HIERARCHICAL_ARROW))
			Protected multiselect.b=Bool(*this\flags & #MYTABLE_TABLE_FLAGS_MULTISELECT)
			Protected colresizeable.b=Bool(*this\flags & #MYTABLE_TABLE_FLAGS_COL_RESIZEABLE)
			Protected rowresizeable.b=Bool(*this\flags & #MYTABLE_TABLE_FLAGS_ROW_RESIZEABLE)
			
			
			Protected mx=GetGadgetAttribute(*this\canvas,#PB_Canvas_MouseX)+GetGadgetState(*this\hscroll)
			Protected my=GetGadgetAttribute(*this\canvas,#PB_Canvas_MouseY)
			Protected ms=GetGadgetAttribute(*this\canvas,#PB_Canvas_WheelDelta)
			Protected control.b=Bool(GetGadgetAttribute(*this\canvas,#PB_Canvas_Modifiers) & #PB_Canvas_Control)
			Protected shift.b=Bool(GetGadgetAttribute(*this\canvas,#PB_Canvas_Modifiers) & #PB_Canvas_Shift)
			
			Protected leftbutton.b=Bool(GetGadgetAttribute(*this\canvas,#PB_Canvas_Buttons) & #PB_Canvas_LeftButton)
			Protected rightbutton.b=Bool(GetGadgetAttribute(*this\canvas,#PB_Canvas_Buttons) & #PB_Canvas_RightButton)
			
			Protected h=DesktopScaledY(GadgetHeight(*this\canvas))
			
			Protected *cell.strMyTableCell=0
			Protected *col.strMyTableCol=0
			Protected *row.strMyTableRow=0
			
			Protected recalc.b=#False
			Protected redraw.b=#True
			
			If ms
				SetGadgetState(*this\vscroll,GetGadgetState(*this\vscroll)-ms)
				*this\dirty=#True
			Else
				
				
				Protected hh=0
				Protected idx=0
				Protected cc=ListSize(*this\expRows()) 
				
				Protected *rowcol.strMyTableRowCol=_MyTableGetRowCol(*this,#True,#False,#False)
				If *rowcol
					Protected row=*rowcol\row
					Protected col=*rowcol\col
					
					
					If col>-1 And row<cc And col<ListSize(*this\cols())
						*col=SelectElement(*this\cols(),col)
						Protected sortable.b=Bool(Bool(*this\flags & #MYTABLE_TABLE_FLAGS_SORTABLE) Or Bool(*col\flags & #MYTABLE_COLUMN_FLAGS_SORTABLE))
						If col=0 And (checkboxes Or hierarchical) And row>-1
							mx=GetGadgetAttribute(*this\canvas,#PB_Canvas_MouseX)+GetGadgetState(*this\hscroll)
							
							SelectElement(*this\expRows(),row)
							*row=*this\expRows()
							
							Protected lv=MyTablew20 * *row\level
							Select  mx
								Case MyTablew20+lv To (MyTablew20*2)+lv
									If hierarchical And checkboxes
										*row\checked=Bool(*row\checked=#False)
										*this\dirty=#True
										If *this\evtRowChecked
											*this\evtRowChecked(*row)
										EndIf
									EndIf
								Case 0+lv To MyTablew20+lv
									If hierarchical And checkboxes
										*row\expanded=Bool(*row\expanded=#False)
										recalc=#True
										*this\dirty=#True
									ElseIf hierarchical
										*row\expanded=Bool(*row\expanded=#False)
										recalc=#True
										*this\dirty=#True
									ElseIf checkboxes
										*row\checked=Bool(*row\checked=#False)
										*this\dirty=#True
										If *this\evtRowChecked
											*this\evtRowChecked(*row)
										EndIf
									EndIf
								Default
									
									If row=-1 And Not noheader								
										If leftbutton
											If sortable									
												If _MyTableSort(*this,col)
													recalc=#True
												EndIf
											ElseIf *this\datagrid										
												_MyTableSelectCol(*col,control,shift,multiselect,#False)
											EndIf
										EndIf
										If rightbutton 
											If *this\evtColRightClick
												*col=SelectElement(*this\cols(),col)
												If *this\evtColRightClick(*col)									
													recalc=#True
												EndIf
											Else
												redraw=#False
											EndIf
										EndIf
									ElseIf row>-1
										SelectElement(*this\expRows(),row)
										*row=*this\expRows()
										If fullrow									
											_MyTableSelectRow(*row,control,shift,multiselect,#False)
											
											If rightbutton And *this\evtRowRightClick
												*this\evtRowRightClick(*row)
											EndIf
											
										Else
											*cell=_MyTableGetOrAddCell(*row,col,#True)
											_MyTableSelectCell(*cell,control,shift,multiselect,#False)
											
											If rightbutton And *this\evtCellRightClick
												*this\evtCellRightClick(*cell)
											EndIf
											
										EndIf
									EndIf
									*this\dirty=#True
							EndSelect					
						Else
							
							If row=-1 And Not noheader
								If leftbutton
									If sortable									
										If _MyTableSort(*this,col)
											recalc=#True
										EndIf
									ElseIf *this\datagrid																
										_MyTableSelectCol(*col,control,shift,multiselect,#False)
									EndIf
								EndIf
								If rightbutton 
									If *this\evtColRightClick
										*col=SelectElement(*this\cols(),col)
										If *this\evtColRightClick(*col)									
											recalc=#True
										EndIf
									Else
										redraw=#False
									EndIf
								EndIf	
							ElseIf row>-1
								SelectElement(*this\expRows(),row)
								*row=*this\expRows()
								If fullrow							
									_MyTableSelectRow(*row,control,shift,multiselect,#False)
									
									If rightbutton And *this\evtRowRightClick
										*this\evtRowRightClick(*row)
									EndIf
									
								Else
									If *this\datagrid And col=0								
										_MyTableSelectRow(*row,control,shift,multiselect,#False)
										
										If rightbutton And *this\evtRowRightClick
											*this\evtRowRightClick(*row)
										EndIf
									Else
										*cell=_MyTableGetOrAddCell(*row,col,#True)
										_MyTableSelectCell(*cell,control,shift,multiselect,#False)
										
										If rightbutton And *this\evtCellRightClick
											*this\evtCellRightClick(*cell)
										EndIf
									EndIf
								EndIf
							EndIf
							*this\dirty=#True
						EndIf
					Else
						If (Not control And Not shift) Or Not multiselect
							ClearMap(*this\selected())
						EndIf
						*this\dirty=#True
					EndIf
					FreeStructure(*rowcol)
				EndIf
			EndIf
			
			If recalc
				_MyTable_Table_Recalc(*this)
			ElseIf redraw
				_MyTable_Table_Redraw(*this)
			EndIf
		EndIf
	EndProcedure
	
	Procedure MyTableEvtLostFocus()
		Protected *this._strMyTableAObject=GetGadgetData(EventGadget())
		If *this
			Select *this\type
				Case #MYTABLE_TYPE_TABLE
					_MyTableStopEditCell(*this)
				Case #MYTABLE_TYPE_CELL
					Protected *cell.strMyTableCell=*this
					_MyTableStopEditCell(*cell\table)
			EndSelect
		EndIf
	EndProcedure
	
	Procedure MyTableEvtDouble()
		Protected *this.strMyTableTable=GetGadgetData(EventGadget())
		If *this
			Protected noheader.b=Bool(*this\flags & #MYTABLE_TABLE_FLAGS_NO_HEADER)
			Protected fullrow.b=Bool(*this\flags & #MYTABLE_TABLE_FLAGS_FULL_ROW_SELECT Or ListSize(*this\cols())=1)
			Protected checkboxes.b=Bool(*this\flags & #MYTABLE_TABLE_FLAGS_CHECKBOX)
			Protected rowresizeable.b=Bool(*this\flags & #MYTABLE_TABLE_FLAGS_ROW_RESIZEABLE)
			Protected colresizeable.b=Bool(*this\flags & #MYTABLE_TABLE_FLAGS_COL_RESIZEABLE)
			Protected hierarchical.b=Bool(Bool(*this\flags & #MYTABLE_TABLE_FLAGS_HIERARCHICAL) Or Bool(*this\flags & #MYTABLE_TABLE_FLAGS_HIERARCHICAL_ARROW))
			
			Protected mx=GetGadgetAttribute(*this\canvas,#PB_Canvas_MouseX)+GetGadgetState(*this\hscroll)
			Protected my=GetGadgetAttribute(*this\canvas,#PB_Canvas_MouseY)
			Protected *row.strMyTableRow=0
			Protected h=DesktopScaledX(GadgetHeight(*this\canvas))
			
			Protected row=0
			Protected hh=0
			Protected idx=0
			Protected cc=ListSize(*this\expRows()) 
			
			If Not noheader
				If my<DesktopScaledY(*this\headerheight)
					row-1
				EndIf
				hh+DesktopScaledY(*this\headerheight)
			EndIf
			
			If row=0
				For idx=GetGadgetState(*this\vscroll) To (cc-1)
					SelectElement(*this\expRows(),idx)
					*row=*this\expRows()					
					hh+*row\calcheight
					If rowresizeable
						If (hh+mytableh2)>=my And (hh-mytableh2)<=my						
							_MyTable_Table_AutosizeRow(*this,idx)
							ProcedureReturn #False
						EndIf
					EndIf
					
					If hh>my
						row=idx
						Break
					EndIf
					
					If hh>h
						Break
					EndIf
				Next
			EndIf
			
			Protected col=0
			ForEach *this\cols()
				mx-*this\cols()\calcwidth
				If mx>=-MyTableW2 And mx<=MyTableW2
					If Bool(*this\cols()\flags & #MYTABLE_COLUMN_FLAGS_RESIZEABLE) Or colresizeable
						_MyTable_Table_AutosizeCol(*this,col)
						ProcedureReturn #False
					EndIf							
				ElseIf mx<=0
					Break
				Else
					col+1
				EndIf
			Next			
			
			If row<ListSize(*this\expRows()) And col<ListSize(*this\cols())
				If row>-1
					SelectElement(*this\expRows(),row)		
					*row=*this\expRows()
					Protected *cell.strMyTableCell=_MyTableGetOrAddCell(*row,col,#True)
					_MyTableEditCell(*cell)				
				EndIf
			EndIf					
			
		EndIf
	EndProcedure
	
	Procedure.s _MyTableGridColumnName(col.i)
		Protected ac=Asc("A")
		Protected result.s=""	
		While col > 0
			Protected ic = col % 26
			If ic = 0
				result + "Z"
				col = (col / 26) - 1
			Else
				result + Chr(ac+(ic-1))
				col = col / 26
			EndIf
		Wend
		
		ProcedureReturn result
	EndProcedure
	
	Procedure _MyTableGridRegister(*application.strMyTableApplication,window,canvas,hscroll,vscroll,rows,cols,flags.i=#MYTABLE_TABLE_FLAGS_GRID_DEFAULT,callback.MyTableProtoEventCallback=0,name.s="")
		Protected *this.strMyTableTable=_MyTableRegister(*application,window,canvas,hscroll,vscroll,flags,callback,name)
		If *this
			_callcountStart(GridRegister)
			*this\fixedcolumns=1
			*this\backgroundfixed=*this\headerbackground1
			*this\headerbackgroundfixed=*this\headerbackground2
			*this\datagrid=#True
			
			Protected redraw.b=*this\redraw
			Protected idx
			*this\redraw=#False
			_MyTable_Table_AddColumn(*this," ",100,#MYTABLE_COLUMN_FLAGS_RIGHT|#MYTABLE_COLUMN_FLAGS_NO_RESIZEABLE|#MYTABLE_COLUMN_FLAGS_NO_EDITABLE|#MYTABLE_COLUMN_FLAGS_INTEGER)
			For idx=1 To cols
				_MyTable_Table_AddColumn(*this,_MyTableGridColumnName(idx),100)
			Next
			
			_MyTable_Table_AddDirtyRows(*this,rows)
			For idx=1 To rows
				Protected *cell.strMyTableCell=_MyTableGetOrAddCell(SelectElement(*this\rows(),idx-1))
				*cell\text=Str(idx)
			Next
			
			
			_callcountEnde(GridRegister)
			
			_MyTable_Table_AutosizeColExp(*this,0,#True)
			*this\redraw=redraw
			
			CompilerIf Defined(MYTABLE_FORMULA,#PB_Module)
				If Bool(flags & #MYTABLE_TABLE_FLAGS_FORMULA)
					_MyTable_InitFormula(*this)
				EndIf
			CompilerEndIf
			
		EndIf
		ProcedureReturn *this
	EndProcedure
	
	Procedure _MyTableRegister(*application.strMyTableApplication,window,canvas,hscroll,vscroll,flags.i=#MYTABLE_TABLE_FLAGS_DEFAULT,callback.MyTableProtoEventCallback=0,name.s="")
		Protected *this.strMyTableTable
		If *application
			*this=AddElement(*application\tables())			
		Else
			*this=AllocateStructure(strMyTableTable)
		EndIf
		With *this
			\vtable=?vtable_table
			\application=*application
			\name=name
			\window=window
			\canvas=canvas
			\hscroll=hscroll
			\vscroll=vscroll
			\flags=flags
			\type=#MYTABLE_TYPE_TABLE
			
			\sortImageAsc=MyTableDefaultImageSortAsc
			\sortImageDesc=MyTableDefaultImageSortDesc
			
			\checkboxImage=MyTableDefaultImageCheckBox
			\checkboxImageChecked=MyTableDefaultImageCheckBoxChecked
			
			\treeImage=MyTableDefaultImageMinus
			\treeImageExpanded=MyTableDefaultImagePlus
			
			If Bool(flags & #MYTABLE_TABLE_FLAGS_HIERARCHICAL_ARROW)
				\flags|#MYTABLE_TABLE_FLAGS_HIERARCHICAL
				\treeImage=MyTableDefaultImagePlusArrow
				\treeImageExpanded=MyTableDefaultImageMinusArrow
			EndIf
			
			\lasth=GadgetHeight(canvas)
			\lastw=GadgetWidth(canvas)
			\dirty=#True
			\redraw=Bool(Not (flags & #MYTABLE_TABLE_FLAGS_STOP_DRAWING))
			\rowheight=20
			\headerheight=20
			
			\selectedbackground=RGBA(200,200,240,255)
			\background=RGBA(250,250,250,255)
			\backgroundfixed=RGBA(255,245,245,255)
			\headerbackground1=RGBA(200,200,200,255)
			\headerbackground2=RGBA(150,150,150,255)
			\headerbackgroundfixed=RGBA(200,150,150,255)
			\forecolor=RGBA(0,0,0,255)
			\headerforecolor=RGBA(240,240,240,255)
			\selectedforecolor=RGBA(240,240,240,255)
			
			\evtCallback=callback
			
			\font=GetGadgetFont(#PB_Default)
			
			\menu=CreatePopupMenu(#PB_Any)
			
			
			
			SetGadgetData(canvas,*this)
			SetGadgetData(hscroll,*this)
			SetGadgetData(vscroll,*this)
			
			BindGadgetEvent(\hscroll,@MyTableEvtScroll())
			BindGadgetEvent(\vscroll,@MyTableEvtScroll())
			BindGadgetEvent(\canvas,@MyTableEvtMouseDown(),#PB_EventType_MouseWheel)
			BindGadgetEvent(\canvas,@MyTableEvtMouseDown(),#PB_EventType_LeftButtonDown)
			BindGadgetEvent(\canvas,@MyTableEvtMouseDown(),#PB_EventType_RightButtonDown)
			BindGadgetEvent(\canvas,@MyTableEvtMouseUp(),#PB_EventType_LeftButtonUp)
			BindGadgetEvent(\canvas,@MyTableEvtMouseMove(),#PB_EventType_MouseMove)
			BindGadgetEvent(\canvas,@MyTableEvtDouble(),#PB_EventType_LeftDoubleClick)
			BindGadgetEvent(\canvas,@MyTableEvtKeyDown(),#PB_EventType_KeyDown)
			
			BindGadgetEvent(\canvas,@MyTableEvtLostFocus(),#PB_EventType_LostFocus)
			
		EndWith
		
		ProcedureReturn *this
	EndProcedure
	
	Procedure MyTableCreateApplication()
		Protected *this.strMyTableApplication=AllocateStructure(strMyTableApplication)
		With *this
			\vtable=?vtable_application
		EndWith
		ProcedureReturn *this
	EndProcedure
	
	Procedure MyTableRegister(window,canvas,hscroll,vscroll,flags.i=#MYTABLE_TABLE_FLAGS_DEFAULT,callback.MyTableProtoEventCallback=0,name.s="")
		Protected *this.strMyTableTable=_MyTableRegister(0,window,canvas,hscroll,vscroll,flags,callback,name)
		BindGadgetEvent(canvas,@MyTableEvtResize(),#PB_EventType_Resize)
		_MyTableResize(*this)
		
		ProcedureReturn *this
	EndProcedure
	
	Procedure MyTableRegisterDialog(window,canvas,hscroll,vscroll,flags.i=#MYTABLE_TABLE_FLAGS_DEFAULT,callback.MyTableProtoEventCallback=0,name.s="")
		Protected *this.strMyTableTable=_MyTableRegister(0,window,canvas,hscroll,vscroll,flags,callback,name)	
		BindGadgetEvent(canvas,@MyTableEvtDialogResize(),#PB_EventType_Resize)
		_MyTable_Table_Recalc(*this)
		ProcedureReturn *this
	EndProcedure
	
	Procedure MyTableGridRegister(window,canvas,hscroll,vscroll,rows.i,cols.i,flags.i=#MYTABLE_TABLE_FLAGS_GRID_DEFAULT,callback.MyTableProtoEventCallback=0,name.s="")
		Protected *this.strMyTableTable=_MyTableGridRegister(0,window,canvas,hscroll,vscroll,rows,cols,flags,callback,name)
		BindGadgetEvent(canvas,@MyTableEvtResize(),#PB_EventType_Resize)
		_MyTableResize(*this)
		ProcedureReturn *this
	EndProcedure
	
	Procedure MyTableGridRegisterDialog(window,canvas,hscroll,vscroll,rows.i,cols.i,flags.i=#MYTABLE_TABLE_FLAGS_GRID_DEFAULT,callback.MyTableProtoEventCallback=0,name.s="")
		Protected *this.strMyTableTable=_MyTableGridRegister(0,window,canvas,hscroll,vscroll,rows,cols,flags,callback,name)	
		BindGadgetEvent(canvas,@MyTableEvtDialogResize(),#PB_EventType_Resize)
		_MyTable_Table_Recalc(*this)
		ProcedureReturn *this
	EndProcedure
	
	
	
	
	
	Procedure MyTableSetTableSortImageAsc(canvas,sortImageAsc.i)
		Protected *this.strMyTableTable=GetGadgetData(canvas)
		If *this
			
			*this\sortImageAsc=sortImageAsc
			*this\dirty=#True
			_MyTable_Table_Redraw(*this)
		EndIf
	EndProcedure
	
	Procedure MyTableSetTableSortImageDesc(canvas,sortImageDesc.i)
		Protected *this.strMyTableTable=GetGadgetData(canvas)
		If *this
			
			*this\sortImageDesc=sortImageDesc
			*this\dirty=#True
			_MyTable_Table_Redraw(*this)
		EndIf
	EndProcedure
	
	Procedure MyTableSetTableCheckboxImage(canvas,checkboxImage.i)
		Protected *this.strMyTableTable=GetGadgetData(canvas)
		If *this
			
			*this\checkboxImage=checkboxImage
			*this\dirty=#True
			_MyTable_Table_Redraw(*this)
		EndIf
	EndProcedure
	
	Procedure MyTableSetTableCheckboxImageChecked(canvas,checkboxImageChecked.i)
		Protected *this.strMyTableTable=GetGadgetData(canvas)
		If *this
			
			*this\checkboxImageChecked=checkboxImageChecked
			*this\dirty=#True
			_MyTable_Table_Redraw(*this)
		EndIf
	EndProcedure
	
	Procedure MyTableSetTableTreeImage(canvas,treeImage.i)
		Protected *this.strMyTableTable=GetGadgetData(canvas)
		If *this
			
			*this\treeImage=treeImage
			*this\dirty=#True
			_MyTable_Table_Redraw(*this)
		EndIf
	EndProcedure
	
	Procedure MyTableSetTableTreeImageExpanded(canvas,treeImageExpanded.i)
		Protected *this.strMyTableTable=GetGadgetData(canvas)
		If *this
			
			*this\treeImageExpanded=treeImageExpanded
			*this\dirty=#True
			_MyTable_Table_Redraw(*this)
		EndIf
	EndProcedure
	
	Procedure MyTableSetTableSelectedRow(canvas,row.i)
		Protected *this.strMyTableTable=GetGadgetData(canvas)
		If *this
			ClearMap(*this\selected())
			If row>-1
				SelectElement(*this\rows(),row)
				*this\selected(Str(*this\rows()))=#True
			EndIf
			*this\dirty=#True
			_MyTable_Table_Redraw(*this)
		EndIf
	EndProcedure
	
	Procedure MyTableSetTableSelectedRowById(canvas,rowid.i)
		Protected *this.strMyTableTable=GetGadgetData(canvas)
		If *this
			ClearMap(*this\selected())
			If rowid>0
				Protected *row.strMyTableRow=*this\rowsById(Str(rowid))			
				*this\selected(Str(*row))=#True
			EndIf
			*this\dirty=#True
			_MyTable_Table_Redraw(*this)
		EndIf
	EndProcedure
	
	Procedure MyTableSetTableSelectedCell(canvas,row.i,col.i)
		Protected *this.strMyTableTable=GetGadgetData(canvas)
		If *this
			ClearMap(*this\selected())
			If row>-1
				SelectElement(*this\rows(),row)
				SelectElement(*this\rows()\cells(),col)
				*this\selected(Str(*this\rows()\cells()))=#True
			EndIf
			*this\dirty=#True
			_MyTable_Table_Redraw(*this)
		EndIf
	EndProcedure
	
	Procedure MyTableGetTableSelectedRow(canvas)
		Protected *this.strMyTableTable=GetGadgetData(canvas)
		If *this
			ForEach *this\selected()
				Protected *o.strMyTableAObject=Val(MapKey(*this\selected()))
				If *o\brow
					Protected *row.strMyTableRow=*o
					ProcedureReturn *row\id
				EndIf
			Next
		EndIf
	EndProcedure
	
	Procedure MyTableGetTableSelectedCell(canvas)
		Protected *this.strMyTableTable=GetGadgetData(canvas)
		If *this
			ForEach *this\selected()
				Protected *o.strMyTableAObject=Val(MapKey(*this\selected()))
				If Not *o\brow
					ProcedureReturn *o
				EndIf
			Next
		EndIf
	EndProcedure
	
	
	
	
	
	
	Procedure MyTableRemoveColumn(canvas,column.i)
		Protected *this.strMyTableTable=GetGadgetData(canvas)
		If *this
			Protected *col.strMyTableCol=SelectElement(*this\cols(),column)
			DeleteMapElement(*this\colsById(),Str(*col\id))
			DeleteElement(*this\cols())
			ForEach *this\rows()
				SelectElement(*this\rows()\cells(),column)
				DeleteElement(*this\rows()\cells())
				*this\rows()\dirty=#True
			Next
			If *this\datagrid
				Protected idx=0
				For idx=2 To ListSize(*this\cols())
					*col=SelectElement(*this\cols(),idx-1)
					*col\text=_MyTableGridColumnName(idx-1)
				Next
			EndIf
			_MyTable_Table_Recalc(*this)
		EndIf
	EndProcedure
	
	
	
	
	
	
	
	
	Procedure MyTableRemoveRow(canvas,row.i)
		Protected *this.strMyTableTable=GetGadgetData(canvas)
		If *this
			SelectElement(*this\rows(),row)
			If IsImage(*this\rows()\sclaedimage)
				FreeImage(*this\rows()\sclaedimage)
			EndIf
			DeleteMapElement(*this\rowsById(),Str(*this\rows()\id))
			DeleteElement(*this\rows())
			*this\dirty=#True
			_MyTable_Table_Recalc(*this)
		EndIf
	EndProcedure
	
	
	
	
	
	
	
	Procedure MyTableExportCSV(canvas,filename.s,sep.s=";",header.b=#True,fieldquote.s="'",linebreak.s=#CRLF$,encode=#PB_UTF8)
		Protected *this.strMyTableTable=GetGadgetData(canvas)
		If *this
			Protected file=CreateFile(#PB_Any,filename,encode)
			If file
				Protected first.b=#True
				If header And ListSize(*this\cols())>0				
					ForEach *this\cols()
						If Not first
							WriteString(file,sep,encode)
						EndIf
						WriteString(file,fieldquote,encode)
						WriteString(file,*this\cols()\text,encode)
						WriteString(file,fieldquote,encode)
						first=#False
					Next
					WriteString(file,linebreak,encode)
				EndIf
				ForEach *this\rows()
					first=#True
					ForEach *this\rows()\cells()
						If Not first
							WriteString(file,sep,encode)
						EndIf
						WriteString(file,fieldquote,encode)
						WriteString(file,*this\rows()\cells()\text,encode)
						WriteString(file,fieldquote,encode)
						first=#False
					Next
					WriteString(file,linebreak,encode)
				Next
				CloseFile(file)
			EndIf
		EndIf
	EndProcedure
	
	
	CompilerIf Defined(MYTABLE_EXPORT_XML,#PB_Module)
		
		Procedure MyTableExportXML(canvas,filename.s)
			Protected *table.strMyTableExportTable=_MyTableExportInit(canvas)
			If *table
				Protected xml=CreateXML(#PB_Any,#PB_UTF8)
				If xml
					InsertXMLStructure(xml,*table,strMyTableExportTable)
					FormatXML(xml,#PB_XML_ReIndent|#PB_XML_ReFormat)
					SetXMLStandalone(xml,#PB_XML_StandaloneYes)
					SaveXML(xml,filename,#PB_XML_StringFormat)
					FreeXML(xml)
				EndIf
				
				FreeStructure(*table)
			EndIf
		EndProcedure
		
		Procedure MyTableImportXML(canvas,filename.s,add.b)
			Protected *this.strMyTableTable=GetGadgetData(canvas)
			Protected xml=LoadXML(#PB_Any,filename)
			
			If xml And XMLStatus(xml)=#PB_XML_Success
				Protected *table.strMyTableExportTable=AllocateStructure(strMyTableExportTable)
				ExtractXMLStructure(MainXMLNode(xml),*table,strMyTableExportTable)
				_MyTableImport(*this,*table,add)
			Else
				MessageRequester("XML Fehler",XMLError(xml),#PB_MessageRequester_Error)
			EndIf
			FreeXML(xml)
		EndProcedure
		
	CompilerEndIf
	
	CompilerIf Defined(MYTABLE_EXPORT_JSON,#PB_Module)
		
		Procedure MyTableExportJSON(canvas,filename.s)
			Protected *table.strMyTableExportTable=_MyTableExportInit(canvas)
			If *table
				Protected json=CreateJSON(#PB_Any)
				If json
					InsertJSONStructure(JSONValue(json),*table,strMyTableExportTable)
					SaveJSON(json,filename,#PB_JSON_PrettyPrint)
					FreeJSON(json)
				EndIf
				FreeStructure(*table)
			EndIf
		EndProcedure
		
		Procedure MyTableImportJSON(canvas,filename.s,add.b)
			Protected *this.strMyTableTable=GetGadgetData(canvas)
			Protected json=LoadJSON(#PB_Any,filename)
			
			If json
				Protected *table.strMyTableExportTable=AllocateStructure(strMyTableExportTable)
				ExtractJSONStructure(JSONValue(json),*table,strMyTableExportTable)
				_MyTableImport(*this,*table,add)
				FreeJSON(json)
			Else
				MessageRequester("JSON Fehler",JSONErrorMessage(),#PB_MessageRequester_Error)
			EndIf
			
		EndProcedure
		
	CompilerEndIf
	
	
	
	XIncludeFile "mytableapplication.pb"
	XIncludeFile "mytabletable.pb"
	XIncludeFile "mytablerow.pb"
	XIncludeFile "mytablecol.pb"
	XIncludeFile "mytablecell.pb"
	
	
	
	CompilerIf Defined(MYTABLE_FORMULA,#PB_Module)
		XIncludeFile "mytablecalc.pb"
	CompilerEndIf
	
	Macro DataSectionMethod(gruppe,name)
		Data.i @_MyTable_#gruppe#_#name()
	EndMacro
	
	Macro DataSectionGetter(gruppe,name)
		DataSectionMethod(gruppe,Get#Name)
	EndMacro
	
	Macro DataSectionSetter(gruppe,name)
		DataSectionMethod(gruppe,Set#Name)
	EndMacro
	
	Macro DataSectionGetterSetter(gruppe,name)
		DataSectionGetter(gruppe,name)
		DataSectionSetter(gruppe,name)
	EndMacro
	
	Macro DataSectionDefault(gruppe)
		DataSectionMethod(gruppe,Dirty)
		DataSectionGetter(gruppe,Type)
		DataSectionGetterSetter(gruppe,Flags)
		DataSectionGetterSetter(gruppe,selectedbackground)
		DataSectionGetterSetter(gruppe,background)
		DataSectionGetterSetter(gruppe,backgroundfixed)		
		DataSectionGetterSetter(gruppe,forecolor)
		DataSectionGetterSetter(gruppe,selectedforecolor)
		DataSectionGetterSetter(gruppe,font)
	EndMacro
	
	DataSection
		;- Application
		vtable_application:
		DataSectionMethod(Application,Register)
		DataSectionMethod(Application,RegisterDialog)
		DataSectionMethod(Application,GridRegister)
		DataSectionMethod(Application,GridRegisterDialog)
		DataSectionMethod(Application,Unregister)
		
		;- Table
		vtable_table:
		DataSectionDefault(Table)
		DataSectionGetter(Table,Application)
		DataSectionGetterSetter(Table,headerbackground1)
		DataSectionGetterSetter(Table,headerbackground2)
		DataSectionGetterSetter(Table,headerbackgroundfixed)
		DataSectionGetterSetter(Table,headerforecolor)
		DataSectionGetter(Table,Canvas)
		DataSectionMethod(Table,UnRegister)
		DataSectionMethod(Table,ClearRows)
		DataSectionMethod(Table,ClearCols)
		DataSectionMethod(Table,Recalc)
		DataSectionMethod(Table,Redraw)
		DataSectionSetter(Table,Redraw)
		DataSectionMethod(Table,AddColumn)
		DataSectionMethod(Table,AddRow)
		DataSectionMethod(Table,AutosizeCol)
		DataSectionMethod(Table,AutosizeHeader)
		DataSectionMethod(Table,AutosizeRow)
		DataSectionMethod(Table,AddDirtyRows)
		DataSectionGetter(Table,Row)
		DataSectionGetter(Table,Col)
		DataSectionGetter(Table,Cell)
		DataSectionGetter(Table,RowCount)
		DataSectionGetter(Table,ColCount)
		
		DataSectionGetterSetter(Table,CellText)
		DataSectionGetterSetter(Table,CellTooltip)
		DataSectionGetterSetter(Table,CellValue)
		CompilerIf Defined(MYTABLE_FORMULA,#PB_Module)
			DataSectionGetterSetter(Table,CellFormula)
		CompilerEndIf
		DataSectionGetterSetter(Table,CellImage)
		
		DataSectionGetterSetter(Table,DefaultRowHeight)
		DataSectionGetterSetter(Table,RowHeight)
		DataSectionGetterSetter(Table,FixedColumns)
		
		DataSectionSetter(Table,EventRowSelected)
		DataSectionSetter(Table,EventCellSelected)
		DataSectionSetter(Table,EventRowChecked)
		DataSectionSetter(Table,EventRowRightClick)
		DataSectionSetter(Table,EventColRightClick)
		DataSectionSetter(Table,EventCellChecked)
		DataSectionSetter(Table,EventCellRightClick)
		DataSectionSetter(Table,EventCellChangedText)
		DataSectionSetter(Table,EventCellChangedValue)
		DataSectionSetter(Table,EventCallback)
		
		DataSectionSetter(Table,CustomCellEdit)
		
		CompilerIf Defined(MYTABLE_FORMULA,#PB_Module)
			DataSectionSetter(Table,RegisterFormula)
		CompilerEndIf
		
		;- Row
		vtable_row:
		DataSectionDefault(Row)
		DataSectionGetter(Row,ID)
		DataSectionGetter(Row,Table)
		DataSectionGetterSetter(Row,Tooltip)
		DataSectionGetterSetter(Row,Data)
		DataSectionGetterSetter(Row,Image)
		DataSectionGetterSetter(Row,RowHeight)
		DataSectionMethod(Row,AddDirtyRows)
		DataSectionGetter(Row,Cell)
		DataSectionGetter(Row,Cells)
		DataSectionMethod(Table,AddRow)
		
		;- Col
		vtable_col:
		DataSectionDefault(Col)
		DataSectionGetter(Col,ID)
		DataSectionGetter(Col,Table)
		DataSectionGetterSetter(Col,Text)
		DataSectionGetterSetter(Col,Tooltip)		
		DataSectionGetterSetter(Col,Format)
		DataSectionGetterSetter(Col,Image)
		DataSectionGetterSetter(Col,Data)
		DataSectionGetterSetter(Col,CanNull)
		DataSectionGetterSetter(Col,Sort)
		
		
		DataSectionSetter(Col,CustomCellEdit)
		
		;- Cell
		vtable_cell:	
		DataSectionDefault(Cell)
		DataSectionGetter(Cell,Table)
		DataSectionGetter(Cell,Row)
		DataSectionGetter(Cell,Col)
		DataSectionGetterSetter(Cell,Text)
		DataSectionGetterSetter(Cell,Tooltip)
		DataSectionGetterSetter(Cell,Data)
		DataSectionGetterSetter(Cell,Image)
		DataSectionGetterSetter(Cell,Value)
		CompilerIf Defined(MYTABLE_FORMULA,#PB_Module)
			DataSectionGetterSetter(Cell,Formula)
		CompilerEndIf
		DataSectionGetterSetter(Cell,Image)
	EndDataSection
EndModule