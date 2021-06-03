;/ ===========================
;/ =   mytableformula.pb     =
;/ ===========================
;/
;/ [ PB V5.7x / 64Bit / all OS / DPI ]
;/
;/ © 2021 Cyllceaux (06/2021)
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

Procedure.s _MyTable_Formula_Mul(*this.strMyTableTable,name.s,List cells.s())	
	Protected value.d=0
	If ListSize(cells())>1
		Protected idx=0
		FirstElement(cells())
		value=ValD(cells())
		For idx=2 To ListSize(cells())
			SelectElement(cells(),idx-1)
			value*ValD(cells())
		Next		
	Else
		ProcedureReturn "#ERROR#: Wrong Parametercount(>1) for MUL"
	EndIf
	
	ProcedureReturn StrD(value)
	
EndProcedure

Procedure.s _MyTable_Formula_Div(*this.strMyTableTable,name.s,List cells.s())	
	Protected value.d=0
	If ListSize(cells())>1
		Protected idx=0
		FirstElement(cells())
		value=ValD(cells())
		For idx=2 To ListSize(cells())
			SelectElement(cells(),idx-1)
			value/ValD(cells())
		Next		
	Else
		ProcedureReturn "#ERROR#: Wrong Parametercount(>1) for DIV"
	EndIf
	
	ProcedureReturn StrD(value)
	
EndProcedure


Procedure.s _MyTable_Formula_Sum(*this.strMyTableTable,name.s,List cells.s())
	Protected value.d=0
	ForEach cells()
		value+ValD(cells())
	Next
	
	ProcedureReturn StrD(value)
	
EndProcedure

Procedure.s _MyTable_Formula_Mod(*this.strMyTableTable,name.s,List cells.s())
	Protected value.d=0
	If ListSize(cells())=2
		SelectElement(cells(),0)
		Protected v1.d=ValD(cells())
		SelectElement(cells(),1)
		Protected v2.d=ValD(cells())
		value=Mod(v1,v2)
	Else
		ProcedureReturn "#ERROR#: Wrong Parametercount(2) for MOD"
	EndIf
	
	ProcedureReturn StrD(value)
EndProcedure

Procedure.s _MyTable_Formula_If(*this.strMyTableTable,name.s,List cells.s())
	Select ListSize(cells())
		Case 1
			SelectElement(cells(),0)
			ProcedureReturn Str(Bool(cells()<>"0"))
		Case 2
			SelectElement(cells(),0)
			If Bool(cells()<>"0")
				SelectElement(cells(),1)	
				ProcedureReturn cells()
			EndIf
		Case 3
			SelectElement(cells(),0)
			If Bool(cells()<>"0")
				SelectElement(cells(),1)					
			Else
				SelectElement(cells(),2)	
			EndIf
			ProcedureReturn cells()
		Default
			ProcedureReturn "0"
	EndSelect
EndProcedure

Procedure.s _MyTable_Formula_Not(*this.strMyTableTable,name.s,List cells.s())
	FirstElement(cells())
	ProcedureReturn Str(Bool(cells()="0"))
EndProcedure

Procedure.s _MyTable_Formula_And(*this.strMyTableTable,name.s,List cells.s())
	Protected ok.b=#True
	ForEach cells()
		ok=Bool(ok And cells()="1")
	Next
	ProcedureReturn Str(ok)
EndProcedure

Procedure.s _MyTable_Formula_Or(*this.strMyTableTable,name.s,List cells.s())
	Protected ok.b=#False
	ForEach cells()
		ok=Bool(ok Or cells()="1")
	Next
	ProcedureReturn Str(ok)
EndProcedure

Procedure.s _MyTable_Formula_XOr(*this.strMyTableTable,name.s,List cells.s())
	Protected ok.b=#False
	ForEach cells()
		ok=Bool(ok XOr cells()="1")
	Next
	ProcedureReturn Str(ok)
EndProcedure

CompilerIf Defined(MYTABLE_MATRIX,#PB_Module)
	Procedure.s _MyTable_Formula_MatrixValue(*this.strMyTableTable,name.s,List cells.s())
		If ListSize(cells())>1
			Protected c=ListSize(cells())-1
			Protected idx=0
			SelectElement(cells(),0)
			Protected row=Val(cells())
			SelectElement(cells(),1)
			Protected col=Val(cells())
			Protected *cell.strMyTableCell=_MyTableGetOrAddCell(SelectElement(*this\rows(),row),col)
			For idx=2 To c
				SelectElement(cells(),idx)
				col=Val(cells())
				*cell=_MyTableCellGetOrAddCell(*cell,col)
			Next
			ProcedureReturn *cell\text
		Else
			ProcedureReturn "#ERROR#: Wrong Parametercount(>1) for MATRIXVALUE"
		EndIf
	EndProcedure
CompilerEndIf

Procedure _MyTable_InitFormula(*this.strMyTableTable)
	*this\forms("SUM")=@_MyTable_Formula_Sum()
	*this\forms("MOD")=@_MyTable_Formula_Mod()
	*this\forms("DIV")=@_MyTable_Formula_Div()
	*this\forms("MUL")=@_MyTable_Formula_Mul()
	
	*this\forms("IF")=@_MyTable_Formula_If()
	*this\forms("NOT")=@_MyTable_Formula_Not()
	*this\forms("AND")=@_MyTable_Formula_And()
	*this\forms("OR")=@_MyTable_Formula_Or()
	*this\forms("XOR")=@_MyTable_Formula_XOr()
	CompilerIf Defined(MYTABLE_MATRIX,#PB_Module)
		*this\forms("MATRIXVALUE")=@_MyTable_Formula_MatrixValue()
	CompilerEndIf
EndProcedure