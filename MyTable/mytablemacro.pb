
Macro MM
	"
EndMacro

CompilerIf #PB_Compiler_Debugger And Defined(MYTABLE_AUTODECLARE,#PB_Module)
	Macro _MyTableAddAutoDeclare(name)
		AddElement(MYTABLE_AUTODECLARE::autodeclare())		
		MYTABLE_AUTODECLARE::autodeclare()=Trim(MM#name#MM)
		If Left(MYTABLE_AUTODECLARE::autodeclare(),1)="."
			MYTABLE_AUTODECLARE::autodeclare()="Declare"+MYTABLE_AUTODECLARE::autodeclare()
		Else
			MYTABLE_AUTODECLARE::autodeclare()="Declare "+MYTABLE_AUTODECLARE::autodeclare()
		EndIf		
	EndMacro	
CompilerElse
	Macro _MyTableAddAutoDeclare(name):EndMacro
CompilerEndIf

CompilerIf #PB_Compiler_Debugger And Defined(MYTABLE_DEBUG,#PB_Module)
	
	Procedure.s _MyTableDebugGetName(*this.strMyTableVTable)
		Select *this\type
			Case #MYTABLE_TYPE_CELL
				Protected *cell.strMyTableCell=*this
				ProcedureReturn *cell\table\name
			Case #MYTABLE_TYPE_ROW
				Protected *row.strMyTableRow=*this
				ProcedureReturn *row\table\name
			Case #MYTABLE_TYPE_COL
				Protected *col.strMyTableCol=*this
				ProcedureReturn *col\table\name
			Case #MYTABLE_TYPE_TABLE,#MYTABLE_TYPE_GRID,#MYTABLE_TYPE_TREE
				Protected *table.strMyTableTable=*this
				ProcedureReturn *table\name
			Case #MYTABLE_TYPE_APPLICATION
				ProcedureReturn ""
			Case #MYTABLE_TYPE_STYLE
				Protected *style.strMyTableStyleObject=*this
				ProcedureReturn _MyTableDebugGetName(*style\obj)
		EndSelect
	EndProcedure
	
	Procedure _MyTableDebugGetCanvas(*this.strMyTableVTable)
		Select *this\type
			Case #MYTABLE_TYPE_CELL
				Protected *cell.strMyTableCell=*this
				ProcedureReturn *cell\table\canvas
			Case #MYTABLE_TYPE_ROW
				Protected *row.strMyTableRow=*this
				ProcedureReturn *row\table\canvas
			Case #MYTABLE_TYPE_COL
				Protected *col.strMyTableCol=*this
				ProcedureReturn *col\table\canvas
			Case #MYTABLE_TYPE_TABLE,#MYTABLE_TYPE_GRID,#MYTABLE_TYPE_TREE
				Protected *table.strMyTableTable=*this
				ProcedureReturn *table\canvas
			Case #MYTABLE_TYPE_APPLICATION
				ProcedureReturn 0
			Case #MYTABLE_TYPE_STYLE
				Protected *style.strMyTableStyleObject=*this
				ProcedureReturn _MyTableDebugGetCanvas(*style\obj)
		EndSelect
	EndProcedure
CompilerEndIf

Macro _MyTable_GetStyleCell(name)
	_MyTableAddAutoDeclare(_MyTable_Cell_Get#name#Style(*this.strMyTableCell))
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
	_MyTableAddAutoDeclare(_MyTable_Col_Get#name#Style(*this.strMyTableCol))
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
	_MyTableAddAutoDeclare(_MyTable_Row_Get#name#Style(*this.strMyTableRow))
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
	_MyTableAddAutoDeclare(_MyTable_Table_Get#name#Style(*this.strMyTableTable))
	Procedure _MyTable_Table_Get#name#Style(*this.strMyTableTable)
		Protected *style.strMyTableStyleObject=AllocateStructure(strMyTableStyleObject)
		
		*style\tableStyle=*this\name#Style		
		*style\applicationStyle=*this\application\name#Style
		
		_MyTableInitStyleObject(*style,*this,*this\name#Style)
		ProcedureReturn *style
	EndProcedure
EndMacro

Macro _MyTable_GetStyleApplication(name)
	_MyTableAddAutoDeclare(_MyTable_Application_Get#name#Style(*this.strMyTableApplication))
	Procedure _MyTable_Application_Get#name#Style(*this.strMyTableApplication)
		Protected *style.strMyTableStyleObject=AllocateStructure(strMyTableStyleObject)
		
		*style\applicationStyle=*this\name#Style
		
		_MyTableInitStyleObject(*style,*this,*this\name#Style)
		ProcedureReturn *style
	EndProcedure
EndMacro

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


Macro _MyTableSimpleGetterPointer(gruppe,name)
	_MyTableAddAutoDeclare(_MyTable_#gruppe#_Get#name(*this.strMyTable#gruppe))
	Procedure _MyTable_#gruppe#_Get#name(*this.strMyTable#gruppe)
		If *this
			ProcedureReturn *this\name
		EndIf
	EndProcedure
EndMacro

Macro _MyTableSimpleGetter(gruppe,name,typ)
	_MyTableAddAutoDeclare(.typ _MyTable_#gruppe#_Get#name(*this.strMyTable#gruppe))
	Procedure.typ _MyTable_#gruppe#_Get#name(*this.strMyTable#gruppe)
		If *this
			ProcedureReturn *this\name
		EndIf
	EndProcedure
EndMacro

Macro _MyTableSimpleSetter(gruppe,name,typ)
	_MyTableAddAutoDeclare(_MyTable_#gruppe#_Set#name(*this.strMyTable#gruppe,value.typ))
	Procedure _MyTable_#gruppe#_Set#name(*this.strMyTable#gruppe,value.typ)
		If *this
			*this\name=value
			*this\dirty=#True
		EndIf
	EndProcedure
EndMacro

Macro _MyTableSimpleSetterPointer(gruppe,name)
	_MyTableAddAutoDeclare(_MyTable_#gruppe#_Set#name(*this.strMyTable#gruppe,*value))
	Procedure _MyTable_#gruppe#_Set#name(*this.strMyTable#gruppe,*value)
		If *this
			*this\name=*value
			*this\dirty=#True
		EndIf
	EndProcedure
EndMacro

Macro _MyTableSimpleSetterPointerStructure(gruppe,name,typ)
	_MyTableAddAutoDeclare(_MyTable_#gruppe#_Set#name(*this.strMyTable#gruppe,*value.typ))
	Procedure _MyTable_#gruppe#_Set#name(*this.strMyTable#gruppe,*value.typ)
		If *this
			*this\name=*value
			*this\dirty=#True
		EndIf
	EndProcedure
EndMacro

Macro _MyTableSimpleSetterRedraw(gruppe,name,typ)
	_MyTableAddAutoDeclare(_MyTable_#gruppe#_Set#name(*this.strMyTable#gruppe,value.typ))
	Procedure _MyTable_#gruppe#_Set#name(*this.strMyTable#gruppe,value.typ)
		If *this
			*this\name=value
			*this\dirty=#True			
			_MyTable_Table_Redraw(*this)						
		EndIf
	EndProcedure
EndMacro

Macro _MyTableSimpleSetterSubRedraw(gruppe,name,typ)
	_MyTableAddAutoDeclare(_MyTable_#gruppe#_Set#name(*this.strMyTable#gruppe,value.typ))
	Procedure _MyTable_#gruppe#_Set#name(*this.strMyTable#gruppe,value.typ)
		If *this
			*this\name=value
			*this\dirty=#True			
			*this\table\dirty=#True
			_MyTable_Table_Redraw(*this\table)						
		EndIf
	EndProcedure
EndMacro

Macro _MyTableSimpleSetterSubPredraw(gruppe,name,typ)
	_MyTableAddAutoDeclare(_MyTable_#gruppe#_Set#name(*this.strMyTable#gruppe,value.typ))
	Procedure _MyTable_#gruppe#_Set#name(*this.strMyTable#gruppe,value.typ)
		If *this
			*this\name=value
			*this\dirty=#True			
			*this\table\dirty=#True
			_MyTable_Table_Predraw(*this\table)						
			_MyTable_Table_Redraw(*this\table)						
		EndIf
	EndProcedure
EndMacro

Macro _MyTableSimpleSetterPredraw(gruppe,name,typ)
	_MyTableAddAutoDeclare(_MyTable_#gruppe#_Set#name(*this.strMyTable#gruppe,value.typ))
	Procedure _MyTable_#gruppe#_Set#name(*this.strMyTable#gruppe,value.typ)
		If *this
			*this\name=value
			*this\dirty=#True			
			*this\dirty=#True
			_MyTable_Table_Predraw(*this)						
			_MyTable_Table_Redraw(*this)						
		EndIf
	EndProcedure
EndMacro

Macro _MyTableSimpleSetterGetter(gruppe,name,typ)
	_MyTableSimpleGetter(gruppe,name,typ)
	_MyTableSimpleSetter(gruppe,name,typ)
EndMacro

Macro _MyTableSimpleSetterGetterRedraw(gruppe,name,typ)
	_MyTableSimpleGetter(gruppe,name,typ)
	_MyTableSimpleSetterRedraw(gruppe,name,typ)
EndMacro

Macro _MyTableSimpleSetterGetterPointer(gruppe,name)
	_MyTableSimpleGetterPointer(gruppe,name)
	_MyTableSimpleSetterPointer(gruppe,name)
EndMacro

Macro _MyTableSimpleSetterGetterPointerStructure(gruppe,name,typ)
	_MyTableSimpleGetterPointer(gruppe,name)
	_MyTableSimpleSetterPointerStructure(gruppe,name,typ)
EndMacro

Macro _MyTableSimpleSetterGetterSubRedraw(gruppe,name,typ)
	_MyTableSimpleGetter(gruppe,name,typ)
	_MyTableSimpleSetterSubRedraw(gruppe,name,typ)
EndMacro

Macro _MyTableSimpleSetterGetterSubPredraw(gruppe,name,typ)
	_MyTableSimpleGetter(gruppe,name,typ)
	_MyTableSimpleSetterSubPredraw(gruppe,name,typ)
EndMacro

Macro _MyTableSimpleSetterGetterPredraw(gruppe,name,typ)
	_MyTableSimpleGetter(gruppe,name,typ)
	_MyTableSimpleSetterPredraw(gruppe,name,typ)
EndMacro

;{
;- workaround for MacOS. thx to mestnyi (https://www.purebasic.fr/english/viewtopic.php?p=571500#p571500)
	Macro PB( _pb_function_name_ ) 
		_pb_function_name_
	EndMacro
	Macro ClipOutput(_x_,_y_,_width_,_height_)
		CompilerIf #PB_Compiler_OS <> #PB_OS_MacOS
			PB(ClipOutput)(_x_,_y_,_width_,_height_)
		CompilerEndIf
	EndMacro
	Macro UnclipOutput()
		CompilerIf #PB_Compiler_OS <> #PB_OS_MacOS
			PB(UnclipOutput)()
		CompilerEndIf
	EndMacro
	Macro DrawingFont(_font_id_)
		CompilerIf #PB_Compiler_OS = #PB_OS_MacOS
			If _font_id_
				PB(DrawingFont)(_font_id_)
			EndIf
		CompilerElse
			PB(DrawingFont)(_font_id_)
		CompilerEndIf
	EndMacro
;}



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
	
	_MyTableDataSectionGetter(gruppe,Canvas)
	_MyTableDataSectionGetter(gruppe,HScroll)
	_MyTableDataSectionGetter(gruppe,VScroll)
	_MyTableDataSectionGetter(gruppe,Window)
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

Macro _MyTableBindEvent(name)
	_MyTableAddAutoDeclare(_MyTable_Table_BindEvent#name(*this.strMyTableTable,event.MyTableProtoEvent#name))
	Procedure _MyTable_Table_BindEvent#name(*this.strMyTableTable,event.MyTableProtoEvent#name)
		If *this
			*this\Event#name=event
		EndIf
	EndProcedure
EndMacro

Macro _MyTableBorderSetterGetter(name,typ)
	_MyTableAddAutoDeclare(.typ _MyTable_Border_Get#name(*this.strMyTableBorderObject))
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
	
	Procedure _MyTable_Border_Set#name(*this.strMyTableBorderObject,value.typ)
		If *this
			*this\border\name=value
			_MyTable_Style_Redraw(*this\style)
		EndIf
	EndProcedure
EndMacro


Macro _MyTable_StyleMethods(gruppe,name,typ,sub=)
	_MyTableAddAutoDeclare(.typ _MyTable_Get#gruppe#name(*obj.strMyTableObject,root.b=#True))
	Procedure.typ _MyTable_Get#gruppe#name(*obj.strMyTableObject,root.b=#True)
		Protected result.typ=*obj\gruppe#Style\sub#name
		
		If Not result
			Select *obj\type
				Case #MYTABLE_TYPE_CELL
					Protected *cell.strMyTableCell=*obj					
					result=_MyTable_Get#gruppe#name(*cell\table,#False)
				Case #MYTABLE_TYPE_ROW
					Protected *row.strMyTableRow=*obj					
					result=_MyTable_Get#gruppe#name(*row\table,#False)
				Case #MYTABLE_TYPE_COL
					Protected *col.strMyTableCol=*obj					
					result=_MyTable_Get#gruppe#name(*col\table,#False)					
				Case #MYTABLE_TYPE_TABLE,#MYTABLE_TYPE_GRID,#MYTABLE_TYPE_TREE
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
	_MyTableAddAutoDeclare(.typ _MyTable_Get#gruppe#name(*obj.strMyTableObject,root.b=#True))
	Procedure.typ _MyTable_Get#gruppe#name(*obj.strMyTableObject,root.b=#True)
		Protected result.typ=*obj\gruppe#Style\sub#name
		
		If Not result
			Select *obj\type
				Case #MYTABLE_TYPE_CELL
					Protected *cell.strMyTableCell=*obj			
					If Not *cell\table\datagrid						
						result=_MyTable_Get#gruppe#name(*cell\row,#False)
					Else
						result=_MyTable_Get#gruppe#name(*cell\table,#False)
					EndIf
				Case #MYTABLE_TYPE_ROW
					Protected *row.strMyTableRow=*obj					
					result=_MyTable_Get#gruppe#name(*row\table,#False)
				Case #MYTABLE_TYPE_COL
					Protected *col.strMyTableCol=*obj					
					result=_MyTable_Get#gruppe#name(*col\table,#False)					
				Case #MYTABLE_TYPE_TABLE,#MYTABLE_TYPE_GRID,#MYTABLE_TYPE_TREE
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
	_MyTableAddAutoDeclare(_MyTable_Get#gruppe#name(*obj.strMyTableObject,root.b=#True))
	Procedure _MyTable_Get#gruppe#name(*obj.strMyTableObject,root.b=#True)
		Protected *result.typ=*obj\gruppe#Style\sub#name
		
		If Not *result
			Select *obj\type
				Case #MYTABLE_TYPE_CELL
					Protected *cell.strMyTableCell=*obj			
					If Not *cell\table\datagrid
						*result=_MyTable_Get#gruppe#name(*cell\row,#False)
					Else
						*result=_MyTable_Get#gruppe#name(*cell\table,#False)
					EndIf
				Case #MYTABLE_TYPE_ROW
					Protected *row.strMyTableRow=*obj					
					*result=_MyTable_Get#gruppe#name(*row\table,#False)
				Case #MYTABLE_TYPE_COL
					Protected *col.strMyTableCol=*obj					
					*result=_MyTable_Get#gruppe#name(*col\table,#False)					
				Case #MYTABLE_TYPE_TABLE,#MYTABLE_TYPE_GRID,#MYTABLE_TYPE_TREE
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
	_MyTableAddAutoDeclare(.typ _MyTable_Get#gruppe#name(*obj.strMyTableObject,root.b=#True))
	Procedure.typ _MyTable_Get#gruppe#name(*obj.strMyTableObject,root.b=#True)
		Protected result.typ=*obj\gruppe#Style\sub#name
		
		If Not result
			Select *obj\type
				Case #MYTABLE_TYPE_CELL
					Protected *cell.strMyTableCell=*obj		
					If Not *cell\table\datagrid						
						result=_MyTable_Get#gruppe#name(*cell\col,#False)
					Else
						result=_MyTable_Get#gruppe#name(*cell\table,#False)
					EndIf
				Case #MYTABLE_TYPE_ROW
					Protected *row.strMyTableRow=*obj					
					result=_MyTable_Get#gruppe#name(*row\table,#False)
				Case #MYTABLE_TYPE_COL
					Protected *col.strMyTableCol=*obj					
					result=_MyTable_Get#gruppe#name(*col\table,#False)					
				Case #MYTABLE_TYPE_TABLE,#MYTABLE_TYPE_GRID,#MYTABLE_TYPE_TREE
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
	_MyTableAddAutoDeclare(.typ _MyTable_Get#gruppe#Border#name#pos(*obj.strMyTableObject,root.b=#True))
	Procedure.typ _MyTable_Get#gruppe#Border#name#pos(*obj.strMyTableObject,root.b=#True)
		Protected result.typ=*obj\gruppe#Style\border\border#pos\name
		If Not result
			Select *obj\type
				Case #MYTABLE_TYPE_CELL
					Protected *cell.strMyTableCell=*obj					
					result= _MyTable_Get#gruppe#Border#name#pos(*cell\table,#False)
				Case #MYTABLE_TYPE_ROW
					Protected *row.strMyTableRow=*obj					
					result= _MyTable_Get#gruppe#Border#name#pos(*row\table,#False)
				Case #MYTABLE_TYPE_COL
					Protected *col.strMyTableCol=*obj					
					result= _MyTable_Get#gruppe#Border#name#pos(*col\table,#False)					
				Case #MYTABLE_TYPE_TABLE,#MYTABLE_TYPE_GRID,#MYTABLE_TYPE_TREE
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
	_MyTableAddAutoDeclare(.b _MyTable_Is#name(*this.strMyTableTable))
	Procedure.b _MyTable_Is#name(*this.strMyTableTable)
		ProcedureReturn Bool(Bool(*this\flags & #MYTABLE_TABLE_FLAGS_#name) And Not *this\datagrid)
	EndProcedure	
EndMacro

Macro _MyTable_IsTable(name)
	_MyTableAddAutoDeclare(.b _MyTable_Is#name(*this.strMyTableTable))
	Procedure.b _MyTable_Is#name(*this.strMyTableTable)
		ProcedureReturn Bool(*this\flags & #MYTABLE_TABLE_FLAGS_#name)
	EndProcedure	
EndMacro

Macro _MyTable_IsTableColNo(name)	
	_MyTableAddAutoDeclare(.b _MyTable_Is#name(*obj.strMyTableObject))
	Procedure.b _MyTable_Is#name(*obj.strMyTableObject)
		Protected result.b=#False
		Select *obj\type
			Case #MYTABLE_TYPE_COL
				Protected *col.strMyTableCol=*obj
				result=Bool(*col\flags & #MYTABLE_COL_FLAGS_#name)
				result=Bool(result Or _Mytable_Is#name(*col\table))
				result=Bool(result And Not Bool(*col\flags & #MYTABLE_COL_FLAGS_NO_#name))
			Case #MYTABLE_TYPE_TABLE,#MYTABLE_TYPE_TREE,#MYTABLE_TYPE_GRID
				result=Bool(*obj\flags & #MYTABLE_TABLE_FLAGS_#name)
			Default
				DebuggerError("Unbekannt Typ")
		EndSelect		
		
		ProcedureReturn result
	EndProcedure	
EndMacro

Macro _MyTable_IsTableCellColRowNo(name)	
	_MyTableAddAutoDeclare(.b _MyTable_Is#name(*obj.strMyTableObject))
	Procedure.b _MyTable_Is#name(*obj.strMyTableObject)
		Protected result.b=#False
		Select *obj\type
			Case #MYTABLE_TYPE_CELL
				Protected *cell.strMyTableCell=*obj
				result=Bool(*cell\flags & #MYTABLE_CELL_FLAGS_#name)
				result=Bool(result Or _Mytable_Is#name(*cell\table))
				result=Bool(result Or _Mytable_Is#name(*cell\col))
				result=Bool(result And Not Bool(*cell\flags & #MYTABLE_CELL_FLAGS_NO_#name))
			Case #MYTABLE_TYPE_COL
				Protected *col.strMyTableCol=*obj
				result=Bool(*col\flags & #MYTABLE_COL_FLAGS_#name)
				result=Bool(result Or _Mytable_Is#name(*col\table))
				result=Bool(result And Not Bool(*col\flags & #MYTABLE_COL_FLAGS_NO_#name))
			Case #MYTABLE_TYPE_ROW
				Protected *row.strMyTableRow=*obj
				result=Bool(*row\flags & #MYTABLE_ROW_FLAGS_#name)
				result=Bool(result Or _Mytable_Is#name(*row\table))
				result=Bool(result And Not Bool(*row\flags & #MYTABLE_ROW_FLAGS_NO_#name))
			Case #MYTABLE_TYPE_TABLE,#MYTABLE_TYPE_TREE,#MYTABLE_TYPE_GRID
				result=Bool(*obj\flags & #MYTABLE_TABLE_FLAGS_#name)
			Default
				DebuggerError("Unbekannt Typ")
		EndSelect		
		
		ProcedureReturn result
	EndProcedure	
EndMacro

Macro _MyTable_IsTableRow(name)	
	_MyTableAddAutoDeclare(.b _MyTable_Is#name(*obj.strMyTableObject))
	Procedure.b _MyTable_Is#name(*obj.strMyTableObject)
		Protected result.b=#False
		Select *obj\type
			Case #MYTABLE_TYPE_ROW
				Protected *row.strMyTableRow=*obj
				result=Bool(*row\flags & #MYTABLE_ROW_FLAGS_#name)
				result=Bool(result Or _Mytable_Is#name(*row\table))
			Case #MYTABLE_TYPE_TABLE,#MYTABLE_TYPE_TREE,#MYTABLE_TYPE_GRID
				result=Bool(*obj\flags & #MYTABLE_TABLE_FLAGS_#name)
			Default
				DebuggerError("Unbekannt Typ")
		EndSelect		
		
		ProcedureReturn result
	EndProcedure	
EndMacro

Macro _MyTable_IsTableRowColNo(name)	
	_MyTableAddAutoDeclare(.b _MyTable_Is#name(*obj.strMyTableObject))
	Procedure.b _MyTable_Is#name(*obj.strMyTableObject)
		Protected result.b=#False
		Select *obj\type
			Case #MYTABLE_TYPE_ROW
				Protected *row.strMyTableRow=*obj
				result=Bool(*row\flags & #MYTABLE_ROW_FLAGS_#name)
				result=Bool(result Or _Mytable_Is#name(*row\table))
				result=Bool(result And Not Bool(*row\flags & #MYTABLE_ROW_FLAGS_NO_#name))
			Case #MYTABLE_TYPE_COL
				Protected *col.strMyTableCol=*obj
				result=Bool(*col\flags & #MYTABLE_COL_FLAGS_#name)
				result=Bool(result Or _Mytable_Is#name(*col\table))
				result=Bool(result And Not Bool(*col\flags & #MYTABLE_COL_FLAGS_NO_#name))
			Case #MYTABLE_TYPE_TABLE,#MYTABLE_TYPE_TREE,#MYTABLE_TYPE_GRID
				result=Bool(*obj\flags & #MYTABLE_TABLE_FLAGS_#name)
			Default
				DebuggerError("Unbekannt Typ")
		EndSelect		
		
		ProcedureReturn result
	EndProcedure	
EndMacro

Macro _MyTable_IsTableAllNo(name)	
	_MyTableAddAutoDeclare(.b _MyTable_Is#name(*obj.strMyTableObject))
	Procedure.b _MyTable_Is#name(*obj.strMyTableObject)
		Protected result.b=#False
		Select *obj\type
			Case #MYTABLE_TYPE_CELL
				Protected *cell.strMyTableCell=*obj
				result=Bool(*cell\flags & #MYTABLE_CELL_FLAGS_#name)
				result=Bool(result Or _Mytable_Is#name(*cell\table))
				result=Bool(result Or _Mytable_Is#name(*cell\row))
				result=Bool(result Or _Mytable_Is#name(*cell\col))
				result=Bool(result And Not Bool(*cell\flags & #MYTABLE_CELL_FLAGS_NO_#name))
			Case #MYTABLE_TYPE_ROW
				Protected *row.strMyTableRow=*obj
				result=Bool(*row\flags & #MYTABLE_ROW_FLAGS_#name)
				result=Bool(result Or _Mytable_Is#name(*row\table))
				result=Bool(result And Not Bool(*row\flags & #MYTABLE_ROW_FLAGS_NO_#name))
			Case #MYTABLE_TYPE_COL
				Protected *col.strMyTableCol=*obj
				result=Bool(*col\flags & #MYTABLE_COL_FLAGS_#name)
				result=Bool(result Or _Mytable_Is#name(*col\table))
				result=Bool(result And Not Bool(*col\flags & #MYTABLE_COL_FLAGS_NO_#name))
			Case #MYTABLE_TYPE_TABLE,#MYTABLE_TYPE_TREE,#MYTABLE_TYPE_GRID
				result=Bool(*obj\flags & #MYTABLE_TABLE_FLAGS_#name)
			Default
				DebuggerError("Unbekannt Typ")
		EndSelect		
		
		ProcedureReturn result
	EndProcedure	
EndMacro

Macro _MyTable_IsTableAll(name)	
	_MyTableAddAutoDeclare(.b _MyTable_Is#name(*obj.strMyTableObject))
	Procedure.b _MyTable_Is#name(*obj.strMyTableObject)
		Protected result.b=#False
		Select *obj\type
			Case #MYTABLE_TYPE_CELL
				Protected *cell.strMyTableCell=*obj
				result=Bool(*cell\flags & #MYTABLE_CELL_FLAGS_#name)
				result=Bool(result Or _Mytable_Is#name(*cell\table))
				result=Bool(result Or _Mytable_Is#name(*cell\row))
				result=Bool(result Or _Mytable_Is#name(*cell\col))
			Case #MYTABLE_TYPE_ROW
				Protected *row.strMyTableRow=*obj
				result=Bool(*row\flags & #MYTABLE_ROW_FLAGS_#name)
				result=Bool(result Or _Mytable_Is#name(*row\table))
			Case #MYTABLE_TYPE_COL
				Protected *col.strMyTableCol=*obj
				result=Bool(*col\flags & #MYTABLE_COL_FLAGS_#name)
				result=Bool(result Or _Mytable_Is#name(*col\table))
			Case #MYTABLE_TYPE_TABLE,#MYTABLE_TYPE_TREE,#MYTABLE_TYPE_GRID
				result=Bool(*obj\flags & #MYTABLE_TABLE_FLAGS_#name)
			Default
				DebuggerError("Unbekannt Typ")
		EndSelect		
		
		ProcedureReturn result
	EndProcedure	
EndMacro

Macro _MyTable_IsTableNo(name)
	_MyTableAddAutoDeclare(.b _MyTable_Is#name(*this.strMyTableTable))
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
	_MyTable_StyleMethodsRowPointer(gruppe,Font,strMyTableFont)
	_MyTable_StyleMethodsRow(gruppe,Border,i,border\)
	_MyTable_StyleMethodsCol(gruppe,HAlign,i)
	_MyTable_StyleMethodsRow(gruppe,VAlign,i)
	_MyTable_StylesBordersMethods(gruppe,Color,q)
	_MyTable_StylesBordersMethods(gruppe,Width,i)
EndMacro

Macro _MyTable_Style_GetterSetter(name,typ,sub=)
	_MyTableAddAutoDeclare(_MyTable_Style_Set#name(*this.strMyTableStyleObject,value.typ))
	Procedure _MyTable_Style_Set#name(*this.strMyTableStyleObject,value.typ)
		Protected *cell.strMyTableCell=0
		Protected idx=0
		If *this
			Select *this\obj\type
				Case #MYTABLE_TYPE_COL
					Protected *col.strMyTableCol=*this\obj
					*this\style\sub#name=value
					If *col\table\datagrid
						ForEach *col\table\rows()
							*cell=_MyTableGetOrAddCell(*col\table\rows(),*col\listindex,#True)
							*cell\defaultStyle\sub#name=value
						Next
					EndIf					
				Case #MYTABLE_TYPE_ROW
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
	
	_MyTableAddAutoDeclare(.typ _MyTable_Style_Get#name(*this.strMyTableStyleObject))
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
	_MyTableAddAutoDeclare(_MyTable_Style_Set#name(*this.strMyTableStyleObject,*value.typ))
	Procedure _MyTable_Style_Set#name(*this.strMyTableStyleObject,*value.typ)
		Protected *cell.strMyTableCell=0
		Protected idx=0
		If *this
			Select *this\obj\type
				Case #MYTABLE_TYPE_COL
					Protected *col.strMyTableCol=*this\obj
					*this\style\sub#name=*value
					If *col\table\datagrid
						ForEach *col\table\rows()							
							*cell=_MyTableGetOrAddCell(*col\table\rows(),*col\listindex,#True)
							*cell\defaultStyle\sub#name=*value							
						Next
					EndIf					
				Case #MYTABLE_TYPE_ROW
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
	
	_MyTableAddAutoDeclare(_MyTable_Style_Get#name(*this.strMyTableStyleObject))
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
	_MyTableAddAutoDeclare(_MyTable_Style_SetBorder#name#pos(*this.strMyTableStyleObject,value.typ))
	Procedure _MyTable_Style_SetBorder#name#pos(*this.strMyTableStyleObject,value.typ)
		Protected *cell.strMyTableCell=0
		Protected idx=0
		If *this
			Select *this\obj\type
				Case #MYTABLE_TYPE_COL
					Protected *col.strMyTableCol=*this\obj
					If *col\table\datagrid
						ForEach *col\table\rows()
							*cell=_MyTableGetOrAddCell(*col\table\rows(),*col\listindex,#True)
							*cell\defaultStyle\border\border#pos\name=value
						Next
					EndIf					
					*this\style\border\border#pos\name=value
				Case #MYTABLE_TYPE_ROW
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
	
	_MyTableAddAutoDeclare(.typ _MyTable_Style_GetBorder#name#pos(*this.strMyTableStyleObject))
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
