DeclareModule MyTable
	
	#MYTABLE_VERSION = 2456
	#MYTABLE_VERSION_DATE = 20210618
	
	Enumeration _mytable_type
		#MYTABLE_TYPE_NONE
		#MYTABLE_TYPE_CELL
		#MYTABLE_TYPE_ROW
		#MYTABLE_TYPE_COL
		#MYTABLE_TYPE_TABLE
		#MYTABLE_TYPE_TREE
		#MYTABLE_TYPE_GRID
		#MYTABLE_TYPE_APPLICATION
		#MYTABLE_TYPE_STYLE
		#MYTABLE_TYPE_FONT
	EndEnumeration
	
	Interface MyTableFont
		GetType()
		GetFlags()
		GetName.s()
		GetSize()
	EndInterface
	
	Interface MyTableStyle
		GetType()
		GetObject()
		
		SetFont(*font.MyTableFont):GetFont()
		SetBackColor(value.q):GetBackColor.q()
		SetFrontColor(value.q):GetFrontColor.q()
		SetForeColor(value.q):GetForeColor.q()
		SetHAlign(value.i):GetHAlign()
		SetVAlign(value.i):GetVAlign()	
		SetBorder(value.i):GetBorder()		
		SetBorderColor(value.q):GetBorderColor.q()
		SetBorderWidth(value.i):GetBorderWidth.i()
		
		
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
		#MYTABLE_STYLE_BORDER_TOP
		#MYTABLE_STYLE_BORDER_RIGHT
		#MYTABLE_STYLE_BORDER_BOTTOM
		#MYTABLE_STYLE_BORDER_LEFT
	EndEnumeration
	
	
	Interface MyTableObject
		GetType()
		GetDefaultStyle()
		GetSelectedStyle()
		GetMouseOverStyle()
		GetFixedStyle()
		SetFlags(value.i):GetFlags()
		SetData(*value):GetData()
		SetDirty(value.b):GetDirty.b()
		SetSelected(value.b):GetSelected.b()
		SetTooltip(value.s):GetTooltip.s()
		
		Autosize()
	EndInterface
	
	EnumerationBinary _mytable_cell	
		#MYTABLE_CELL_FLAGS_CHECKBOXES
		#MYTABLE_CELL_FLAGS_EDITABLE
		#MYTABLE_CELL_FLAGS_NO_EDITABLE
	EndEnumeration
	
	Interface MyTableCell Extends MyTableObject
		GetApplication()
		GetTable()
		GetRow()
		GetCol()
		GetParent()
		SetText(value.s):GetText.s()
		SetValue(value.d):GetValue.d()
		SetImageLeft(value.i):GetImageLeft.i()
		SetImageRight(value.i):GetImageRight.i()
		SetChecked(value.b):GetChecked.b()
		
		AddCell(text.s,image.i=0,flags.i=0)
		DeleteCell(row.i)
		GetCell(row.i)
		CountCells()
		ScrollTo(setSelect.b=#False,redraw.b=#True)
		StartEdit()
		StopEdit()
	EndInterface
	
	EnumerationBinary _mytable_col
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
	EndEnumeration
	
	Interface MyTableRow Extends MyTableObject
		GetElementSelectedStyle()
		GetApplication()
		GetTable()
		GetParent()
		GetPosition()
		GetLevel()
		SetExpanded(value.b):GetExpanded.b()
		SetImage(value.i):GetImage.i()
		SetChecked(value.b):GetChecked.b()
		
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
		#MYTABLE_TABLE_FLAGS_CHECKBOXES ; rows woth checkboxes
		#MYTABLE_TABLE_FLAGS_FULLROWSELECT ; select always rows
		#MYTABLE_TABLE_FLAGS_MULTISELECT ; can select more rows/cells/cols		
		#MYTABLE_TABLE_FLAGS_BORDER ; draw a grid
		#MYTABLE_TABLE_FLAGS_NO_HEADER ; no header will drawn
		#MYTABLE_TABLE_FLAGS_NO_REDRAW ; stops redrawing. setRedraw(#True) will activate it again
		#MYTABLE_TABLE_FLAGS_CALLBACK	; Table has callbacks for dynamic loads	
		#MYTABLE_TABLE_FLAGS_SORTABLE ; Table is sortable		
		#MYTABLE_TABLE_FLAGS_RESIZABLE ; Cols and Rows are Resizeable
		#MYTABLE_TABLE_FLAGS_PAGES ; Table can have pages
		#MYTABLE_TABLE_FLAGS_TITLE ; draw the title
		#MYTABLE_TABLE_FLAGS_MARK_MOUSE_OVER ; MouseOver marks the cell
		#MYTABLE_TABLE_FLAGS_EDITABLE ; Editable
		#MYTABLE_TABLE_FLAGS_ZEBRA ; Zebra Layout
		#MYTABLE_TABLE_FLAGS_GRID ; Grid (Excel-like) Layout
	EndEnumeration
	
	#MYTABLE_TABLE_FLAGS_DEFAULT_TABLE=#MYTABLE_TABLE_FLAGS_BORDER|#MYTABLE_TABLE_FLAGS_SORTABLE|#MYTABLE_TABLE_FLAGS_RESIZABLE
	#MYTABLE_TABLE_FLAGS_DEFAULT_TREE=#MYTABLE_TABLE_FLAGS_BORDER|#MYTABLE_TABLE_FLAGS_HIERARCHICAL
	#MYTABLE_TABLE_FLAGS_DEFAULT_GRID=#MYTABLE_TABLE_FLAGS_BORDER|#MYTABLE_TABLE_FLAGS_GRID|#MYTABLE_TABLE_FLAGS_RESIZABLE|#MYTABLE_TABLE_FLAGS_MULTISELECT|#MYTABLE_TABLE_FLAGS_EDITABLE
	
	
	Prototype.b MyTableProtoEventColLeftClick(*cell.MyTableCol)	
	Prototype.b MyTableProtoEventColRightClick(*cell.MyTableCol)
	Prototype.b MyTableProtoEventColLeftDoubleClick(*cell.MyTableCol)		
	Prototype.b MyTableProtoEventColRightDoubleClick(*cell.MyTableCol)
	
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
	Prototype.b MyTableProtoEventCustomCellEdit(*cell.MyTableCell); Return #True if custom cell is edited
	
	
	Prototype MyTableProtoCallback(*row.MyTableRow)
	
	
	Interface MyTableTable Extends MyTableObject
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
		SetHeaderHeight(value.i):GetHeaderHeight.i()
		SetTitleHeight(value.i):GetTitleHeight.i()
		SetDefaultRowHeight(value.i):GetDefaultRowHeight.i()
		SetFixedCols(value.i):GetFixedCols.i()
		SetEmptyText(value.s):GetEmptyText.s()
		SetPage(value.i):GetPage.i()
		SetPageElements(value.i):GetPageElements.i()
		
		SetDefaultImageSortAsc(value.i):GeDefaultImageSortAsc.i()
		SetDefaultImageSortDesc(value.i):GeDefaultImageSortDesc.i()
		SetDefaultImagePlus(value.i):GeDefaultImagePlus.i()
		SetDefaultImageMinus(value.i):GeDefaultImageMinus.i()
		SetDefaultImageCheckBox(value.i):GeDefaultImageCheckBox.i()
		SetDefaultImageCheckBoxChecked(value.i):GeDefaultImageCheckBoxChecked.i()
		SetDefaultImagePlusArrow(value.i):GeDefaultImagePlusArrow.i()
		SetDefaultImageMinusArrow(value.i):GeDefaultImageMinusArrow.i()
		
		GetSelectedRows(List rows.MyTableRow())
		GetSelectedCells(List cells.MyTableCell())
		GetSelectedCols(List cols.MyTableCol())		
		GetCalcHeight()
		GetCalcWidth()
		
		AddDirtyRows(rows.i)
		AddRow(text.s,sep.s="|",image.i=0,flags.i=0)
		DeleteRow(row.i)
		GetRow(row.i)
		RowCount()
		VisibleRowCount()
		AddCol(text.s,width.i,image.i=0,flags.i=0)
		DeleteCol(col.i)
		GetCol(col.i)
		ColCount()
		GetCell(row.i,col.i)
		Delete()
		ClearRows()
		ClearCols()
		Redraw()
		Recalc()
		Free()
		ScrollToPos(row.i,setSelect.b=#False)
		ScrollToCellPos(row.i,col.i,setSelect.b=#False)
		AutosizeRows()
		AutosizeCols()
		AutosizeHeader()
		

		RegisterEventColLeftClick(event.MyTableProtoEventColLeftClick)
		RegisterEventColLeftDoubleClick(event.MyTableProtoEventColLeftDoubleClick)
		RegisterEventColRightClick(event.MyTableProtoEventColRightClick)
		RegisterEventColRightDoubleClick(event.MyTableProtoEventColRightDoubleClick)
		
		RegisterEventCellChangedChecked(event.MyTableProtoEventCellChangedChecked)
		RegisterEventCellChangedUnChecked(event.MyTableProtoEventCellChangedUnChecked)
		RegisterEventCellChangedText(event.MyTableProtoEventCellChangedText)
		RegisterEventCellChangedValue(event.MyTableProtoEventCellChangedValue)
		RegisterEventCellSelected(event.MyTableProtoEventCellSelected)
		RegisterEventCellLeftClick(event.MyTableProtoEventCellLeftClick)
		RegisterEventCellLeftDoubleClick(event.MyTableProtoEventCellLeftDoubleClick)
		RegisterEventCellRightClick(event.MyTableProtoEventCellRightClick)
		RegisterEventCellRightDoubleClick(event.MyTableProtoEventCellRightDoubleClick)
		
		RegisterEventRowChangedChecked(event.MyTableProtoEventRowChangedChecked)
		RegisterEventRowChangedUnChecked(event.MyTableProtoEventRowChangedUnChecked)
		RegisterEventRowChangedExpanded(event.MyTableProtoEventRowChangedExpanded)
		RegisterEventRowChangedCollapsed(event.MyTableProtoEventRowChangedCollapsed)
		RegisterEventRowSelected(event.MyTableProtoEventRowSelected)
		RegisterEventRowLeftClick(event.MyTableProtoEventRowLeftClick)
		RegisterEventRowLeftDoubleClick(event.MyTableProtoEventRowLeftDoubleClick)
		RegisterEventRowRightClick(event.MyTableProtoEventRowRightClick)
		RegisterEventRowRightDoubleClick(event.MyTableProtoEventRowRightDoubleClick)
		
		RegisterEventCustomCellDraw(event.MyTableProtoEventCustomCellDraw)
		RegisterEventCustomCellEdit(event.MyTableProtoEventCustomCellEdit)
		
		RegisterCallback(callback.MyTableProtoCallback)
	EndInterface
	
	Interface MyTableTree Extends MyTableTable
		
	EndInterface
	
	Interface MyTableGrid Extends MyTableTable
		ResizeGrid(rows.i=#PB_Ignore,cols.i=#PB_Ignore)
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
		ClearTables()
		Redraw()
		Recalc()
		Free()
		Save.b(file.s)
	EndInterface
	
	Declare MyTableCreateApplication(flags.i=0)	
	Declare MyTableLoadApplication(file.s)	
	Declare MyTableCreateTable(window.i,canvas.i,vscroll.i,hscroll.i,flags.i=#MYTABLE_TABLE_FLAGS_DEFAULT_TABLE)	
	Declare MyTableCreateTree(window.i,canvas.i,vscroll.i,hscroll.i,flags.i=#MYTABLE_TABLE_FLAGS_DEFAULT_TREE)	
	Declare MyTableCreateGrid(window.i,canvas.i,vscroll.i,hscroll.i,rows.i,cols.i,flags.i=#MYTABLE_TABLE_FLAGS_DEFAULT_GRID)	
	Declare MyTableCreateFont(name.s,size.i,flags.i=0)	
	
EndDeclareModule

XIncludeFile "global.pb"
XIncludeFile "mytable.pb"