;/ ===========================
;/ =   mytablecalc.pbi    =
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

CompilerIf Not Defined(MYTABLE_FORMULA_QUOTE,#PB_Constant)
	#MYTABLE_FORMULA_DQUOTE=1
CompilerEndIf

EnumerationBinary _MyTableTableFlags
	#MYTABLE_TABLE_FLAGS_FORMULA
EndEnumeration

Declare _MyTableFillCellFormula(*cell.strMyTableCell,formula.s)
Declare _MyTableFormulaCalcTable(*this.strMyTableTable)
Declare _MyTableFormulaCalcCell(*cell.strMyTableCell)
Declare _MyTableGetOrAddFormulaCell(*this.strMyTableTable,cell.s)
Declare _MyTableGridColumnFromColumnName(col.s)

Declare MyTableSetCellFormula(canvas,row.i,col.i,formula.s)
Declare.s MyTableGetCellFormula(canvas,row.i,col.i)

Procedure _MyTableFillCellFormula(*cell.strMyTableCell,formula.s)
	If Bool(*cell\table\flags & #MYTABLE_TABLE_FLAGS_FORMULA) And Left(formula,1)="="
		*cell\formula=formula
		*cell\table\formulaCells(Str(*cell))=#True
		_MyTableFormulaCalcCell(*cell)
	Else
		*cell\table\formulaCells(Str(*cell))=#False
		_MyTableFillCellText(*cell,formula)
	EndIf
EndProcedure

Procedure _MyTableFormulaCalcTable(*this.strMyTableTable)
	If *this
		Protected *cell.strMyTableCell=0
		_MyTableClearMaps(*this)
		ForEach *this\formulaCells()
			If *this\formulaCells()
				*cell=Val(MapKey(*this\formulaCells()))
				*cell\calced=#False
			EndIf
		Next
		ForEach *this\formulaCells()
			If *this\formulaCells()
				*cell=Val(MapKey(*this\formulaCells()))
				If Not *cell\calced
					_MyTableFormulaCalcCell(*cell)
				EndIf
			EndIf
		Next
	EndIf
EndProcedure

CompilerIf #MYTABLE_FORMULA_DQUOTE
	Global MyTableRegExHK=CreateRegularExpression(#PB_Any,~"\".*?\"")
	#MyTableHK=#DQUOTE$
CompilerElse
	Global MyTableRegExHK=CreateRegularExpression(#PB_Any,"'.*?'")
	#MyTableHK="'"
CompilerEndIf

Global MyTableRegExCells=CreateRegularExpression(#PB_Any,"[a-zA-Z]+\d+")
Global MyTableRegExRow=CreateRegularExpression(#PB_Any,"\d+")
Global MyTableRegExCol=CreateRegularExpression(#PB_Any,"[a-zA-Z]+")

Procedure _MyTableGridColumnFromColumnName(col.s)
	Protected result=0
	Protected idx=0
	Protected scol.s=UCase(col)
	For idx=1 To Len(scol)
		Protected cidx=Asc(Mid(scol,idx,1))-64
		Protected delta=0
		If idx=1
			delta=cidx-1
		Else
			If cidx=0
				delta=26*(idx-1)
			Else
				delta=cidx*26*(idx-1)
			EndIf
		EndIf
		result+delta
	Next
	
	ProcedureReturn result
EndProcedure

Procedure _MyTableGetOrAddFormulaCell(*this.strMyTableTable,cell.s)
	Protected *cell.strMyTableCell=0
	If cell<>""
		Protected row.s=""
		Protected col.s=""
		If ExamineRegularExpression(MyTableRegExRow,cell)
			While NextRegularExpressionMatch(MyTableRegExRow)			
				row=RegularExpressionMatchString(MyTableRegExRow)
			Wend
		EndIf
		If ExamineRegularExpression(MyTableRegExCol,cell)
			While NextRegularExpressionMatch(MyTableRegExCol)			
				col=RegularExpressionMatchString(MyTableRegExCol)
			Wend
		EndIf
	EndIf
	If row<>"" And col<>""
		Protected *rc.strMyTableRowCol=AllocateStructure(strMyTableRowCol)
		*rc\row=Val(row)-1
		*rc\col=_MyTableGridColumnFromColumnName(col)+1
		*cell=_MyTableGetOrAddCell(SelectElement(*this\rows(),*rc\row),*rc\col)		
		If *cell
			If Not *cell\calced
				_MyTableFormulaCalcCell(*cell)
			EndIf
		EndIf
		FreeStructure(*rc)
	EndIf
	ProcedureReturn *cell
EndProcedure

Procedure _MyTableFormulaCalcCell(*cell.strMyTableCell)
	Protected *formulacell.strMyTableCell=0
	Protected error.b=#False
	Protected errors.s=""
	
	If *cell
		*cell\text="#FORMULA#"
		Protected NewMap strings.s()
		Protected NewMap cells.s()
		Protected NewMap vcells.d()
		
		Protected formula.s=*cell\formula		
		Protected line.s=Mid(formula,2)
		
		Protected idx=0
		If ExamineRegularExpression(MyTableRegExHK,line)
			While NextRegularExpressionMatch(MyTableRegExHK)			
				strings("#"+Str(idx)+"#")=RegularExpressionMatchString(MyTableRegExHK)
				idx+1
			Wend
		EndIf
		idx=0
		If ExamineRegularExpression(MyTableRegExCells,line)
			While NextRegularExpressionMatch(MyTableRegExCells)			
				cells("!"+Str(idx)+"!")=RegularExpressionMatchString(MyTableRegExCells)
				idx+1
			Wend
		EndIf
		ForEach strings()
			line=ReplaceString(line,strings(),MapKey(strings()))
		Next
		line=ReplaceString(line,"+"," + ")
		line=ReplaceString(line,"-"," - ")
		line=ReplaceString(line,"*"," * ")
		line=ReplaceString(line,"/"," / ")
		line=ReplaceString(line,","," , ")
		line=ReplaceString(line,";"," ; ")
		line=ReplaceString(line,"&"," & ")
		line=ReplaceString(line,"%"," % ")
		
		While FindString(line,"  ")
			line=ReplaceString(line,"  "," ")
		Wend
		
		ForEach cells()
			line=ReplaceString(line,cells(),MapKey(cells()))		
		Next
		
		
		If Not error
			If line<>""
				
				
				line=ReplaceString(line," & ","")			
				ForEach strings()
					line=ReplaceString(line,MapKey(strings()),ReplaceString(strings(),#MyTableHK,""))
				Next	
				
				ForEach cells()					
					*formulacell=_MyTableGetOrAddFormulaCell(*cell\table,UCase(cells()))
					If Not *formulacell
						errors="#ERROR# Cell not Found: '"+UCase(cells())+"'"
						error=#True
						Break
					EndIf
					vcells(MapKey(cells()))=*formulacell\value
					line=ReplaceString(line,MapKey(cells()),*formulacell\text)
				Next
				
			EndIf
		EndIf
		
		If error
			If errors<>""
				_MyTableFillCellText(*cell,errors,#False)
			Else
				_MyTableFillCellText(*cell,"#ERROR#",#False)
			EndIf
		Else
			_MyTableFillCellText(*cell,line,#False)
		EndIf
		
		*cell\formula=formula
		
		FreeMap(strings())
		FreeMap(cells())
		FreeMap(vcells())
		*cell\calced=#True
	EndIf
EndProcedure

Procedure MyTableSetCellFormula(canvas,row.i,col.i,formula.s)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		Protected *row.strMyTableRow=SelectElement(*this\rows(),row)
		Protected *cell.strMyTableCell=_MyTableGetOrAddCell(*this\rows(),col+1)
		Protected *col.strMyTableCol=*cell\col
		If *cell\formula<>formula
			*cell\formula=formula
			*cell\textwidth=0
			*cell\textheight=0
			*cell\dirty=#True
			_MyTableFillCellFormula(*cell,formula)
			_MyTableRedraw(*this)
		EndIf
	EndIf
EndProcedure

Procedure.s MyTableGetCellFormula(canvas,row.i,col.i)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		Protected *row.strMyTableRow=SelectElement(*this\rows(),row)
		Protected *cell.strMyTableCell=_MyTableGetOrAddCell(*this\rows(),col)		
		ProcedureReturn *cell\formula
	EndIf
EndProcedure