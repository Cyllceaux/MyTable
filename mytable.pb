
Module MyTable
	EnableExplicit
	
	
	
	XIncludeFile "mytablemacro.pb"
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
		_MyTableDataSectionSetterGetter(Row,Height)
		
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
		_MyTableDataSectionSetterGetter(Cell,Colspan)
		_MyTableDataSectionMethode(Cell,AddCell)
		_MyTableDataSectionMethode(Cell,DeleteCell)
		_MyTableDataSectionMethode(Cell,GetCell)
		_MyTableDataSectionMethode(Cell,CountCells)
		_MyTableDataSectionMethode(Cell,ScrollTo)
		_MyTableDataSectionMethode(Cell,StartEdit)
		_MyTableDataSectionMethode(Cell,StopEdit)
		
	EndDataSection	
EndModule