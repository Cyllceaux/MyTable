;/ ===========================
;/ =   mytablecalc.pb        =
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

CompilerIf #MYTABLE_FORMULA_DQUOTE
	Global MyTableRegExHK=CreateRegularExpression(#PB_Any,~"\".*?\"")
	Global MyTableRegDQuot=CreateRegularExpression(#PB_Any,~"[\"]{3,}")
	#MyTableHK=#DQUOTE$
CompilerElse
	Global MyTableRegExHK=CreateRegularExpression(#PB_Any,"'.*?'")
	Global MyTableRegDQuot=CreateRegularExpression(#PB_Any,~"[']{3,}")
	#MyTableHK="'"
CompilerEndIf

Global MyTableRegExCells=CreateRegularExpression(#PB_Any,"[a-zA-Z]+\d+")
Global MyTableRegExRange=CreateRegularExpression(#PB_Any,"[a-zA-Z]+\d+\:[a-zA-Z]+\d+")
Global MyTableRegExRow=CreateRegularExpression(#PB_Any,"\d+")
Global MyTableRegExCol=CreateRegularExpression(#PB_Any,"[a-zA-Z]+")
Global MyTableRegMul=CreateRegularExpression(#PB_Any,"-?[\d+\.]+ \* -?[\d+\.]+")
Global MyTableRegAdd=CreateRegularExpression(#PB_Any,"-?[\d+\.]+ \+ -?[\d+\.]+")
Global MyTableRegSub=CreateRegularExpression(#PB_Any,"-?[\d+\.]+ \- -?[\d+\.]+")
Global MyTableRegDiv=CreateRegularExpression(#PB_Any,"-?[\d+\.]+ \/ -?[\d+\.]+")
Global MyTableRegMod=CreateRegularExpression(#PB_Any,"-?[\d+\.]+ \% -?[\d+\.]+")

Global MyTableRegEQ=CreateRegularExpression(#PB_Any,"[\w+\d+\.]+ \= [\w+\d+\.]+")
Global MyTableRegNEQ=CreateRegularExpression(#PB_Any,"[\w+\d+\.]+ (\!\=|\<\>) [\w+\d+\.]+")
Global MyTableRegGT=CreateRegularExpression(#PB_Any,"[\w+\d+\.]+ \> [\w+\d+\.]+")
Global MyTableRegLT=CreateRegularExpression(#PB_Any,"[\w+\d+\.]+ \< [\w+\d+\.]+")
Global MyTableRegGE=CreateRegularExpression(#PB_Any,"[\w+\d+\.]+ \>\= [\w+\d+\.]+")
Global MyTableRegLE=CreateRegularExpression(#PB_Any,"[\w+\d+\.]+ \<\= [\w+\d+\.]+")

Global MyTableRegKL=CreateRegularExpression(#PB_Any,"\(-?[\d+\.]+\)")
Global MyTableRegFormula=CreateRegularExpression(#PB_Any,"[\w\d]+\([^()]*\)")

Prototype.s MyTableProtoFormulaRegex(typ.s,value.s)

Structure strMyTableFormulaRegex
	regex.i
	method.MyTableProtoFormulaRegex
EndStructure

Global NewMap MyTableFormulaRegexMap.strMyTableFormulaRegex()
Global NewMap MyTableFormulaRegexLogicMap.strMyTableFormulaRegex()


Procedure.s MyTableFormulaRegexAdd(typ.s,value.s)
	ProcedureReturn StrD(ValD(StringField(value,1," "+typ+" ")) + ValD(StringField(value,2," "+typ+" ")))
EndProcedure

Procedure.s MyTableFormulaRegexSub(typ.s,value.s)
	ProcedureReturn StrD(ValD(StringField(value,1," "+typ+" ")) - ValD(StringField(value,2," "+typ+" ")))
EndProcedure

Procedure.s MyTableFormulaRegexMul(typ.s,value.s)
	ProcedureReturn StrD(ValD(StringField(value,1," "+typ+" ")) * ValD(StringField(value,2," "+typ+" ")))
EndProcedure

Procedure.s MyTableFormulaRegexDiv(typ.s,value.s)
	ProcedureReturn StrD(ValD(StringField(value,1," "+typ+" ")) / ValD(StringField(value,2," "+typ+" ")))
EndProcedure

Procedure.s MyTableFormulaRegexMod(typ.s,value.s)
	ProcedureReturn StrD(Mod(ValD(StringField(value,1," "+typ+" ")) , ValD(StringField(value,2," "+typ+" "))))
EndProcedure

Procedure.s MyTableFormulaRegexLogic(typ.s,value.s)
	Protected v1.s=Trim(StringField(value,1,typ))
	Protected v2.s=Trim(StringField(value,2,typ))
	
	Protected vd1.d=ValD(Trim(StringField(value,1,typ)))
	Protected vd2.d=ValD(Trim(StringField(value,2,typ)))
	Select typ
		Case "="
			ProcedureReturn Str(Bool(v1=v2))
		Case "!=","<>"
			ProcedureReturn Str(Bool(v1<>v2))
		Case ">"
			ProcedureReturn Str(Bool(vd1>vd2))
		Case ">="
			ProcedureReturn Str(Bool(vd1>=vd2))
		Case "<"
			ProcedureReturn Str(Bool(vd1<vd2))
		Case "<="
			ProcedureReturn Str(Bool(vd1<=vd2))
	EndSelect
EndProcedure

Macro _macroFormulaRegexMap(typ,name)
	MyTableFormulaRegexMap(MM#typ#MM)\method=@MyTableFormulaRegex#name()
	MyTableFormulaRegexMap(MM#typ#MM)\regex=MyTableReg#name
EndMacro

Macro _macroFormulaRegexLogicMap(typ,name)
	MyTableFormulaRegexLogicMap(MM#typ#MM)\method=@MyTableFormulaRegexLogic()
	MyTableFormulaRegexLogicMap(MM#typ#MM)\regex=MyTableReg#name
EndMacro

_macroFormulaRegexMap(+,Add)
_macroFormulaRegexMap(-,Sub)
_macroFormulaRegexMap(*,Mul)
_macroFormulaRegexMap(/,Div)
_macroFormulaRegexMap(%,Mod)

_macroFormulaRegexLogicMap(=,EQ)
_macroFormulaRegexLogicMap(!=,NEQ)
_macroFormulaRegexLogicMap(<>,NEQ)
_macroFormulaRegexLogicMap(>,GT)
_macroFormulaRegexLogicMap(>=,GE)
_macroFormulaRegexLogicMap(<,LT)
_macroFormulaRegexLogicMap(<=,LE)

Procedure.s _MyTableFormulaRegExReplace(Map rMap.strMyTableFormulaRegex(),typ.s,line.s)
	Protected result.s=line
	Protected *tfr.strMyTableFormulaRegex=rMap(typ)
	Protected calc.b=#False
	If *tfr
		If ExamineRegularExpression(*tfr\regex,result)
			While NextRegularExpressionMatch(*tfr\regex)			
				Protected rech.s=Trim(RegularExpressionMatchString(*tfr\regex))
				result=ReplaceString(result,rech,*tfr\method(typ,rech))			
				calc=#True
			Wend
		EndIf
	EndIf
	If calc
		ProcedureReturn _MyTableFormulaRegExReplace(rMap(),typ,result)
	Else
		ProcedureReturn result
	EndIf
EndProcedure

Structure strMyTableRange
	from.strMyTableRowCol
	To.strMyTableRowCol
EndStructure


Procedure.s _MyTableFormulaExt(*this.strMyTableTable,name.s,List cells.s())
	Protected form.MyTableProtoFormula=0
	ForEach *this\forms()
		If LCase(MapKey(*this\forms()))=LCase(name)
			form=*this\forms()
			Break
		EndIf
	Next
	
	If form
		ProcedureReturn form(name,cells())
	Else
		ProcedureReturn "#ERROR#: Unknown Method '"+name+"'"
	EndIf
EndProcedure

Procedure.s _MyTableFormula(*this.strMyTableTable,formula.s)
	Protected result.s=formula
	Protected dqline.s=""
	Protected name.s=Mid(result,1,FindString(result,"(")-1)
	result=Mid(result,Len(name)+2,Len(result)-2-Len(name))
	
	If ExamineRegularExpression(MyTableRegFormula,result)
		While NextRegularExpressionMatch(MyTableRegFormula)			
			dqline=RegularExpressionMatchString(MyTableRegFormula)
			result=ReplaceString(result,dqline,_MyTableFormula(*this,dqline))
		Wend
	EndIf
	
	Protected c=CountString(result,";")
	Protected i
	Protected NewList cells.s()
	For i=0 To c
		AddElement(cells())
		cells()=Trim(StringField(result,i+1,";"))
	Next
	result= _MyTableFormulaExt(*this,name,cells())
	FreeList(cells())
	ProcedureReturn result
EndProcedure

Procedure _MyTableFillCellFormula(*cell.strMyTableCell,formula.s)
	If Bool(*cell\table\flags & #MYTABLE_TABLE_FLAGS_FORMULA) And Left(formula,1)="'" And Right(formula,1)<>"'"
		*cell\table\formulaCells(Str(*cell))=#False
		_MyTableFillCellText(*cell,Mid(formula,2))
		*cell\formula=formula
	ElseIf Bool(*cell\table\flags & #MYTABLE_TABLE_FLAGS_FORMULA) And Left(formula,1)="="
		*cell\formula=formula
		*cell\table\formulaCells(Str(*cell))=#True
		*cell\calced=#False
		Protected NewList cells()
		_MyTableFormulaCalcCell(*cell,cells())
		FreeList(cells())
	Else
		*cell\table\formulaCells(Str(*cell))=#False
		_MyTableFillCellText(*cell,formula)
	EndIf
EndProcedure

Procedure _MyTableFormulaCalcTable(*this.strMyTableTable)
	If *this
		If MapSize(*this\formulaCells())>0
			_callcountStart(calctable)
			
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
						Protected NewList cells()
						_MyTableFormulaCalcCell(*cell,cells())
						FreeList(cells())
					EndIf
				EndIf
			Next
			_callcountEnde(calctable)
		EndIf
	EndIf
EndProcedure


Procedure.s _MyTable_RangeString(range.s)
	Protected result.s=""
	If range<>""
		
		Protected row.s=""
		Protected col.s=""
		If ExamineRegularExpression(MyTableRegExRow,StringField(range,1,":"))
			While NextRegularExpressionMatch(MyTableRegExRow)			
				row=RegularExpressionMatchString(MyTableRegExRow)
			Wend
		EndIf
		If ExamineRegularExpression(MyTableRegExCol,StringField(range,1,":"))
			While NextRegularExpressionMatch(MyTableRegExCol)			
				col=RegularExpressionMatchString(MyTableRegExCol)
			Wend
		EndIf
		
		
		Protected *rc.strMyTableRange=AllocateStructure(strMyTableRange)
		*rc\from\row=Val(row)-1
		*rc\from\col=_MyTableGridColumnFromColumnName(col)
		If ExamineRegularExpression(MyTableRegExRow,StringField(range,2,":"))
			While NextRegularExpressionMatch(MyTableRegExRow)			
				row=RegularExpressionMatchString(MyTableRegExRow)
			Wend
		EndIf
		If ExamineRegularExpression(MyTableRegExCol,StringField(range,2,":"))
			While NextRegularExpressionMatch(MyTableRegExCol)			
				col=RegularExpressionMatchString(MyTableRegExCol)
			Wend
		EndIf
		*rc\to\row=Val(row)-1
		*rc\to\col=_MyTableGridColumnFromColumnName(col)
		Protected i,g
		Protected *cell.strMyTableCell
		
		For i=*rc\from\row To *rc\to\row
			For g=*rc\from\col To *rc\to\col
				If result<>""
					result+"; "
				EndIf
				result+_MyTableGridColumnName(g+1)+Str(i+1)
			Next
		Next
		
		FreeStructure(*rc)
	EndIf
	ProcedureReturn result
EndProcedure

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

Procedure _MyTableGetOrAddFormulaCell(*this.strMyTableTable,cell.s,List calccells())
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
		*rc\col=_MyTableGridColumnFromColumnName(col)
		*cell=_MyTableGetOrAddCell(SelectElement(*this\rows(),*rc\row),*rc\col)		
		If *cell
			ForEach calccells()
				If calccells()=*cell
					*cell=-1
					Break
				EndIf
			Next
			If *cell<>0 And *cell<>-1
				If Not *cell\calced
					_MyTableFormulaCalcCell(*cell,calccells())
				EndIf
			EndIf
		EndIf
		FreeStructure(*rc)
	EndIf
	ProcedureReturn *cell
EndProcedure

Procedure.s _MyTableFormulaMath(line.s)
	Protected result.s=line
	Protected rech.s=""
	Protected calc.b=#False
	If ExamineRegularExpression(MyTableRegKL,result)
		While NextRegularExpressionMatch(MyTableRegKL)			
			rech=Trim(RegularExpressionMatchString(MyTableRegKL))
			result=ReplaceString(result,rech,Mid(rech,2,Len(rech)-2))
			calc=#True
		Wend
	EndIf
	
	If Not calc
		rech=_MyTableFormulaRegExReplace(MyTableFormulaRegexMap(),"/",result)
		If rech<>result
			calc=#True
		EndIf
		result=rech
	EndIf
	
	If Not calc
		rech=_MyTableFormulaRegExReplace(MyTableFormulaRegexMap(),"*",result)
		If rech<>result
			calc=#True
		EndIf
		result=rech
	EndIf
	
	If Not calc
		rech=_MyTableFormulaRegExReplace(MyTableFormulaRegexMap(),"%",result)
		If rech<>result
			calc=#True
		EndIf
		result=rech
	EndIf
	
	If Not calc
		rech=_MyTableFormulaRegExReplace(MyTableFormulaRegexMap(),"-",result)
		If rech<>result
			calc=#True
		EndIf
		result=rech		
	EndIf
	
	If Not calc
		rech=_MyTableFormulaRegExReplace(MyTableFormulaRegexMap(),"+",result)
		If rech<>result
			calc=#True
		EndIf
		result=rech
	EndIf
	
	
	
	If calc
		ProcedureReturn _MyTableFormulaMath(result)
	Else
		ProcedureReturn result
	EndIf
EndProcedure

Procedure.s _MyTableFormulaCalcCellExp(*cell.strMyTableCell,formula.s,List calccells())
	Protected error.b=#False
	Protected line.s=formula
	Protected errors.s=""
	Protected *formulacell.strMyTableCell=0
	Protected calc.b=#False
	If Not error
		AddElement(calccells())
		Protected NewMap strings.s()
		Protected NewMap dqstrings.s()
		Protected NewMap cells.s()
		Protected NewMap range.s()
		Protected NewMap vcells.d()
		
		
		Protected dqline.s=""
		Protected ranges.s=""
		
		Protected idx=0
		If ExamineRegularExpression(MyTableRegDQuot,line)
			While NextRegularExpressionMatch(MyTableRegDQuot)			
				dqline=RegularExpressionMatchString(MyTableRegDQuot)
				dqstrings("#DQ#"+Str(Len(dqline)-2)+"#QD#")=dqline
			Wend
			ForEach dqstrings()
				line=ReplaceString(line,dqstrings(),MapKey(dqstrings())+#MyTableHK)
			Next
		EndIf
		idx=0
		If ExamineRegularExpression(MyTableRegExHK,line)
			While NextRegularExpressionMatch(MyTableRegExHK)			
				strings("##"+Str(idx)+"##")=RegularExpressionMatchString(MyTableRegExHK)
				idx+1
			Wend
		EndIf
		
		
		
		ForEach strings()
			line=ReplaceString(line,strings(),MapKey(strings()))
		Next
		
		idx=0
		If ExamineRegularExpression(MyTableRegExRange,line)
			While NextRegularExpressionMatch(MyTableRegExRange)			
				range("#_"+Str(idx)+"_#")=RegularExpressionMatchString(MyTableRegExRange)
				idx+1
			Wend
		EndIf
		
		ForEach range()
			ranges=_MyTable_RangeString(range())
			line=ReplaceString(line,range(),ranges)
		Next
		
		idx=0
		If ExamineRegularExpression(MyTableRegExCells,line)
			While NextRegularExpressionMatch(MyTableRegExCells)			
				cells("#!"+Str(idx)+"!#")=RegularExpressionMatchString(MyTableRegExCells)
				idx+1
			Wend
		EndIf
		
		
		line=ReplaceString(line,"+"," + ")
		line=ReplaceString(line,"-"," - ")
		line=ReplaceString(line,"*"," * ")
		line=ReplaceString(line,"/"," / ")
		line=ReplaceString(line,","," , ")
		line=ReplaceString(line,";"," ; ")
		line=ReplaceString(line,"&"," & ")
		line=ReplaceString(line,"%"," % ")
		line=ReplaceString(line,"="," = ")
		
		While FindString(line,"  ")
			line=ReplaceString(line,"  "," ")
		Wend
		
		
		
		ForEach cells()
			line=ReplaceString(line,cells(),MapKey(cells()))		
		Next
		
		
		If Not error
			If line<>""
				
				ForEach cells()					
					*formulacell=_MyTableGetOrAddFormulaCell(*cell\table,UCase(cells()),calccells())
					If *formulacell=0
						errors="#ERROR# Cell not Found: '"+UCase(cells())+"'"
						error=#True
						Break
					EndIf
					If *formulacell = *cell Or *formulacell=-1
						errors="#ERROR# Recursion: '"+UCase(cells())+"'"
						error=#True
						Break
					EndIf
					vcells(MapKey(cells()))=*formulacell\value
					line=ReplaceString(line,MapKey(cells()),*formulacell\text)
				Next
				
				line=_MyTableFormulaMath(line)
				
				line=ReplaceString(line," & ","")			
				ForEach strings()
					line=ReplaceString(line,MapKey(strings()),ReplaceString(strings(),#MyTableHK,""))
				Next	
				ForEach dqstrings()
					dqline=ReplaceString(MapKey(dqstrings()),"#DQ#","")
					dqline=ReplaceString(dqline,"#QD#","")
					dqline=LSet(~"\"",Val(dqline),#MyTableHK)
					line=ReplaceString(line,MapKey(dqstrings()),dqline)
				Next
				
				
				
			EndIf
		EndIf
	EndIf
	
	If Not error
		If line<>""
			ForEach MyTableFormulaRegexLogicMap()
				dqline=_MyTableFormulaRegExReplace(MyTableFormulaRegexLogicMap(),MapKey(MyTableFormulaRegexLogicMap()),line)
				If dqline<>line
					calc=#True
					line=dqline
				EndIf
			Next
		EndIf
	EndIf	
	
	If Not error
		If line<>""
			idx=1
			While idx
				idx=0
				If ExamineRegularExpression(MyTableRegFormula,line)
					While NextRegularExpressionMatch(MyTableRegFormula)			
						dqline=RegularExpressionMatchString(MyTableRegFormula)
						line=ReplaceString(line,dqline,_MyTableFormula(*cell\table,dqline))
						idx=1
						calc=#True
					Wend
				EndIf
			Wend
		EndIf
	EndIf	
	
	FreeMap(strings())
	FreeMap(dqstrings())
	FreeMap(cells())
	FreeMap(range())
	FreeMap(vcells())
	If calc
		line=_MyTableFormulaCalcCellExp(*cell,line,calccells())
	EndIf
	
	ProcedureReturn line
EndProcedure

Procedure _MyTableFormulaCalcCell(*cell.strMyTableCell,List calccells())
	
	Protected error.b=#False
	Protected errors.s=""
	
	If *cell And Not *cell\calced
		ForEach calccells()
			If calccells()=*cell
				error=#True
				errors="#ERROR# Recursion"
			EndIf
			
		Next
		If Not error
			*cell\calced=#True
			AddElement(calccells())
			calccells()=*cell
		EndIf
		
		Protected formula.s=*cell\formula		
		Protected line.s=Mid(formula,2)
		
		line=_MyTableFormulaCalcCellExp(*cell,line,calccells())
		
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
		
		
		*cell\calced=#True
	EndIf
EndProcedure

Procedure _MyTable_Cell_SetFormula(*this.strMyTableCell,formula.s)
	If *this		
		If *this\formula<>formula
			*this\formula=formula
			*this\textwidth=0
			*this\textheight=0
			*this\dirty=#True
			_MyTableFillCellFormula(*this,formula)
			_MyTable_Table_Redraw(*this\table)
		EndIf
	EndIf
EndProcedure

Procedure.s _MyTable_Cell_GetFormula(*this.strMyTableCell)
	If *this
		ProcedureReturn *this\formula
	EndIf
EndProcedure


Procedure _MyTable_Table_SetCellformula(*this.strMyTableTable,row.i,col.i,formula.s)
	If *this
		Protected *row.strMyTableRow=SelectElement(*this\rows(),row)
		Protected *cell.strMyTableCell=_MyTableGetOrAddCell(*this\rows(),col)
		_MyTable_Cell_SetFormula(*cell,formula)
	EndIf
EndProcedure

Procedure.s _MyTable_Table_GetCellFormula(*this.strMyTableTable,row.i,col.i)
	If *this
		Protected *row.strMyTableRow=SelectElement(*this\rows(),row)
		Protected *cell.strMyTableCell=_MyTableGetOrAddCell(*this\rows(),col)
		ProcedureReturn _MyTable_Cell_GetFormula(*cell)
	EndIf
EndProcedure

Procedure _MyTable_Table_SetRegisterFormula(*this.strMyTableTable,name.s,method.MyTableProtoFormula)
	If *this
		*this\forms(name)=method
	EndIf
EndProcedure

XIncludeFile "mytableformula.pb"