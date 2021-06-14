﻿DeclareModule MyTable
	
	#MYTABLE_VERSION = 1757
	#MYTABLE_VERSION_DATE = 20210614
	
	Enumeration _mytable_type
		#MYTABLE_TYPE_NONE
		#MYTABLE_TYPE_CELL
		#MYTABLE_TYPE_ROW
		#MYTABLE_TYPE_COL
		#MYTABLE_TYPE_TABLE
		#MYTABLE_TYPE_APPLICATION
		#MYTABLE_TYPE_STYLE
	EndEnumeration
	
	Interface MyTableStyleObject
		GetObject()
		SetFont(value.i):GetFont()
		SetBackColor(value.q):GetBackColor.q()
		SetFrontColor(value.q):GetFrontColor.q()
		SetForeColor(value.q):GetForeColor.q()
		
		SetSelectedColor(value.q):GetSelectedColor.q()
		SetBorderColor(value.q):GetBorderColor.q()
		SetBorderWidth(value.i):GetBorderWidth.i()
		SetSelectedBorderColor(value.q):GetSelectedBorderColor.q()
		SetSelectedBorderWidth(value.i):GetSelectedBorderWidth.i()
		SetSelectedForeColor(value.q):GetSelectedForeColor.q()
		
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
	
	Interface MyTableStyleCell Extends MYTableStyleObject		
		SetHAlign(value.i):GetHAlign()
		SetVAlign(value.i):GetVAlign()		
		SetBorder(value.i):GetBorder()		
	EndInterface
	
	Interface MyTableStyleCol Extends MYTableStyleCell
		SetElementSelectedColor(value.q):GetElementSelectedColor.q()
		SetElementSelectedBorderColor(value.q):GetElementSelectedBorderColor.q()
		SetElementSelectedForeColor(value.q):GetElementSelectedForeColor.q()
	EndInterface
	
	Interface MyTableStyleRow Extends MyTableStyleCell
		SetElementSelectedColor(value.q):GetElementSelectedColor.q()
		SetElementSelectedBorderColor(value.q):GetElementSelectedBorderColor.q()
		SetElementSelectedForeColor(value.q):GetElementSelectedForeColor.q()
	EndInterface
	
	Interface MyTableStyleTable Extends MYTableStyleObject
		SetZebraBackColor(value.q):GetZebraBackColor.q()
		SetZebraFrontColor(value.q):GetZebraFrontColor.q()		
		SetFixedBackColor(value.q):GetFixedBackColor.q()
		SetFixedFrontColor(value.q):GetFixedFrontColor.q()		
		SetFixedForeColor(value.q):GetFixedForeColor.q()		
		
		SetTitleFont(value.i):GetTitleFont()
		SetTitleBackColor(value.q):GetTitleBackColor.q()
		SetTitleFrontColor(value.q):GetTitleFrontColor.q()
		SetTitleForeColor(value.q):GetTitleForeColor.q()
		SetTitleHAlign(value.i):GetTitleHAlign()
		SetTitleVAlign(value.i):GetTitleVAlign()
	EndInterface
	
	Interface MyTableStyleApplication Extends MYTableStyleObject
		
	EndInterface
	
	Interface MyTableObject
		GetType()
		GetStyle()
		SetFlags(value.i):GetFlags()
		SetData(*value):GetData()
		SetDirty(value.b):GetDirty.b()
		SetSelected(value.b):GetSelected.b()
		SetTooltip(value.s):GetTooltip.s()
		
		Autosize()
	EndInterface
	
	EnumerationBinary _mytable_cell	
		#MYTABLE_CELL_FLAGS_CHECKBOXES
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
	EndInterface
	
	EnumerationBinary _mytable_col
		#MYTABLE_COL_FLAGS_CHECKBOXES
		#MYTABLE_COL_FLAGS_SORTABLE
		#MYTABLE_COL_FLAGS_NO_SORTABLE
		#MYTABLE_COL_FLAGS_RESIZABLE
		#MYTABLE_COL_FLAGS_NO_RESIZABLE
	EndEnumeration
	
	Enumeration _mytable_col_sort
		#MYTABLE_COL_SORT_NONE
		#MYTABLE_COL_SORT_ASC
		#MYTABLE_COL_SORT_DESC
	EndEnumeration
	
	Interface MyTableCol Extends MyTableObject
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
		#MYTABLE_ROW_FLAGS_RESIZABLE
		#MYTABLE_ROW_FLAGS_NO_RESIZABLE
	EndEnumeration
	
	Interface MyTableRow Extends MyTableObject
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
		#MYTABLE_TABLE_FLAGS_HIERARCHICAL
		#MYTABLE_TABLE_FLAGS_CHECKBOXES
		#MYTABLE_TABLE_FLAGS_FULLROWSELECT
		#MYTABLE_TABLE_FLAGS_MULTISELECT
		#MYTABLE_TABLE_FLAGS_BORDER
		#MYTABLE_TABLE_FLAGS_NO_HEADER
		#MYTABLE_TABLE_FLAGS_NO_REDRAW
		#MYTABLE_TABLE_FLAGS_CALLBACK
		#MYTABLE_TABLE_FLAGS_SORTABLE
		#MYTABLE_TABLE_FLAGS_RESIZABLE
		#MYTABLE_TABLE_FLAGS_PAGES
		#MYTABLE_TABLE_FLAGS_TITLE
	EndEnumeration
	
	#MYTABLE_TABLE_FLAGS_DEFAULT_TABLE=#MYTABLE_TABLE_FLAGS_BORDER|#MYTABLE_TABLE_FLAGS_SORTABLE|#MYTABLE_TABLE_FLAGS_RESIZABLE
	#MYTABLE_TABLE_FLAGS_DEFAULT_TREE=#MYTABLE_TABLE_FLAGS_BORDER|#MYTABLE_TABLE_FLAGS_HIERARCHICAL
	
	Prototype MyTableProtoEventCellChangedChecked(*cell.MyTableCell)
	Prototype MyTableProtoEventCellChangedUnChecked(*cell.MyTableCell)
	Prototype MyTableProtoEventCellChangedText(*cell.MyTableCell,old.s)
	Prototype MyTableProtoEventCellChangedValue(*cell.MyTableCell,old.d)
	Prototype MyTableProtoEventCellSelected(*cell.MyTableCell)
	Prototype MyTableProtoEventRowChangedChecked(*row.MyTableRow)
	Prototype MyTableProtoEventRowChangedUnChecked(*row.MyTableRow)
	Prototype MyTableProtoEventRowChangedExpanded(*row.MyTableRow)
	Prototype MyTableProtoEventRowChangedCollapsed(*row.MyTableRow)
	Prototype MyTableProtoEventRowSelected(*row.MyTableRow)
	
	
	Prototype MyTableProtoCallback(*row.MyTableRow)
	
	
	Interface MyTableTable Extends MyTableObject
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
		
		
		RegisterEventCellChangedChecked(callback.MyTableProtoEventCellChangedChecked)
		RegisterEventCellChangedUnChecked(callback.MyTableProtoEventCellChangedUnChecked)
		RegisterEventCellChangedText(callback.MyTableProtoEventCellChangedText)
		RegisterEventCellChangedValue(callback.MyTableProtoEventCellChangedValue)
		RegisterEventCellSelected(callback.MyTableProtoEventCellSelected)
		RegisterEventRowChangedChecked(callback.MyTableProtoEventRowChangedChecked)
		RegisterEventRowChangedUnChecked(callback.MyTableProtoEventRowChangedUnChecked)
		RegisterEventRowChangedExpanded(callback.MyTableProtoEventRowChangedExpanded)
		RegisterEventRowChangedCollapsed(callback.MyTableProtoEventRowChangedCollapsed)
		RegisterEventRowSelected(callback.MyTableProtoEventRowSelected)
		
		RegisterCallback(callback.MyTableProtoCallback)
	EndInterface
	
	Interface MyTableApplication Extends MyTableObject
		SetRedraw(value.b):GetRedraw.b()
		SetRecalc(value.b):GetRecalc.b()
		
		AddTable(window.i,canvas.i,vscroll.i,hscroll.i,name.s="",flags.i=#MYTABLE_TABLE_FLAGS_DEFAULT_TABLE)			
		ClearTables()
		Redraw()
		Recalc()
		Free()
	EndInterface
	
	Declare MyTableCreateApplication(flags.i=0)	
	Declare MyTableCreateTable(window.i,canvas.i,vscroll.i,hscroll.i,flags.i=#MYTABLE_TABLE_FLAGS_DEFAULT_TABLE)	
	
EndDeclareModule

XIncludeFile "global.pb"
XIncludeFile "mytable.pb"