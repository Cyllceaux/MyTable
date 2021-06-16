
Module MyTable
	EnableExplicit
	
	
	
	XIncludeFile "mytablestructures.pb"
	XIncludeFile "declare.pb"
	XIncludeFile "mytableglobal.pb"
	XIncludeFile "mytablestyle.pb"
	XIncludeFile "mytableapplication.pb"
	XIncludeFile "mytabletable.pb"
	XIncludeFile "mytablerow.pb"
	XIncludeFile "mytablecol.pb"
	XIncludeFile "mytablecell.pb"
	
	
	Macro _MyTableDataSectionMethode(gruppe,methode)
		Data.i @_MyTable_#gruppe#_#methode()
	EndMacro
	
	Macro _MyTableDataSectionSetter(gruppe,name)
		_MyTableDataSectionMethode(gruppe,Set#name)
	EndMacro
	
	Macro _MyTableDataSectionGetter(gruppe,name)
		_MyTableDataSectionMethode(gruppe,Get#name)
	EndMacro
	
	Macro _MyTableDataSectionSetterGetter(gruppe,name)
		_MyTableDataSectionSetter(gruppe,name)
		_MyTableDataSectionGetter(gruppe,name)
	EndMacro
	
	Macro _MyTableDataSectionDefault(gruppe)
		_MyTableDataSectionGetter(gruppe,Type)
		_MyTableDataSectionGetter(gruppe,DefaultStyle)
		_MyTableDataSectionGetter(gruppe,SelectedStyle)
		_MyTableDataSectionGetter(gruppe,MouseOverStyle)
		_MyTableDataSectionGetter(gruppe,FixedStyle)
		_MyTableDataSectionSetterGetter(gruppe,Flags)
		_MyTableDataSectionSetterGetter(gruppe,Data)
		_MyTableDataSectionSetterGetter(gruppe,Dirty)
		_MyTableDataSectionSetterGetter(gruppe,Selected)		
		_MyTableDataSectionSetterGetter(gruppe,Tooltip)
		
		_MyTableDataSectionMethode(gruppe,Autosize)
	EndMacro
	
	
	Macro _MyTableDataSectionStyleDefault(gruppe)
		_MyTableDataSectionGetter(gruppe,Object)
		
		_MyTableDataSectionSetterGetter(gruppe,Font)
		_MyTableDataSectionSetterGetter(gruppe,BackColor)
		_MyTableDataSectionSetterGetter(gruppe,FrontColor)
		_MyTableDataSectionSetterGetter(gruppe,ForeColor)
		_MyTableDataSectionSetterGetter(gruppe,HAlign)
		_MyTableDataSectionSetterGetter(gruppe,VAlign)
		_MyTableDataSectionSetterGetter(gruppe,Border)
		_MyTableDataSectionSetterGetter(gruppe,BorderColorDefault)
		_MyTableDataSectionSetterGetter(gruppe,BorderWidthDefault)
	
	_MyTableDataSectionMethode(gruppe,Free)
	_MyTableDataSectionMethode(gruppe,Delete)
EndMacro



DataSection
	vtable_style: ;- Style
	_MyTableDataSectionStyleDefault(Style)
	
	
	vtable_application:;- Application
	_MyTableDataSectionDefault(Application)
	_MyTableDataSectionGetter(Application,ElementSelectedStyle)
	_MyTableDataSectionGetter(Application,ZebraStyle)
	_MyTableDataSectionGetter(Application,TitleStyle)
	_MyTableDataSectionGetter(Application,EmptyStyle)
	_MyTableDataSectionSetterGetter(Application,Redraw)
	_MyTableDataSectionSetterGetter(Application,Recalc)
	
	_MyTableDataSectionMethode(Application,AddTable)
	_MyTableDataSectionMethode(Application,ClearTables)
	_MyTableDataSectionMethode(Application,Redraw)
	_MyTableDataSectionMethode(Application,Recalc)
	_MyTableDataSectionMethode(Application,Free)
	
	vtable_table:;- Table
	_MyTableDataSectionDefault(Table)
	_MyTableDataSectionGetter(Table,ElementSelectedStyle)
	_MyTableDataSectionGetter(Table,ZebraStyle)
	_MyTableDataSectionGetter(Table,TitleStyle)
	_MyTableDataSectionGetter(Table,EmptyStyle)
	_MyTableDataSectionGetter(Table,Application)
	_MyTableDataSectionGetter(Table,Pages)
	_MyTableDataSectionSetterGetter(Table,Name)
	_MyTableDataSectionSetterGetter(Table,Title)
	_MyTableDataSectionSetterGetter(Table,Redraw)
	_MyTableDataSectionSetterGetter(Table,Recalc)
	_MyTableDataSectionSetterGetter(Table,HeaderHeight)
	_MyTableDataSectionSetterGetter(Table,TitleHeight)
	_MyTableDataSectionSetterGetter(Table,DefaultRowHeight)
	_MyTableDataSectionSetterGetter(Table,FixedCols)
	_MyTableDataSectionSetterGetter(Table,EmptyText)
	_MyTableDataSectionSetterGetter(Table,Page)
	_MyTableDataSectionSetterGetter(Table,PageElements)
	
	_MyTableDataSectionSetterGetter(Table,DefaultImageSortAsc)
	_MyTableDataSectionSetterGetter(Table,DefaultImageSortDesc)
	_MyTableDataSectionSetterGetter(Table,DefaultImagePlus)
	_MyTableDataSectionSetterGetter(Table,DefaultImageMinus)
	_MyTableDataSectionSetterGetter(Table,DefaultImageCheckBox)
	_MyTableDataSectionSetterGetter(Table,DefaultImageCheckBoxChecked)
	_MyTableDataSectionSetterGetter(Table,DefaultImagePlusArrow)
	_MyTableDataSectionSetterGetter(Table,DefaultImageMinusArrow)
	
	_MyTableDataSectionGetter(Table,SelectedRows)
	_MyTableDataSectionGetter(Table,SelectedCells)
	_MyTableDataSectionGetter(Table,SelectedCols)
	_MyTableDataSectionGetter(Table,CalcHeight)
	_MyTableDataSectionGetter(Table,CalcWidth)
	
	_MyTableDataSectionMethode(Table,AddDirtyRows)
	_MyTableDataSectionMethode(Table,AddRow)
	_MyTableDataSectionMethode(Table,DeleteRow)
	_MyTableDataSectionGetter(Table,Row)
	_MyTableDataSectionMethode(Table,RowCount)
	_MyTableDataSectionMethode(Table,VisibleRowCount)
	_MyTableDataSectionMethode(Table,AddCol)
	_MyTableDataSectionMethode(Table,DeleteCol)
	_MyTableDataSectionGetter(Table,Col)
	_MyTableDataSectionMethode(Table,ColCount)
	_MyTableDataSectionGetter(Table,Cell)
	_MyTableDataSectionMethode(Table,Delete)
	_MyTableDataSectionMethode(Table,ClearRows)
	_MyTableDataSectionMethode(Table,ClearCols)
	_MyTableDataSectionMethode(Table,Redraw)
	_MyTableDataSectionMethode(Table,Recalc)
	_MyTableDataSectionMethode(Table,Free)
	_MyTableDataSectionMethode(Table,ScrollToPos)
	_MyTableDataSectionMethode(Table,ScrollToCellPos)
	_MyTableDataSectionMethode(Table,AutosizeRows)
	_MyTableDataSectionMethode(Table,AutosizeCols)
	_MyTableDataSectionMethode(Table,AutosizeHeader)
	
	_MyTableDataSectionMethode(Table,RegisterEventCellChangedChecked)
	_MyTableDataSectionMethode(Table,RegisterEventCellChangedUnChecked)
	_MyTableDataSectionMethode(Table,RegisterEventCellChangedText)
	_MyTableDataSectionMethode(Table,RegisterEventCellChangedValue)
	_MyTableDataSectionMethode(Table,RegisterEventCellSelected)
	_MyTableDataSectionMethode(Table,RegisterEventCellLeftClick)
	_MyTableDataSectionMethode(Table,RegisterEventCellLeftDoubleClick)
	_MyTableDataSectionMethode(Table,RegisterEventCellRightClick)
	_MyTableDataSectionMethode(Table,RegisterEventCellRightDoubleClick)
	_MyTableDataSectionMethode(Table,RegisterEventRowChangedChecked)
	_MyTableDataSectionMethode(Table,RegisterEventRowChangedUnChecked)
	_MyTableDataSectionMethode(Table,RegisterEventRowChangedExpanded)
	_MyTableDataSectionMethode(Table,RegisterEventRowChangedCollapsed)
	_MyTableDataSectionMethode(Table,RegisterEventRowSelected)
	_MyTableDataSectionMethode(Table,RegisterEventRowLeftClick)
	_MyTableDataSectionMethode(Table,RegisterEventRowLeftDoubleClick)
	_MyTableDataSectionMethode(Table,RegisterEventRowRightClick)
	_MyTableDataSectionMethode(Table,RegisterEventRowRightDoubleClick)
	_MyTableDataSectionMethode(Table,RegisterEventCustomCellDraw)
	_MyTableDataSectionMethode(Table,RegisterEventCustomCellEdit)
	
	_MyTableDataSectionMethode(Table,RegisterCallback)
	
	vtable_row:;- Row
	_MyTableDataSectionDefault(Row)
	_MyTableDataSectionGetter(Row,ElementSelectedStyle)
	_MyTableDataSectionGetter(Row,Application)
	_MyTableDataSectionGetter(Row,Table)
	_MyTableDataSectionGetter(Row,Parent)
	_MyTableDataSectionGetter(Row,Position)
	_MyTableDataSectionGetter(Row,Level)
	_MyTableDataSectionSetterGetter(Row,Expanded)
	_MyTableDataSectionSetterGetter(Row,Image)
	_MyTableDataSectionSetterGetter(Row,Checked)
	
	_MyTableDataSectionMethode(Row,AddDirtyRows)
	_MyTableDataSectionMethode(Row,AddRow)
	_MyTableDataSectionMethode(Row,DeleteRow)
	_MyTableDataSectionGetter(Row,Row)
	_MyTableDataSectionMethode(Row,RowCount)
	_MyTableDataSectionGetter(Row,Cell)
	_MyTableDataSectionMethode(Row,Delete)
	_MyTableDataSectionMethode(Row,ScrollTo)
	
	vtable_col:;- Col
	_MyTableDataSectionDefault(Col)
	_MyTableDataSectionGetter(Col,ElementSelectedStyle)
	_MyTableDataSectionGetter(Col,Application)
	_MyTableDataSectionGetter(Col,Table)
	_MyTableDataSectionGetter(Col,Position)
	_MyTableDataSectionSetterGetter(Col,Text)
	_MyTableDataSectionSetterGetter(Col,Image)
	_MyTableDataSectionSetterGetter(Col,Width)
	_MyTableDataSectionSetterGetter(Col,Sort)
	_MyTableDataSectionSetterGetter(Col,Colspan)
	
	
	_MyTableDataSectionMethode(Col,Delete)
	_MyTableDataSectionMethode(Col,ScrollTo)
	
	vtable_cell:;- Cell
	_MyTableDataSectionDefault(Cell)
	_MyTableDataSectionGetter(Cell,Application)
	_MyTableDataSectionGetter(Cell,Table)
	_MyTableDataSectionGetter(Cell,Row)
	_MyTableDataSectionGetter(Cell,Col)
	_MyTableDataSectionGetter(Cell,Parent)
	_MyTableDataSectionSetterGetter(Cell,Text)
	_MyTableDataSectionSetterGetter(Cell,Value)
	_MyTableDataSectionSetterGetter(Cell,ImageLeft)
	_MyTableDataSectionSetterGetter(Cell,ImageRight)
	_MyTableDataSectionSetterGetter(Cell,Checked)
	_MyTableDataSectionMethode(Cell,AddCell)
	_MyTableDataSectionMethode(Cell,DeleteCell)
	_MyTableDataSectionMethode(Cell,GetCell)
	_MyTableDataSectionMethode(Cell,CountCells)
	_MyTableDataSectionMethode(Cell,ScrollTo)
	_MyTableDataSectionMethode(Cell,StartEdit)
	_MyTableDataSectionMethode(Cell,StopEdit)
	
EndDataSection	
EndModule