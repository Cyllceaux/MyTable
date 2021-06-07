DeclareModule MyTable
	
	#MYTABLE_VERSION = 396
	#MYTABLE_VERSION_DATE = 20210607
	
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
		SetFont(value.i):GetFont()
		SetBackColor(value.q):GetBackColor.q()
		SetFrontColor(value.q):GetFrontColor.q()
		SetForeColor(value.q):GetForeColor.q()
		SetSelectedColor(value.q):GetSelectedColor.q()
		SetBorderColor(value.q):GetBorderColor.q()
		SetSelectedBorderColor(value.q):GetSelectedBorderColor.q()
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
	
	Interface MyTableStyleCell Extends MYTableStyleObject		
		SetHAlign(value.i):GetHAlign()
		SetVAlign(value.i):GetVAlign()		
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
	EndInterface
	
	EnumerationBinary _mytable_cell	
		#MYTABLE_CELL_FLAGS_CHECKBOXES
	EndEnumeration
	
	Interface MyTableCell Extends MyTableObject
		GetParent()
		SetText(value.s):GetText.s()
		SetValue(value.d):GetValue.d()
		SetImage(value.i):GetImage.i()
		SetChecked(value.b):GetChecked.b()		
	EndInterface
	
	EnumerationBinary _mytable_col
		#MYTABLE_COL_FLAGS_CHECKBOXES
	EndEnumeration
	
	Enumeration _mytable_col_sort
		#MYTABLE_COL_SORT_NONE
		#MYTABLE_COL_SORT_ASC
		#MYTABLE_COL_SORT_DESC
	EndEnumeration
	
	Interface MyTableCol Extends MyTableObject
		SetText(value.s):GetText.s()
		SetImage(value.i):GetImage.i()
		SetWidth(value.i):GetWidth.i()
		SetSort(value.i):GetSort.i()
		
		Delete()
	EndInterface
	
	Interface MyTableRow Extends MyTableObject
		GetParent()
		SetExpanded(value.b):GetExpanded.b()
		SetImage(value.i):GetImage.i()
		SetChecked(value.b):GetChecked.b()
		
		AddRow(text.s,sep.s="|",image.i=0,flags.i=0)
		DeleteRow(row.i)
		GetRow(row.i)
		RowCount()
		GetCell(col.i)
		Delete()
	EndInterface
	
	EnumerationBinary _mytable_table
		#MYTABLE_TABLE_FLAGS_HIERARCHICAL
		#MYTABLE_TABLE_FLAGS_CHECKBOXES
		#MYTABLE_TABLE_FLAGS_FULLROWSELECT
		#MYTABLE_TABLE_FLAGS_MULTISELECT
		#MYTABLE_TABLE_FLAGS_BORDER
		#MYTABLE_TABLE_FLAGS_NO_HEADER
	EndEnumeration
	
	#MYTABLE_TABLE_FLAGS_DEFAULT=#MYTABLE_TABLE_FLAGS_BORDER
	
	Prototype MyTableProtoCallbackCellChangedChecked(*cell.MyTableCell)
	Prototype MyTableProtoCallbackCellChangedText(*cell.MyTableCell,old.s)
	Prototype MyTableProtoCallbackCellChangedValue(*cell.MyTableCell,old.d)
	Prototype MyTableProtoCallbackCellSelected(*cell.MyTableCell)
	Prototype MyTableProtoCallbackRowChangedChecked(*row.MyTableRow)
	Prototype MyTableProtoCallbackRowChangedExpanded(*row.MyTableRow)
	Prototype MyTableProtoCallbackRowSelected(*row.MyTableRow)
	
	
	Interface MyTableTable Extends MyTableObject
		SetName(value.s):GetName.s()
		SetTitle(value.s):GetTitle.s()
		SetRedraw(value.b):GetRedraw.b()
		SetRecalc(value.b):GetRecalc.b()
		SetHeaderHeight(value.i):GetHeaderHeight.i()
		SetDefaultRowHeight(value.i):GetDefaultRowHeight.i()
		
		AddRow(text.s,sep.s="|",image.i=0,flags.i=0)
		DeleteRow(row.i)
		GetRow(row.i)
		RowCount()
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
		
		RegisterCallbackCellChangedChecked(callback.MyTableProtoCallbackCellChangedChecked)
		RegisterCallbackCellChangedText(callback.MyTableProtoCallbackCellChangedText)
		RegisterCallbackCellChangedValue(callback.MyTableProtoCallbackCellChangedValue)
		RegisterCallbackCellSelected(callback.MyTableProtoCallbackCellSelected)
		RegisterCallbackRowChangedChecked(callback.MyTableProtoCallbackRowChangedChecked)
		RegisterCallbackRowChangedExpanded(callback.MyTableProtoCallbackRowChangedExpanded)
		RegisterCallbackProtoRowSelected(callback.MyTableProtoCallbackRowSelected)
	EndInterface
	
	Interface MyTableApplication Extends MyTableObject
		SetRedraw(value.b):GetRedraw.b()
		SetRecalc(value.b):GetRecalc.b()
		
		AddTable(window.i,canvas.i,vscroll.i,hscroll.i,name.s="",flags.i=#MYTABLE_TABLE_FLAGS_DEFAULT)	
		ClearTables()
		Redraw()
		Recalc()
		Free()
	EndInterface
	
	Declare MyTableCreateApplication(flags.i=0)	
	Declare MyTableCreateTable(window.i,canvas.i,vscroll.i,hscroll.i,flags.i=#MYTABLE_TABLE_FLAGS_DEFAULT)	
	
EndDeclareModule

XIncludeFile "global.pb"
XIncludeFile "mytable.pb"