﻿;/ ===========================
;/ =   mytablematrix.pb      =
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

Global MyTableRegMatrix=CreateRegularExpression(#PB_Any,"\{[^{}]*\}")


Procedure.s _MyTableMatrixCalcCell(*cell.strMyTableCell,matrix.s)
	ClearList(*cell\cells())
	Protected.s dqline,result
	Protected c,idx
	result=matrix
	Protected NewMap cells.s()
	idx=0
	While CountString(result,"{")>1
		If ExamineRegularExpression(MyTableRegMatrix,result)
			While NextRegularExpressionMatch(MyTableRegMatrix)
				cells("#"+idx+"#")=RegularExpressionMatchString(MyTableRegMatrix)
				result=ReplaceString(result,cells("#"+idx+"#"),"#"+idx+"#")
				idx+1
			Wend
		EndIf
	Wend
	
	ClearMap(cells())
EndProcedure

Procedure.b _MyTableFillCellMatrix(*cell.strMyTableCell,matrix.s)
	Protected result.b=#False
	If Bool(*cell\table\flags & #MYTABLE_TABLE_FLAGS_MATRIX) And Left(matrix,1)="{"
		*cell\matrix=matrix
		*cell\table\matrixCells(Str(*cell))=#True		
		_MyTableMatrixCalcCell(*cell,matrix)
		result=#True
	Else
		*cell\table\matrixCells(Str(*cell))=#False
		CompilerIf Defined(MYTABLE_FORMULA,#PB_Module)
			_MyTableFillCellFormula(*cell.strMyTableCell,matrix)
		CompilerElse
			*cell\table\matrixCells(Str(*cell))=#False
			_MyTableFillCellText(*cell,matrix)
		CompilerEndIf
	EndIf
	ProcedureReturn result
EndProcedure

Procedure _MyTable_Cell_SetMatrix(*this.strMyTableCell,matrix.s)
	If *this		
		If *this\matrix<>matrix
			*this\matrix=matrix
			*this\textwidth=0
			*this\textheight=0
			*this\dirty=#True
			_MyTableFillCellMatrix(*this,matrix)
			_MyTable_Table_Redraw(*this\table)
		EndIf
	EndIf
EndProcedure

Procedure.s _MyTable_Cell_GetMatrix(*this.strMyTableCell)
	If *this
		ProcedureReturn *this\matrix
	EndIf
EndProcedure

Procedure _MyTable_Table_SetCellMatrix(*this.strMyTableTable,row.i,col.i,matrix.s)
	If *this
		Protected *row.strMyTableRow=SelectElement(*this\rows(),row)
		If *row
			Protected *cell.strMyTableCell=_MyTableGetOrAddCell(*this\rows(),col)
			_MyTable_Cell_SetMatrix(*cell,matrix)
		EndIf
	EndIf
EndProcedure

Procedure.s _MyTable_Table_GetCellMatrix(*this.strMyTableTable,row.i,col.i)
	If *this
		Protected *row.strMyTableRow=SelectElement(*this\rows(),row)
		Protected *cell.strMyTableCell=_MyTableGetOrAddCell(*this\rows(),col)
		ProcedureReturn _MyTable_Cell_GetMatrix(*cell)
	EndIf
EndProcedure