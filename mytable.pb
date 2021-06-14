
Module MyTable
	EnableExplicit
	
	
	
	XIncludeFile "mytablestructures.pb"
	XIncludeFile "declare.pb"
	XIncludeFile "mytableglobal.pb"
	

	
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
		_MyTableDataSectionGetter(gruppe,Style)
		_MyTableDataSectionSetterGetter(gruppe,Flags)
		_MyTableDataSectionSetterGetter(gruppe,Data)
		_MyTableDataSectionSetterGetter(gruppe,Dirty)
		_MyTableDataSectionSetterGetter(gruppe,Selected)		
		_MyTableDataSectionSetterGetter(gruppe,Tooltip)
		
		_MyTableDataSectionMethode(gruppe,Autosize)
	EndMacro
	
	Macro _MyTableDataSectionStyleDefault(gruppe)
		_MyTableDataSectionGetter(gruppe,Object)
		_MyTableDataSectionSetterGetter(gruppe,DefaultFont)
		_MyTableDataSectionSetterGetter(gruppe,DefaultBackColor)
		_MyTableDataSectionSetterGetter(gruppe,DefaultFrontColor)
		_MyTableDataSectionSetterGetter(gruppe,DefaultForeColor)
		
		_MyTableDataSectionSetterGetter(gruppe,SelectedBackColor)
		_MyTableDataSectionSetterGetter(gruppe,DefaultBorderColorDefault)
		_MyTableDataSectionSetterGetter(gruppe,DefaultBorderWidthDefault)
		_MyTableDataSectionSetterGetter(gruppe,SelectedBorderColorDefault)
		_MyTableDataSectionSetterGetter(gruppe,SelectedBorderWidthDefault)
		_MyTableDataSectionSetterGetter(gruppe,SelectedForeColor)
		
		_MyTableDataSectionMethode(gruppe,Free)
		_MyTableDataSectionMethode(gruppe,Delete)
	EndMacro
	
	Macro _MyTableDataSectionCellStyleDefault(gruppe)
		_MyTableDataSectionStyleDefault(gruppe)
		_MyTableDataSectionSetterGetter(gruppe,DefaultHAlign)
		_MyTableDataSectionSetterGetter(gruppe,DefaultVAlign)
		_MyTableDataSectionSetterGetter(gruppe,DefaultBorder)
		
	EndMacro
	
	DataSection
		vtable_style_cell:;- Style Cell
		_MyTableDataSectionCellStyleDefault(Style)
		
		vtable_style_row:;- Style Row
		_MyTableDataSectionCellStyleDefault(Style)
		_MyTableDataSectionSetterGetter(Style,ElementSelectedBackColor)
		_MyTableDataSectionSetterGetter(Style,ElementSelectedBorderColorDefault)
		_MyTableDataSectionSetterGetter(Style,ElementSelectedForeColor)
		
		vtable_style_col:;- Style Col
		_MyTableDataSectionCellStyleDefault(Style)
		_MyTableDataSectionSetterGetter(Style,ElementSelectedBackColor)
		_MyTableDataSectionSetterGetter(Style,ElementSelectedForeColor)
		
		vtable_style_table:;- Style Table
		_MyTableDataSectionStyleDefault(Style)
		_MyTableDataSectionSetterGetter(Style,ZebraBackColor)
		_MyTableDataSectionSetterGetter(Style,ZebraFrontColor)
		_MyTableDataSectionSetterGetter(Style,FixedBackColor)
		_MyTableDataSectionSetterGetter(Style,FixedFrontColor)
		_MyTableDataSectionSetterGetter(Style,FixedForeColor)
		_MyTableDataSectionSetterGetter(Style,TitleFont)
		_MyTableDataSectionSetterGetter(Style,TitleBackColor)
		_MyTableDataSectionSetterGetter(Style,TitleFrontColor)
		_MyTableDataSectionSetterGetter(Style,TitleForeColor)
		_MyTableDataSectionSetterGetter(Style,TitleHAlign)
		_MyTableDataSectionSetterGetter(Style,TitleVAlign)
		
		
		vtable_style_application:;- Style Application
		_MyTableDataSectionStyleDefault(Style)
		
		
		vtable_application:;- Application
		_MyTableDataSectionDefault(Application)
		_MyTableDataSectionSetterGetter(Application,Redraw)
		_MyTableDataSectionSetterGetter(Application,Recalc)
		
		_MyTableDataSectionMethode(Application,AddTable)
		_MyTableDataSectionMethode(Application,ClearTables)
		_MyTableDataSectionMethode(Application,Redraw)
		_MyTableDataSectionMethode(Application,Recalc)
		_MyTableDataSectionMethode(Application,Free)
		
		vtable_table:;- Table
		_MyTableDataSectionDefault(Table)
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
		_MyTableDataSectionMethode(Table,RegisterEventRowChangedChecked)
		_MyTableDataSectionMethode(Table,RegisterEventRowChangedUnChecked)
		_MyTableDataSectionMethode(Table,RegisterEventRowChangedExpanded)
		_MyTableDataSectionMethode(Table,RegisterEventRowChangedCollapsed)
		_MyTableDataSectionMethode(Table,RegisterEventRowSelected)
		
		_MyTableDataSectionMethode(Table,RegisterCallback)
		
		vtable_row:;- Row
		_MyTableDataSectionDefault(Row)
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
		
	EndDataSection	
EndModule