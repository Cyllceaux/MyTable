IncludeFile "../MyGlobal/myglobalstructure.pb"


Structure strMyTableStyleBorderStyle
	color.q
	width.i
EndStructure

Structure strMyTableStyleBorder
	border.i
	borderDefault.strMyTableStyleBorderStyle
	borderLeft.strMyTableStyleBorderStyle
	borderRight.strMyTableStyleBorderStyle
	borderTop.strMyTableStyleBorderStyle
	borderBottom.strMyTableStyleBorderStyle
EndStructure

Structure strMyTableStyle		
	*font.MyFont::MyFont
	backcolor.q
	frontcolor.q
	forecolor.q
	valign.i
	halign.i
	border.strMyTableStyleBorder
EndStructure

Structure strMyTableObject Extends strMyVTable
	flags.i
	*data
	dirty.b
	defaultStyle.strMyTableStyle
	selectedStyle.strMyTableStyle
	zebraStyle.strMyTableStyle
	fixedStyle.strMyTableStyle
	elementselectedStyle.strMyTableStyle
	titleStyle.strMyTableStyle
	mouseoverStyle.strMyTableStyle
	emptyStyle.strMyTableStyle
	disabledStyle.strMyTableStyle
	tooltip.s
	disabled.b
EndStructure


Structure strMyTableStyleObject Extends strMyVTable
	*obj.strMyTableObject
	*cellStyle.strMyTableStyle
	*rowStyle.strMyTableStyle
	*colStyle.strMyTableStyle
	*tableStyle.strMyTableStyle
	*applicationStyle.strMyTableStyle
	*style.strMyTableStyle
EndStructure

Structure strMyTableBorderObject Extends strMyVTable
	*style.strMyTableStyleObject
	*border.strMyTableStyleBorderStyle
	
	*borderDefault.strMyTableStyleBorderStyle
	*borderTop.strMyTableStyleBorderStyle
	*borderLeft.strMyTableStyleBorderStyle
	*borderRight.strMyTableStyleBorderStyle
	*borderBottom.strMyTableStyleBorderStyle
		
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
	formula.s
	mask.s
	datatype.i
	*cells.strMyTableCellList
	*imageLeft.MyImage::MyImage
	*imageRight.MyImage::MyImage
	
	textwidth.i
	textheight.i
	
	startx.i
	starty.i
	
	colspan.i
EndStructure

Structure strMyTableCol Extends strMyTableObject
	*table.strMyTableTable
	*application.strMyTableApplication
	*parent.strMyTableCol
	listindex.i
	text.s
	*image.MyImage::MyImage
	
	stretched.b
	width.i
	calcwidth.i
	minwidth.i
	calcminwidth.i
	
	textwidth.i
	textheight.i
	
	sort.i
	colspan.i
	
	mask.s
	datatype.i
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
	*image.MyImage::MyImage
	height.i
	calcheight.i
	checked.b
	
	sorts.s
	sortd.d
	
	explistindex.i
EndStructure

Structure strMyTableTableEdit
	*cell.strMyTableCell
	window.i
	gadget.i
	menu.i
EndStructure

Structure strMyTableTable Extends strMyTableObject
	vscroll.i
	hscroll.i
	maxvscroll.i
	maxhscroll.i
	
	window.i
	canvas.i
	
	*application.strMyTableApplication
	List rows.strMyTableRow()
	List expRows.i()
	List cols.strMyTableCol()
	listindex.i
	name.s
	title.s
	textheight.i
	textwidth.i
	titleHeight.i
	calctitleHeight.i
	redraw.b
	recalc.b
	batch.b
	datagrid.b
	
	emptytext.s
	
	drawing.b
	

	
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
	*shiftcell.strMyTableCell
	*lastmouseovercell.strMyTableCell
	*lastrow.strMyTableRow
	*lastcol.strMyTableCol
	
	*mvcell.strMyTableCell
	*mvrow.strMyTableRow
	*mvcol.strMyTableCol
		
	*resizeRow.strMyTableRow
	*resizeCol.strMyTableCol
	
	eventColLeftClick.MyTableProtoEventColLeftClick
	eventColRightClick.MyTableProtoEventColRightClick
	eventColLeftDoubleClick.MyTableProtoEventColLeftDoubleClick	
	eventColRightDoubleClick.MyTableProtoEventColRightDoubleClick
	eventColSelected.MyTableProtoEventColSelected
	
	eventCellChangedChecked.MyTableProtoEventCellChangedChecked
	eventCellChangedUnChecked.MyTableProtoEventCellChangedUnChecked
	eventCellChangedText.MyTableProtoEventCellChangedText
	eventCellChangedValue.MyTableProtoEventCellChangedValue
	eventCellSelected.MyTableProtoEventCellSelected
	eventCellLeftClick.MyTableProtoEventCellLeftClick
	eventCellRightClick.MyTableProtoEventCellRightClick
	eventCellLeftDoubleClick.MyTableProtoEventCellLeftDoubleClick	
	eventCellRightDoubleClick.MyTableProtoEventCellRightDoubleClick
	
	eventRowChangedChecked.MyTableProtoEventRowChangedChecked
	eventRowChangedUnChecked.MyTableProtoEventRowChangedUnChecked
	eventRowChangedExpanded.MyTableProtoEventRowChangedExpanded
	eventRowChangedCollapsed.MyTableProtoEventRowChangedCollapsed
	eventRowSelected.MyTableProtoEventRowSelected
	eventRowLeftClick.MyTableProtoEventRowLeftClick	
	eventRowRightClick.MyTableProtoEventRowRightClick
	eventRowLeftDoubleClick.MyTableProtoEventRowLeftDoubleClick		
	eventRowRightDoubleClick.MyTableProtoEventRowRightDoubleClick
	
	eventCustomCellDraw.MyTableProtoEventCustomCellDraw
	eventCustomCellEdit.MyTableProtoEventCustomCellEdit
	
	
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
	
	edit.strMyTableTableEdit
	
	oldwith.i
	oldheight.i
EndStructure

Structure strMyTableTree Extends strMyTableTable
	
EndStructure

Structure strMyTableGrid Extends strMyTableTable
	
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
	startx.i
	starty.i
EndStructure

Structure strMyTableCellList
	List cells.strMyTableCell()
EndStructure

Structure strMyTableRowList
	List rows.strMyTableRow()
EndStructure

Structure strMyTableSaveStyleFont
	name.s
	size.i
	flags.i	
EndStructure

Structure strMyTableSaveStyleBorder
	color.q
	width.i
EndStructure

Structure strMyTableSaveStyle
	border.i	
	boderDefault.strMyTableSaveStyleBorder
	boderTop.strMyTableSaveStyleBorder
	boderBottom.strMyTableSaveStyleBorder
	boderLeft.strMyTableSaveStyleBorder
	boderRight.strMyTableSaveStyleBorder
	font.strMyTableSaveStyleFont
	backcolor.q
	frontcolor.q
	forecolor.q
EndStructure

Structure strMyTableSaveObject
	flags.i
EndStructure

Structure strMyTableSaveCell Extends strMyTableSaveObject
	text.s
	value.d
	checked.b
	selected.b
EndStructure

Structure strMyTableSaveRow Extends strMyTableSaveObject
	checked.b
	selected.b
EndStructure

Structure strMyTableSaveCol Extends strMyTableSaveObject
	text.s
	selected.b
EndStructure

Structure strMyTableSaveTable Extends strMyTableSaveObject
	name.s
	title.s
	List cols.strMyTableSaveCol()
	List rows.strMyTableSaveRow()
EndStructure

Structure strMyTableSaveApplication Extends strMyTableSaveObject
	List tables.strMyTableSaveTable()
EndStructure