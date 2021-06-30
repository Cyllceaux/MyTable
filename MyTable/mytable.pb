
Module MyTable
	EnableExplicit
	
	XIncludeFile "mytablestructures.pb"
	XIncludeFile "mytablemacro.pb"
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
		_DataSectionGetter(MyTable,Font,Type)
		_DataSectionGetter(MyTable,Font,Flags)
		_DataSectionGetter(MyTable,Font,Name)
		_DataSectionGetter(MyTable,Font,Size)
		
		vtable_style: ;- Style
		_MyTableDataSectionStyleDefault(Style)
		
		vtable_border: ;- Border
		_MyTableDataSectionBorderDefault(Border)
		
		
		vtable_application:;- Application
		_MyTableDataSectionDefault(Application)
		_DataSectionGetter(MyTable,Application,ElementSelectedStyle)
		_DataSectionGetter(MyTable,Application,ZebraStyle)
		_DataSectionGetter(MyTable,Application,TitleStyle)
		_DataSectionGetter(MyTable,Application,EmptyStyle)
		_DataSectionSetterGetter(MyTable,Application,Redraw)
		_DataSectionSetterGetter(MyTable,Application,Recalc)
		
		_DataSectionMethode(MyTable,Application,AddTable)
		_DataSectionMethode(MyTable,Application,AddTree)
		_DataSectionMethode(MyTable,Application,AddGrid)
		_DataSectionMethode(MyTable,Application,AddNewTable)
		_DataSectionMethode(MyTable,Application,AddNewTree)
		_DataSectionMethode(MyTable,Application,AddNewGrid)
		_DataSectionMethode(MyTable,Application,ClearTables)
		_DataSectionMethode(MyTable,Application,Redraw)
		_DataSectionMethode(MyTable,Application,Recalc)
		_DataSectionMethode(MyTable,Application,Free)
		_DataSectionMethode(MyTable,Application,Save)
		
		vtable_table:;- Table
		_MyTableDataSectionDefaultTable(Table)
		
		vtable_tree:;- Tree
		_MyTableDataSectionDefaultTable(Table)
		
		vtable_grid:;- Grid
		_MyTableDataSectionDefaultTableObject(Table)
		_DataSectionMethode(MyTable,Grid,ResizeGrid)
		_DataSectionMethode(MyTable,Table,BindEventColSelected)
		
		vtable_row:;- Row
		_MyTableDataSectionDefault(Row)
		_DataSectionGetter(MyTable,Row,ElementSelectedStyle)
		_DataSectionGetter(MyTable,Row,Application)
		_DataSectionGetter(MyTable,Row,Table)
		_DataSectionGetter(MyTable,Row,Parent)
		_DataSectionGetter(MyTable,Row,Position)
		_DataSectionGetter(MyTable,Row,VisiblePosition)
		_DataSectionGetter(MyTable,Row,Level)
		_DataSectionSetterGetter(MyTable,Row,Expanded)
		_DataSectionSetterGetter(MyTable,Row,Image)
		_DataSectionSetterGetter(MyTable,Row,Checked)
		_DataSectionSetterGetter(MyTable,Row,Height)
		
		_DataSectionMethode(MyTable,Row,AddDirtyRows)
		_DataSectionMethode(MyTable,Row,AddRow)
		_DataSectionMethode(MyTable,Row,DeleteRow)
		_DataSectionGetter(MyTable,Row,Row)
		_DataSectionMethode(MyTable,Row,RowCount)
		_DataSectionGetter(MyTable,Row,Cell)
		_DataSectionMethode(MyTable,Row,Delete)
		_DataSectionMethode(MyTable,Row,ScrollTo)
		
		vtable_col:;- Col
		_MyTableDataSectionDefault(Col)
		_DataSectionGetter(MyTable,Col,ElementSelectedStyle)
		_DataSectionGetter(MyTable,Col,Application)
		_DataSectionGetter(MyTable,Col,Table)
		_DataSectionGetter(MyTable,Col,Position)
		_DataSectionSetterGetter(MyTable,Col,Text)
		_DataSectionSetterGetter(MyTable,Col,Mask)
		_DataSectionSetterGetter(MyTable,Col,Datatype)
		_DataSectionSetterGetter(MyTable,Col,Image)
		_DataSectionSetterGetter(MyTable,Col,Width)
		_DataSectionSetterGetter(MyTable,Col,Sort)
		_DataSectionSetterGetter(MyTable,Col,Colspan)
		
		
		_DataSectionMethode(MyTable,Col,Delete)
		_DataSectionMethode(MyTable,Col,ScrollTo)
		
		vtable_cell:;- Cell
		_MyTableDataSectionDefault(Cell)
		_DataSectionGetter(MyTable,Cell,Application)
		_DataSectionGetter(MyTable,Cell,Table)
		_DataSectionGetter(MyTable,Cell,Row)
		_DataSectionGetter(MyTable,Cell,Col)
		_DataSectionGetter(MyTable,Cell,Parent)
		_DataSectionSetterGetter(MyTable,Cell,Text)
		_DataSectionSetterGetter(MyTable,Cell,Formula)
		_DataSectionSetterGetter(MyTable,Cell,Mask)
		_DataSectionSetterGetter(MyTable,Cell,Datatype)
		_DataSectionSetterGetter(MyTable,Cell,Value)
		_DataSectionSetterGetter(MyTable,Cell,ImageLeft)
		_DataSectionSetterGetter(MyTable,Cell,ImageRight)
		_DataSectionSetterGetter(MyTable,Cell,Checked)
		_DataSectionSetterGetter(MyTable,Cell,Colspan)
		_DataSectionMethode(MyTable,Cell,AddCell)
		_DataSectionMethode(MyTable,Cell,DeleteCell)
		_DataSectionMethode(MyTable,Cell,GetCell)
		_DataSectionMethode(MyTable,Cell,CountCells)
		_DataSectionMethode(MyTable,Cell,ScrollTo)
		_DataSectionMethode(MyTable,Cell,StartEdit)
		_DataSectionMethode(MyTable,Cell,StopEdit)
		
	EndDataSection	
	
EndModule