;/ ===========================
;/ =   mytablecol.pb       =
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

Procedure _MyTable_Col_GetTable(*this.strMyTableCol)
	ProcedureReturn *this\table
EndProcedure

Procedure _MyTable_Col_GetType(*this.strMyTableCol)
	ProcedureReturn *this\type
EndProcedure

Procedure.s _MyTable_Col_GetText(*this.strMyTableCol)
	If *this
		ProcedureReturn *this\text
	EndIf
EndProcedure

Procedure.s _MyTable_Col_GetFormat(*this.strMyTableCol)
	If *this
		ProcedureReturn *this\format
	EndIf
EndProcedure

Procedure.s _MyTable_Col_GetTooltip(*this.strMyTableCol)
	If *this
		ProcedureReturn *this\tooltip
	EndIf
EndProcedure

Procedure _MyTable_Col_SetText(*this.strMyTableCol,text.s)
	If *this
		
		If *this\text<>text And Not *this\table\datagrid
			*this\text=text
			*this\dirty=#True
			*this\textwidth=0
			*this\textheight=0
			*this\table\dirty=#True
			_MyTable_Table_Redraw(*this\table)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Col_SetFormat(*this.strMyTableCol,format.s)
	If *this
		If *this\format<>format
			*this\format=format
			*this\dirty=#True
			*this\textwidth=0
			*this\textheight=0
			*this\dirty=#True
			*this\table\dirty=#True
			ForEach *this\table\rows()
				Protected *cell.strMyTableCell=_MyTableGetOrAddCell(*this\table\rows(),*this\listindex)
				_MyTableFillCellValue(*cell,*cell\value)
			Next
			_MyTable_Table_Redraw(*this\table)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Col_SetTooltip(*this.strMyTableCol,tooltip.s)
	If *this
		*this\tooltip=tooltip
	EndIf
EndProcedure

Procedure _MyTable_Col_GetFlags(*this.strMyTableCol)
	If *this
		ProcedureReturn *this\flags
	EndIf
EndProcedure

Procedure _MyTable_Col_SetFlags(*this.strMyTableCol,flags.i)
	If *this
		
		If *this\flags<>flags And (*this\table\datagrid=#False Or *this\id>0)
			*this\flags=flags
			*this\dirty=#True
			*this\dirty=#True
			*this\table\dirty=#True
			If Bool(flags & #MYTABLE_COLUMN_FLAGS_DATE)
				*this\format="%dd.%mm.%yyyy"
			EndIf
			If Bool(flags & #MYTABLE_COLUMN_FLAGS_DATE_TIME)
				*this\format="%dd.%mm.%yyyy %hh:%ii:%ss"
			EndIf
			If Bool(flags & #MYTABLE_COLUMN_FLAGS_TIME)
				*this\format="%hh:%ii"
			EndIf
			If Bool(flags & #MYTABLE_COLUMN_FLAGS_TIME_LONG)
				*this\format="%hh:%ii:%ss"
			EndIf
			_MyTable_Table_Redraw(*this\table)
		EndIf
	EndIf
EndProcedure


Procedure.b _MyTable_Col_GetCanNull(*this.strMyTableCol)
	
	If *this
		
		ProcedureReturn *this\canNull
	EndIf
EndProcedure

Procedure _MyTable_Col_GetWidth(*this.strMyTableCol)
	
	If *this
		
		ProcedureReturn *this\width
	EndIf
EndProcedure



Procedure _MyTable_Col_GetImage(*this.strMyTableCol)
	
	If *this
		
		ProcedureReturn *this\image
	EndIf
EndProcedure

Procedure _MyTable_Col_GetData(*this.strMyTableCol)
	
	If *this
		
		ProcedureReturn *this\data
	EndIf
EndProcedure

Procedure _MyTable_Col_GetSort(*this.strMyTableCol)
	
	If *this
		
		ProcedureReturn *this\sort
	EndIf
EndProcedure

Procedure _MyTable_Col_GetID(*this.strMyTableCol)
	ProcedureReturn *this\id
EndProcedure

Procedure _MyTable_Col_SetCustomCellEdit(*this.strMyTableCol,evtCustomEditCell.MyTableProtoEventCustomEditCell,evtCancelCustomEditCell.MyTableProtoEventCancelCustomEditCell)
	If *this

		*this\evtCustomEditCell=evtCustomEditCell
		*this\evtCancelCustomEditCell=evtCancelCustomEditCell
		
	EndIf
EndProcedure

Procedure _MyTable_Col_SetSelectedbackground(*this.strMyTableRow,color.q)
	
	If *this
		If *this\selectedbackground<>color
			*this\selectedbackground=color
			*this\dirty=#True
			_MyTable_Table_Redraw(*this\table)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Col_SetBackground(*this.strMyTableRow,color.q)
	
	If *this
		If *this\background<>color
			*this\background=color
			*this\dirty=#True
			_MyTable_Table_Redraw(*this\table)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Col_SetBackgroundFixed(*this.strMyTableRow,color.q)
	
	If *this
		If *this\backgroundfixed<>color
			*this\backgroundfixed=color
			*this\dirty=#True
			_MyTable_Table_Redraw(*this\table)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Col_SetHeaderbackground1(*this.strMyTableRow,color.q)
	
	If *this
		If *this\headerbackground1<>color
			*this\headerbackground1=color
			*this\dirty=#True
			_MyTable_Table_Redraw(*this\table)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Col_SetHeaderbackground2(*this.strMyTableRow,color.q)
	
	If *this
		If *this\headerbackground2<>color
			*this\headerbackground2=color
			*this\dirty=#True
			_MyTable_Table_Redraw(*this\table)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Col_SetHeaderbackgroundFixed(*this.strMyTableRow,color.q)
	
	If *this
		If *this\headerbackgroundfixed<>color
			*this\headerbackgroundfixed=color
			*this\dirty=#True
			_MyTable_Table_Redraw(*this\table)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Col_SetForecolor(*this.strMyTableRow,color.q)
	
	If *this
		If *this\forecolor<>color
			*this\forecolor=color
			*this\dirty=#True
			_MyTable_Table_Redraw(*this\table)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Col_SetHeaderforecolor(*this.strMyTableRow,color.q)
	
	If *this
		If *this\headerforecolor<>color
			*this\headerforecolor=color
			*this\dirty=#True
			_MyTable_Table_Redraw(*this\table)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Col_SetSelectedforecolor(*this.strMyTableRow,color.q)
	
	If *this
		If *this\selectedforecolor<>color
			*this\selectedforecolor=color
			*this\dirty=#True
			_MyTable_Table_Redraw(*this\table)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Col_SetFont(*this.strMyTableRow,font.i)
	
	If *this
		If *this\font<>font And IsFont(font)
			*this\font=font
			*this\dirty=#True
			_MyTable_Table_Recalc(*this\table)
		EndIf
	EndIf
EndProcedure

Procedure.q _MyTable_Col_GetSelectedbackground(*this.strMyTableCol)
	
	If *this
		ProcedureReturn *this\selectedbackground
	EndIf
EndProcedure

Procedure.q _MyTable_Col_GetBackground(*this.strMyTableCol)
	
	If *this
		ProcedureReturn *this\background
	EndIf
EndProcedure

Procedure.q _MyTable_Col_GetBackgroundFixed(*this.strMyTableCol)
	
	If *this
		ProcedureReturn *this\backgroundfixed
	EndIf
EndProcedure

Procedure.q _MyTable_Col_GetHeaderbackground1(*this.strMyTableCol)
	
	If *this
		ProcedureReturn *this\headerbackground1
	EndIf
EndProcedure

Procedure.q _MyTable_Col_GetHeaderbackground2(*this.strMyTableCol)
	
	If *this
		ProcedureReturn *this\headerbackground2
	EndIf
EndProcedure

Procedure.q _MyTable_Col_GetHeaderbackgroundFixed(*this.strMyTableCol)
	
	If *this
		ProcedureReturn *this\headerbackgroundfixed
	EndIf
EndProcedure

Procedure.q _MyTable_Col_GetForecolor(*this.strMyTableCol)
	
	If *this
		ProcedureReturn *this\forecolor
	EndIf
EndProcedure

Procedure.q _MyTable_Col_GetHeaderforecolor(*this.strMyTableCol)
	
	If *this
		ProcedureReturn *this\headerforecolor
	EndIf
EndProcedure

Procedure.q _MyTable_Col_GetSelectedforecolor(*this.strMyTableCol)
	
	If *this
		ProcedureReturn *this\selectedforecolor
	EndIf
EndProcedure

Procedure _MyTable_Col_GetFont(*this.strMyTableCol)
	
	If *this
		ProcedureReturn *this\font
	EndIf
EndProcedure

Procedure _MyTable_Col_Dirty(*this.strMyTableCol)
	*this\dirty=#True
EndProcedure