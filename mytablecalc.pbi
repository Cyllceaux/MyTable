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


EnumerationBinary _MyTableTableFlags
	#MYTABLE_TABLE_FLAGS_FORMULA
EndEnumeration

Declare _MyTableFillCellFormula(*cell.strMyTableCell,formula.s)
Declare _MyTableFormulaCalcTable(*this.strMyTableTable)
Declare _MyTableFormulaCalcCell(*cell.strMyTableCell)

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

Procedure _MyTableFormulaCalcCell(*cell.strMyTableCell)
	If *cell
		*cell\text="#FORMULA#"
		*cell\calced=#True
	EndIf
EndProcedure

Procedure MyTableSetCellFormula(canvas,row.i,col.i,formula.s)
	Protected *this.strMyTableTable=GetGadgetData(canvas)
	If *this
		Protected *row.strMyTableRow=SelectElement(*this\rows(),row)
		Protected *cell.strMyTableCell=_MyTableGetOrAddCell(*this\rows(),col)
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