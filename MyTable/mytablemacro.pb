
IncludeFile "../MyGlobal/myglobalmacro.pb"


Macro _MyTable_GetStyleCell(name)
	_AddAutoDeclare(MyTable,_MyTable_Cell_Get#name#Style(*this.strMyTableCell))
	Procedure _MyTable_Cell_Get#name#Style(*this.strMyTableCell)
		Protected *style.strMyTableStyleObject=AllocateStructure(strMyTableStyleObject)
		
		*style\cellStyle=*this\name#Style
		*style\rowStyle=*this\row\name#Style
		*style\colStyle=*this\col\name#Style
		*style\tableStyle=*this\table\name#Style
		*style\applicationStyle=*this\application\name#Style
		
		_MyTableInitStyleObject(*style,*this,*this\name#Style)
		ProcedureReturn *style
	EndProcedure
EndMacro

Macro _MyTable_GetStyleCol(name)
	_AddAutoDeclare(MyTable,_MyTable_Col_Get#name#Style(*this.strMyTableCol))
	Procedure _MyTable_Col_Get#name#Style(*this.strMyTableCol)
		Protected *style.strMyTableStyleObject=AllocateStructure(strMyTableStyleObject)
		
		*style\colStyle=*this\name#Style
		*style\tableStyle=*this\table\name#Style
		*style\applicationStyle=*this\application\name#Style
		
		_MyTableInitStyleObject(*style,*this,*this\name#Style)
		ProcedureReturn *style
	EndProcedure
EndMacro

Macro _MyTable_GetStyleRow(name)
	_AddAutoDeclare(MyTable,_MyTable_Row_Get#name#Style(*this.strMyTableRow))
	Procedure _MyTable_Row_Get#name#Style(*this.strMyTableRow)
		Protected *style.strMyTableStyleObject=AllocateStructure(strMyTableStyleObject)
		
		*style\rowStyle=*this\name#Style
		*style\tableStyle=*this\table\name#Style
		*style\applicationStyle=*this\application\name#Style
		
		_MyTableInitStyleObject(*style,*this,*this\name#Style)
		ProcedureReturn *style
	EndProcedure
EndMacro

Macro _MyTable_GetStyleTable(name)
	_AddAutoDeclare(MyTable,_MyTable_Table_Get#name#Style(*this.strMyTableTable))
	Procedure _MyTable_Table_Get#name#Style(*this.strMyTableTable)
		Protected *style.strMyTableStyleObject=AllocateStructure(strMyTableStyleObject)
		
		*style\tableStyle=*this\name#Style		
		*style\applicationStyle=*this\application\name#Style
		
		_MyTableInitStyleObject(*style,*this,*this\name#Style)
		ProcedureReturn *style
	EndProcedure
EndMacro

Macro _MyTable_GetStyleApplication(name)
	_AddAutoDeclare(MyTable,_MyTable_Application_Get#name#Style(*this.strMyTableApplication))
	Procedure _MyTable_Application_Get#name#Style(*this.strMyTableApplication)
		Protected *style.strMyTableStyleObject=AllocateStructure(strMyTableStyleObject)
		
		*style\applicationStyle=*this\name#Style
		
		_MyTableInitStyleObject(*style,*this,*this\name#Style)
		ProcedureReturn *style
	EndProcedure
EndMacro


CompilerIf #PB_Compiler_Debugger And Defined(MYTABLE_DEBUG,#PB_Module)
	
	Procedure.s _MyTableDebugGetName(*this.strMyVTable)
		Select *this\type
			Case My::#MY_TYPE_CELL
				Protected *cell.strMyTableCell=*this
				ProcedureReturn *cell\table\name
			Case My::#MY_TYPE_ROW
				Protected *row.strMyTableRow=*this
				ProcedureReturn *row\table\name
			Case My::#MY_TYPE_COL
				Protected *col.strMyTableCol=*this
				ProcedureReturn *col\table\name
			Case My::#MY_TYPE_TABLE,My::#MY_TYPE_GRID,My::#MY_TYPE_TREE
				Protected *table.strMyTableTable=*this
				ProcedureReturn *table\name
			Case My::#MY_TYPE_APPLICATION
				ProcedureReturn ""
			Case My::#MY_TYPE_STYLE
				Protected *style.strMyTableStyleObject=*this
				ProcedureReturn _MyTableDebugGetName(*style\obj)
		EndSelect
	EndProcedure
	
	Procedure _MyTableDebugGetCanvas(*this.strMyVTable)
		Select *this\type
			Case My::#MY_TYPE_CELL
				Protected *cell.strMyTableCell=*this
				ProcedureReturn *cell\table\canvas
			Case My::#MY_TYPE_ROW
				Protected *row.strMyTableRow=*this
				ProcedureReturn *row\table\canvas
			Case My::#MY_TYPE_COL
				Protected *col.strMyTableCol=*this
				ProcedureReturn *col\table\canvas
			Case My::#MY_TYPE_TABLE,My::#MY_TYPE_GRID,My::#MY_TYPE_TREE
				Protected *table.strMyTableTable=*this
				ProcedureReturn *table\canvas
			Case My::#MY_TYPE_APPLICATION
				ProcedureReturn 0
			Case My::#MY_TYPE_STYLE
				Protected *style.strMyTableStyleObject=*this
				ProcedureReturn _MyTableDebugGetCanvas(*style\obj)
		EndSelect
	EndProcedure
CompilerEndIf



CompilerIf #PB_Compiler_Debugger And Defined(MYTABLE_DEBUG,#PB_Module)
	Macro _callcountStart()
		Static NewMap callcount.i()
		Static NewMap callms.i()
		Static NewMap callmssum.i()					
		callms(#PB_Compiler_Procedure+"_"+Str(_MyTableDebugGetCanvas(*this)))=ElapsedMilliseconds()		
		
		
	EndMacro
	
	Macro _callcountEnde()
		
		Protected _callcountms=ElapsedMilliseconds()-callms(#PB_Compiler_Procedure+"_"+Str(_MyTableDebugGetCanvas(*this)))
		callcount(#PB_Compiler_Procedure+"_"+Str(_MyTableDebugGetCanvas(*this)))+1
		callmssum(#PB_Compiler_Procedure+"_"+Str(_MyTableDebugGetCanvas(*this)))+_callcountms
		
		Protected tname.s=""
		If _MyTableDebugGetName(*this)=""
			tname=Str(_MyTableDebugGetCanvas(*this))
		Else
			tname=_MyTableDebugGetName(*this)
		EndIf
		
		Protected debugline.s=LSet(tname+":",20," ")
		debugline + LSet(#PB_Compiler_Procedure+":   "+callcount(#PB_Compiler_Procedure+"_"+Str(_MyTableDebugGetCanvas(*this))),40," ")
		
		CompilerIf Defined(MYTABLE_DEBUG_MS_MAX,#PB_Module)
			If _callcountms>MYTABLE_DEBUG_MS_MAX::#MYTABLE_DEBUG_MS_MAX
				DebuggerWarning(#PB_Compiler_Procedure+" für "+tname+" > "+Str(MYTABLE_DEBUG_MS_MAX::#MYTABLE_DEBUG_MS_MAX)+"ms ( "+Str(_callcountms)+" )")
			EndIf
		CompilerEndIf
		debugline + Str(_callcountms)+"ms / "+Str(callmssum(#PB_Compiler_Procedure+"_"+Str(_MyTableDebugGetCanvas(*this))))+"ms / " +Str(callmssum(#PB_Compiler_Procedure+"_"+Str(_MyTableDebugGetCanvas(*this)))/callcount(#PB_Compiler_Procedure+"_"+Str(_MyTableDebugGetCanvas(*this))))+ "ms"
		CompilerIf Defined(MYTABLE_DEBUG_LEVEL,#PB_Module)
			Debug debugline,MYTABLE_DEBUG_LEVEL::#MYTABLE_DEBUG_LEVEL
		CompilerElse
			Debug debugline
		CompilerEndIf
	EndMacro
CompilerElse
	Macro _callcountStart():EndMacro
	Macro _callcountEnde():EndMacro
CompilerEndIf

Macro _MyTable_GetStylesApplication()
_MyTable_GetStyleApplication(Default)
	_MyTable_GetStyleApplication(Selected)
	_MyTable_GetStyleApplication(Fixed)
	_MyTable_GetStyleApplication(MouseOver)
	_MyTable_GetStyleApplication(Title)
	_MyTable_GetStyleApplication(ElementSelected)
	_MyTable_GetStyleApplication(Empty)
	_MyTable_GetStyleApplication(Zebra)
	_MyTable_GetStyleApplication(Disabled)
EndMacro

Macro _MyTable_GetStylesTable()
_MyTable_GetStyleTable(Default)
	_MyTable_GetStyleTable(Selected)
	_MyTable_GetStyleTable(Fixed)
	_MyTable_GetStyleTable(MouseOver)
	_MyTable_GetStyleTable(Title)
	_MyTable_GetStyleTable(ElementSelected)
	_MyTable_GetStyleTable(Empty)
	_MyTable_GetStyleTable(Zebra)
	_MyTable_GetStyleTable(Disabled)
EndMacro

Macro _MyTable_GetStylesRow()
_MyTable_GetStyleRow(Default)
	_MyTable_GetStyleRow(Selected)
	_MyTable_GetStyleRow(Fixed)
	_MyTable_GetStyleRow(MouseOver)
	_MyTable_GetStyleRow(Title)
	_MyTable_GetStyleRow(ElementSelected)
	_MyTable_GetStyleRow(Empty)
	_MyTable_GetStyleRow(Zebra)
	_MyTable_GetStyleRow(Disabled)
EndMacro

Macro _MyTable_GetStylesCol()
_MyTable_GetStyleCol(Default)
	_MyTable_GetStyleCol(Selected)
	_MyTable_GetStyleCol(Fixed)
	_MyTable_GetStyleCol(MouseOver)
	_MyTable_GetStyleCol(Title)
	_MyTable_GetStyleCol(ElementSelected)
	_MyTable_GetStyleCol(Empty)
	_MyTable_GetStyleCol(Zebra)
	_MyTable_GetStyleCol(Disabled)
EndMacro

Macro _MyTable_GetStylesCell()
_MyTable_GetStyleCell(Default)
	_MyTable_GetStyleCell(Selected)
	_MyTable_GetStyleCell(Fixed)
	_MyTable_GetStyleCell(MouseOver)
	_MyTable_GetStyleCell(Title)
	_MyTable_GetStyleCell(ElementSelected)
	_MyTable_GetStyleCell(Empty)
	_MyTable_GetStyleCell(Zebra)
	_MyTable_GetStyleCell(Disabled)
EndMacro


Macro _MyTableDataSectionDefault(gruppe)
	_DataSectionGetter(MyTable,gruppe,Type)
	_DataSectionGetter(MyTable,gruppe,DefaultStyle)
	_DataSectionGetter(MyTable,gruppe,SelectedStyle)
	_DataSectionGetter(MyTable,gruppe,MouseOverStyle)
	_DataSectionGetter(MyTable,gruppe,DisabledStyle)
	_DataSectionGetter(MyTable,gruppe,FixedStyle)
	_DataSectionSetterGetter(MyTable,gruppe,Flags)
	_DataSectionSetterGetter(MyTable,gruppe,Data)
	_DataSectionSetterGetter(MyTable,gruppe,Dirty)
	_DataSectionSetterGetter(MyTable,gruppe,Selected)		
	_DataSectionSetterGetter(MyTable,gruppe,Tooltip)
	_DataSectionSetterGetter(MyTable,gruppe,Disabled)
	
	_DataSectionMethode(MyTable,gruppe,Autosize)
EndMacro

Macro _MyTableDataSectionBorderDefault(gruppe)
	_DataSectionGetter(MyTable,gruppe,Type)
	_DataSectionGetter(MyTable,gruppe,Object)
	_DataSectionGetter(MyTable,gruppe,Style)
	
	_DataSectionSetterGetter(MyTable,gruppe,Color)
	_DataSectionSetterGetter(MyTable,gruppe,Width)
	
	_DataSectionMethode(MyTable,gruppe,Free)
	_DataSectionMethode(MyTable,gruppe,Delete)
EndMacro

Macro _MyTableDataSectionStyleDefault(gruppe)
	_DataSectionGetter(MyTable,gruppe,Type)
	_DataSectionGetter(MyTable,gruppe,Object)
	
	_DataSectionGetter(MyTable,gruppe,BorderDefault)
	_DataSectionGetter(MyTable,gruppe,BorderTop)
	_DataSectionGetter(MyTable,gruppe,BorderLeft)
	_DataSectionGetter(MyTable,gruppe,BorderRight)
	_DataSectionGetter(MyTable,gruppe,BorderBottom)
	
	_DataSectionSetterGetter(MyTable,gruppe,Font)
	_DataSectionSetterGetter(MyTable,gruppe,BackColor)
	_DataSectionSetterGetter(MyTable,gruppe,FrontColor)
	_DataSectionSetterGetter(MyTable,gruppe,ForeColor)
	_DataSectionSetterGetter(MyTable,gruppe,HAlign)
	_DataSectionSetterGetter(MyTable,gruppe,VAlign)
	_DataSectionSetterGetter(MyTable,gruppe,Border)
	
	
	_DataSectionMethode(MyTable,gruppe,Free)
	_DataSectionMethode(MyTable,gruppe,Delete)
EndMacro

Macro _MyTableDataSectionDefaultTableObject(gruppe)
	_MyTableDataSectionDefault(gruppe)
	_DataSectionGetter(MyTable,gruppe,ElementSelectedStyle)
	_DataSectionGetter(MyTable,gruppe,ZebraStyle)
	_DataSectionGetter(MyTable,gruppe,TitleStyle)
	_DataSectionGetter(MyTable,gruppe,EmptyStyle)
	_DataSectionGetter(MyTable,gruppe,Application)
	
	_DataSectionGetter(MyTable,gruppe,Pages)
	
	_DataSectionSetterGetter(MyTable,gruppe,Name)
	_DataSectionSetterGetter(MyTable,gruppe,Title)
	_DataSectionSetterGetter(MyTable,gruppe,Redraw)
	_DataSectionSetterGetter(MyTable,gruppe,Recalc)
	_DataSectionSetterGetter(MyTable,gruppe,Batch)
	_DataSectionSetterGetter(MyTable,gruppe,HeaderHeight)
	_DataSectionSetterGetter(MyTable,gruppe,TitleHeight)
	_DataSectionSetterGetter(MyTable,gruppe,DefaultRowHeight)
	_DataSectionSetterGetter(MyTable,gruppe,FixedCols)
	_DataSectionSetterGetter(MyTable,gruppe,EmptyText)
	_DataSectionSetterGetter(MyTable,gruppe,Page)
	_DataSectionSetterGetter(MyTable,gruppe,PageElements)
	
	_DataSectionGetter(MyTable,gruppe,SelectedRows)
	_DataSectionGetter(MyTable,gruppe,SelectedCells)
	_DataSectionGetter(MyTable,gruppe,SelectedCols)
	_DataSectionGetter(MyTable,gruppe,CalcHeight)
	_DataSectionGetter(MyTable,gruppe,CalcWidth)
	
	_DataSectionMethode(MyTable,gruppe,Redraw)
	_DataSectionMethode(MyTable,gruppe,Recalc)
	_DataSectionMethode(MyTable,gruppe,ReInit)
	_DataSectionMethode(MyTable,gruppe,Free)
	_DataSectionMethode(MyTable,gruppe,ScrollToPos)
	_DataSectionMethode(MyTable,gruppe,ScrollToCellPos)
	_DataSectionMethode(MyTable,gruppe,AutosizeRows)
	_DataSectionMethode(MyTable,gruppe,AutosizeCols)
	_DataSectionMethode(MyTable,gruppe,AutosizeHeader)
	
	_DataSectionMethode(MyTable,gruppe,BindEventColLeftClick)
	_DataSectionMethode(MyTable,gruppe,BindEventColLeftDoubleClick)
	_DataSectionMethode(MyTable,gruppe,BindEventColRightClick)
	_DataSectionMethode(MyTable,gruppe,BindEventColRightDoubleClick)
	
	_DataSectionMethode(MyTable,gruppe,BindEventCellChangedChecked)
	_DataSectionMethode(MyTable,gruppe,BindEventCellChangedUnChecked)
	_DataSectionMethode(MyTable,gruppe,BindEventCellChangedText)
	_DataSectionMethode(MyTable,gruppe,BindEventCellChangedValue)
	_DataSectionMethode(MyTable,gruppe,BindEventCellSelected)
	_DataSectionMethode(MyTable,gruppe,BindEventCellLeftClick)
	_DataSectionMethode(MyTable,gruppe,BindEventCellLeftDoubleClick)
	_DataSectionMethode(MyTable,gruppe,BindEventCellRightClick)
	_DataSectionMethode(MyTable,gruppe,BindEventCellRightDoubleClick)
	
	_DataSectionMethode(MyTable,gruppe,BindEventRowChangedChecked)
	_DataSectionMethode(MyTable,gruppe,BindEventRowChangedUnChecked)
	_DataSectionMethode(MyTable,gruppe,BindEventRowChangedExpanded)
	_DataSectionMethode(MyTable,gruppe,BindEventRowChangedCollapsed)
	_DataSectionMethode(MyTable,gruppe,BindEventRowSelected)
	_DataSectionMethode(MyTable,gruppe,BindEventRowLeftClick)
	_DataSectionMethode(MyTable,gruppe,BindEventRowLeftDoubleClick)
	_DataSectionMethode(MyTable,gruppe,BindEventRowRightClick)
	_DataSectionMethode(MyTable,gruppe,BindEventRowRightDoubleClick)
	
	_DataSectionMethode(MyTable,gruppe,BindEventCustomCellDraw)
	_DataSectionMethode(MyTable,gruppe,BindEventCustomCellEdit)
	
	_DataSectionMethode(MyTable,gruppe,BindCallback)
	
	_DataSectionGetter(MyTable,gruppe,Cell)
	_DataSectionMethode(MyTable,gruppe,Delete)
	
	_DataSectionGetter(MyTable,gruppe,Row)
	_DataSectionMethode(MyTable,gruppe,RowCount)
	_DataSectionMethode(MyTable,gruppe,VisibleRowCount)
	
	_DataSectionGetter(MyTable,gruppe,Col)
	_DataSectionMethode(MyTable,gruppe,ColCount)
	
	_DataSectionGetter(MyTable,gruppe,Canvas)
	_DataSectionGetter(MyTable,gruppe,HScroll)
	_DataSectionGetter(MyTable,gruppe,VScroll)
	_DataSectionGetter(MyTable,gruppe,Window)
EndMacro

Macro _MyTableDataSectionDefaultTable(gruppe)
	_MyTableDataSectionDefaultTableObject(gruppe)
	
	
	_DataSectionSetterGetter(MyTable,gruppe,DefaultImageSortAsc)
	_DataSectionSetterGetter(MyTable,gruppe,DefaultImageSortDesc)
	_DataSectionSetterGetter(MyTable,gruppe,DefaultImagePlus)
	_DataSectionSetterGetter(MyTable,gruppe,DefaultImageMinus)
	_DataSectionSetterGetter(MyTable,gruppe,DefaultImageCheckBox)
	_DataSectionSetterGetter(MyTable,gruppe,DefaultImageCheckBoxChecked)
	_DataSectionSetterGetter(MyTable,gruppe,DefaultImagePlusArrow)
	_DataSectionSetterGetter(MyTable,gruppe,DefaultImageMinusArrow)
	
	
	_DataSectionMethode(MyTable,gruppe,AddDirtyRows)
	_DataSectionMethode(MyTable,gruppe,AddRow)
	_DataSectionMethode(MyTable,gruppe,DeleteRow)
	
	_DataSectionMethode(MyTable,gruppe,AddCol)
	_DataSectionMethode(MyTable,gruppe,DeleteCol)
	
	
	
	_DataSectionMethode(MyTable,gruppe,ClearRows)
	_DataSectionMethode(MyTable,gruppe,ClearCols)
	
EndMacro


Macro _MyTableBorderSetterGetter(name,typ)
	_AddAutoDeclare(MyTable,.typ _MyTable_Border_Get#name(*this.strMyTableBorderObject))
	Procedure.typ _MyTable_Border_Get#name(*this.strMyTableBorderObject)
		If *this
			Protected result.typ= *this\border\name
			If Not result
				If *this\borderBottom
					result=_MyTable_GetDefaultBorder#name#Bottom(*this\style\obj)
				ElseIf *this\borderDefault
					result=_MyTable_GetDefaultBorder#name#Default(*this\style\obj)
				ElseIf *this\borderLeft
					result=_MyTable_GetDefaultBorder#name#Left(*this\style\obj)
				ElseIf *this\borderRight
					result=_MyTable_GetDefaultBorder#name#Right(*this\style\obj)					
				ElseIf *this\borderTop
					result=_MyTable_GetDefaultBorder#name#Top(*this\style\obj)
				EndIf
			EndIf
			ProcedureReturn result
		EndIf
	EndProcedure
	
	_AddAutoDeclare(MyTable, _MyTable_Border_Set#name(*this.strMyTableBorderObject,value.typ))
	Procedure _MyTable_Border_Set#name(*this.strMyTableBorderObject,value.typ)
		If *this
			*this\border\name=value
			_MyTable_Style_Redraw(*this\style)
		EndIf
	EndProcedure
EndMacro


Macro _MyTable_StyleMethods(gruppe,name,typ,sub=)
	_AddAutoDeclare(MyTable,.typ _MyTable_Get#gruppe#name(*obj.strMyTableObject,root.b=#True))
	Procedure.typ _MyTable_Get#gruppe#name(*obj.strMyTableObject,root.b=#True)
		Protected result.typ=*obj\gruppe#Style\sub#name
		
		If Not result
			Select *obj\type
				Case My::#MY_TYPE_CELL
					Protected *cell.strMyTableCell=*obj					
					result=_MyTable_Get#gruppe#name(*cell\table,#False)
				Case My::#MY_TYPE_ROW
					Protected *row.strMyTableRow=*obj					
					result=_MyTable_Get#gruppe#name(*row\table,#False)
				Case My::#MY_TYPE_COL
					Protected *col.strMyTableCol=*obj					
					result=_MyTable_Get#gruppe#name(*col\table,#False)					
				Case My::#MY_TYPE_TABLE,My::#MY_TYPE_GRID,My::#MY_TYPE_TREE
					Protected *table.strMyTableTable=*obj
					If *table\application
						result=_MyTable_Get#gruppe#name(*table\application,#False)
					EndIf
			EndSelect
		EndIf
		If root And Not result
			result=_MyTable_GetDefault#name(*obj,#False)
		EndIf
		ProcedureReturn result
	EndProcedure
EndMacro

Macro _MyTable_StyleMethodsRow(gruppe,name,typ,sub=)
	_AddAutoDeclare(MyTable,.typ _MyTable_Get#gruppe#name(*obj.strMyTableObject,root.b=#True))
	Procedure.typ _MyTable_Get#gruppe#name(*obj.strMyTableObject,root.b=#True)
		Protected result.typ=*obj\gruppe#Style\sub#name
		
		If Not result
			Select *obj\type
				Case My::#MY_TYPE_CELL
					Protected *cell.strMyTableCell=*obj			
					If Not *cell\table\datagrid						
						result=_MyTable_Get#gruppe#name(*cell\row,#False)
					Else
						result=_MyTable_Get#gruppe#name(*cell\table,#False)
					EndIf
				Case My::#MY_TYPE_ROW
					Protected *row.strMyTableRow=*obj					
					result=_MyTable_Get#gruppe#name(*row\table,#False)
				Case My::#MY_TYPE_COL
					Protected *col.strMyTableCol=*obj					
					result=_MyTable_Get#gruppe#name(*col\table,#False)					
				Case My::#MY_TYPE_TABLE,My::#MY_TYPE_GRID,My::#MY_TYPE_TREE
					Protected *table.strMyTableTable=*obj
					If *table\application
						result=_MyTable_Get#gruppe#name(*table\application,#False)
					EndIf
			EndSelect
		EndIf
		If root And Not result
			result=_MyTable_GetDefault#name(*obj,#False)
		EndIf
		ProcedureReturn result
	EndProcedure
EndMacro

Macro _MyTable_StyleMethodsRowPointer(gruppe,name,typ,sub=)
	_AddAutoDeclare(MyTable,_MyTable_Get#gruppe#name(*obj.strMyTableObject,root.b=#True))
	Procedure _MyTable_Get#gruppe#name(*obj.strMyTableObject,root.b=#True)
		Protected *result.typ=*obj\gruppe#Style\sub#name
		
		If Not *result
			Select *obj\type
				Case My::#MY_TYPE_CELL
					Protected *cell.strMyTableCell=*obj			
					If Not *cell\table\datagrid
						*result=_MyTable_Get#gruppe#name(*cell\row,#False)
					Else
						*result=_MyTable_Get#gruppe#name(*cell\table,#False)
					EndIf
				Case My::#MY_TYPE_ROW
					Protected *row.strMyTableRow=*obj					
					*result=_MyTable_Get#gruppe#name(*row\table,#False)
				Case My::#MY_TYPE_COL
					Protected *col.strMyTableCol=*obj					
					*result=_MyTable_Get#gruppe#name(*col\table,#False)					
				Case My::#MY_TYPE_TABLE,My::#MY_TYPE_GRID,My::#MY_TYPE_TREE
					Protected *table.strMyTableTable=*obj
					If *table\application
						*result=_MyTable_Get#gruppe#name(*table\application,#False)
					EndIf
			EndSelect
		EndIf
		If root And Not *result
			*result=_MyTable_GetDefault#name(*obj,#False)
		EndIf
		ProcedureReturn *result
	EndProcedure
EndMacro

Macro _MyTable_StyleMethodsCol(gruppe,name,typ,sub=)
	_AddAutoDeclare(MyTable,.typ _MyTable_Get#gruppe#name(*obj.strMyTableObject,root.b=#True))
	Procedure.typ _MyTable_Get#gruppe#name(*obj.strMyTableObject,root.b=#True)
		Protected result.typ=*obj\gruppe#Style\sub#name
		
		If Not result
			Select *obj\type
				Case My::#MY_TYPE_CELL
					Protected *cell.strMyTableCell=*obj		
					If Not *cell\table\datagrid						
						result=_MyTable_Get#gruppe#name(*cell\col,#False)
					Else
						result=_MyTable_Get#gruppe#name(*cell\table,#False)
					EndIf
				Case My::#MY_TYPE_ROW
					Protected *row.strMyTableRow=*obj					
					result=_MyTable_Get#gruppe#name(*row\table,#False)
				Case My::#MY_TYPE_COL
					Protected *col.strMyTableCol=*obj					
					result=_MyTable_Get#gruppe#name(*col\table,#False)					
				Case My::#MY_TYPE_TABLE,My::#MY_TYPE_GRID,My::#MY_TYPE_TREE
					Protected *table.strMyTableTable=*obj
					If *table\application
						result=_MyTable_Get#gruppe#name(*table\application,#False)
					EndIf
			EndSelect
		EndIf
		If root And Not result
			result=_MyTable_GetDefault#name(*obj,#False)
		EndIf
		ProcedureReturn result
	EndProcedure
EndMacro

Macro _MyTable_StyleBorderMethods(gruppe,name,pos,typ)
	_AddAutoDeclare(MyTable,.typ _MyTable_Get#gruppe#Border#name#pos(*obj.strMyTableObject,root.b=#True))
	Procedure.typ _MyTable_Get#gruppe#Border#name#pos(*obj.strMyTableObject,root.b=#True)
		Protected result.typ=*obj\gruppe#Style\border\border#pos\name
		If Not result
			Select *obj\type
				Case My::#MY_TYPE_CELL
					Protected *cell.strMyTableCell=*obj					
					result= _MyTable_Get#gruppe#Border#name#pos(*cell\table,#False)
				Case My::#MY_TYPE_ROW
					Protected *row.strMyTableRow=*obj					
					result= _MyTable_Get#gruppe#Border#name#pos(*row\table,#False)
				Case My::#MY_TYPE_COL
					Protected *col.strMyTableCol=*obj					
					result= _MyTable_Get#gruppe#Border#name#pos(*col\table,#False)					
				Case My::#MY_TYPE_TABLE,My::#MY_TYPE_GRID,My::#MY_TYPE_TREE
					Protected *table.strMyTableTable=*obj
					If *table\application
						result= _MyTable_Get#gruppe#Border#name#pos(*table\application,#False)
					EndIf
			EndSelect
		EndIf
		
		If root And Not result
			result=_MyTable_Get#gruppe#Border#name#Default(*obj,#False)	
		EndIf
		If root And Not result
			result=_MyTable_GetDefaultBorder#name#pos(*obj,#False)	
		EndIf
		ProcedureReturn result
	EndProcedure
EndMacro


Macro _MyTable_IsTableNoGrid(name)
	_AddAutoDeclare(MyTable,.b _MyTable_Is#name(*this.strMyTableTable))
	Procedure.b _MyTable_Is#name(*this.strMyTableTable)
		ProcedureReturn Bool(Bool(*this\flags & #MYTABLE_TABLE_FLAGS_#name) And Not *this\datagrid)
	EndProcedure	
EndMacro

Macro _MyTable_IsTable(name)
	_AddAutoDeclare(MyTable,.b _MyTable_Is#name(*this.strMyTableTable))
	Procedure.b _MyTable_Is#name(*this.strMyTableTable)
		ProcedureReturn Bool(*this\flags & #MYTABLE_TABLE_FLAGS_#name)
	EndProcedure	
EndMacro

Macro _MyTable_IsTableColNo(name)	
	_AddAutoDeclare(MyTable,.b _MyTable_Is#name(*obj.strMyTableObject))
	Procedure.b _MyTable_Is#name(*obj.strMyTableObject)
		Protected result.b=#False
		Select *obj\type
			Case My::#MY_TYPE_COL
				Protected *col.strMyTableCol=*obj
				result=Bool(*col\flags & #MYTABLE_COL_FLAGS_#name)
				result=Bool(result Or _Mytable_Is#name(*col\table))
				result=Bool(result And Not Bool(*col\flags & #MYTABLE_COL_FLAGS_NO_#name))
			Case My::#MY_TYPE_TABLE,My::#MY_TYPE_TREE,My::#MY_TYPE_GRID
				result=Bool(*obj\flags & #MYTABLE_TABLE_FLAGS_#name)
			Default
				DebuggerError("Unbekannt Typ")
		EndSelect		
		
		ProcedureReturn result
	EndProcedure	
EndMacro

Macro _MyTable_IsTableCellColRowNo(name)	
	_AddAutoDeclare(MyTable,.b _MyTable_Is#name(*obj.strMyTableObject))
	Procedure.b _MyTable_Is#name(*obj.strMyTableObject)
		Protected result.b=#False
		Select *obj\type
			Case My::#MY_TYPE_CELL
				Protected *cell.strMyTableCell=*obj
				result=Bool(*cell\flags & #MYTABLE_CELL_FLAGS_#name)
				result=Bool(result Or _Mytable_Is#name(*cell\table))
				result=Bool(result Or _Mytable_Is#name(*cell\col))
				result=Bool(result And Not Bool(*cell\flags & #MYTABLE_CELL_FLAGS_NO_#name))
			Case My::#MY_TYPE_COL
				Protected *col.strMyTableCol=*obj
				result=Bool(*col\flags & #MYTABLE_COL_FLAGS_#name)
				result=Bool(result Or _Mytable_Is#name(*col\table))
				result=Bool(result And Not Bool(*col\flags & #MYTABLE_COL_FLAGS_NO_#name))
			Case My::#MY_TYPE_ROW
				Protected *row.strMyTableRow=*obj
				result=Bool(*row\flags & #MYTABLE_ROW_FLAGS_#name)
				result=Bool(result Or _Mytable_Is#name(*row\table))
				result=Bool(result And Not Bool(*row\flags & #MYTABLE_ROW_FLAGS_NO_#name))
			Case My::#MY_TYPE_TABLE,My::#MY_TYPE_TREE,My::#MY_TYPE_GRID
				result=Bool(*obj\flags & #MYTABLE_TABLE_FLAGS_#name)
			Default
				DebuggerError("Unbekannt Typ")
		EndSelect		
		
		ProcedureReturn result
	EndProcedure	
EndMacro

Macro _MyTable_IsTableRow(name)	
	_AddAutoDeclare(MyTable,.b _MyTable_Is#name(*obj.strMyTableObject))
	Procedure.b _MyTable_Is#name(*obj.strMyTableObject)
		Protected result.b=#False
		Select *obj\type
			Case My::#MY_TYPE_ROW
				Protected *row.strMyTableRow=*obj
				result=Bool(*row\flags & #MYTABLE_ROW_FLAGS_#name)
				result=Bool(result Or _Mytable_Is#name(*row\table))
			Case My::#MY_TYPE_TABLE,My::#MY_TYPE_TREE,My::#MY_TYPE_GRID
				result=Bool(*obj\flags & #MYTABLE_TABLE_FLAGS_#name)
			Default
				DebuggerError("Unbekannt Typ")
		EndSelect		
		
		ProcedureReturn result
	EndProcedure	
EndMacro

Macro _MyTable_IsTableRowColNo(name)	
	_AddAutoDeclare(MyTable,.b _MyTable_Is#name(*obj.strMyTableObject))
	Procedure.b _MyTable_Is#name(*obj.strMyTableObject)
		Protected result.b=#False
		Select *obj\type
			Case My::#MY_TYPE_ROW
				Protected *row.strMyTableRow=*obj
				result=Bool(*row\flags & #MYTABLE_ROW_FLAGS_#name)
				result=Bool(result Or _Mytable_Is#name(*row\table))
				result=Bool(result And Not Bool(*row\flags & #MYTABLE_ROW_FLAGS_NO_#name))
			Case My::#MY_TYPE_COL
				Protected *col.strMyTableCol=*obj
				result=Bool(*col\flags & #MYTABLE_COL_FLAGS_#name)
				result=Bool(result Or _Mytable_Is#name(*col\table))
				result=Bool(result And Not Bool(*col\flags & #MYTABLE_COL_FLAGS_NO_#name))
			Case My::#MY_TYPE_TABLE,My::#MY_TYPE_TREE,My::#MY_TYPE_GRID
				result=Bool(*obj\flags & #MYTABLE_TABLE_FLAGS_#name)
			Default
				DebuggerError("Unbekannt Typ")
		EndSelect		
		
		ProcedureReturn result
	EndProcedure	
EndMacro

Macro _MyTable_IsTableAllNo(name)	
	_AddAutoDeclare(MyTable,.b _MyTable_Is#name(*obj.strMyTableObject))
	Procedure.b _MyTable_Is#name(*obj.strMyTableObject)
		Protected result.b=#False
		Select *obj\type
			Case My::#MY_TYPE_CELL
				Protected *cell.strMyTableCell=*obj
				result=Bool(*cell\flags & #MYTABLE_CELL_FLAGS_#name)
				result=Bool(result Or _Mytable_Is#name(*cell\table))
				result=Bool(result Or _Mytable_Is#name(*cell\row))
				result=Bool(result Or _Mytable_Is#name(*cell\col))
				result=Bool(result And Not Bool(*cell\flags & #MYTABLE_CELL_FLAGS_NO_#name))
			Case My::#MY_TYPE_ROW
				Protected *row.strMyTableRow=*obj
				result=Bool(*row\flags & #MYTABLE_ROW_FLAGS_#name)
				result=Bool(result Or _Mytable_Is#name(*row\table))
				result=Bool(result And Not Bool(*row\flags & #MYTABLE_ROW_FLAGS_NO_#name))
			Case My::#MY_TYPE_COL
				Protected *col.strMyTableCol=*obj
				result=Bool(*col\flags & #MYTABLE_COL_FLAGS_#name)
				result=Bool(result Or _Mytable_Is#name(*col\table))
				result=Bool(result And Not Bool(*col\flags & #MYTABLE_COL_FLAGS_NO_#name))
			Case My::#MY_TYPE_TABLE,My::#MY_TYPE_TREE,My::#MY_TYPE_GRID
				result=Bool(*obj\flags & #MYTABLE_TABLE_FLAGS_#name)
			Default
				DebuggerError("Unbekannt Typ")
		EndSelect		
		
		ProcedureReturn result
	EndProcedure	
EndMacro

Macro _MyTable_IsTableAll(name)	
	_AddAutoDeclare(MyTable,.b _MyTable_Is#name(*obj.strMyTableObject))
	Procedure.b _MyTable_Is#name(*obj.strMyTableObject)
		Protected result.b=#False
		Select *obj\type
			Case My::#MY_TYPE_CELL
				Protected *cell.strMyTableCell=*obj
				result=Bool(*cell\flags & #MYTABLE_CELL_FLAGS_#name)
				result=Bool(result Or _Mytable_Is#name(*cell\table))
				result=Bool(result Or _Mytable_Is#name(*cell\row))
				result=Bool(result Or _Mytable_Is#name(*cell\col))
			Case My::#MY_TYPE_ROW
				Protected *row.strMyTableRow=*obj
				result=Bool(*row\flags & #MYTABLE_ROW_FLAGS_#name)
				result=Bool(result Or _Mytable_Is#name(*row\table))
			Case My::#MY_TYPE_COL
				Protected *col.strMyTableCol=*obj
				result=Bool(*col\flags & #MYTABLE_COL_FLAGS_#name)
				result=Bool(result Or _Mytable_Is#name(*col\table))
			Case My::#MY_TYPE_TABLE,My::#MY_TYPE_TREE,My::#MY_TYPE_GRID
				result=Bool(*obj\flags & #MYTABLE_TABLE_FLAGS_#name)
			Default
				DebuggerError("Unbekannt Typ")
		EndSelect		
		
		ProcedureReturn result
	EndProcedure	
EndMacro

Macro _MyTable_IsTableNo(name)
	_AddAutoDeclare(MyTable,.b _MyTable_Is#name(*this.strMyTableTable))
	Procedure.b _MyTable_Is#name(*this.strMyTableTable)
		ProcedureReturn Bool(Not Bool(*this\flags & #MYTABLE_TABLE_FLAGS_NO_#name))
	EndProcedure	
EndMacro


Macro _MyTable_StylesBordersMethods(gruppe,name,typ)
_MyTable_StyleBorderMethods(gruppe,name,Default,i)
	_MyTable_StyleBorderMethods(gruppe,name,Top,i)
	_MyTable_StyleBorderMethods(gruppe,name,Bottom,i)
	_MyTable_StyleBorderMethods(gruppe,name,Left,i)
	_MyTable_StyleBorderMethods(gruppe,name,Right,i)
EndMacro

Macro _MyTable_StylesMethods(gruppe)
	_MyTable_StyleMethodsRow(gruppe,BackColor,q)
	_MyTable_StyleMethodsRow(gruppe,FrontColor,q)
	_MyTable_StyleMethodsRow(gruppe,ForeColor,q)
	_MyTable_StyleMethodsRowPointer(gruppe,Font,MyFont::MyFont)
	_MyTable_StyleMethodsRow(gruppe,Border,i,border\)
	_MyTable_StyleMethodsCol(gruppe,HAlign,i)
	_MyTable_StyleMethodsRow(gruppe,VAlign,i)
	_MyTable_StylesBordersMethods(gruppe,Color,q)
	_MyTable_StylesBordersMethods(gruppe,Width,i)
EndMacro

Macro _MyTable_Style_GetterSetter(name,typ,sub=)
	_AddAutoDeclare(MyTable,_MyTable_Style_Set#name(*this.strMyTableStyleObject,value.typ))
	Procedure _MyTable_Style_Set#name(*this.strMyTableStyleObject,value.typ)
		Protected *cell.strMyTableCell=0
		Protected idx=0
		If *this
			Select *this\obj\type
				Case My::#MY_TYPE_COL
					Protected *col.strMyTableCol=*this\obj
					*this\style\sub#name=value
					If *col\table\datagrid
						ForEach *col\table\rows()
							*cell=_MyTableGetOrAddCell(*col\table\rows(),*col\listindex,#True)
							*cell\defaultStyle\sub#name=value
						Next
					EndIf					
				Case My::#MY_TYPE_ROW
					Protected *row.strMyTableRow=*this\obj					
					
					For idx=1 To ListSize(*row\table\cols())
						*cell=_MyTableGetOrAddCell(*row,idx-1,#True)
						*cell\defaultStyle\sub#name=value
					Next
					
					*this\style\sub#name=value
				Default
					*this\style\sub#name=value
			EndSelect
			_MyTable_Style_Redraw(*this)
		EndIf
	EndProcedure
	
	_AddAutoDeclare(MyTable,.typ _MyTable_Style_Get#name(*this.strMyTableStyleObject))
	Procedure.typ _MyTable_Style_Get#name(*this.strMyTableStyleObject)
		If *this
			Protected result.typ=*this\style\sub#name
			If Not result
				result=_mytable_getDefault#name(*this\obj)
			EndIf
			ProcedureReturn result
		EndIf
	EndProcedure
EndMacro

Macro _MyTable_Style_GetterSetterPointer(name,typ,sub=)
	_AddAutoDeclare(MyTable,_MyTable_Style_Set#name(*this.strMyTableStyleObject,*value.typ))
	Procedure _MyTable_Style_Set#name(*this.strMyTableStyleObject,*value.typ)
		Protected *cell.strMyTableCell=0
		Protected idx=0
		If *this
			Select *this\obj\type
				Case My::#MY_TYPE_COL
					Protected *col.strMyTableCol=*this\obj
					*this\style\sub#name=*value
					If *col\table\datagrid
						ForEach *col\table\rows()							
							*cell=_MyTableGetOrAddCell(*col\table\rows(),*col\listindex,#True)
							*cell\defaultStyle\sub#name=*value							
						Next
					EndIf					
				Case My::#MY_TYPE_ROW
					Protected *row.strMyTableRow=*this\obj					
					
					For idx=1 To ListSize(*row\table\cols())
						*cell=_MyTableGetOrAddCell(*row,idx-1,#True)
						*cell\defaultStyle\sub#name=*value
					Next
					
					*this\style\sub#name=*value
				Default
					*this\style\sub#name=*value
			EndSelect
			_MyTable_Style_Redraw(*this)
		EndIf
	EndProcedure
	
	_AddAutoDeclare(MyTable,_MyTable_Style_Get#name(*this.strMyTableStyleObject))
	Procedure _MyTable_Style_Get#name(*this.strMyTableStyleObject)
		If *this
			Protected *result.typ=*this\style\sub#name
			If Not *result
				*result=_mytable_getDefault#name(*this\obj)
			EndIf
			ProcedureReturn *result
		EndIf
	EndProcedure
EndMacro

Macro _MyTable_Style_GetterSetterBorder(name,typ,pos)
	_AddAutoDeclare(MyTable,_MyTable_Style_SetBorder#name#pos(*this.strMyTableStyleObject,value.typ))
	Procedure _MyTable_Style_SetBorder#name#pos(*this.strMyTableStyleObject,value.typ)
		Protected *cell.strMyTableCell=0
		Protected idx=0
		If *this
			Select *this\obj\type
				Case My::#MY_TYPE_COL
					Protected *col.strMyTableCol=*this\obj
					If *col\table\datagrid
						ForEach *col\table\rows()
							*cell=_MyTableGetOrAddCell(*col\table\rows(),*col\listindex,#True)
							*cell\defaultStyle\border\border#pos\name=value
						Next
					EndIf					
					*this\style\border\border#pos\name=value
				Case My::#MY_TYPE_ROW
					Protected *row.strMyTableRow=*this\obj					
					
					For idx=1 To ListSize(*row\table\cols())
						*cell=_MyTableGetOrAddCell(*row,idx-1,#True)
						*cell\defaultStyle\border\border#pos\name=value
					Next
					
					*this\style\border\border#pos\name=value
				Default
					*this\style\border\border#pos\name=value
			EndSelect
			
			_MyTable_Style_Redraw(*this)
		EndIf
	EndProcedure
	
	_AddAutoDeclare(MyTable,.typ _MyTable_Style_GetBorder#name#pos(*this.strMyTableStyleObject))
	Procedure.typ _MyTable_Style_GetBorder#name#pos(*this.strMyTableStyleObject)
		If *this
			Protected result.typ=*this\style\border\border#pos\name
			If Not result
				result=_mytable_getDefaultBorder#name#pos(*this\obj)
			EndIf
			ProcedureReturn result
		EndIf
	EndProcedure
EndMacro

Macro _MyTable_Style_GetterSetterBorders(name,typ)
_MyTable_Style_GetterSetterBorder(name,typ,Default)
	_MyTable_Style_GetterSetterBorder(name,typ,Top)
	_MyTable_Style_GetterSetterBorder(name,typ,Bottom)
	_MyTable_Style_GetterSetterBorder(name,typ,Left)
	_MyTable_Style_GetterSetterBorder(name,typ,Right)
EndMacro

Macro _MyTableStyleBorder(name)
	_AddAutoDeclare(MyTable,_MyTable_Style_GetBorder#name(*this.strMyTableStyleObject))
	Procedure _MyTable_Style_GetBorder#name(*this.strMyTableStyleObject)
		If *this
			Protected *border.strMyTableBorderObject=AllocateStructure(strMyTableBorderObject)
			_MyTableInitBorderObject(*border,*this,*this\style\border\border#name)
			*border\border#name=*this\style\border\border#name
			ProcedureReturn *border
		EndIf
	EndProcedure
	
EndMacro
