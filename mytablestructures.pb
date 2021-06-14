Structure strMyTableVTable
	vtable.i
	type.i
EndStructure

Structure strMyTableStyleBorderStyle
	color.q
	width.i
	selectedcolor.q
	selectedwidth.q
EndStructure

Structure strMyTableStyleBorder
	border.i
	defaultBorder.strMyTableStyleBorderStyle
	borderLeft.strMyTableStyleBorderStyle
	borderRight.strMyTableStyleBorderStyle
	borderTop.strMyTableStyleBorderStyle
	borderBottom.strMyTableStyleBorderStyle
	elementselectedbordercolor.q
EndStructure

Structure strMyTableStyle		
	font.i
	backcolor.q
	frontcolor.q
	zebrabackcolor.q
	zebrafrontcolor.q
	fixedbackcolor.q
	fixedfrontcolor.q
	fixedforecolor.q
	valign.i
	halign.i
	border.strMyTableStyleBorder
	forecolor.q
	selectedcolor.q
	selectedforecolor.q
	elementselectedcolor.q
	elementselectedforecolor.q
EndStructure

Structure strMyTableObject Extends strMyTableVTable
	flags.i
	*data
	dirty.b
	style.strMyTableStyle
	tooltip.s
EndStructure

Structure strMyTableStyleObject Extends strMyTableVTable
	*obj.strMyTableObject
EndStructure

Structure strMyTableImage
	orig.i
	sized.i
	resize.b
EndStructure

Structure strMyTableCell Extends strMyTableObject
	*parent.strMyTableCell
	*col.strMyTableCol
	*row.strMyTableRow
	*table.strMyTableTable
	*application.strMyTableApplication
	listindex.i
	text.s
	value.d
	checked.b
	*cells.strMyTableCellList
	imageLeft.strMyTableImage
	imageRight.strMyTableImage
	
	textwidth.i
	textheight.i
EndStructure

Structure strMyTableCol Extends strMyTableObject
	*table.strMyTableTable
	*application.strMyTableApplication
	*parent.strMyTableCol
	listindex.i
	text.s
	image.strMyTableImage
	
	stretched.b
	width.i
	calcwidth.i
	minwidth.i
	calcminwidth.i
	
	textwidth.i
	textheight.i
	
	sort.i
	colspan.i
EndStructure

Structure strMyTableRow Extends strMyTableObject
	*table.strMyTableTable
	*application.strMyTableApplication
	*cells.strMyTableCellList
	*rows.strMyTableRowList
	level.i
	*parent.strMyTableRow
	listindex.i
	expanded.b
	image.strMyTableImage
	height.i
	calcheight.i
	checked.b
	
	sorts.s
	sortd.d
EndStructure

Structure strMyTableTable Extends strMyTableObject		
	*application.strMyTableApplication
	List rows.strMyTableRow()
	List expRows.i()
	List cols.strMyTableCol()
	listindex.i
	name.s
	title.s
	redraw.b
	recalc.b
	
	emptytext.s
	
	drawing.b
	
	window.i
	canvas.i
	vscroll.i
	hscroll.i
	maxvscroll.i
	maxhscroll.i
	
	fixedcols.i
	
	defaultheaderheight.i
	calcdefaultheaderheight.i
	headerheight.i
	calcheaderheight.i
	
	defaultrowheight.i
	calcdefaultrowheight.i
	
	Map selectedCells.b()
	Map selectedRows.b()
	Map selectedCols.b()
	Map tempselectedCells.b()
	Map tempselectedRows.b()
	Map tempselectedCols.b()
	selectall.b
	
	md.b
	mxd.i
	myd.i
	*lastcell.strMyTableCell
	*lastrow.strMyTableRow
	*lastcol.strMyTableCol
	
	*resizeRow.strMyTableRow
	*resizeCol.strMyTableCol
	
	eventCellChangedChecked.MyTableProtoEventCellChangedChecked
	eventCellChangedUnChecked.MyTableProtoEventCellChangedUnChecked
	eventCellChangedText.MyTableProtoEventCellChangedText
	eventCellChangedValue.MyTableProtoEventCellChangedValue
	eventCellSelected.MyTableProtoEventCellSelected
	eventRowChangedChecked.MyTableProtoEventRowChangedChecked
	eventRowChangedUnChecked.MyTableProtoEventRowChangedUnChecked
	eventRowChangedExpanded.MyTableProtoEventRowChangedExpanded
	eventRowChangedCollapsed.MyTableProtoEventRowChangedCollapsed
	eventRowSelected.MyTableProtoEventRowSelected
	callback.MyTableProtoCallback
	
	DefaultImageSortAsc.i
	DefaultImageSortDesc.i
	DefaultImagePlus.i
	DefaultImageMinus.i
	DefaultImageCheckBox.i
	DefaultImageCheckBoxChecked.i
	DefaultImagePlusArrow.i
	DefaultImageMinusArrow.i
	
	pageElements.i
	page.i
	List expRowsPage.i()
EndStructure

Structure strMyTableApplication Extends strMyTableObject
	List tables.strMyTableTable()
	lastindex.i
	redraw.b
	recalc.b
EndStructure

Structure strMyTableRowCol
	row.i
	col.i
	bottom.b
	right.b
	exp.b
	check.b
	*trow.strMyTableRow
	*tcol.strMyTableCol
	*tcell.strMyTableCell
	mx.i
	my.i
EndStructure

Structure strMyTableCellList
	List cells.strMyTableCell()
EndStructure

Structure strMyTableRowList
	List rows.strMyTableRow()
EndStructure