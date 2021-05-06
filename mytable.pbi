﻿Global MyTableW2=DesktopScaledX(2)
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

Global MyTableSortImageAsc=CreateImage(#PB_Any,MyTableW16,MyTableH16,32,#PB_Image_Transparent)
Global MyTableSortImageDesc=CreateImage(#PB_Any,MyTableW16,MyTableH16,32,#PB_Image_Transparent)
Global MyTableImagePlus=CreateImage(#PB_Any,MyTableW16,MyTableH16,32,#PB_Image_Transparent)
Global MyTableImageMinus=CreateImage(#PB_Any,MyTableW16,MyTableH16,32,#PB_Image_Transparent)
Global MyTableImageCheckBox=CreateImage(#PB_Any,MyTableW16,MyTableH16,32,#PB_Image_Transparent)
Global MyTableImageCheckBoxChecked=CreateImage(#PB_Any,MyTableW16,MyTableH16,32,#PB_Image_Transparent)
Global MyTableImagePlusArrow=CreateImage(#PB_Any,MyTableW16,MyTableH16,32,#PB_Image_Transparent)
Global MyTableImageMinusArrow=CreateImage(#PB_Any,MyTableW16,MyTableH16,32,#PB_Image_Transparent)


StartDrawing(ImageOutput(MyTableSortImageAsc))
DrawingMode(#PB_2DDrawing_AlphaBlend)
LineXY(MyTableW2,MyTableH8,MyTableW8,MyTableH2,RGBA(0,0,0,255))
LineXY(MyTableW8,MyTableH2,MyTableW14,MyTableH8,RGBA(0,0,0,255))
LineXY(MyTableW2,MyTableH8,MyTableW14,MyTableH8,RGBA(0,0,0,255))
StopDrawing()

StartDrawing(ImageOutput(MyTableSortImageDesc))
DrawingMode(#PB_2DDrawing_AlphaBlend)
LineXY(MyTableW2,MyTableH8,MyTableW8,MyTableH14,RGBA(0,0,0,255))
LineXY(MyTableW8,MyTableH14,MyTableW14,MyTableH8,RGBA(0,0,0,255))
LineXY(MyTableW2,MyTableH8,MyTableW14,MyTableH8,RGBA(0,0,0,255))
StopDrawing()

StartDrawing(ImageOutput(MyTableImagePlus))
DrawingMode(#PB_2DDrawing_Outlined|#PB_2DDrawing_AlphaBlend)
Box(MyTableW2,MyTableH2,MyTableW12,MyTableH12,RGBA(0,0,0,255))
LineXY(MyTableW4,MyTableH7,MyTableW10,MyTableH7,RGBA(0,0,0,255))
LineXY(MyTableW7,MyTableH4,MyTableW7,MyTableH10,RGBA(0,0,0,255))
StopDrawing()

StartDrawing(ImageOutput(MyTableImageMinus))
DrawingMode(#PB_2DDrawing_Outlined|#PB_2DDrawing_AlphaBlend)
Box(MyTableW2,MyTableH2,MyTableW12,MyTableH12,RGBA(0,0,0,255))
LineXY(MyTableW4,MyTableH7,MyTableW10,MyTableH7,RGBA(0,0,0,255))
StopDrawing()

StartDrawing(ImageOutput(MyTableImageCheckBox))
DrawingMode(#PB_2DDrawing_Outlined|#PB_2DDrawing_AlphaBlend)
Box(MyTableW2,MyTableH2,MyTableW12,MyTableH12,RGBA(0,0,0,255))
StopDrawing()

StartDrawing(ImageOutput(MyTableImageCheckBoxChecked))
DrawingMode(#PB_2DDrawing_Outlined|#PB_2DDrawing_AlphaBlend)
Box(MyTableW2,MyTableH2,MyTableW12,MyTableH12,RGBA(0,0,0,255))
LineXY(MyTableW4,MyTableH4,MyTableW12,MyTableH12,RGBA(0,0,0,255))
LineXY(MyTableW4,MyTableH12,MyTableW12,MyTableH4,RGBA(0,0,0,255))
StopDrawing()

StartDrawing(ImageOutput(MyTableImagePlusArrow))
DrawingMode(#PB_2DDrawing_AlphaBlend)
LineXY(MyTableW8,MyTableH4,MyTableW12,MyTableH8,RGBA(0,0,0,255))
LineXY(MyTableW8,MyTableH12,MyTableW12,MyTableH8,RGBA(0,0,0,255))
StopDrawing()

StartDrawing(ImageOutput(MyTableImageMinusArrow))
DrawingMode(#PB_2DDrawing_AlphaBlend)
LineXY(MyTableW4,MyTableH6,MyTableW8,MyTableH10,RGBA(0,0,0,255))
LineXY(MyTableW8,MyTableH10,MyTableW12,MyTableH6,RGBA(0,0,0,255))
StopDrawing()

Enumeration _mytable_type
	#MYTABLE_TYPE_NONE
	#MYTABLE_TYPE_TABLE
	#MYTABLE_TYPE_ROW
	#MYTABLE_TYPE_COL
	#MYTABLE_TYPE_CELL
EndEnumeration

Structure _strMyTableAObject
	type.i
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
EndStructure

Structure strMyTableCell Extends strMyTableAObject
	text.s
	value.d
	checked.b
	*row.strMyTableRow
	*col.strMyTableCol	
	startx.i
	starty.i
	formula.s
EndStructure

Structure strMyTableRow Extends strMyTableAObject
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

EnumerationBinary _MyTableColumnFlags
	#MYTABLE_COLUMN_FLAGS_LEFT
	#MYTABLE_COLUMN_FLAGS_RIGHT
	#MYTABLE_COLUMN_FLAGS_CENTER
	#MYTABLE_COLUMN_FLAGS_TEXT
	#MYTABLE_COLUMN_FLAGS_INTEGER
	#MYTABLE_COLUMN_FLAGS_DATE
	#MYTABLE_COLUMN_FLAGS_DATE_TIME
	#MYTABLE_COLUMN_FLAGS_TIME
	#MYTABLE_COLUMN_FLAGS_TIME_LONG
	#MYTABLE_COLUMN_FLAGS_DOUBLE
	#MYTABLE_COLUMN_FLAGS_BOOLEAN
	#MYTABLE_COLUMN_FLAGS_EDITABLE
	#MYTABLE_COLUMN_FLAGS_IMAGE
	#MYTABLE_COLUMN_FLAGS_TOP
	#MYTABLE_COLUMN_FLAGS_MIDDLE
	#MYTABLE_COLUMN_FLAGS_BOTTOM
	#MYTABLE_COLUMN_FLAGS_RESIZEABLE
	#MYTABLE_COLUMN_FLAGS_SORTABLE
EndEnumeration

#MYTABLE_COLUMN_FLAGS_DEFAULT = #MYTABLE_COLUMN_FLAGS_LEFT|#MYTABLE_COLUMN_FLAGS_TEXT
#MYTABLE_COLUMN_FLAGS_DEFAULT_DATE = #MYTABLE_COLUMN_FLAGS_DATE|#MYTABLE_COLUMN_FLAGS_DATE_TIME
#MYTABLE_COLUMN_FLAGS_DEFAULT_TIME = #MYTABLE_COLUMN_FLAGS_TIME|#MYTABLE_COLUMN_FLAGS_TIME_LONG
#MYTABLE_COLUMN_FLAGS_DEFAULT_DATE_TIME = #MYTABLE_COLUMN_FLAGS_DEFAULT_DATE|#MYTABLE_COLUMN_FLAGS_DEFAULT_TIME

Prototype MyTableProtoEventCancelCustomEditCell(canvas,*cell.strMyTableCell)
Prototype MyTableProtoEventCustomEditCell(canvas,*cell.strMyTableCell,x,y,w,h)

Structure strMyTableCol Extends strMyTableAObject
	id.q
	text.s	
	width.i
	sort.i	
	flags.i
	format.s
	evtCustomEditCell.MyTableProtoEventCustomEditCell	
	evtCancelCustomEditCell.MyTableProtoEventCancelCustomEditCell
EndStructure

EnumerationBinary _MyTableTableFlags
	#MYTABLE_TABLE_FLAGS_GRID
	#MYTABLE_TABLE_FLAGS_HIERARCHICAL
	#MYTABLE_TABLE_FLAGS_HIERARCHICAL_ARROW
	#MYTABLE_TABLE_FLAGS_LAST_STRETCH
	#MYTABLE_TABLE_FLAGS_NO_HEADER
	#MYTABLE_TABLE_FLAGS_FULL_ROW_SELECT	
	#MYTABLE_TABLE_FLAGS_CHECKBOX
	#MYTABLE_TABLE_FLAGS_STOP_DRAWING
	#MYTABLE_TABLE_FLAGS_MULTISELECT
	#MYTABLE_TABLE_FLAGS_CALLBACK
	#MYTABLE_TABLE_FLAGS_ROW_RESIZEABLE	
	#MYTABLE_TABLE_FLAGS_COL_RESIZEABLE	
	#MYTABLE_TABLE_FLAGS_SORTABLE
	#MYTABLE_TABLE_FLAGS_ALL_ROW_COUNT
EndEnumeration

#MYTABLE_TABLE_FLAGS_DEFAULT=#MYTABLE_TABLE_FLAGS_GRID|#MYTABLE_TABLE_FLAGS_SORTABLE|#MYTABLE_TABLE_FLAGS_ROW_RESIZEABLE|#MYTABLE_TABLE_FLAGS_COL_RESIZEABLE

Prototype MyTableProtoEventRowSelected(canvas,*row.strMyTableRow)
Prototype MyTableProtoEventCellSelected(canvas,*cell.strMyTableCell)
Prototype MyTableProtoEventRowChecked(canvas,*row.strMyTableRow)
Prototype MyTableProtoEventRowRightClick(canvas,*row.strMyTableRow)
Prototype MyTableProtoEventColRightClick(canvas,*col.strMyTableCol)
Prototype MyTableProtoEventCellChecked(canvas,*cell.strMyTableCell)
Prototype MyTableProtoEventCellRightClick(canvas,*cell.strMyTableCell)
Prototype MyTableProtoEventCellChangedText(canvas,*cell.strMyTableCell,old.s)
Prototype MyTableProtoEventCellChangedValue(canvas,*cell.strMyTableCell,old.d)
Prototype MyTableProtoEventCallback(canvas,*row.strMyTableRow)


Structure strMyTableTable Extends _strMyTableAObject
	name.s
	window.i
	canvas.i
	vscroll.i
	hscroll.i
	List rows.strMyTableRow()
	Map rowsById.i()
	List cols.strMyTableCol()	
	Map colsById.i()
	flags.i
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
	List expRows.i()
	expheight.i
	
	editorgadget.i
	editorwindow.i
	*editcell.strMyTableCell
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
	
	
	selectedbackground.q
	background.q
	backgroundfixed.q
	headerbackground1.q
	headerbackground2.q
	headerbackgroundfixed.q
	forecolor.q
	headerforecolor.q
	selectedforecolor.q
	font.i
	
	fixedcolumns.i
	resizecol.b
	oldx.i
	*colResize.strMyTableCol
	resizerow.b
	oldy.i
	*rowResize.strMyTableRow
	
	*data
EndStructure



Declare _MyTableRedraw(*this.strMyTableTable)
Declare _MyTableRecalc(*this.strMyTableTable,force.b=#False)
Declare _MyTableClearMaps(*this.strMyTableTable)
Declare.b _MyTableSort(*this.strMyTableTable,col.i)
Declare _MyTableResize(*this.strMyTableTable)
Declare _MyTableRecalcExp(*this.strMyTableTable,*row.strMyTableRow,w)
Declare _MyTableRegister(window,canvas,hscroll,vscroll,flags.i=#MYTABLE_TABLE_FLAGS_DEFAULT,callback.MyTableProtoEventCallback=0,name.s="")
Declare _MyTableRowExpand(*row.strMyTableRow,expanded.b)	
Declare _MyTableDrawText(x,y,text.s,color.q)
Declare _MyTableDrawHeader(*this.strMyTableTable,*col.strMyTableCol,bx.i,fixed.b)
Declare _MyTableDrawRow(*this.strMyTableTable,*row.strMyTableRow,w.i,bx.i,by.i,fixed.b,fullrowselect.b,grid.b,hierarchical.b,checkboxes.b)
Declare _MyTableEditCell(*cell.strMyTableCell)
Declare _MyTableStopEditCell(*this.strMyTableTable)
Declare _MyTableTextHeight(text.s)
Declare _MyTableTextWidth(text.s)

Declare MyTableEvtResize()
Declare MyTableEvtDialogResize()
Declare MyTableEvtScroll()
Declare MyTableEvtMouseDown()
Declare MyTableEvtMouseUp()
Declare MyTableEvtMouseMove()
Declare MyTableEvtDouble()
Declare MyTableEvtKeyDown()
Declare MyTableEvtReturn()
Declare MyTableEvtEsc()
Declare MyTableEvtLostFocus()

Declare MyTableRegister(window,canvas,hscroll,vscroll,flags.i=#MYTABLE_TABLE_FLAGS_DEFAULT,callback.MyTableProtoEventCallback=0,name.s="")
Declare MyTableRegisterDialog(window,canvas,hscroll,vscroll,flags.i=#MYTABLE_TABLE_FLAGS_DEFAULT,callback.MyTableProtoEventCallback=0,name.s="")
Declare MyTableUnRegister(canvas)
Declare MyTableSetTableFlags(canvas,flags.i)
Declare MyTableSetTableName(canvas,name.s)
Declare MyTableSetTableRowHeight(canvas,flags.i)
Declare MyTableSetTableSelectedRow(canvas,row.i)
Declare MyTableSetTableSelectedRowById(canvas,rowid.i)
Declare MyTableSetTableSelectedCell(canvas,row.i,col.i)
Declare MyTableSetTableData(canvas,*data)
Declare MyTableSetTableFixedColumns(canvas,columns.i)
Declare MyTableGetTableFlags(canvas)
Declare MyTableGetTableRowHeight(canvas)
Declare MyTableGetTableSelectedRow(canvas)
Declare MyTableGetTableSelectedCell(canvas)
Declare MyTableRedraw(canvas,redraw.b)
Declare MyTableGetTableData(canvas)
Declare.s MyTableGetTableName(canvas)
Declare MyTableGetTableFixedColumns(canvas)

Declare MyTableSetEventRowSelected(canvas,event.MyTableProtoEventRowSelected)
Declare MyTableSetEventCellSelected(canvas,event.MyTableProtoEventCellSelected)
Declare MyTableSetEventRowChecked(canvas,event.MyTableProtoEventRowChecked)
Declare MyTableSetEventRowRightClick(canvas,event.MyTableProtoEventRowRightClick)
Declare MyTableSetEventCellChecked(canvas,event.MyTableProtoEventCellChecked)
Declare MyTableSetEventCellRightClick(canvas,event.MyTableProtoEventCellRightClick)
Declare MyTableSetEventCellChangedText(canvas,event.MyTableProtoEventCellChangedText)
Declare MyTableSetEventCellChangedValue(canvas,event.MyTableProtoEventCellChangedValue)
Declare MyTableSetEventCallback(canvas,event.MyTableProtoEventCallback)

Declare.q MyTableAddColumn(canvas,text.s,width.i,flags.i=#MYTABLE_COLUMN_FLAGS_DEFAULT,image.i=0,*data=0,sort.i=0)
Declare MyTableRemoveColumn(canvas,column.i)
Declare MyTableSetColumnText(canvas,column.i,text.s)
Declare MyTableSetColumnWidth(canvas,column.i,width.i)
Declare MyTableSetColumnFlags(canvas,column.i,flags.i)
Declare MyTableSetColumnImage(canvas,column.i,image.i)
Declare MyTableSetColumnData(canvas,column.i,*data)
Declare MyTableSetColumnSort(canvas,column.i,sort.i)
Declare MyTableSetCustomCellEdit(canvas,column.i,evtCustomEditCell.MyTableProtoEventCustomEditCell,evtCancelCustomEditCell.MyTableProtoEventCancelCustomEditCell)
Declare.s MyTableGetColumnText(canvas,column.i)
Declare MyTableGetColumnWidth(canvas,column.i)
Declare MyTableGetColumnFlags(canvas,column.i)
Declare MyTableGetColumnImage(canvas,column.i)
Declare MyTableGetColumnData(canvas,column.i)
Declare MyTableGetColumnSort(canvas,column.i)
Declare MyTableAutosizeColumn(canvas,col.i)
Declare MyTableAutosizeRow(canvas,row.i)
Declare MyTableExportCSV(canvas,filename.s,sep.s=";",header.b=#True,fieldquote.s="'",linebreak.s=#CRLF$,encode=#PB_UTF8)

Declare.q MyTableAddRow(canvas,text.s,sep.s="|",id.q=#PB_Ignore,image.i=0,*data=0,checked.b=#False,expanded.b=#False,parentid.q=0)
Declare MyTableRemoveRow(canvas,row.i)
Declare MyTableAddDirtyRow(canvas,rows.i,parentid.q=0)
Declare MyTableClearRows(canvas)
Declare MyTableSetRowImage(canvas,row.i,image.i)
Declare MyTableSetRowData(canvas,row.i,*data)
Declare MyTableSetRowChecked(canvas,row.i,checked.b)
Declare MyTableSetRowExpanded(canvas,row.i,expanded.b)
Declare MyTableSetRowHeight(canvas,row.i,height.i)
Declare MyTableGetRowImage(canvas,row.i)
Declare MyTableGetRowDirty(canvas,row.i)
Declare MyTableGetRowData(canvas,row.i)
Declare.b MyTableGetRowChecked(canvas,row.i)
Declare.b MyTableGetRowExpanded(canvas,row.i)
Declare MyTableGetRowHeigth(canvas,row.i)
Declare MyTableGetRowCount(canvas)

Declare MyTableSetCellText(canvas,row.i,col.i,text.s)
Declare MyTableSetCellValue(canvas,row.i,col.i,value.d)
Declare MyTableSetCellChecked(canvas,row.i,col.i,checked.b)
Declare MyTableSetCellData(canvas,row.i,col.i,*data)
Declare MyTableSetCellImage(canvas,row.i,col.i,image.i)
Declare.s MyTableGetCellText(canvas,row.i,col.i)
Declare.d MyTableGetCellValue(canvas,row.i,col.i)
Declare MyTableGetCellChecked(canvas,row.i,col.i)
Declare MyTableGetCellData(canvas,row.i,col.i)
Declare MyTableGetCellImage(canvas,row.i,col.i)

Declare MyTableSetSelectedbackground(canvas,color.q)
Declare MyTableSetBackground(canvas,color.q)
Declare MyTableSetBackgroundFixedColumns(canvas,color.q)
Declare MyTableSetHeaderbackground1(canvas,color.q)
Declare MyTableSetHeaderbackground2(canvas,color.q)
Declare MyTableSetHeaderbackgroundFixedColumns(canvas,color.q)
Declare MyTableSetForecolor(canvas,color.q)
Declare MyTableSetHeaderforecolor(canvas,color.q)
Declare MyTableSetSelectedforecolor(canvas,color.q)
Declare.q MyTableGetSelectedbackground(canvas)
Declare.q MyTableGetBackground(canvas)
Declare.q MyTableGetBackgroundFixedColumns(canvas)
Declare.q MyTableGetHeaderbackground1(canvas)
Declare.q MyTableGetHeaderbackground2(canvas)
Declare.q MyTableGetHeaderbackgroundFixedColumns(canvas)
Declare.q MyTableGetForecolor(canvas)
Declare.q MyTableGetHeaderforecolor(canvas)
Declare.q MyTableGetSelectedforecolor(canvas)

Macro MM
	"
EndMacro

CompilerIf #PB_Compiler_Debugger And Not Defined(DEBUG_LEVEL,#PB_Constant)
	#DEBUG_LEVEL=0
CompilerEndIf

CompilerIf #PB_Compiler_Debugger And Not Defined(DEBUG_MS_MAX,#PB_Constant)
	#DEBUG_MS_MAX=200
CompilerEndIf

Macro _callcountStart(sname)
	CompilerIf #PB_Compiler_Debugger And #DEBUG_LEVEL=1
		Static NewMap callcount.i()
		Static NewMap callms.i()
		Static NewMap callmssum.i()		
		callms(MM#sname#MM+"_"+Str(*this\canvas))=ElapsedMilliseconds()		
	CompilerEndIf
EndMacro

Macro _callcountEnde(sname)
	CompilerIf #PB_Compiler_Debugger And #DEBUG_LEVEL=1
		callcount(MM#sname#MM+"_"+Str(*this\canvas))+1
		
		
		Protected tname.s=""
		If *this\name=""
			tname=Str(*this\canvas)
		Else
			tname=*this\name
		EndIf
		
		Protected debugline.s=LSet(tname+":",16," ")
		debugline + LSet(MM#sname#MM+": "+callcount(MM#sname#MM+"_"+Str(*this\canvas)),20," ")
		Protected _#sname#ms=ElapsedMilliseconds()-callms(MM#sname#MM+"_"+Str(*this\canvas))
		callmssum(MM#sname#MM+"_"+Str(*this\canvas))+_#sname#ms
		If _#sname#ms>#DEBUG_MS_MAX
			DebuggerWarning(MM#sname#MM+" für "+tname+" > "+Str(#DEBUG_MS_MAX)+"ms ( "+Str(_#sname#ms)+" )")
		EndIf
		debugline + Str(_#sname#ms)+"ms / "+Str(callmssum(MM#sname#MM+"_"+Str(*this\canvas)))+"ms / " +Str(callmssum(MM#sname#MM+"_"+Str(*this\canvas))/callcount(MM#sname#MM+"_"+Str(*this\canvas)))+ "ms"
		Debug debugline,1
	CompilerEndIf
EndMacro

Procedure _MyTableStopEditCell(*this.strMyTableTable)
	If *this			
		If *this\editcell
			If *this\editcell\col\evtCancelCustomEditCell
				*this\editcell\col\evtCancelCustomEditCell(*this\canvas,*this\editcell)
				*this\dirty=#True
				*this\editcell=0
				_MyTableRecalc(*this)
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
						*cell\text=s
						If *this\evtCellChangedText
							*this\evtCellChangedText(*this\canvas,*cell,sold)
						EndIf
						If Bool(*col\flags & #MYTABLE_COLUMN_FLAGS_DOUBLE)
							*cell\value=ValD(s)
						EndIf
						If Bool(*col\flags & #MYTABLE_COLUMN_FLAGS_INTEGER)
							*cell\value=ValD(s)
						EndIf
						If Bool(*col\flags & #MYTABLE_COLUMN_FLAGS_DEFAULT_DATE_TIME)
							*cell\value=ParseDate(*col\format,s)
						EndIf
						*this\dirty=#True
						_MyTableRedraw(*this)
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

Procedure _MyTableEditCell(*cell.strMyTableCell)
	If *cell
		Protected *col.strMyTableCol=*cell\col
		Protected *row.strMyTableRow=*cell\row
		Protected *this.strMyTableTable=*cell\table
		
		If Bool(*col\flags & #MYTABLE_COLUMN_FLAGS_EDITABLE)
			If Bool(*col\flags & #MYTABLE_COLUMN_FLAGS_BOOLEAN)
				*cell\checked=Bool(*cell\checked=#False)
				*cell\value=*cell\checked
				*cell\text=Str(*cell\checked)
				*cell\textwidth=0
				*cell\textheight=0
				*cell\dirty=#True
				*this\dirty=#True
				If *this\evtCellChecked
					*this\evtCellChecked(*this\canvas,*cell)
				EndIf
				_MyTableRedraw(*this)
			Else
				If IsWindow(*this\editorwindow)
					CloseWindow(*this\editorwindow)					
				EndIf
				If *col\evtCustomEditCell
					
					*col\evtCustomEditCell(*this\canvas,
					                       *cell,
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
					
					SetGadgetText(*this\editorgadget,*cell\text)
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
EndProcedure

Procedure _MyTableTextHeight(text.s)
	ProcedureReturn TextHeight(text) * (CountString(text,#CRLF$)+1)
EndProcedure

Procedure _MyTableTextWidth(text.s)
	Protected result.i=0
	If FindString(text,#CRLF$)
		Protected c=CountString(text,#CRLF$)+1		
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
	If FindString(text,#CRLF$)
		Protected c=CountString(text,#CRLF$)+1
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

Procedure _MyTableDrawRow(*this.strMyTableTable,*row.strMyTableRow,w,bx.i,by.i,fixed.b,fullrowselect.b,grid.b,hierarchical.b,checkboxes.b)
	Protected *cell.strMyTableCell=0
	Protected *col.strMyTableCol=0
	If Bool(*this\flags & #MYTABLE_TABLE_FLAGS_CALLBACK) And *row\dirty And *this\evtCallback
		*this\evtCallback(*this\canvas,*row)
		ForEach *row\cells()
			*cell=*row\cells()
			*col=*cell\col
			If Bool(*col\flags & #MYTABLE_COLUMN_FLAGS_DEFAULT_DATE_TIME)
				*cell\value=ParseDate(*col\format,*cell\text)
			ElseIf Bool(*col\flags & #MYTABLE_COLUMN_FLAGS_INTEGER)
				*cell\value=Val(*cell\text)
			ElseIf Bool(*col\flags & #MYTABLE_COLUMN_FLAGS_DOUBLE)
				*cell\value=ValD(*cell\text)
			ElseIf Bool(*col\flags & #MYTABLE_COLUMN_FLAGS_BOOLEAN)
				*cell\value=Bool(*cell\text="1" Or 
				                 LCase(*cell\text)="x" Or 
				                 LCase(*cell\text)="true" Or
				                 LCase(*cell\text)="yes")
				*cell\checked=*cell\value
			EndIf
		Next
		*row\dirty=#False
	EndIf
	Protected idx=0
	Protected firstcol.b=#True
	ForEach *row\cells()
		*cell=*row\cells()
		*col=*cell\col
		If ListIndex(*row\cells())>=*this\fixedcolumns And fixed
			Break
		EndIf
		If *cell\textheight=0
			If Bool(*col\flags & #MYTABLE_COLUMN_FLAGS_BOOLEAN)
				*cell\textheight=MyTableW20
			Else
				*cell\textheight=_MyTableTextHeight(*cell\text)
			EndIf
		EndIf
		If *cell\textwidth=0
			If Bool(*col\flags & #MYTABLE_COLUMN_FLAGS_BOOLEAN)
				*cell\textwidth=MyTableW20
			Else
				*cell\textwidth=_MyTableTextWidth(*cell\text)
			EndIf
		EndIf
		
		Protected selected.b=#False
		If fixed
			Box(bx,by,*col\calcwidth,*row\calcheight,*this\backgroundfixed)	
		EndIf
		If (fullrowselect And *this\selected(Str(*row))=#True) Or *this\selected(Str(*cell))=#True
			Box(bx,by,*col\calcwidth,*row\calcheight,*this\selectedbackground)	
			selected=#True
		EndIf
		*cell\startx=bx
		*cell\starty=by
		
		DrawingMode(#PB_2DDrawing_Outlined)	
		If grid
			Box(bx,by,*col\calcwidth,*row\calcheight,*this\headerbackground2)
		EndIf
		
		Protected foi.i=0
		Protected coi.i=0
		Protected cob.i=0
		
		Protected valw=0
		If Bool(*col\flags & #MYTABLE_COLUMN_FLAGS_MIDDLE)
			valw=*row\calcheight/2-*cell\textheight/2
		ElseIf Bool(*col\flags & #MYTABLE_COLUMN_FLAGS_BOTTOM)
			valw=*row\calcheight-*cell\textheight
		Else
			valw=MyTableH2
		EndIf
		
		If firstcol And hierarchical
			foi=MyTableW20 * (*row\level+1)
			If ListSize(*row\rows())>0
				If *row\expanded
					If Bool(*this\flags & #MYTABLE_TABLE_FLAGS_HIERARCHICAL_ARROW)
						DrawAlphaImage(ImageID(MyTableImageMinusArrow),bx+foi-MyTableW20,by+valw)
					Else
						DrawAlphaImage(ImageID(MyTableImageMinus),bx+foi-MyTableW20,by+valw)
					EndIf
				Else
					If Bool(*this\flags & #MYTABLE_TABLE_FLAGS_HIERARCHICAL_ARROW)
						DrawAlphaImage(ImageID(MyTableImagePlusArrow),bx+foi-MyTableW20,by+valw)
					Else
						DrawAlphaImage(ImageID(MyTableImagePlus),bx+foi-MyTableW20,by+valw)
					EndIf
				EndIf
			EndIf
		EndIf
		
		If firstcol And checkboxes
			coi=MyTableW20
			If *row\checked
				DrawAlphaImage(ImageID(MyTableImageCheckBoxChecked),bx+foi,by+valw)
			Else
				DrawAlphaImage(ImageID(MyTableImageCheckBox),bx+foi,by+valw)
			EndIf
		EndIf
		
		
		If firstcol And IsImage(*row\sclaedimage)
			cob+MyTableW20
			
			DrawAlphaImage(ImageID(*row\sclaedimage),bx+foi+coi,by+valw)
		EndIf
		
		
		ClipOutput(bx,by,*col\calcwidth,*row\calcheight)
		DrawingMode(#PB_2DDrawing_Transparent)			
		
		
		If Bool(*col\flags & #MYTABLE_COLUMN_FLAGS_IMAGE)
			If IsImage(*cell\image)
				If Bool(*col\flags & #MYTABLE_COLUMN_FLAGS_CENTER)
					DrawAlphaImage(ImageID(*cell\image),bx+MyTableW2+*col\calcwidth/2-*cell\textwidth/2,by+valw)
				ElseIf Bool(*col\flags & #MYTABLE_COLUMN_FLAGS_RIGHT)
					DrawAlphaImage(ImageID(*cell\image),bx+*col\calcwidth-*cell\textwidth-MyTableW4,by+valw)
				Else
					DrawAlphaImage(ImageID(*cell\image),bx+MyTableW2+foi,by+valw)
				EndIf	
			EndIf
		ElseIf Bool(*col\flags & #MYTABLE_COLUMN_FLAGS_BOOLEAN)
			Protected img=0
			If *cell\checked
				img=MyTableImageCheckBoxChecked
			Else
				img=MyTableImageCheckBox
			EndIf
			
			If Bool(*col\flags & #MYTABLE_COLUMN_FLAGS_CENTER)
				DrawAlphaImage(ImageID(img),bx+MyTableW2+*col\calcwidth/2-*cell\textwidth/2,by+valw)
			ElseIf Bool(*col\flags & #MYTABLE_COLUMN_FLAGS_RIGHT)
				DrawAlphaImage(ImageID(img),bx+*col\calcwidth-*cell\textwidth-MyTableW4,by+valw)
			Else
				DrawAlphaImage(ImageID(img),bx+MyTableW2+foi,by+valw)
			EndIf					
		Else
			Protected color=*this\forecolor
			If selected
				color=*this\selectedforecolor
			EndIf
			If Bool(*col\flags & #MYTABLE_COLUMN_FLAGS_CENTER)
				_MyTableDrawText(bx+MyTableW2+*col\calcwidth/2-*cell\textwidth/2,by+valw,*cell\text,color)
			ElseIf Bool(*col\flags & #MYTABLE_COLUMN_FLAGS_RIGHT)
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

Procedure _MyTableDrawHeader(*this.strMyTableTable,*col.strMyTableCol,bx.i,fixed.b)
	If *col\textwidth=0
		*col\textwidth=_MyTableTextWidth(*col\text)
	EndIf
	If *col\textheight=0
		*col\textheight=_MyTableTextHeight(*col\text)
	EndIf
	Protected soi.i=0
	
	If *col\sort
		soi=MyTableW20
	EndIf
	
	
	Box(bx,0,*col\calcwidth,*col\calcheight,*this\headerbackground1)
	If fixed
		Box(bx,0,*col\calcwidth-MyTableW2,*col\calcheight-MyTableH2,*this\headerbackgroundfixed)
	Else
		Box(bx,0,*col\calcwidth-MyTableW2,*col\calcheight-MyTableH2,*this\headerbackground2)
	EndIf
	ClipOutput(bx,0,*col\calcwidth,*col\calcheight)
	DrawingMode(#PB_2DDrawing_Transparent)					
	If Bool(*col\flags & #MYTABLE_COLUMN_FLAGS_CENTER)
		_MyTableDrawText(bx+MyTableW2+*col\calcwidth/2-*col\textwidth/2-soi,0,*col\text,*this\headerforecolor)
	ElseIf Bool(*col\flags & #MYTABLE_COLUMN_FLAGS_RIGHT)
		_MyTableDrawText(bx+*col\calcwidth-*col\textwidth-MyTableW4-soi,0,*col\text,*this\headerforecolor)
	Else
		_MyTableDrawText(bx+MyTableW2,0,*col\text,*this\headerforecolor)
	EndIf					
	DrawingMode(#PB_2DDrawing_AlphaClip)
	UnclipOutput()		
	Select *col\sort
		Case -1
			DrawAlphaImage(ImageID(MyTableSortImageDesc),bx+*col\calcwidth-soi,0)
		Case 1
			DrawAlphaImage(ImageID(MyTableSortImageAsc),bx+*col\calcwidth-soi,0)
	EndSelect
	ProcedureReturn *col\calcwidth
EndProcedure

Procedure _MyTableRedraw(*this.strMyTableTable)
	If *this
		With *this
			If \redraw And \dirty
				_MyTableClearMaps(*this)
				_callcountStart(redraw)
				
				Protected grid.b=Bool(\flags & #MYTABLE_TABLE_FLAGS_GRID)
				Protected hierarchical.b=Bool(Bool(*this\flags & #MYTABLE_TABLE_FLAGS_HIERARCHICAL) Or Bool(*this\flags & #MYTABLE_TABLE_FLAGS_HIERARCHICAL_ARROW))
				Protected laststretch.b=Bool(\flags & #MYTABLE_TABLE_FLAGS_LAST_STRETCH)
				Protected noheader.b=Bool(\flags & #MYTABLE_TABLE_FLAGS_NO_HEADER)
				Protected fullrowselect.b=Bool(\flags & #MYTABLE_TABLE_FLAGS_FULL_ROW_SELECT Or ListSize(*this\cols())=1)
				Protected checkboxes.b=Bool(\flags & #MYTABLE_TABLE_FLAGS_CHECKBOX)
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
						
						bx+_MyTableDrawHeader(*this,*col,bx,#False)
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
							bx+_MyTableDrawHeader(*this,*col,bx,#True)
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
					by+_MyTableDrawRow(*this,*row,w,bx,by,#False,fullrowselect,grid,hierarchical,checkboxes)
					If by>=h
						Break
					EndIf
				Next
				
				If *this\fixedcolumns>0
					by=DesktopScaledY(\headerheight)
					For i=GetGadgetState(\vscroll) To c
						SelectElement(\expRows(),i)				
						*row=\expRows()
						by+_MyTableDrawRow(*this,*row,w,0,by,#True,fullrowselect,grid,hierarchical,checkboxes)
						If by>=h
							Break
						EndIf
					Next
				EndIf
				
				
				
				StopDrawing()
				
				_callcountEnde(redraw)
				\dirty=#False
			EndIf			
		EndWith
	EndIf
EndProcedure

Procedure _MyTableRecalcExp(*this.strMyTableTable,*parent.strMyTableRow,w)
	ForEach *parent\rows()
		Protected *row.strMyTableRow=*parent\rows()
		AddElement(*this\expRows()):*this\expRows()=*row
		If *row\dirty
			*row\calcheight=DesktopScaledY(*row\height)
			*row\calcwidth=w
			*row\dirty=#False
		EndIf
		If *row\expanded
			_MyTableRecalcExp(*this,*row,w)
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
	EndIf	
EndProcedure

Procedure _MyTableRecalc(*this.strMyTableTable,force.b=#False)
	If *this
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
						_MyTableRecalcExp(*this,*row,w)
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
			_MyTableRedraw(*this)
		EndIf
	EndIf
EndProcedure

Procedure.b _MyTableSort(*this.strMyTableTable,col.i)
	Protected result.b=#False
	If *this
		Protected sortable.b=Bool(*this\flags & #MYTABLE_TABLE_FLAGS_SORTABLE)
		Protected *col.strMyTableCol=SelectElement(*this\cols(),col)
		If sortable Or Bool(*col\flags & #MYTABLE_COLUMN_FLAGS_SORTABLE)
			_callcountStart(sort)
			result=#True
			Protected bdsort.b=Bool(Bool(*col\flags & #MYTABLE_COLUMN_FLAGS_BOOLEAN) Or 
			                        Bool(*col\flags & #MYTABLE_COLUMN_FLAGS_DEFAULT_DATE_TIME) Or 
			                        Bool(*col\flags & #MYTABLE_COLUMN_FLAGS_INTEGER) Or 
			                        Bool(*col\flags & #MYTABLE_COLUMN_FLAGS_DOUBLE))
			ForEach *this\rows()
				Protected *row.strMyTableRow=*this\rows()
				SelectElement(*row\cells(),col)
				If bdsort
					*row\dsort=*row\cells()\value
				Else
					*row\sort=*row\cells()\text
				EndIf
			Next
			Select *this\cols()\sort
				Case -1
					*this\cols()\sort=0				
					SortStructuredList(*this\rows(),#PB_Sort_Ascending,OffsetOf(strMyTableRow\id),TypeOf(strMyTableRow\id))				
				Case 0
					*this\cols()\sort=1
					If bdsort
						SortStructuredList(*this\rows(),#PB_Sort_Ascending,OffsetOf(strMyTableRow\dsort),TypeOf(strMyTableRow\dsort))
					Else
						SortStructuredList(*this\rows(),#PB_Sort_Ascending,OffsetOf(strMyTableRow\sort),TypeOf(strMyTableRow\sort))
					EndIf
				Case 1
					*this\cols()\sort=-1
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
				_MyTableRecalc(*this)
			EndIf
		EndWith
	EndIf
EndProcedure

Procedure _MyTableAddDirtyRow(*this.strMyTableTable,*row.strMyTableRow)
	*row\dirty=#True
	*row\table=*this
	*this\lastRowid+1
	*row\id=*this\lastRowid	
	*row\type=#MYTABLE_TYPE_ROW
	*row\height=*this\rowheight
	Protected i
	For i=1 To ListSize(*this\cols())		
		Protected *cell.strMyTableCell=AddElement(*row\cells())
		*cell\row=*row
		*cell\table=*this
		*cell\type=#MYTABLE_TYPE_CELL
		*cell\col=SelectElement(*this\cols(),i-1)
	Next
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
				_MyTableRecalc(*this)
			EndIf
		EndWith
	EndIf
EndProcedure


Procedure MyTableEvtScroll()
	Protected *this.strMyTableTable=GetGadgetData(EventGadget())
	If *this
		*this\dirty=#True
		_MyTableRedraw(*this)
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
		Protected listidx=-1,colidx=-1
		Protected NewList selected.q()
		
		Select GetGadgetAttribute(*this\canvas,#PB_Canvas_Key)
			Case #PB_Shortcut_Return,#PB_Shortcut_F2
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
								*cell=Val(MapKey(*this\selected()))
								*row=*cell\row
								ForEach *row\cells()
									If *row\cells()=*cell
										listidx=ListIndex(*row\cells())
										Break
									EndIf
								Next
								listidx-1
								If listidx>-1				
									*cell=SelectElement(*row\cells(),listidx)
								EndIf
								AddElement(selected())
								selected()=*cell									
							Next
							ClearMap(*this\selected())
							ForEach selected()
								*cell=selected()
								*this\selected(Str(*cell))=#True
								If *this\evtCellSelect
									*this\evtCellSelect(*this\canvas,*cell)
								EndIf
							Next
							redraw=#True
						EndIf
					Else
						If Not fullrowselect						
							SelectElement(*this\expRows(),0)
							*row=*this\expRows()
							*cell=SelectElement(*row\cells(),ListSize(*row\cells())-1)
							*this\selected(Str(*cell))=#True
							If *this\evtCellSelect
								*this\evtCellSelect(*this\canvas,*cell)
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
								*cell=Val(MapKey(*this\selected()))
								*row=*cell\row
								ForEach *row\cells()
									If *row\cells()=*cell
										listidx=ListIndex(*row\cells())
										Break
									EndIf
								Next
								listidx+1
								If listidx<ListSize(*row\cells())									
									*cell=SelectElement(*row\cells(),listidx)
								EndIf
								AddElement(selected())
								selected()=*cell
							Next
							ClearMap(*this\selected())
							ForEach selected()
								*cell=selected()
								*this\selected(Str(*cell))=#True
								If *this\evtCellSelect
									*this\evtCellSelect(*this\canvas,*cell)
								EndIf
							Next
							redraw=#True
						EndIf
					Else
						If Not fullrowselect
							SelectElement(*this\expRows(),0)
							*row=*this\expRows()
							*cell=SelectElement(*row\cells(),0)
							*this\selected(Str(*cell))=#True
							If *this\evtCellSelect
								*this\evtCellSelect(*this\canvas,*cell)
							EndIf
							redraw=#True
						EndIf
					EndIf
					
				EndIf
			Case #PB_Shortcut_Up
				_MyTableClearMaps(*this)
				If ListSize(*this\expRows())>0
					If MapSize(*this\selected())>0
						If fullrowselect
							ForEach *this\selected()
								*row=Val(MapKey(*this\selected()))
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
							Next
							ClearMap(*this\selected())
							ForEach selected()
								*row=selected()
								*this\selected(Str(*row))=#True
								If *this\evtRowSelect
									*this\evtRowSelect(*this\canvas,*row)
								EndIf
							Next
							redraw=#True
						Else
							ForEach *this\selected()
								*cell=Val(MapKey(*this\selected()))
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
									*cell=SelectElement(*row\cells(),colidx)
								EndIf								
								AddElement(selected())
								selected()=*cell
							Next
							ClearMap(*this\selected())
							ForEach selected()
								*cell=selected()
								*this\selected(Str(*cell))=#True
								If *this\evtCellSelect
									*this\evtCellSelect(*this\canvas,*cell)
								EndIf
							Next
							redraw=#True
						EndIf
					Else
						If fullrowselect
							SelectElement(*this\expRows(),ListSize(*this\expRows())-1)
							*row=*this\expRows()
							*this\selected(Str(*row))=#True
							If *this\evtRowSelect
								*this\evtRowSelect(*this\canvas,*row)
							EndIf
							redraw=#True
						Else
							SelectElement(*this\expRows(),ListSize(*this\expRows())-1)
							*row=*this\expRows()
							*cell=SelectElement(*row\cells(),0)
							*this\selected(Str(*cell))=#True
							If *this\evtCellSelect
								*this\evtCellSelect(*this\canvas,*cell)
							EndIf
							redraw=#True
						EndIf
					EndIf
					
				EndIf
			Case #PB_Shortcut_Down
				_MyTableClearMaps(*this)
				If ListSize(*this\expRows())>0
					If MapSize(*this\selected())>0
						If fullrowselect
							ForEach *this\selected()
								*row=Val(MapKey(*this\selected()))
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
							Next
							ClearMap(*this\selected())
							ForEach selected()
								*row=selected()
								*this\selected(Str(*row))=#True
								If *this\evtRowSelect
									*this\evtRowSelect(*this\canvas,*row)
								EndIf
							Next
							redraw=#True
						Else
							ForEach *this\selected()
								*cell=Val(MapKey(*this\selected()))
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
									*cell=SelectElement(*row\cells(),colidx)
								EndIf								
								AddElement(selected())
								selected()=*cell
							Next
							ClearMap(*this\selected())
							ForEach selected()
								*cell=selected()
								*this\selected(Str(*cell))=#True
								If *this\evtCellSelect
									*this\evtCellSelect(*this\canvas,*cell)
								EndIf
							Next
							redraw=#True
						EndIf
					Else
						If fullrowselect
							SelectElement(*this\expRows(),0)
							*row=*this\expRows()
							*this\selected(Str(*row))=#True
							If *this\evtRowSelect
								*this\evtRowSelect(*this\canvas,*row)
							EndIf
							redraw=#True
						Else
							SelectElement(*this\expRows(),0)
							*row=*this\expRows()
							*cell=SelectElement(*row\cells(),0)
							*this\selected(Str(*cell))=#True
							If *this\evtCellSelect
								*this\evtCellSelect(*this\canvas,*cell)
							EndIf
							redraw=#True
						EndIf
					EndIf					
				EndIf
		EndSelect
		If recalc
			*this\dirty=#True
			_MyTableRecalc(*this)
		ElseIf redraw
			*this\dirty=#True
			_MyTableRedraw(*this)
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
		Protected idx=0
		
		Protected h=DesktopScaledY(GadgetHeight(*this\canvas))
		
		my=DesktopUnscaledY(my)
		
		If *this\resizecol
			Protected newx=DesktopUnscaledX(GetGadgetAttribute(*this\canvas,#PB_Canvas_MouseX))-*this\oldx
			SetGadgetAttribute(*this\canvas,#PB_Canvas_Cursor,#PB_Cursor_LeftRight)
			*this\colResize\width+newx
			If *this\colResize\width<0
				*this\colResize\width=0
			EndIf
			*this\colResize\dirty=#True
			*this\oldx=DesktopUnscaledX(GetGadgetAttribute(*this\canvas,#PB_Canvas_MouseX))
			*this\dirty=#True
			_MyTableRecalc(*this)    
		Else
			
			Protected col=0
			Protected fw.b=#False
			SetGadgetAttribute(*this\canvas,#PB_Canvas_Cursor,#PB_Cursor_Default)
			If *this\fixedcolumns>0
				mx=GetGadgetAttribute(*this\canvas,#PB_Canvas_MouseX)
				ForEach *this\cols()
					If ListIndex(*this\cols())<*this\fixedcolumns
						mx-*this\cols()\calcwidth
						If mx>=-MyTableW2 And mx<=MyTableW2
							fw=#True
							If Bool(*this\cols()\flags & #MYTABLE_COLUMN_FLAGS_RESIZEABLE) Or resizecol
								SetGadgetAttribute(*this\canvas,#PB_Canvas_Cursor,#PB_Cursor_LeftRight)
								ProcedureReturn #False
							EndIf
							Break
						EndIf
					EndIf
				Next
			EndIf
			
			If Not fw
				mx=GetGadgetAttribute(*this\canvas,#PB_Canvas_MouseX)+GetGadgetState(*this\hscroll)
				col=0
				ForEach *this\cols()
					mx-*this\cols()\calcwidth
					If mx>=-MyTableW2 And mx<=MyTableW2
						If Bool(*this\cols()\flags & #MYTABLE_COLUMN_FLAGS_RESIZEABLE) Or resizecol
							SetGadgetAttribute(*this\canvas,#PB_Canvas_Cursor,#PB_Cursor_LeftRight)
							ProcedureReturn #False
						EndIf
						Break
						
					EndIf
				Next			
				
			EndIf
		EndIf
		
		If resizerow
			If *this\resizerow
				Protected newy=DesktopUnscaledX(GetGadgetAttribute(*this\canvas,#PB_Canvas_MouseY))-*this\oldy
				SetGadgetAttribute(*this\canvas,#PB_Canvas_Cursor,#PB_Cursor_UpDown)
				*this\rowResize\height+newy
				If *this\rowResize\height<0
					*this\rowResize\height=0
				EndIf
				*this\rowResize\dirty=#True
				*this\oldy=DesktopUnscaledX(GetGadgetAttribute(*this\canvas,#PB_Canvas_MouseY))
				*this\dirty=#True
				_MyTableRecalc(*this)    
			Else
				Protected hh=0
				If Not noheader
					hh+*this\headerheight
				EndIf
				For idx=GetGadgetState(*this\vscroll) To (ListSize(*this\expRows())-1)
					SelectElement(*this\expRows(),idx)
					Protected *row.strMyTableRow=*this\expRows()
					hh+*row\calcheight
					If (hh+mytableh2)>=my And (hh-mytableh2)<=my
						SetGadgetAttribute(*this\canvas,#PB_Canvas_Cursor,#PB_Cursor_UpDown)
						Break
					EndIf
					
					If hh>h
						Break
					EndIf
				Next
			EndIf
		EndIf
		
	EndIf
EndProcedure

Procedure MyTableEvtMouseDown()
	Protected *this.strMyTableTable=GetGadgetData(EventGadget())
	If *this
		
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
		
		my=DesktopUnscaledY(my)
		
		If ms
			SetGadgetState(*this\vscroll,GetGadgetState(*this\vscroll)-ms)
			*this\dirty=#True
		Else
			
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
					If rowresizeable And leftbutton
						If (hh+mytableh2)>=my And (hh-mytableh2)<=my
							*this\resizerow=#True
							*this\rowResize=*row
							*this\oldy=DesktopUnscaledX(GetGadgetAttribute(*this\canvas,#PB_Canvas_MouseY))
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
			Protected fw.b=#False
			
			If *this\fixedcolumns>0
				mx=GetGadgetAttribute(*this\canvas,#PB_Canvas_MouseX)
				ForEach *this\cols()
					If ListIndex(*this\cols())<*this\fixedcolumns
						mx-*this\cols()\calcwidth
						If mx>=-MyTableW2 And mx<=MyTableW2 And leftbutton
							fw=#True
							If Bool(*this\cols()\flags & #MYTABLE_COLUMN_FLAGS_RESIZEABLE) Or colresizeable
								*this\resizecol=#True
								*this\oldx=DesktopUnscaledX(GetGadgetAttribute(*this\canvas,#PB_Canvas_MouseX))-mx
								*this\colResize=*this\cols()
								ProcedureReturn #False
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
					mx-*this\cols()\calcwidth
					If mx>=-MyTableW2 And mx<=MyTableW2 And leftbutton
						
						If Bool(*this\cols()\flags & #MYTABLE_COLUMN_FLAGS_RESIZEABLE) Or colresizeable
							*this\resizecol=#True
							*this\oldx=DesktopUnscaledX(GetGadgetAttribute(*this\canvas,#PB_Canvas_MouseX))-mx
							*this\colResize=*this\cols()
							ProcedureReturn #False
						EndIf
					ElseIf mx<=0
						
						Break
					Else
						col+1
					EndIf
				Next			
			EndIf
			
			If row<cc And col<ListSize(*this\cols())
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
									*this\evtRowChecked(*this\canvas,*row)
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
									*this\evtRowChecked(*this\canvas,*row)
								EndIf
							EndIf
						Default
							If Not control Or Not multiselect
								ClearMap(*this\selected())
							EndIf
							If row=-1 And Not noheader
								If leftbutton
									If _MyTableSort(*this,col)
										recalc=#True
									EndIf
								EndIf
								If rightbutton 
									If *this\evtColRightClick
										*col=SelectElement(*this\cols(),col)
										If *this\evtColRightClick(*this\canvas,*col)									
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
									*this\selected(Str(*row))=Bool(*this\selected(Str(*row))=#False)
									If *this\evtRowSelect
										*this\evtRowSelect(*this\canvas,*row)
									EndIf
									If rightbutton And *this\evtRowRightClick
										*this\evtRowRightClick(*this\canvas,*row)
									EndIf
									
								Else
									*cell=SelectElement(*row\cells(),col)
									*this\selected(Str(*row\cells()))=Bool(*this\selected(Str(*row\cells()))=#False)
									If *this\evtCellSelect
										*this\evtCellSelect(*this\canvas,*cell)
									EndIf
									If rightbutton And *this\evtCellRightClick
										*this\evtCellRightClick(*this\canvas,*cell)
									EndIf
									
								EndIf
							EndIf
							*this\dirty=#True
					EndSelect					
				Else
					If Not control Or Not multiselect
						ClearMap(*this\selected())
					EndIf
					If row=-1 And Not noheader
						If leftbutton
							If _MyTableSort(*this,col)
								recalc=#True
							EndIf
						EndIf
						If rightbutton 
							If *this\evtColRightClick
								*col=SelectElement(*this\cols(),col)
								If *this\evtColRightClick(*this\canvas,*col)									
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
							*this\selected(Str(*row))=Bool(*this\selected(Str(*row))=#False)
							If *this\evtRowSelect
								*this\evtRowSelect(*this\canvas,*row)
							EndIf
							If rightbutton And *this\evtRowRightClick
								*this\evtRowRightClick(*this\canvas,*row)
							EndIf
							
						Else
							*cell=SelectElement(*row\cells(),col)
							*this\selected(Str(*row\cells()))=Bool(*this\selected(Str(*row\cells()))=#False)
							If *this\evtCellSelect
								*this\evtCellSelect(*this\canvas,*cell)
							EndIf
							If rightbutton And *this\evtCellRightClick
								*this\evtCellRightClick(*this\canvas,*cell)
							EndIf
							
						EndIf
					EndIf
					*this\dirty=#True
				EndIf
			Else
				If Not control Or Not multiselect
					ClearMap(*this\selected())
				EndIf
				*this\dirty=#True
			EndIf
		EndIf
		
		If recalc
			_MyTableRecalc(*this)
		ElseIf redraw
			_MyTableRedraw(*this)
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
		Protected my=DesktopUnscaledY(GetGadgetAttribute(*this\canvas,#PB_Canvas_MouseY))
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
						MyTableAutosizeRow(*this\canvas,idx)
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
					MyTableAutosizeColumn(*this\canvas,col)
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
				Protected *cell.strMyTableCell=SelectElement(*row\cells(),col)
				_MyTableEditCell(*cell)				
			EndIf
		EndIf					
		
	EndIf
EndProcedure

Procedure _MyTableRegister(window,canvas,hscroll,vscroll,flags.i=#MYTABLE_TABLE_FLAGS_DEFAULT,callback.MyTableProtoEventCallback=0,name.s="")
	Protected *this.strMyTableTable=AllocateStructure(strMyTableTable)
	With *this
		\name=name
		\window=window
		\canvas=canvas
		\hscroll=hscroll
		\vscroll=vscroll
		\flags=flags
		\type=#MYTABLE_TYPE_TABLE
		If Bool(flags & #MYTABLE_TABLE_FLAGS_HIERARCHICAL_ARROW)
			\flags|#MYTABLE_TABLE_FLAGS_HIERARCHICAL
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

Procedure MyTableRegister(window,canvas,hscroll,vscroll,flags.i=#MYTABLE_TABLE_FLAGS_DEFAULT,callback.MyTableProtoEventCallback=0,name.s="")
	Protected *this.strMyTableTable=_MyTableRegister(window,canvas,hscroll,vscroll,flags,callback,name)
	BindGadgetEvent(canvas,@MyTableEvtResize(),#PB_EventType_Resize)
	_MyTableResize(*this)
	ProcedureReturn *this
EndProcedure

Procedure MyTableRegisterDialog(window,canvas,hscroll,vscroll,flags.i=#MYTABLE_TABLE_FLAGS_DEFAULT,callback.MyTableProtoEventCallback=0,name.s="")
	Protected *this.strMyTableTable=_MyTableRegister(window,canvas,hscroll,vscroll,flags,callback,name)	
	BindGadgetEvent(canvas,@MyTableEvtDialogResize(),#PB_EventType_Resize)
	_MyTableRecalc(*this)
	ProcedureReturn *this
EndProcedure

Procedure MyTableUnRegister(canvas)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
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
	EndIf
	FreeStructure(*this)
EndProcedure

Procedure MyTableSetTableFlags(canvas,flags.i)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		If *this\flags<>flags
			*this\flags=flags
			*this\dirty=#True
			_MyTableRecalc(*this)
		EndIf
	EndIf
EndProcedure

Procedure MyTableSetTableName(canvas,name.s)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		If *this\name<>name
			*this\name=name
		EndIf
	EndIf
EndProcedure


Procedure MyTableSetTableRowHeight(canvas,rowheight.i)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
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
			_MyTableRecalc(*this)
		EndIf
	EndIf
EndProcedure

Procedure MyTableSetTableData(canvas,*data)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		*this\data=*data
	EndIf
EndProcedure

Procedure MyTableSetTableFixedColumns(canvas,columns.i)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		*this\fixedcolumns=columns
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
		_MyTableRedraw(*this)
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
		_MyTableRedraw(*this)
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
		_MyTableRedraw(*this)
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


Procedure MyTableGetTableFlags(canvas)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		ProcedureReturn *this\flags
	EndIf
EndProcedure

Procedure MyTableGetTableRowHeight(canvas)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		ProcedureReturn *this\rowheight
	EndIf
EndProcedure

Procedure MyTableGetTableData(canvas)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		ProcedureReturn *this\data
	EndIf
EndProcedure

Procedure.s MyTableGetTableName(canvas)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		ProcedureReturn *this\name
	EndIf
EndProcedure

Procedure MyTableGetTableFixedColumns(canvas)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		ProcedureReturn *this\fixedcolumns
	EndIf
EndProcedure

Procedure MyTableRedraw(canvas,redraw.b)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		*this\redraw=redraw
		*this\dirty=#True
		_MyTableRecalc(*this)
	EndIf
EndProcedure


Procedure.q MyTableAddColumn(canvas,text.s,width.i,flags.i=#MYTABLE_COLUMN_FLAGS_DEFAULT,image.i=0,*data=0,sort.i=0)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		_callcountStart(addcol)
		LastElement(*this\cols())
		Protected *col.strMyTableCol=AddElement(*this\cols())
		With *col
			\text=text
			\width=width
			\flags=flags
			\image=image
			\data=*data
			\sort=sort
			\dirty=#True
			\type=#MYTABLE_TYPE_COL
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
		EndWith
		*this\colsById(Str(*col\id))=*col
		*this\dirty=#True
		ForEach *this\rows()
			Protected *cell.strMyTableCell=AddElement(*this\rows()\cells())
			*cell\row=*this\rows()
			*cell\col=*col
			*cell\table=*this
		Next
		_callcountEnde(addcol)
		_MyTableRecalc(*this)
		ProcedureReturn *col\id
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
		_MyTableRecalc(*this)
	EndIf
EndProcedure

Procedure MyTableSetColumnText(canvas,column.i,text.s)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		Protected *col.strMyTableCol=SelectElement(*this\cols(),column)
		If *col\text<>text
			*col\text=text
			*col\dirty=#True
			*col\textwidth=0
			*col\textheight=0
			*this\dirty=#True
			_MyTableRedraw(*this)
		EndIf
	EndIf
EndProcedure

Procedure MyTableSetCustomCellEdit(canvas,column.i,evtCustomEditCell.MyTableProtoEventCustomEditCell,evtCancelCustomEditCell.MyTableProtoEventCancelCustomEditCell)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		Protected *col.strMyTableCol=SelectElement(*this\cols(),column)
		
		*col\evtCustomEditCell=evtCustomEditCell
		*col\evtCancelCustomEditCell=evtCancelCustomEditCell
		
	EndIf
EndProcedure

Procedure MyTableSetColumnWidth(canvas,column.i,width.i)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		Protected *col.strMyTableCol=SelectElement(*this\cols(),column)
		If *col\width<>width
			*col\width=width
			*col\dirty=#True
			*this\dirty=#True
			_MyTableRecalc(*this)
		EndIf
	EndIf
EndProcedure

Procedure MyTableSetColumnFlags(canvas,column.i,flags.i)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		Protected *col.strMyTableCol=SelectElement(*this\cols(),column)
		If *col\flags<>flags
			*col\flags=flags
			*col\dirty=#True
			*this\dirty=#True
			If Bool(flags & #MYTABLE_COLUMN_FLAGS_DATE)
				*col\format="%dd.%mm.%yyyy"
			EndIf
			If Bool(flags & #MYTABLE_COLUMN_FLAGS_DATE_TIME)
				*col\format="%dd.%mm.%yyyy %hh:%ii:%ss"
			EndIf
			If Bool(flags & #MYTABLE_COLUMN_FLAGS_TIME)
				*col\format="%hh:%ii"
			EndIf
			If Bool(flags & #MYTABLE_COLUMN_FLAGS_TIME_LONG)
				*col\format="%hh:%ii:%ss"
			EndIf
			_MyTableRedraw(*this)
		EndIf
	EndIf
EndProcedure

Procedure MyTableSetColumnImage(canvas,column.i,image.i)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		Protected *col.strMyTableCol=SelectElement(*this\cols(),column)
		If *col\image<>image
			*col\image=image
			*col\dirty=#True
			*this\dirty=#True
			_MyTableRedraw(*this)
		EndIf
	EndIf
EndProcedure

Procedure MyTableSetColumnData(canvas,column.i,*data)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		Protected *col.strMyTableCol=SelectElement(*this\cols(),column)		
		*col\data=*data		
	EndIf
EndProcedure

Procedure MyTableSetColumnSort(canvas,column.i,sort.i)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		Protected *col.strMyTableCol=SelectElement(*this\cols(),column)
		If *col\sort<>sort
			*col\sort=sort
			*col\dirty=#True
			*this\dirty=#True
			_MyTableRedraw(*this)
		EndIf
	EndIf
EndProcedure

Procedure.s MyTableGetColumnText(canvas,column.i)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		Protected *col.strMyTableCol=SelectElement(*this\cols(),column)
		ProcedureReturn *col\text
	EndIf
EndProcedure

Procedure MyTableGetColumnWidth(canvas,column.i)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		Protected *col.strMyTableCol=SelectElement(*this\cols(),column)
		ProcedureReturn *col\width
	EndIf
EndProcedure

Procedure MyTableGetColumnFlags(canvas,column.i)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		Protected *col.strMyTableCol=SelectElement(*this\cols(),column)
		ProcedureReturn *col\flags
	EndIf
EndProcedure

Procedure MyTableGetColumnImage(canvas,column.i)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		Protected *col.strMyTableCol=SelectElement(*this\cols(),column)
		ProcedureReturn *col\image
	EndIf
EndProcedure

Procedure MyTableGetColumnData(canvas,column.i)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		Protected *col.strMyTableCol=SelectElement(*this\cols(),column)
		ProcedureReturn *col\data
	EndIf
EndProcedure

Procedure MyTableGetColumnSort(canvas,column.i)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		Protected *col.strMyTableCol=SelectElement(*this\cols(),column)
		ProcedureReturn *col\sort
	EndIf
EndProcedure



Procedure MyTableAddDirtyRow(canvas,rows.i,parentid.q=0)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		_callcountStart(adddirtyrows)
		Protected i=0
		Protected *row.strMyTableRow=0
		If parentid>0
			Protected *parent.strMyTableRow=*this\rowsById(Str(parentid))
			LastElement(*parent\rows())
			For i=1 To rows
				*row=AddElement(*this\rows())					
				_MyTableAddDirtyRow(*this,*row)
				*row\level=*parent\level+1
			Next
		Else
			LastElement(*this\rows())
			For i=1 To rows
				*row=AddElement(*this\rows())
				_MyTableAddDirtyRow(*this,*row)				
			Next
		EndIf
		*this\dirty=#True
		_callcountEnde(adddirtyrows)
		_MyTableRecalc(*this)
	EndIf	
EndProcedure

Procedure.q MyTableAddRow(canvas,text.s,sep.s="|",id.q=#PB_Ignore,image.i=0,*data=0,checked.b=#False,expanded.b=#False,parentid.q=0)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		Protected *row.strMyTableRow=0
		If parentid>0
			Protected *parent.strMyTableRow=*this\rowsById(Str(parentid))
			LastElement(*parent\rows())
			*row=AddElement(*parent\rows())
			*row\level=*parent\level+1
		Else
			LastElement(*this\rows())
			*row=AddElement(*this\rows())
		EndIf
		
		With *row
			\height=*this\rowheight
			\brow=#True
			\checked=checked
			\expanded=expanded
			\data=*data
			\image=image
			\type=#MYTABLE_TYPE_ROW
			If IsImage(image)				
				\sclaedimage=CopyImage(image,#PB_Any)
				ResizeImage(\sclaedimage,MyTableW16,MyTableH16)
			EndIf
			If id=#PB_Ignore Or id=*this\lastRowid
				*this\lastRowid+1
				\id=*this\lastRowid
			Else
				\id=id
				*this\lastRowid=id
			EndIf
			\dirty=#True
			\table=*this
			Protected c=CountString(text,sep)+1
			Protected i=0
			For i=1 To c
				Protected *cell.strMyTableCell=AddElement(*row\cells())
				Protected *col.strMyTableCol=SelectElement(*this\cols(),i-1)
				*cell\text=StringField(text,i,sep)
				*cell\row=*row
				*cell\col=*col
				*cell\table=*this
				*cell\type=#MYTABLE_TYPE_CELL
				If Bool(*col\flags & #MYTABLE_COLUMN_FLAGS_DEFAULT_DATE_TIME)
					*cell\value=ParseDate(*col\format,*cell\text)
				ElseIf Bool(*col\flags & #MYTABLE_COLUMN_FLAGS_INTEGER)
					*cell\value=Val(*cell\text)
				ElseIf Bool(*col\flags & #MYTABLE_COLUMN_FLAGS_DOUBLE)
					*cell\value=ValD(*cell\text)
				ElseIf Bool(*col\flags & #MYTABLE_COLUMN_FLAGS_BOOLEAN)
					*cell\value=Bool(*cell\text="1" Or 
					                 LCase(*cell\text)="x" Or 
					                 LCase(*cell\text)="true" Or
					                 LCase(*cell\text)="yes")
					*cell\checked=*cell\value
				EndIf
			Next
		EndWith
		*this\rowsById(Str(*row\id))=*row
		*this\dirty=#True
		_MyTableRecalc(*this)
		ProcedureReturn *row\id
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
		_MyTableRecalc(*this)
	EndIf
EndProcedure

Procedure MyTableClearRows(canvas)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		ClearList(*this\rows())
		ClearMap(*this\rowsById())
		*this\dirty=#True
		*this\lastRowid=0
		_MyTableRecalc(*this)
	EndIf
EndProcedure


Procedure MyTableSetRowImage(canvas,row.i,image.i)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		Protected *row.strMyTableRow=SelectElement(*this\rows(),row)
		If *row\image<>image
			*row\image=image
			*row\dirty=#True
			*this\dirty=#True
			If IsImage(*row\sclaedimage)
				FreeImage(*row\sclaedimage)				
			EndIf
			If IsImage(image)				
				*row\sclaedimage=CopyImage(image,#PB_Any)
				ResizeImage(*row\sclaedimage,MyTableW16,MyTableH16)
			EndIf
			_MyTableRedraw(*this)
		EndIf
	EndIf
EndProcedure

Procedure MyTableSetRowData(canvas,row.i,*data)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		Protected *row.strMyTableRow=SelectElement(*this\rows(),row)
		*row\data=*data		
	EndIf
EndProcedure


Procedure MyTableSetRowDirty(canvas,row.i)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		Protected *row.strMyTableRow=SelectElement(*this\rows(),row)
		*row\dirty=#True
		_MyTableRedraw(*this)
	EndIf
EndProcedure

Procedure MyTableSetRowChecked(canvas,row.i,checked.b)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		Protected *row.strMyTableRow=SelectElement(*this\rows(),row)
		If *row\checked<>checked
			*row\checked=checked
			*row\dirty=#True
			*this\dirty=#True
			_MyTableRedraw(*this)
		EndIf
	EndIf
EndProcedure

Procedure MyTableSetRowExpanded(canvas,row.i,expanded.b)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		Protected *row.strMyTableRow=SelectElement(*this\rows(),row)
		If *row\expanded<>expanded
			*row\expanded=expanded
			*row\dirty=#True
			*this\dirty=#True
			_MyTableRecalc(*this)
		EndIf
	EndIf
EndProcedure

Procedure MyTableSetRowHeight(canvas,row.i,height.i)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		Protected *row.strMyTableRow=SelectElement(*this\rows(),row)
		If *row
			If *row\height<>height
				*row\height=height
				*row\dirty=#True
				*this\dirty=#True
				_MyTableRecalc(*this)
			EndIf
		EndIf
	EndIf
EndProcedure

Procedure MyTableGetRowImage(canvas,row.i)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		Protected *row.strMyTableRow=SelectElement(*this\rows(),row)
		ProcedureReturn *row\image
	EndIf
EndProcedure

Procedure MyTableGetRowData(canvas,row.i)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		Protected *row.strMyTableRow=SelectElement(*this\rows(),row)
		ProcedureReturn *row\data
	EndIf
EndProcedure

Procedure MyTableGetRowHeight(canvas,row.i)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		Protected *row.strMyTableRow=SelectElement(*this\rows(),row)
		ProcedureReturn *row\height
	EndIf
EndProcedure

Procedure MyTableGetRowCount(canvas)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		ProcedureReturn ListSize(*this\expRows())
	EndIf
EndProcedure

Procedure.b MyTableGetRowChecked(canvas,row.i)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		Protected *row.strMyTableRow=SelectElement(*this\rows(),row)
		ProcedureReturn *row\checked
	EndIf
EndProcedure

Procedure.b MyTableGetRowExpanded(canvas,row.i)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		Protected *row.strMyTableRow=SelectElement(*this\rows(),row)
		ProcedureReturn *row\expanded
	EndIf
EndProcedure

Procedure MyTableSetCellText(canvas,row.i,col.i,text.s)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		Protected *row.strMyTableRow=SelectElement(*this\rows(),row)
		Protected *cell.strMyTableCell=SelectElement(*this\rows()\cells(),col)
		Protected *col.strMyTableCol=*cell\col
		If *cell\text<>text
			*cell\text=text
			*cell\textwidth=0
			*cell\textheight=0
			*cell\dirty=#True
			If Bool(*col\flags & #MYTABLE_COLUMN_FLAGS_DEFAULT_DATE_TIME)
				*cell\value=ParseDate(*col\format,*cell\text)
			ElseIf Bool(*col\flags & #MYTABLE_COLUMN_FLAGS_INTEGER)
				*cell\value=Val(*cell\text)
			ElseIf Bool(*col\flags & #MYTABLE_COLUMN_FLAGS_DOUBLE)
				*cell\value=ValD(*cell\text)
			ElseIf Bool(*col\flags & #MYTABLE_COLUMN_FLAGS_BOOLEAN)
				*cell\value=Bool(*cell\text="1" Or 
				                 LCase(*cell\text)="x" Or 
				                 LCase(*cell\text)="true" Or
				                 LCase(*cell\text)="yes")
				*cell\checked=*cell\value
			EndIf
			_MyTableRedraw(*this)
		EndIf
	EndIf
EndProcedure

Procedure MyTableSetCellValue(canvas,row.i,col.i,value.d)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		Protected *row.strMyTableRow=SelectElement(*this\rows(),row)
		Protected *cell.strMyTableCell=SelectElement(*this\rows()\cells(),col)
		Protected *col.strMyTableCol=*cell\col
		If *cell\value<>value		
			*cell\value=value		
			*cell\textwidth=0
			*cell\textheight=0
			*cell\dirty=#True
			If Bool(*col\flags & #MYTABLE_COLUMN_FLAGS_DEFAULT_DATE_TIME)
				If value
					*cell\text=""
				Else
					*cell\text=FormatDate(*col\format,*cell\value)
				EndIf
			ElseIf Bool(*col\flags & #MYTABLE_COLUMN_FLAGS_INTEGER)
				*cell\text=Str(value)
			ElseIf Bool(*col\flags & #MYTABLE_COLUMN_FLAGS_DOUBLE)
				*cell\text=FormatNumber(value)
			ElseIf Bool(*col\flags & #MYTABLE_COLUMN_FLAGS_BOOLEAN)
				*cell\checked=*cell\value
				*cell\text=Str(value)
			EndIf
			_MyTableRedraw(*this)
		EndIf
	EndIf
EndProcedure

Procedure MyTableSetCellChecked(canvas,row.i,col.i,checked.b)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		Protected *row.strMyTableRow=SelectElement(*this\rows(),row)
		Protected *cell.strMyTableCell=SelectElement(*this\rows()\cells(),col)
		Protected *col.strMyTableCol=*cell\col
		If *cell\checked<>checked
			*cell\value=checked		
			*cell\checked=checked		
			*cell\textwidth=0
			*cell\textheight=0
			*cell\dirty=#True				
			*cell\text=Str(checked)		
			_MyTableRedraw(*this)
		EndIf
	EndIf
EndProcedure

Procedure MyTableSetCellData(canvas,row.i,col.i,*data)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		Protected *row.strMyTableRow=SelectElement(*this\rows(),row)
		Protected *cell.strMyTableCell=SelectElement(*this\rows()\cells(),col)
		Protected *col.strMyTableCol=*cell\col
		*cell\data=*data
	EndIf
EndProcedure

Procedure MyTableSetCellImage(canvas,row.i,col.i,image.i)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		Protected *row.strMyTableRow=SelectElement(*this\rows(),row)
		Protected *cell.strMyTableCell=SelectElement(*this\rows()\cells(),col)
		Protected *col.strMyTableCol=*cell\col
		If *cell\image<>image
			*cell\image=image		
			If IsImage(image)
				*cell\textheight=ImageHeight(image)
				*cell\textwidth=ImageWidth(image)
			Else
				*cell\textheight=0
				*cell\textwidth=0
			EndIf
			*cell\dirty=#True							
			_MyTableRedraw(*this)
		EndIf
	EndIf
EndProcedure

Procedure.s MyTableGetCellText(canvas,row.i,col.i)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		Protected *row.strMyTableRow=SelectElement(*this\rows(),row)
		Protected *cell.strMyTableCell=SelectElement(*this\rows()\cells(),col)		
		ProcedureReturn *cell\text
	EndIf
EndProcedure

Procedure.d MyTableGetCellValue(canvas,row.i,col.i)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		Protected *row.strMyTableRow=SelectElement(*this\rows(),row)
		Protected *cell.strMyTableCell=SelectElement(*this\rows()\cells(),col)		
		ProcedureReturn *cell\value
	EndIf
EndProcedure

Procedure MyTableGetCellChecked(canvas,row.i,col.i)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		Protected *row.strMyTableRow=SelectElement(*this\rows(),row)
		Protected *cell.strMyTableCell=SelectElement(*this\rows()\cells(),col)		
		ProcedureReturn *cell\checked
	EndIf
EndProcedure

Procedure MyTableGetCellData(canvas,row.i,col.i)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		Protected *row.strMyTableRow=SelectElement(*this\rows(),row)
		Protected *cell.strMyTableCell=SelectElement(*this\rows()\cells(),col)		
		ProcedureReturn *cell\data
	EndIf
EndProcedure

Procedure MyTableGetCellImage(canvas,row.i,col.i)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		Protected *row.strMyTableRow=SelectElement(*this\rows(),row)
		Protected *cell.strMyTableCell=SelectElement(*this\rows()\cells(),col)		
		ProcedureReturn *cell\image
	EndIf
EndProcedure

Procedure MyTableSetEventRowSelected(canvas,event.MyTableProtoEventRowSelected)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		*this\evtRowSelect=event
	EndIf
EndProcedure

Procedure MyTableSetEventCellSelected(canvas,event.MyTableProtoEventCellSelected)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		*this\evtCellSelect=event
	EndIf
EndProcedure

Procedure MyTableSetEventRowChecked(canvas,event.MyTableProtoEventRowChecked)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		*this\evtRowChecked=event
	EndIf
EndProcedure

Procedure MyTableSetEventRowRightClick(canvas,event.MyTableProtoEventRowRightClick)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		*this\evtRowRightClick=event
	EndIf
EndProcedure

Procedure MyTableSetEventColRightClick(canvas,event.MyTableProtoEventColRightClick)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		*this\evtColRightClick=event
	EndIf
EndProcedure

Procedure MyTableSetEventCellChecked(canvas,event.MyTableProtoEventCellChecked)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		*this\evtCellChecked=event
	EndIf
EndProcedure

Procedure MyTableSetEventCellRightClick(canvas,event.MyTableProtoEventCellRightClick)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		*this\evtCellRightClick=event
	EndIf
EndProcedure

Procedure MyTableSetEventCellChangedText(canvas,event.MyTableProtoEventCellChangedText)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		*this\evtCellChangedText=event
	EndIf
EndProcedure

Procedure MyTableSetEventCellChangedValue(canvas,event.MyTableProtoEventCellChangedValue)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		*this\evtCellChangedValue=event
	EndIf
EndProcedure

Procedure MyTableSetEventCallback(canvas,event.MyTableProtoEventCallback)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		*this\evtCallback=event
	EndIf
EndProcedure


Procedure MyTableSetSelectedbackground(canvas,color.q)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		If *this\selectedbackground<>color
			*this\selectedbackground=color
			*this\dirty=#True
			_MyTableRedraw(*this)
		EndIf
	EndIf
EndProcedure

Procedure MyTableSetBackground(canvas,color.q)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		If *this\background<>color
			*this\background=color
			*this\dirty=#True
			_MyTableRedraw(*this)
		EndIf
	EndIf
EndProcedure

Procedure MyTableSetBackgroundFixedColumns(canvas,color.q)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		If *this\backgroundfixed<>color
			*this\backgroundfixed=color
			*this\dirty=#True
			_MyTableRedraw(*this)
		EndIf
	EndIf
EndProcedure

Procedure MyTableSetHeaderbackground1(canvas,color.q)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		If *this\headerbackground1<>color
			*this\headerbackground1=color
			*this\dirty=#True
			_MyTableRedraw(*this)
		EndIf
	EndIf
EndProcedure

Procedure MyTableSetHeaderbackground2(canvas,color.q)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		If *this\headerbackground2<>color
			*this\headerbackground2=color
			*this\dirty=#True
			_MyTableRedraw(*this)
		EndIf
	EndIf
EndProcedure

Procedure MyTableSetHeaderbackgroundFixedColumns(canvas,color.q)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		If *this\headerbackgroundfixed<>color
			*this\headerbackgroundfixed=color
			*this\dirty=#True
			_MyTableRedraw(*this)
		EndIf
	EndIf
EndProcedure

Procedure MyTableSetForecolor(canvas,color.q)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		If *this\forecolor<>color
			*this\forecolor=color
			*this\dirty=#True
			_MyTableRedraw(*this)
		EndIf
	EndIf
EndProcedure

Procedure MyTableSetHeaderforecolor(canvas,color.q)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		If *this\headerforecolor<>color
			*this\headerforecolor=color
			*this\dirty=#True
			_MyTableRedraw(*this)
		EndIf
	EndIf
EndProcedure

Procedure MyTableSetSelectedforecolor(canvas,color.q)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		If *this\selectedforecolor<>color
			*this\selectedforecolor=color
			*this\dirty=#True
			_MyTableRedraw(*this)
		EndIf
	EndIf
EndProcedure

Procedure.q MyTableGetSelectedbackground(canvas)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		ProcedureReturn *this\selectedbackground
	EndIf
EndProcedure

Procedure.q MyTableGetBackground(canvas)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		ProcedureReturn *this\background
	EndIf
EndProcedure

Procedure.q MyTableGetBackgroundFixedColumns(canvas)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		ProcedureReturn *this\backgroundfixed
	EndIf
EndProcedure

Procedure.q MyTableGetHeaderbackground1(canvas)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		ProcedureReturn *this\headerbackground1
	EndIf
EndProcedure

Procedure.q MyTableGetHeaderbackground2(canvas)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		ProcedureReturn *this\headerbackground2
	EndIf
EndProcedure

Procedure.q MyTableGetHeaderbackgroundFixedColumns(canvas)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		ProcedureReturn *this\headerbackgroundfixed
	EndIf
EndProcedure

Procedure.q MyTableGetForecolor(canvas)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		ProcedureReturn *this\forecolor
	EndIf
EndProcedure

Procedure.q MyTableGetHeaderforecolor(canvas)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		ProcedureReturn *this\headerforecolor
	EndIf
EndProcedure

Procedure.q MyTableGetSelectedforecolor(canvas)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		ProcedureReturn *this\selectedforecolor
	EndIf
EndProcedure

Procedure MyTableAutosizeColumn(canvas,col.i)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	Protected *row.strMyTableRow=0
	
	Static NewMap all.b()
	
	If *this
		
		If col=#PB_Ignore
			_callcountStart(autosizecol)
			Protected c=ListSize(*this\cols())-1
			Protected i=0
			all(Str(canvas))=#True
			_MyTableRecalc(*this,#True)
			For i=0 To c
				MyTableAutosizeColumn(canvas,i)
			Next
			all(Str(canvas))=#False
		Else
			StartDrawing(CanvasOutput(*this\canvas))			
			DrawingFont(*this\font)
			
			If Not all(Str(canvas))
				_MyTableRecalc(*this,#True)
			EndIf
			
			Protected w=0
			Protected *col.strMyTableCol=SelectElement(*this\cols(),col)
			w=_MyTableTextWidth(*col\text)
			
			ForEach *this\expRows()
				*row=*this\expRows()
				Protected *cell.strMyTableCell=SelectElement(*row\cells(),col)
				If *cell
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
					If *cell\textwidth>w
						w=*cell\textwidth
					EndIf
				EndIf
			Next
			*col\width=w+40
			*col\calcwidth=DesktopScaledX(*col\width)
			
			StopDrawing()
		EndIf
		If Not all(Str(canvas))
			_callcountEnde(autosizecol)
			*this\dirty=#True
			_MyTableRedraw(*this)
		EndIf
	EndIf
EndProcedure

Procedure MyTableAutosizeRow(canvas,row.i)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	Static NewMap all.b()
	
	If *this
		
		If row=#PB_Ignore
			_callcountStart(autosizerow)
			Protected c=ListSize(*this\rows())-1
			Protected i=0
			all(Str(canvas))=#True
			For i=0 To c
				MyTableAutosizeRow(canvas,i)
			Next
			all(Str(canvas))=#False
		Else
			
			Protected *row.strMyTableRow=SelectElement(*this\rows(),row)
			*row\dirty=#True
			*row\height=0
			ForEach *row\cells()
				If *row\cells()\textheight>*row\height
					*row\height=*row\cells()\textheight
				EndIf
			Next
			*row\height+4
			*row\calcheight=DesktopScaledY(*row\height)
			
			
		EndIf
		If Not all(Str(canvas))
			_callcountEnde(autosizerow)
			*this\dirty=#True
			_MyTableRecalc(*this)
		EndIf
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