;- Global
Declare _MyTableInitStyleTable(*style.strMyTableStyle)
Declare _MyTableInitStyleObject(*style.strMyTableStyleObject,
                                *this.strMyTableObject)
Declare _MyTableInitApplication(*application.strMyTableApplication,
                                flags.i)
Declare _MyTableInitTable(*application.strMyTableApplication,
                          *table.strMyTableTable,
                          window.i,
                          canvas.i,
                          vscroll.i,
                          hscroll.i,
                          flags.i)
Declare _MyTableInitRow(*application.strMyTableApplication,
                        *table.strMyTableTable,
                        *parent.strMyTableRow,
                        *row.strMyTableRow,
                        text.s,
                        sep.s,
                        image.i,
                        flags.i)
Declare _MyTableInitCol(*application.strMyTableApplication,
                        *table.strMyTableTable,
                        *col.strMyTableCol,
                        text.s,
                        width.i,
                        image.i,
                        flags.i)
Declare _MyTableInitCell(*application.strMyTableApplication,
                         *table.strMyTableTable,
                         *row.strMyTableRow,
                         *col.strMyTableCol,
                         *parent.strMyTableCell,
                         *cell.strMyTableCell,
                         flags.i)

Declare.s _MyTableCleanName(name.s)
Declare _MyTableTextHeight(text.s)
Declare _MyTableTextWidth(text.s)
Declare _MyTableGetOrAddCell(*row.strMyTableRow,idx.i)

;- Application
Declare.b _MyTable_Application_HasName(*this.strMyTableApplication,name.s)
Declare _MyTable_Application_Redraw(*this.strMyTableApplication)

;- Tables
Declare _MyTable_Table_Redraw(*this.strMyTableTable)
Declare _MyTable_Table_Predraw(*this.strMyTableTable,force.b=#false)
Declare _MyTable_Table_Recalc(*this.strMyTableTable)
Declare _MyTable_Table_ClearMaps(*this.strMyTableTable)
Declare.b _MyTable_Table_GetSelected(*this.strMyTableTable)
Declare _MyTable_Table_SetSelected(*this.strMyTableTable,value.b)

Declare _MyTableEvtResize()
Declare _MyTableEvtCanvasKeyDown()
Declare _MyTableEvtCanvasMouseMove()
Declare _MyTableEvtCanvasMouseLeftDown()
Declare _MyTableEvtCanvasMouseLeftUp()
Declare _MyTableEvtCanvasMouseLeftDouble()
Declare _MyTableEvtCanvasMouseRightDown()
Declare _MyTableEvtCanvasMouseRightUp()
Declare _MyTableEvtCanvasMouseRightDouble()
Declare _MyTableEvtCanvasScroll()
Declare _MyTableEvtScroll()

;- Rows
Declare _MyTable_Row_Delete(*this.strMyTableRow)

;-Cols
Declare _MyTable_Col_Delete(*this.strMyTableCol)
Declare _MyTable_Col_Sort(*this.strMyTableCol,sort.i)

;- Styled
Declare _MyTable_Style_Redraw(*this.strMyTableStyleObject)

;- Macros

Macro MM
	"
EndMacro

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
			Case #MYTABLE_TYPE_TABLE
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
			Case #MYTABLE_TYPE_TABLE
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


CompilerIf #PB_Compiler_Debugger And Defined(MYTABLE_DEBUG,#PB_Module)
	Macro _callcountStart(sname)
		Static NewMap callcount.i()
		Static NewMap callms.i()
		Static NewMap callmssum.i()					
		callms(MM#sname#MM+"_"+Str(_MyTableDebugGetCanvas(*this)))=ElapsedMilliseconds()		
		
		
	EndMacro
	
	Macro _callcountEnde(sname)
		
		Protected _#sname#ms=ElapsedMilliseconds()-callms(MM#sname#MM+"_"+Str(_MyTableDebugGetCanvas(*this)))
		callcount(MM#sname#MM+"_"+Str(_MyTableDebugGetCanvas(*this)))+1
		callmssum(MM#sname#MM+"_"+Str(_MyTableDebugGetCanvas(*this)))+_#sname#ms
		
		Protected tname.s=""
		If _MyTableDebugGetName(*this)=""
			tname=Str(_MyTableDebugGetCanvas(*this))
		Else
			tname=_MyTableDebugGetName(*this)
		EndIf
		
		Protected debugline.s=LSet(tname+":",16," ")
		debugline + LSet(MM#sname#MM+": "+callcount(MM#sname#MM+"_"+Str(_MyTableDebugGetCanvas(*this))),20," ")
		
		CompilerIf Defined(MYTABLE_DEBUG_MS_MAX,#PB_Module)
			If _#sname#ms>MYTABLE_DEBUG_MS_MAX::#MYTABLE_DEBUG_MS_MAX
				DebuggerWarning(MM#sname#MM+" für "+tname+" > "+Str(MYTABLE_DEBUG_MS_MAX::#MYTABLE_DEBUG_MS_MAX)+"ms ( "+Str(_#sname#ms)+" )")
			EndIf
		CompilerEndIf
		debugline + Str(_#sname#ms)+"ms / "+Str(callmssum(MM#sname#MM+"_"+Str(_MyTableDebugGetCanvas(*this))))+"ms / " +Str(callmssum(MM#sname#MM+"_"+Str(_MyTableDebugGetCanvas(*this)))/callcount(MM#sname#MM+"_"+Str(_MyTableDebugGetCanvas(*this))))+ "ms"
		CompilerIf Defined(MYTABLE_DEBUG_LEVEL,#PB_Module)
			Debug debugline,MYTABLE_DEBUG_LEVEL::#MYTABLE_DEBUG_LEVEL
		CompilerElse
			Debug debugline
		CompilerEndIf
	EndMacro
CompilerElse
	Macro _callcountStart(sname):EndMacro
	Macro _callcountEnde(sname):EndMacro
CompilerEndIf

;- Includes
XIncludeFile "mytablestyle.pb"
XIncludeFile "mytableapplication.pb"
XIncludeFile "mytabletable.pb"
XIncludeFile "mytablerow.pb"
XIncludeFile "mytablecol.pb"
XIncludeFile "mytablecell.pb"