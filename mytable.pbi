XIncludeFile "my.pbi"
XIncludeFile "myfont.pbi"

DeclareModule MyTable
	
	#VERSION = 3543
	#VERSION_DATE = 20210701


	
	Interface MyTableBorder
		GetType()
		GetObject()
		GetStyle()
		
		SetColor(value.q):GetColor.q()
		SetWidth(value.i):GetWidth.i()
		
		Free()
		Delete()
	EndInterface
	
	Interface MyTableStyle
		GetType()
		GetObject()
		
		getBorderDefault()
		getBorderTop()
		getBorderLeft()
		getBorderRight()
		getBorderBottom()
		
		SetFont(*font.MyFont::MyFont):GetFont()
		SetBackColor(value.q):GetBackColor.q()
		SetFrontColor(value.q):GetFrontColor.q()
		SetForeColor(value.q):GetForeColor.q()
		SetHAlign(value.i):GetHAlign()
		SetVAlign(value.i):GetVAlign()	
		SetBorder(value.i):GetBorder()	
		
		Free()
		Delete()
	EndInterface
	
	Enumeration _mytable_style_valign
		#MYTABLE_STYLE_VALIGN_TOP
		#MYTABLE_STYLE_VALIGN_MIDDLE
		#MYTABLE_STYLE_VALIGN_BOTTOM
	EndEnumeration
	
	Enumeration _mytable_style_halign
		#MYTABLE_STYLE_HALIGN_LEFT
		#MYTABLE_STYLE_HALIGN_CENTER
		#MYTABLE_STYLE_HALIGN_RIGHT
	EndEnumeration
	
	EnumerationBinary _mytable_style_border
		#MYTABLE_STYLE_BORDER_NONE
		#MYTABLE_STYLE_BORDER_TOP
		#MYTABLE_STYLE_BORDER_RIGHT
		#MYTABLE_STYLE_BORDER_BOTTOM
		#MYTABLE_STYLE_BORDER_LEFT
	EndEnumeration
	
	#MYTABLE_STYLE_BORDER_ALL=#MYTABLE_STYLE_BORDER_TOP|#MYTABLE_STYLE_BORDER_RIGHT|#MYTABLE_STYLE_BORDER_BOTTOM|#MYTABLE_STYLE_BORDER_LEFT
	
	
	
	Interface MyTableObject
		GetType()
		GetDefaultStyle()
		GetSelectedStyle()
		GetMouseOverStyle()
		GetDisabledStyle()
		GetFixedStyle()
		SetFlags(value.i):GetFlags()
		SetData(*value):GetData()
		SetDirty(value.b):GetDirty.b()
		SetSelected(value.b):GetSelected.b()
		SetTooltip(value.s):GetTooltip.s()
		SetDisabled(value.b):GetDisabled.b()
		
		Autosize()
	EndInterface
	
	EnumerationBinary _mytable_cell	
		#MYTABLE_CELL_FLAGS_NO_CHECKBOXES
		#MYTABLE_CELL_FLAGS_CHECKBOXES
		#MYTABLE_CELL_FLAGS_EDITABLE
		#MYTABLE_CELL_FLAGS_NO_EDITABLE
	EndEnumeration
	
	Enumeration _mytable_datatype
		#MYTABLE_DATATYPE_DEFAULT
		#MYTABLE_DATATYPE_NUMBER
		#MYTABLE_DATATYPE_DATE
		#MYTABLE_DATATYPE_TEXT
	EndEnumeration
	
	Interface MyTableCell Extends MyTableObject
		GetApplication()
		GetTable()
		GetRow()
		GetCol()
		GetParent()
		SetText(value.s):GetText.s()
		SetFormula(value.s):GetFormula.s()
		SetMask(value.s):GetMask.s()
		SetDatatype(value.i):GetDatatype.i()
		SetValue(value.d):GetValue.d()
		SetImageLeft(value.i):GetImageLeft.i()
		SetImageRight(value.i):GetImageRight.i()
		SetChecked(value.b):GetChecked.b()
		SetColspan(value.i):GetColspan.i()
		
		AddCell(text.s,image.i=0,flags.i=0)
		DeleteCell(row.i)
		GetCell(row.i)
		CountCells()
		ScrollTo(setSelect.b=#False,redraw.b=#True)
		StartEdit()
		StopEdit()
	EndInterface
	
	EnumerationBinary _mytable_col
		#MYTABLE_COL_FLAGS_NO_CHECKBOXES
		#MYTABLE_COL_FLAGS_CHECKBOXES
		#MYTABLE_COL_FLAGS_SORTABLE
		#MYTABLE_COL_FLAGS_NO_SORTABLE
		#MYTABLE_COL_FLAGS_RESIZABLE
		#MYTABLE_COL_FLAGS_NO_RESIZABLE
		#MYTABLE_COL_FLAGS_EDITABLE
		#MYTABLE_COL_FLAGS_NO_EDITABLE
	EndEnumeration
	
	Enumeration _mytable_col_sort
		#MYTABLE_COL_SORT_NONE
		#MYTABLE_COL_SORT_ASC
		#MYTABLE_COL_SORT_DESC
	EndEnumeration
	
	Interface MyTableCol Extends MyTableObject
		GetElementSelectedStyle()
		GetApplication()
		GetTable()
		GetPosition()
		SetText(value.s):GetText.s()
		SetMask(value.s):GetMask.s()
		SetDatatype(value.i):GetDatatype.i()
		SetImage(value.i):GetImage.i()
		SetWidth(value.i):GetWidth.i()
		SetSort(value.i):GetSort.i()
		SetColspan(value.i):GetColspan.i()
		
		Delete()
		ScrollTo(setSelect.b=#False,redraw.b=#True)
	EndInterface
	
	EnumerationBinary _mytable_row
		#MYTABLE_ROW_FLAGS_RESIZABLE ; Row is resizeable
		#MYTABLE_ROW_FLAGS_NO_RESIZABLE ; if table is resizeable, this stops the row to be resizeable
		#MYTABLE_ROW_FLAGS_HIERARCHICAL_ALWAYS_EXPANDED ; always expand the row
		#MYTABLE_ROW_FLAGS_EDITABLE
		#MYTABLE_ROW_FLAGS_NO_EDITABLE
		#MYTABLE_ROW_FLAGS_NO_CHECKBOXES
		#MYTABLE_ROW_FLAGS_CHECKBOXES
	EndEnumeration
	
	Interface MyTableRow Extends MyTableObject
		GetElementSelectedStyle()
		GetApplication()
		GetTable()
		GetParent()
		GetPosition()
		GetVisiblePosition()
		GetLevel()
		SetExpanded(value.b):GetExpanded.b()
		SetImage(value.i):GetImage.i()
		SetChecked(value.b):GetChecked.b()
		SetHeight(value.i):GetHeight.i()
		
		AddDirtyRows(rows.i)
		AddRow(text.s,sep.s="|",image.i=0,flags.i=0)
		DeleteRow(row.i)
		GetRow(row.i)
		RowCount()
		GetCell(col.i)
		Delete()
		ScrollTo(setSelect.b=#False,redraw.b=#True)
	EndInterface
	
	EnumerationBinary _mytable_table		
		#MYTABLE_TABLE_FLAGS_HIERARCHICAL ; Tree
		#MYTABLE_TABLE_FLAGS_HIERARCHICAL_ALWAYS_EXPANDED ; always expanded rows in tree
		#MYTABLE_TABLE_FLAGS_CHECKBOXES										; rows woth checkboxes
		#MYTABLE_TABLE_FLAGS_FULLROWSELECT								; select always rows
		#MYTABLE_TABLE_FLAGS_MULTISELECT									; can select more rows/cells/cols		
		#MYTABLE_TABLE_FLAGS_BORDER												; draw a grid
		#MYTABLE_TABLE_FLAGS_NO_HEADER										; no header will drawn
		#MYTABLE_TABLE_FLAGS_NO_REDRAW										; stops redrawing. setRedraw(#True) will activate it again
		#MYTABLE_TABLE_FLAGS_CALLBACK											; Table has callbacks for dynamic loads	
		#MYTABLE_TABLE_FLAGS_SORTABLE											; Table is sortable		
		#MYTABLE_TABLE_FLAGS_RESIZABLE										; Cols and Rows are Resizeable
		#MYTABLE_TABLE_FLAGS_PAGES												; Table can have pages
		#MYTABLE_TABLE_FLAGS_TITLE												; draw the title
		#MYTABLE_TABLE_FLAGS_MARK_MOUSE_OVER							; MouseOver marks the cell
		#MYTABLE_TABLE_FLAGS_EDITABLE											; Editable
		#MYTABLE_TABLE_FLAGS_ZEBRA												; Zebra Layout
		#MYTABLE_TABLE_FLAGS_GRID													; Grid (Excel-like) Layout
		#MYTABLE_TABLE_FLAGS_ELEMENT_SELECTED							; Col/Row Color for selected Elements
	EndEnumeration
	
	#MYTABLE_TABLE_FLAGS_DEFAULT_TABLE=#MYTABLE_TABLE_FLAGS_BORDER|#MYTABLE_TABLE_FLAGS_SORTABLE|#MYTABLE_TABLE_FLAGS_RESIZABLE
	#MYTABLE_TABLE_FLAGS_DEFAULT_TREE=#MYTABLE_TABLE_FLAGS_BORDER|#MYTABLE_TABLE_FLAGS_HIERARCHICAL
	#MYTABLE_TABLE_FLAGS_DEFAULT_GRID=#MYTABLE_TABLE_FLAGS_ELEMENT_SELECTED|#MYTABLE_TABLE_FLAGS_BORDER|#MYTABLE_TABLE_FLAGS_GRID|#MYTABLE_TABLE_FLAGS_RESIZABLE|#MYTABLE_TABLE_FLAGS_MULTISELECT|#MYTABLE_TABLE_FLAGS_EDITABLE
	
	
	Prototype.b MyTableProtoEventColLeftClick(*col.MyTableCol)	
	Prototype.b MyTableProtoEventColRightClick(*col.MyTableCol)
	Prototype.b MyTableProtoEventColLeftDoubleClick(*col.MyTableCol)		
	Prototype.b MyTableProtoEventColRightDoubleClick(*col.MyTableCol)
	Prototype.b MyTableProtoEventColSelected(*col.MyTableCol)
	
	Prototype.b MyTableProtoEventCellChangedChecked(*cell.MyTableCell)
	Prototype.b MyTableProtoEventCellChangedUnChecked(*cell.MyTableCell)
	Prototype.b MyTableProtoEventCellChangedText(*cell.MyTableCell,old.s)
	Prototype.b MyTableProtoEventCellChangedValue(*cell.MyTableCell,old.d)
	Prototype.b MyTableProtoEventCellSelected(*cell.MyTableCell)		
	Prototype.b MyTableProtoEventCellLeftClick(*cell.MyTableCell)	
	Prototype.b MyTableProtoEventCellRightClick(*cell.MyTableCell)
	Prototype.b MyTableProtoEventCellLeftDoubleClick(*cell.MyTableCell)		
	Prototype.b MyTableProtoEventCellRightDoubleClick(*cell.MyTableCell)
	
	Prototype.b MyTableProtoEventRowChangedChecked(*row.MyTableRow)
	Prototype.b MyTableProtoEventRowChangedUnChecked(*row.MyTableRow)
	Prototype.b MyTableProtoEventRowChangedExpanded(*row.MyTableRow)
	Prototype.b MyTableProtoEventRowChangedCollapsed(*row.MyTableRow)
	Prototype.b MyTableProtoEventRowSelected(*row.MyTableRow)
	Prototype.b MyTableProtoEventRowLeftClick(*cell.MyTableRow)	
	Prototype.b MyTableProtoEventRowRightClick(*cell.MyTableRow)
	Prototype.b MyTableProtoEventRowLeftDoubleClick(*cell.MyTableRow)		
	Prototype.b MyTableProtoEventRowRightDoubleClick(*cell.MyTableRow)
	
	Prototype.b MyTableProtoEventCustomCellDraw(*cell.MyTableCell,x,y,w,h); Return #True if custom cell is drawn
	Prototype.b MyTableProtoEventCustomCellEdit(*cell.MyTableCell,x,y,w,h); Return #True if custom cell is edited
	
	
	Prototype MyTableProtoCallback(*row.MyTableRow)
	
	Interface MyTableTableObject Extends MyTableObject
		GetElementSelectedStyle()
		GetZebraStyle()
		GetTitleStyle()
		GetEmptyStyle()		
		
		GetApplication()
		GetPages()
		SetName(value.s):GetName.s()
		SetTitle(value.s):GetTitle.s()
		SetRedraw(value.b):GetRedraw.b()
		SetRecalc(value.b):GetRecalc.b()
		SetBatch(value.b):GetBatch.b()
		SetHeaderHeight(value.i):GetHeaderHeight.i()
		SetTitleHeight(value.i):GetTitleHeight.i()
		SetDefaultRowHeight(value.i):GetDefaultRowHeight.i()
		SetFixedCols(value.i):GetFixedCols.i()
		SetEmptyText(value.s):GetEmptyText.s()
		SetPage(value.i):GetPage.i()
		SetPageElements(value.i):GetPageElements.i()
		
		GetSelectedRows(List rows.MyTableRow())
		GetSelectedCells(List cells.MyTableCell())
		GetSelectedCols(List cols.MyTableCol())		
		GetCalcHeight()
		GetCalcWidth()
		
		Redraw()
		Recalc()
		ReInit()
		Free()
		ScrollToPos(row.i,setSelect.b=#False)
		ScrollToCellPos(row.i,col.i,setSelect.b=#False)
		AutosizeRows()
		AutosizeCols()
		AutosizeHeader()
		
		
		BindEventColLeftClick(event.MyTableProtoEventColLeftClick)
		BindEventColLeftDoubleClick(event.MyTableProtoEventColLeftDoubleClick)
		BindEventColRightClick(event.MyTableProtoEventColRightClick)
		BindEventColRightDoubleClick(event.MyTableProtoEventColRightDoubleClick)
		
		BindEventCellChangedChecked(event.MyTableProtoEventCellChangedChecked)
		BindEventCellChangedUnChecked(event.MyTableProtoEventCellChangedUnChecked)
		BindEventCellChangedText(event.MyTableProtoEventCellChangedText)
		BindEventCellChangedValue(event.MyTableProtoEventCellChangedValue)
		BindEventCellSelected(event.MyTableProtoEventCellSelected)
		BindEventCellLeftClick(event.MyTableProtoEventCellLeftClick)
		BindEventCellLeftDoubleClick(event.MyTableProtoEventCellLeftDoubleClick)
		BindEventCellRightClick(event.MyTableProtoEventCellRightClick)
		BindEventCellRightDoubleClick(event.MyTableProtoEventCellRightDoubleClick)
		
		BindEventRowChangedChecked(event.MyTableProtoEventRowChangedChecked)
		BindEventRowChangedUnChecked(event.MyTableProtoEventRowChangedUnChecked)
		BindEventRowChangedExpanded(event.MyTableProtoEventRowChangedExpanded)
		BindEventRowChangedCollapsed(event.MyTableProtoEventRowChangedCollapsed)
		BindEventRowSelected(event.MyTableProtoEventRowSelected)
		BindEventRowLeftClick(event.MyTableProtoEventRowLeftClick)
		BindEventRowLeftDoubleClick(event.MyTableProtoEventRowLeftDoubleClick)
		BindEventRowRightClick(event.MyTableProtoEventRowRightClick)
		BindEventRowRightDoubleClick(event.MyTableProtoEventRowRightDoubleClick)
		
		BindEventCustomCellDraw(event.MyTableProtoEventCustomCellDraw)
		BindEventCustomCellEdit(event.MyTableProtoEventCustomCellEdit)
		
		BindCallback(callback.MyTableProtoCallback)
		
		GetCell(row.i,col.i)
		Delete()
		
		GetRow(row.i)
		RowCount()
		VisibleRowCount()
		GetCol(col.i)
		ColCount()
		
		GetCanvas()
		GetHScroll()
		GetVScroll()
		GetWindow()
	EndInterface
	
	Interface MyTableTable Extends MyTableTableObject
		
		SetDefaultImageSortAsc(value.i):GeDefaultImageSortAsc.i()
		SetDefaultImageSortDesc(value.i):GeDefaultImageSortDesc.i()
		SetDefaultImagePlus(value.i):GeDefaultImagePlus.i()
		SetDefaultImageMinus(value.i):GeDefaultImageMinus.i()
		SetDefaultImageCheckBox(value.i):GeDefaultImageCheckBox.i()
		SetDefaultImageCheckBoxChecked(value.i):GeDefaultImageCheckBoxChecked.i()
		SetDefaultImagePlusArrow(value.i):GeDefaultImagePlusArrow.i()
		SetDefaultImageMinusArrow(value.i):GeDefaultImageMinusArrow.i()
		
		
		AddDirtyRows(rows.i)
		AddRow(text.s,sep.s="|",image.i=0,flags.i=0)
		DeleteRow(row.i)
		
		AddCol(text.s,width.i,image.i=0,flags.i=0)
		DeleteCol(col.i)
		
		
		ClearRows()
		ClearCols()
		
	EndInterface
	
	Interface MyTableTree Extends MyTableTable
		
	EndInterface
	
	Interface MyTableGrid Extends MyTableTableObject
		ResizeGrid(rows.i=#PB_Ignore,cols.i=#PB_Ignore)
		
		BindEventColSelected(event.MyTableProtoEventColSelected)
	EndInterface
	
	Interface MyTableApplication Extends MyTableObject
		GetElementSelectedStyle()
		GetZebraStyle()
		GetTitleStyle()
		GetEmptyStyle()	
		
		SetRedraw(value.b):GetRedraw.b()
		SetRecalc(value.b):GetRecalc.b()
		
		AddTable(window.i,canvas.i,vscroll.i,hscroll.i,name.s="",flags.i=#MYTABLE_TABLE_FLAGS_DEFAULT_TABLE)			
		AddTree(window.i,canvas.i,vscroll.i,hscroll.i,name.s="",flags.i=#MYTABLE_TABLE_FLAGS_DEFAULT_TREE)			
		AddGrid(window.i,canvas.i,vscroll.i,hscroll.i,rows.i,cols.i,name.s="",flags.i=#MYTABLE_TABLE_FLAGS_DEFAULT_GRID)
		
		AddNewTable(x.i,y.i,w.i,h.i,name.s="",flags.i=#MYTABLE_TABLE_FLAGS_DEFAULT_TABLE)			
		AddNewTree(x.i,y.i,w.i,h.i,name.s="",flags.i=#MYTABLE_TABLE_FLAGS_DEFAULT_TREE)			
		AddNewGrid(x.i,y.i,w.i,h.i,rows.i,cols.i,name.s="",flags.i=#MYTABLE_TABLE_FLAGS_DEFAULT_GRID)			
		
		ClearTables()
		Redraw()
		Recalc()
		Free()
		Save.b(file.s); TODO
	EndInterface
	
	Declare MyTableCreateApplication(flags.i=0)	
	Declare MyTableLoadApplication(file.s); TODO
	Declare MyTableCreateTable(window.i,canvas.i,vscroll.i,hscroll.i,flags.i=#MYTABLE_TABLE_FLAGS_DEFAULT_TABLE)	
	Declare MyTableCreateTree(window.i,canvas.i,vscroll.i,hscroll.i,flags.i=#MYTABLE_TABLE_FLAGS_DEFAULT_TREE)	
	Declare MyTableCreateGrid(window.i,canvas.i,vscroll.i,hscroll.i,rows.i,cols.i,flags.i=#MYTABLE_TABLE_FLAGS_DEFAULT_GRID)	
	
	
	Declare MyTableCreateNewTable(x.i,y.i,w.i,h.i,flags.i=#MYTABLE_TABLE_FLAGS_DEFAULT_TABLE)	
	Declare MyTableCreateNewTree(x.i,y.i,w.i,h.i,flags.i=#MYTABLE_TABLE_FLAGS_DEFAULT_TREE)	
	Declare MyTableCreateNewGrid(x.i,y.i,w.i,h.i,rows.i,cols.i,flags.i=#MYTABLE_TABLE_FLAGS_DEFAULT_GRID)	
EndDeclareModule

XIncludeFile "MyTable/global.pb"
XIncludeFile "MyTable/mytable.pb"