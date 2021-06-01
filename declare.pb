;/ ===========================
;/ =   declare.pb            =
;/ ===========================
;/
;/ [ PB V5.7x / 64Bit / all OS / DPI ]
;/
;/ © 2021 Cyllceaux (05/2021)
;/


;{ ===== MIT License =====
;
; Copyright (c) 2021 Silko Pillasch
;
; Permission is hereby granted, free of charge, to any person obtaining a copy
; of this software and associated documentation files (the "Software"), to deal
; in the Software without restriction, including without limitation the rights
; to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
; copies of the Software, and to permit persons to whom the Software is
; furnished to do so, subject to the following conditions:
; 
; The above copyright notice and this permission notice shall be included in all
; copies or substantial portions of the Software.
;
; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
; SOFTWARE.
;}

Macro MacroGetter(gruppe,name,typ)
	Declare.typ _MyTable_#gruppe#_Get#name(*this.strMyTable#gruppe)	
EndMacro

Macro MacroSetter(gruppe,name,typ)	
	Declare _MyTable_#gruppe#_Set#name(*this.strMyTable#gruppe,value.typ)
EndMacro

Macro MacroGetterSetter(gruppe,name,typ)
	MacroGetter(gruppe,name,typ)
	MacroSetter(gruppe,name,typ)	
EndMacro

;- Interface
Declare _MyTable_Table_ClearRows(*this.strMyTableTable)
Declare _MyTable_Table_ClearCols(*this.strMyTableTable)
Declare _MyTable_Table_AddColumn(*this.strMyTableTable,text.s,width.i,flags.i=#MYTABLE_COLUMN_FLAGS_DEFAULT,image.i=0,*data=0,sort.i=0,tooltip.s="")
Declare _MyTable_Table_AddRow(*this.strMyTableTable,text.s,sep.s="|",id.q=#PB_Ignore,image.i=0,*data=0,checked.b=#False,expanded.b=#False,tooltip.s="")
Declare _MyTable_Table_Redraw(*this.strMyTableTable)
Declare _MyTable_Table_Recalc(*this.strMyTableTable)
Declare _MyTable_Table_AutosizeRow(*this.strMyTableTable,row.i=#PB_Ignore)
Declare _MyTable_Table_AutosizeCol(*this.strMyTableTable,col.i=#PB_Ignore)

Declare _MyTable_Table_AddDirtyRows(*this.strMyTableTable,rows.i)


Declare _MyTable_Row_AddDirtyRows(*this.strMyTableRow,rows.i)
Declare _MyTable_Row_GetTable(*this.strMyTableRow)
MacroGetterSetter(Row,RowHeight,i)
Declare _MyTable_Row_Delete(*this.strMyTableRow)

Declare _MyTable_Col_GetTable(*this.strMyTableCol)
Declare _MyTable_Col_Delete(*this.strMyTableCol)

Declare _MyTable_Cell_GetTable(*this.strMyTableCell)
Declare _MyTable_Cell_GetRow(*this.strMyTableCell)
Declare _MyTable_Cell_GetCol(*this.strMyTableCell)
MacroGetterSetter(Cell,Text,s)
MacroGetterSetter(Cell,Tooltip,s)
MacroGetterSetter(Cell,Value,d)
MacroGetterSetter(Cell,Image,i)



;- Intern
Declare _MyTableFillCellText(*cell.strMyTableCell,text.s,override.b=#True)
Declare _MyTableGetOrAddCell(*row.strMyTableRow,col.i=-1,force.b=#False)
Declare _MyTableClearMaps(*this.strMyTableTable)
Declare _MyTableRegister(*application.strMyTableApplication,window,canvas,hscroll,vscroll,flags.i=#MYTABLE_TABLE_FLAGS_DEFAULT,callback.MyTableProtoEventCallback=0,name.s="")
Declare _MyTable_Table_RecalcExp(*this.strMyTableTable,force.b=#False)
Declare _MyTable_Table_AutosizeColExp(*this.strMyTableTable,col.i=#PB_Ignore,force.b=#True)
Declare _MyTable_Table_UnRegister(*this.strMyTableTable)		
Declare _MyTable_Table_Dirty(*this.strMyTableTable)		
CompilerIf #PB_Compiler_Debugger And Defined(MYTABLE_DEBUG,#PB_Module)
	Declare _MyTableDebugGetCanvas(*element._strMyTableAObject)
	Declare.s _MyTableDebugGetName(*element._strMyTableAObject)
CompilerEndIf
Declare _MyTableFormulaCalcApplication(*this.strMyTableApplication)
Declare.b _MyTableFillCellMatrix(*cell.strMyTableCell,matrix.s)

;- Events
Declare MyTableEvtResize()
Declare MyTableEvtDialogResize()
Declare MyTableEvtScroll()
Declare MyTableEvtMouseDown()
Declare MyTableEvtMouseUp()
Declare MyTableEvtMouseMove()
Declare MyTableEvtDouble()
Declare MyTableEvtKeyDown()
Declare MyTableEvtReturn()
Declare MyTableEvtEsc()
Declare MyTableEvtLostFocus()




