;/ ===========================
;/ =   global.pbi            =
;/ ===========================
;/
;/ [ PB V5.7x / 64Bit / all OS / DPI ]
;/
;/ © 2021 Cyllceaux (05/2021)
;/
;/ Workaround for Constants in Modules
;/
;/ https://www.purebasic.fr/english/viewtopic.php?p=553687#p553687
;/ https://www.purebasic.fr/english/viewtopic.php?f=13&t=76600
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

CompilerIf #PB_Compiler_Debugger And Not Defined(MYTABLE_DEBUG,#PB_Constant)
	#MYTABLE_DEBUG=0
CompilerEndIf

CompilerIf #PB_Compiler_Debugger And Not Defined(MYTABLE_DEBUG_LEVEL,#PB_Constant)
	#MYTABLE_DEBUG_LEVEL=0
CompilerEndIf

CompilerIf #PB_Compiler_Debugger And Not Defined(MYTABLE_DEBUG_MS_MAX,#PB_Constant)
	#MYTABLE_DEBUG_MS_MAX=200
CompilerEndIf

CompilerIf Not Defined(MYTABLE_EXPORT_XML,#PB_Constant)
	#MYTABLE_EXPORT_XML=1
CompilerEndIf

CompilerIf Not Defined(MYTABLE_EXPORT_JSON,#PB_Constant)
	#MYTABLE_EXPORT_JSON=1
CompilerEndIf

CompilerIf Not Defined(MYTABLE_GRID,#PB_Constant)
	#MYTABLE_GRID=1
CompilerEndIf

CompilerIf Not Defined(MYTABLE_FORMULA,#PB_Constant)
	#MYTABLE_FORMULA=#MYTABLE_GRID
CompilerEndIf

CompilerIf Not Defined(MYTABLE_MATRIX,#PB_Constant)
	#MYTABLE_MATRIX=#MYTABLE_GRID
CompilerEndIf

CompilerIf Not Defined(MYTABLE_FORMULA_QUOTE,#PB_Constant)
	#MYTABLE_FORMULA_QUOTE=1
CompilerEndIf

CompilerIf #PB_Compiler_Debugger And Defined(MYTABLE_DEBUG,#PB_Constant) 
	CompilerIf #MYTABLE_DEBUG
		DeclareModule MYTABLE_DEBUG:EndDeclareModule:Module MYTABLE_DEBUG:EndModule
	CompilerEndIf
CompilerEndIf

CompilerIf #PB_Compiler_Debugger And Defined(MYTABLE_DEBUG_LEVEL,#PB_Constant) And Not Defined(MYTABLE_DEBUG_LEVEL,#PB_Module)
	DeclareModule MYTABLE_DEBUG_LEVEL
		#MYTABLE_DEBUG_LEVEL=0
	EndDeclareModule
	Module MYTABLE_DEBUG_LEVEL:EndModule
CompilerEndIf

CompilerIf #PB_Compiler_Debugger And Defined(MYTABLE_DEBUG_MS_MAX,#PB_Constant) And Not Defined(MYTABLE_DEBUG_MS_MAX,#PB_Module)
	DeclareModule MYTABLE_DEBUG_MS_MAX
		#MYTABLE_DEBUG_MS_MAX=200
	EndDeclareModule
	Module MYTABLE_DEBUG_MS_MAX:EndModule
CompilerEndIf

CompilerIf Defined(MYTABLE_EXPORT_XML,#PB_Constant) 
	CompilerIf #MYTABLE_EXPORT_XML
		DeclareModule MYTABLE_EXPORT_XML:EndDeclareModule:Module MYTABLE_EXPORT_XML:EndModule
	CompilerEndIf
CompilerEndIf

CompilerIf Defined(MYTABLE_EXPORT_JSON,#PB_Constant) 
	CompilerIf #MYTABLE_EXPORT_JSON
		DeclareModule MYTABLE_EXPORT_JSON:EndDeclareModule:Module MYTABLE_EXPORT_JSON:EndModule
	CompilerEndIf
CompilerEndIf

CompilerIf Defined(MYTABLE_GRID,#PB_Constant) 
	CompilerIf #MYTABLE_GRID
		DeclareModule MYTABLE_GRID:EndDeclareModule:Module MYTABLE_GRID:EndModule
	CompilerEndIf
CompilerEndIf

CompilerIf Defined(MYTABLE_FORMULA,#PB_Constant) 
	CompilerIf #MYTABLE_FORMULA
		DeclareModule MYTABLE_FORMULA:EndDeclareModule:Module MYTABLE_FORMULA:EndModule
	CompilerEndIf
CompilerEndIf

CompilerIf Defined(MYTABLE_FORMULA_QUOTE,#PB_Constant) 
	CompilerIf #MYTABLE_FORMULA_QUOTE
		DeclareModule MYTABLE_FORMULA_QUOTE:EndDeclareModule:Module MYTABLE_FORMULA_QUOTE:EndModule
	CompilerEndIf
CompilerEndIf

CompilerIf Defined(MYTABLE_MATRIX,#PB_Constant) 
	CompilerIf #MYTABLE_MATRIX
		DeclareModule MYTABLE_MATRIX:EndDeclareModule:Module MYTABLE_MATRIX:EndModule
	CompilerEndIf
CompilerEndIf


Debug "Debug: "+#MYTABLE_DEBUG,2
Debug "Debug Level: "+#MYTABLE_DEBUG_LEVEL,2
Debug "Debug MS: "+#MYTABLE_DEBUG_MS_MAX,2
Debug "",2
Debug "Grid: "+#MYTABLE_GRID,2
Debug "Formula: "+#MYTABLE_FORMULA,2
Debug "Formula Quote: "+#MYTABLE_FORMULA_QUOTE,2
Debug "Matrix: "+#MYTABLE_MATRIX,2
Debug "",2
Debug "Export XML: "+#MYTABLE_EXPORT_JSON,2
Debug "Export JSON: "+#MYTABLE_EXPORT_XML,2
	
