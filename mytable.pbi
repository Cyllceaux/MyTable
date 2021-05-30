;/ ===========================
;/ =   mytable.pbi           =
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

XIncludeFile "global.pbi"

DeclareModule MyTable
	
	
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
		#MYTABLE_TABLE_FLAGS_EDITABLE	
		#MYTABLE_TABLE_FLAGS_READONLY
	EndEnumeration
	
	#MYTABLE_TABLE_FLAGS_DEFAULT=#MYTABLE_TABLE_FLAGS_GRID|#MYTABLE_TABLE_FLAGS_SORTABLE|#MYTABLE_TABLE_FLAGS_ROW_RESIZEABLE|#MYTABLE_TABLE_FLAGS_COL_RESIZEABLE
	#MYTABLE_TABLE_FLAGS_GRID_DEFAULT=#MYTABLE_TABLE_FLAGS_MULTISELECT|#MYTABLE_TABLE_FLAGS_ALL_ROW_COUNT|#MYTABLE_TABLE_FLAGS_EDITABLE|#MYTABLE_TABLE_FLAGS_GRID|#MYTABLE_TABLE_FLAGS_ROW_RESIZEABLE|#MYTABLE_TABLE_FLAGS_COL_RESIZEABLE
	
	
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
		#MYTABLE_COLUMN_FLAGS_NO_EDITABLE
		#MYTABLE_COLUMN_FLAGS_IMAGE
		#MYTABLE_COLUMN_FLAGS_TOP
		#MYTABLE_COLUMN_FLAGS_MIDDLE
		#MYTABLE_COLUMN_FLAGS_BOTTOM
		#MYTABLE_COLUMN_FLAGS_RESIZEABLE
		#MYTABLE_COLUMN_FLAGS_SORTABLE
		#MYTABLE_COLUMN_FLAGS_NO_RESIZEABLE
	EndEnumeration
	
	#MYTABLE_COLUMN_FLAGS_DEFAULT = #MYTABLE_COLUMN_FLAGS_LEFT|#MYTABLE_COLUMN_FLAGS_TEXT
	#MYTABLE_COLUMN_FLAGS_DEFAULT_DATE = #MYTABLE_COLUMN_FLAGS_DATE|#MYTABLE_COLUMN_FLAGS_DATE_TIME
	#MYTABLE_COLUMN_FLAGS_DEFAULT_TIME = #MYTABLE_COLUMN_FLAGS_TIME|#MYTABLE_COLUMN_FLAGS_TIME_LONG
	#MYTABLE_COLUMN_FLAGS_DEFAULT_DATE_TIME = #MYTABLE_COLUMN_FLAGS_DEFAULT_DATE|#MYTABLE_COLUMN_FLAGS_DEFAULT_TIME
	
	CompilerIf Defined(MYTABLE_FORMULA,#PB_Module)
		
		EnumerationBinary _MyTableTableFlags
			#MYTABLE_TABLE_FLAGS_FORMULA
		EndEnumeration
		
		#MYTABLE_TABLE_FLAGS_GRID_FORMULA_DEFAULT=#MYTABLE_TABLE_FLAGS_GRID_DEFAULT|#MYTABLE_TABLE_FLAGS_FORMULA		
		
		Prototype.s MyTableProtoFormula(name.s,List cells.s())
		
	CompilerEndIf
	
	CompilerIf Defined(MYTABLE_MATRIX,#PB_Module)
		
		EnumerationBinary _MyTableTableFlags
			#MYTABLE_TABLE_FLAGS_MATRIX
		EndEnumeration
		
		#MYTABLE_TABLE_FLAGS_GRID_MATRIX_DEFAULT=#MYTABLE_TABLE_FLAGS_GRID_DEFAULT|#MYTABLE_TABLE_FLAGS_MATRIX
		
		CompilerIf Defined(MYTABLE_FORMULA,#PB_Module)
			#MYTABLE_TABLE_FLAGS_GRID_FORMULA_MATRIX_DEFAULT=#MYTABLE_TABLE_FLAGS_GRID_FORMULA_DEFAULT|#MYTABLE_TABLE_FLAGS_MATRIX
		CompilerEndIf
		
	CompilerEndIf
	
	Prototype MyTableProtoEventRowSelected(*row)
	Prototype MyTableProtoEventCellSelected(*cell)
	Prototype MyTableProtoEventRowChecked(*row)
	Prototype MyTableProtoEventRowRightClick(*row)
	Prototype MyTableProtoEventColRightClick(*col)
	Prototype MyTableProtoEventCellChecked(*cell)
	Prototype MyTableProtoEventCellRightClick(*cell)
	Prototype MyTableProtoEventCellChangedText(*cell,old.s)
	Prototype MyTableProtoEventCellChangedValue(*cell,old.d)
	Prototype MyTableProtoEventCallback(*row)
	Prototype MyTableProtoEventCancelCustomEditCell(*cell)
	Prototype MyTableProtoEventCustomEditCell(*cell,x,y,w,h)
	
	
	
	Enumeration _mytable_type
		#MYTABLE_TYPE_NONE
		#MYTABLE_TYPE_APPLICATION
		#MYTABLE_TYPE_TABLE
		#MYTABLE_TYPE_ROW
		#MYTABLE_TYPE_COL
		#MYTABLE_TYPE_CELL
	EndEnumeration
	
	Interface _MyTableUAObject
		Dirty()
		GetType()
	EndInterface
	
	Interface _MyTableObject Extends _MyTableUAObject		
		GetFlags()
		SetFlags(value.i)
		GetSelectedbackground.q()
		SetSelectedbackground(value.q)
		GetBackground.q()
		SetBackground(value.q)
		GetBackgroundfixed.q()
		SetBackgroundfixed(value.q)		
		GetForecolor.q()
		SetForecolor(value.q)
		GetSelectedforecolor.q()
		SetSelectedforecolor(value.q)
		GetFont.i()
		SetFont(value.i)
	EndInterface
	
	Interface MyTableCell Extends _MyTableObject
		GetTable()
		GetRow()
		GetColumn()
		GetText.s()
		SetText(value.s)
		GetTooltip.s()
		SetTooltip(value.s)
		GetData()
		SetData(*value)
		GetImage()
		SetImage(image.i)
		GetValue.d()
		SetValue(value.d)
		CompilerIf Defined(MYTABLE_FORMULA,#PB_Module)
			GetFormula.s()			
			SetFormula(value.s)
		CompilerEndIf
		CompilerIf Defined(MYTABLE_MATRIX,#PB_Module)
			GetMatrix.s()
			SetMatrix(value.s)
		CompilerEndIf
	EndInterface
	
	Interface MyTableCol Extends _MyTableObject
		GetID()
		GetTable()
		GetText.s()
		SetText(value.s)
		GetTooltip.s()
		SetTooltip(value.s)
		GetFormat.s()
		SetFormat(value.s)
		GetImage()
		SetImage(image.i)
		GetData()
		SetData(*value)
		GetCanNull.b()
		SetCanNull(cannull.i)
		GetSort()
		SetSort(image.i)
		
		SetCustomCellEdit(event.MyTableProtoEventCustomEditCell,event.MyTableProtoEventCancelCustomEditCell)
	EndInterface
	
	Interface MyTableRow Extends _MyTableObject
		GetID()
		GetTable()
		GetTooltip.s()
		SetTooltip(value.s)
		GetData()
		SetData(*value)
		GetImage()
		SetImage(image.i)
		GetRowHeight()
		SetRowHeight(value.i)
		AddDirtyRows(rows.i)
		GetCell(col.i)
		GetCells(List cells.MyTableCell())
		AddRow(text.s,sep.s="|",id.q=#PB_Ignore,image.i=0,*data=0,checked.b=#False,expanded.b=#False,tooltip.s="")
	EndInterface
	
	Interface MyTableTable Extends _MyTableObject
		GetApplication()
		GetHeaderbackground1.q()
		SetHeaderbackground1(value.q)
		GetHeaderbackground2.q()
		SetHeaderbackground2(value.q)
		GetHeaderbackgroundfixed.q()
		SetHeaderbackgroundfixed(value.q)
		GetHeaderforecolor.q()
		SetHeaderforecolor(value.q)
		GetCanvas()
		UnRegister()
		ClearRows()
		ClearColumns()
		Recalc()
		Redraw()
		SetRedraw(redraw.b)
		AddColumn(text.s,width.i,flags.i=#MYTABLE_COLUMN_FLAGS_DEFAULT,image.i=0,*data=0,sort.i=0,tooltip.s="")
		AddRow(text.s,sep.s="|",id.q=#PB_Ignore,image.i=0,*data=0,checked.b=#False,expanded.b=#False,tooltip.s="")
		AutosizeColumn(col.i=#PB_Ignore)
		AutosizeHeader(col.i=#PB_Ignore)
		AutosizeRow(row.i=#PB_Ignore)
		AddDirtyRows(rows.i)
		GetRow(row.i)
		GetCol(col.i)
		GetCell(row.i,col.i)
		
		GetRowCount()
		GetColCount()
		
		GetCellText.s(row.i,col.i)
		SetCellText(row.i,col.i,value.s)
		GetCellTooltip.s(row.i,col.i)
		SetCellTooltip(row.i,col.i,value.s)
		GetCellValue.d(row.i,col.i)
		SetCellValue(row.i,col.i,value.d)
		CompilerIf Defined(MYTABLE_FORMULA,#PB_Module)
			GetCellFormula.s(row.i,col.i)
			SetCellFormula(row.i,col.i,value.s)
			SetRecalc(value.b)
		CompilerEndIf
		CompilerIf Defined(MYTABLE_MATRIX,#PB_Module)
			GetCellMatrix.s(row.i,col.i)
			SetCellMatrix(row.i,col.i,value.s)
		CompilerEndIf
		GetCellImage(row.i,col.i)
		SetCellImage(row.i,col.i,value.i)
		
		GetDefaultRowHeight()
		SetDefaultRowHeight(value.i)
		GetRowHeight()
		SetRowHeight(row.i,value.i)
		GetFixedColumns()
		SetFixedColumns(value.i)
		
		SetEventRowSelected(event.MyTableProtoEventRowSelected)
		SetEventCellSelected(event.MyTableProtoEventCellSelected)
		SetEventRowChecked(event.MyTableProtoEventRowChecked)
		SetEventRowRightClick(event.MyTableProtoEventRowRightClick)
		SetEventColRightClick(event.MyTableProtoEventColRightClick)
		SetEventCellChecked(event.MyTableProtoEventCellChecked)
		SetEventCellRightClick(event.MyTableProtoEventCellRightClick)
		SetEventCellChangedText(event.MyTableProtoEventCellChangedText)
		SetEventCellChangedValue(event.MyTableProtoEventCellChangedValue)
		SetEventCallback(event.MyTableProtoEventCallback)
		
		SetCustomCellEdit(col.i,event.MyTableProtoEventCustomEditCell,event.MyTableProtoEventCancelCustomEditCell)
		CompilerIf Defined(MYTABLE_FORMULA,#PB_Module)
			RegisterFormula(name.s,method.MyTableProtoFormula)
		CompilerEndIf
	EndInterface
	
	Interface MyTableApplication Extends _MyTableUAObject
		Register(window,canvas,hscroll,vscroll,flags.i=#MYTABLE_TABLE_FLAGS_DEFAULT,callback.MyTableProtoEventCallback=0,name.s="")
		RegisterDialog(window,canvas,hscroll,vscroll,flags.i=#MYTABLE_TABLE_FLAGS_DEFAULT,callback.MyTableProtoEventCallback=0,name.s="")
		GridRegister(window,canvas,hscroll,vscroll,rows.i,cols.i,flags.i=#MYTABLE_TABLE_FLAGS_GRID_DEFAULT,callback.MyTableProtoEventCallback=0,name.s="")
		GridRegisterDialog(window,canvas,hscroll,vscroll,rows.i,cols.i,flags.i=#MYTABLE_TABLE_FLAGS_GRID_DEFAULT,callback.MyTableProtoEventCallback=0,name.s="")
		Unregister()
		CompilerIf Defined(MYTABLE_FORMULA,#PB_Module)
			Recalc()
			SetRecalc(value.b)
		CompilerEndIf
	EndInterface
	
	Declare MyTableCreateApplication()
	
	Declare MyTableRegister(window,canvas,hscroll,vscroll,flags.i=#MYTABLE_TABLE_FLAGS_DEFAULT,callback.MyTableProtoEventCallback=0,name.s="")
	Declare MyTableRegisterDialog(window,canvas,hscroll,vscroll,flags.i=#MYTABLE_TABLE_FLAGS_DEFAULT,callback.MyTableProtoEventCallback=0,name.s="")
	Declare MyTableGridRegister(window,canvas,hscroll,vscroll,rows.i,cols.i,flags.i=#MYTABLE_TABLE_FLAGS_GRID_DEFAULT,callback.MyTableProtoEventCallback=0,name.s="")
	Declare MyTableGridRegisterDialog(window,canvas,hscroll,vscroll,rows.i,cols.i,flags.i=#MYTABLE_TABLE_FLAGS_GRID_DEFAULT,callback.MyTableProtoEventCallback=0,name.s="")
	
EndDeclareModule

XIncludeFile "mytable.pb"
