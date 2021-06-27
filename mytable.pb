
Module MyTable
	EnableExplicit
	
	
	
	XIncludeFile "mytablestructures.pb"
	XIncludeFile "declare.pb"
	XIncludeFile "autodeclare.pb"
	XIncludeFile "mytableglobal.pb"
	XIncludeFile "mytablefont.pb"
	XIncludeFile "mytablestyle.pb"
	XIncludeFile "mytableborder.pb"
	XIncludeFile "mytableapplication.pb"
	XIncludeFile "mytabletable.pb"
	XIncludeFile "mytabletree.pb"
	XIncludeFile "mytablegrid.pb"
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
		_MyTableDataSectionGetter(gruppe,DisabledStyle)
		_MyTableDataSectionGetter(gruppe,FixedStyle)
		_MyTableDataSectionSetterGetter(gruppe,Flags)
		_MyTableDataSectionSetterGetter(gruppe,Data)
		_MyTableDataSectionSetterGetter(gruppe,Dirty)
		_MyTableDataSectionSetterGetter(gruppe,Selected)		
		_MyTableDataSectionSetterGetter(gruppe,Tooltip)
		_MyTableDataSectionSetterGetter(gruppe,Disabled)
		
		_MyTableDataSectionMethode(gruppe,Autosize)
	EndMacro
	
	Macro _MyTableDataSectionBorderDefault(gruppe)
		_MyTableDataSectionGetter(gruppe,Type)
		_MyTableDataSectionGetter(gruppe,Object)
		_MyTableDataSectionGetter(gruppe,Style)
		
		_MyTableDataSectionSetterGetter(gruppe,Color)
		_MyTableDataSectionSetterGetter(gruppe,Width)
		
		_MyTableDataSectionMethode(gruppe,Free)
		_MyTableDataSectionMethode(gruppe,Delete)
	EndMacro
	
	Macro _MyTableDataSectionStyleDefault(gruppe)
		_MyTableDataSectionGetter(gruppe,Type)
		_MyTableDataSectionGetter(gruppe,Object)
		
		_MyTableDataSectionGetter(gruppe,BorderDefault)
		_MyTableDataSectionGetter(gruppe,BorderTop)
		_MyTableDataSectionGetter(gruppe,BorderLeft)
		_MyTableDataSectionGetter(gruppe,BorderRight)
		_MyTableDataSectionGetter(gruppe,BorderBottom)
		
		_MyTableDataSectionSetterGetter(gruppe,Font)
		_MyTableDataSectionSetterGetter(gruppe,BackColor)
		_MyTableDataSectionSetterGetter(gruppe,FrontColor)
		_MyTableDataSectionSetterGetter(gruppe,ForeColor)
		_MyTableDataSectionSetterGetter(gruppe,HAlign)
		_MyTableDataSectionSetterGetter(gruppe,VAlign)
		_MyTableDataSectionSetterGetter(gruppe,Border)
		
		
		_MyTableDataSectionMethode(gruppe,Free)
		_MyTableDataSectionMethode(gruppe,Delete)
	EndMacro
	
	Macro _MyTableDataSectionDefaultTableObject(gruppe)
		_MyTableDataSectionDefault(gruppe)
		_MyTableDataSectionGetter(gruppe,ElementSelectedStyle)
		_MyTableDataSectionGetter(gruppe,ZebraStyle)
		_MyTableDataSectionGetter(gruppe,TitleStyle)
		_MyTableDataSectionGetter(gruppe,EmptyStyle)
		_MyTableDataSectionGetter(gruppe,Application)
		
		_MyTableDataSectionGetter(gruppe,Pages)
		
		_MyTableDataSectionSetterGetter(gruppe,Name)
		_MyTableDataSectionSetterGetter(gruppe,Title)
		_MyTableDataSectionSetterGetter(gruppe,Redraw)
		_MyTableDataSectionSetterGetter(gruppe,Recalc)
		_MyTableDataSectionSetterGetter(gruppe,Batch)
		_MyTableDataSectionSetterGetter(gruppe,HeaderHeight)
		_MyTableDataSectionSetterGetter(gruppe,TitleHeight)
		_MyTableDataSectionSetterGetter(gruppe,DefaultRowHeight)
		_MyTableDataSectionSetterGetter(gruppe,FixedCols)
		_MyTableDataSectionSetterGetter(gruppe,EmptyText)
		_MyTableDataSectionSetterGetter(gruppe,Page)
		_MyTableDataSectionSetterGetter(gruppe,PageElements)
		
		_MyTableDataSectionGetter(gruppe,SelectedRows)
		_MyTableDataSectionGetter(gruppe,SelectedCells)
		_MyTableDataSectionGetter(gruppe,SelectedCols)
		_MyTableDataSectionGetter(gruppe,CalcHeight)
		_MyTableDataSectionGetter(gruppe,CalcWidth)
		
		_MyTableDataSectionMethode(gruppe,Redraw)
		_MyTableDataSectionMethode(gruppe,Recalc)
		_MyTableDataSectionMethode(gruppe,ReInit)
		_MyTableDataSectionMethode(gruppe,Free)
		_MyTableDataSectionMethode(gruppe,ScrollToPos)
		_MyTableDataSectionMethode(gruppe,ScrollToCellPos)
		_MyTableDataSectionMethode(gruppe,AutosizeRows)
		_MyTableDataSectionMethode(gruppe,AutosizeCols)
		_MyTableDataSectionMethode(gruppe,AutosizeHeader)
		
		_MyTableDataSectionMethode(gruppe,BindEventColLeftClick)
		_MyTableDataSectionMethode(gruppe,BindEventColLeftDoubleClick)
		_MyTableDataSectionMethode(gruppe,BindEventColRightClick)
		_MyTableDataSectionMethode(gruppe,BindEventColRightDoubleClick)
		
		_MyTableDataSectionMethode(gruppe,BindEventCellChangedChecked)
		_MyTableDataSectionMethode(gruppe,BindEventCellChangedUnChecked)
		_MyTableDataSectionMethode(gruppe,BindEventCellChangedText)
		_MyTableDataSectionMethode(gruppe,BindEventCellChangedValue)
		_MyTableDataSectionMethode(gruppe,BindEventCellSelected)
		_MyTableDataSectionMethode(gruppe,BindEventCellLeftClick)
		_MyTableDataSectionMethode(gruppe,BindEventCellLeftDoubleClick)
		_MyTableDataSectionMethode(gruppe,BindEventCellRightClick)
		_MyTableDataSectionMethode(gruppe,BindEventCellRightDoubleClick)
		
		_MyTableDataSectionMethode(gruppe,BindEventRowChangedChecked)
		_MyTableDataSectionMethode(gruppe,BindEventRowChangedUnChecked)
		_MyTableDataSectionMethode(gruppe,BindEventRowChangedExpanded)
		_MyTableDataSectionMethode(gruppe,BindEventRowChangedCollapsed)
		_MyTableDataSectionMethode(gruppe,BindEventRowSelected)
		_MyTableDataSectionMethode(gruppe,BindEventRowLeftClick)
		_MyTableDataSectionMethode(gruppe,BindEventRowLeftDoubleClick)
		_MyTableDataSectionMethode(gruppe,BindEventRowRightClick)
		_MyTableDataSectionMethode(gruppe,BindEventRowRightDoubleClick)
		
		_MyTableDataSectionMethode(gruppe,BindEventCustomCellDraw)
		_MyTableDataSectionMethode(gruppe,BindEventCustomCellEdit)
		
		_MyTableDataSectionMethode(gruppe,BindCallback)
		
		_MyTableDataSectionGetter(gruppe,Cell)
		_MyTableDataSectionMethode(gruppe,Delete)
		
		_MyTableDataSectionGetter(gruppe,Row)
		_MyTableDataSectionMethode(gruppe,RowCount)
		_MyTableDataSectionMethode(gruppe,VisibleRowCount)
		
		_MyTableDataSectionGetter(gruppe,Col)
		_MyTableDataSectionMethode(gruppe,ColCount)
	EndMacro
	
	Macro _MyTableDataSectionDefaultTable(gruppe)
		_MyTableDataSectionDefaultTableObject(gruppe)
		
		
		_MyTableDataSectionSetterGetter(gruppe,DefaultImageSortAsc)
		_MyTableDataSectionSetterGetter(gruppe,DefaultImageSortDesc)
		_MyTableDataSectionSetterGetter(gruppe,DefaultImagePlus)
		_MyTableDataSectionSetterGetter(gruppe,DefaultImageMinus)
		_MyTableDataSectionSetterGetter(gruppe,DefaultImageCheckBox)
		_MyTableDataSectionSetterGetter(gruppe,DefaultImageCheckBoxChecked)
		_MyTableDataSectionSetterGetter(gruppe,DefaultImagePlusArrow)
		_MyTableDataSectionSetterGetter(gruppe,DefaultImageMinusArrow)
		
		
		_MyTableDataSectionMethode(gruppe,AddDirtyRows)
		_MyTableDataSectionMethode(gruppe,AddRow)
		_MyTableDataSectionMethode(gruppe,DeleteRow)
		
		_MyTableDataSectionMethode(gruppe,AddCol)
		_MyTableDataSectionMethode(gruppe,DeleteCol)
		
		
		
		_MyTableDataSectionMethode(gruppe,ClearRows)
		_MyTableDataSectionMethode(gruppe,ClearCols)
		
	EndMacro
	
	
	
	DataSection
		vtable_font: ;- Font
		_MyTableDataSectionGetter(Font,Type)
		_MyTableDataSectionGetter(Font,Flags)
		_MyTableDataSectionGetter(Font,Name)
		_MyTableDataSectionGetter(Font,Size)
		
		vtable_style: ;- Style
		_MyTableDataSectionStyleDefault(Style)
		
		vtable_border: ;- Border
		_MyTableDataSectionBorderDefault(Border)
		
		
		vtable_application:;- Application
		_MyTableDataSectionDefault(Application)
		_MyTableDataSectionGetter(Application,ElementSelectedStyle)
		_MyTableDataSectionGetter(Application,ZebraStyle)
		_MyTableDataSectionGetter(Application,TitleStyle)
		_MyTableDataSectionGetter(Application,EmptyStyle)
		_MyTableDataSectionSetterGetter(Application,Redraw)
		_MyTableDataSectionSetterGetter(Application,Recalc)
		
		_MyTableDataSectionMethode(Application,AddTable)
		_MyTableDataSectionMethode(Application,AddTree)
		_MyTableDataSectionMethode(Application,AddGrid)
		_MyTableDataSectionMethode(Application,ClearTables)
		_MyTableDataSectionMethode(Application,Redraw)
		_MyTableDataSectionMethode(Application,Recalc)
		_MyTableDataSectionMethode(Application,Free)
		_MyTableDataSectionMethode(Application,Save)
		
		vtable_table:;- Table
		_MyTableDataSectionDefaultTable(Table)
		
		vtable_tree:;- Tree
		_MyTableDataSectionDefaultTable(Table)
		
		vtable_grid:;- Grid
		_MyTableDataSectionDefaultTableObject(Table)
		_MyTableDataSectionMethode(Grid,ResizeGrid)
		_MyTableDataSectionMethode(Table,BindEventColSelected)
		
		vtable_row:;- Row
		_MyTableDataSectionDefault(Row)
		_MyTableDataSectionGetter(Row,ElementSelectedStyle)
		_MyTableDataSectionGetter(Row,Application)
		_MyTableDataSectionGetter(Row,Table)
		_MyTableDataSectionGetter(Row,Parent)
		_MyTableDataSectionGetter(Row,Position)
		_MyTableDataSectionGetter(Row,VisiblePosition)
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
		_MyTableDataSectionSetterGetter(Col,Mask)
		_MyTableDataSectionSetterGetter(Col,Datatype)
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
		_MyTableDataSectionSetterGetter(Cell,Formula)
		_MyTableDataSectionSetterGetter(Cell,Mask)
		_MyTableDataSectionSetterGetter(Cell,Datatype)
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