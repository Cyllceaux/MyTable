;/ ===========================
;/ =   mytableformula.pb     =
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


Procedure.s _MyTable_Formula_Sum(name.s,List cells.s())
	Protected value.d=0
	ForEach cells()
		value+ValD(cells())
	Next
	
	ProcedureReturn StrD(value)
EndProcedure

Procedure.s _MyTable_Formula_If(name.s,List cells.s())
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

Procedure.s _MyTable_Formula_Not(name.s,List cells.s())
	FirstElement(cells())
	ProcedureReturn Str(Bool(cells()="0"))
EndProcedure

Procedure _MyTable_InitFormula(*this.strMyTableTable)
	*this\forms("SUM")=@_MyTable_Formula_Sum()
	*this\forms("IF")=@_MyTable_Formula_If()
	*this\forms("NOT")=@_MyTable_Formula_Not()
EndProcedure