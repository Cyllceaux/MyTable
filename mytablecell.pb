;/ ===========================
;/ =   mytablecell.pb       =
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

Procedure _MyTable_Cell_GetTable(*this.strMyTableCell)
	ProcedureReturn *this\table
EndProcedure

Procedure _MyTable_Cell_Dirty(*this.strMyTableCell)
	*this\dirty=#True
EndProcedure

Procedure _MyTable_Cell_GetType(*this.strMyTableCell)
	ProcedureReturn *this\type
EndProcedure

Procedure _MyTable_Cell_GetRow(*this.strMyTableCell)
	ProcedureReturn *this\row
EndProcedure

Procedure _MyTable_Cell_GetCol(*this.strMyTableCell)
	ProcedureReturn *this\col
EndProcedure

Procedure.s _MyTable_Cell_GetText(*this.strMyTableCell)
	If *this
		ProcedureReturn *this\text
	EndIf
EndProcedure

Procedure.s _MyTable_Cell_GetTooltip(*this.strMyTableCell)
	If *this	
		ProcedureReturn *this\tooltip
	EndIf
EndProcedure

Procedure.d _MyTable_Cell_GetValue(*this.strMyTableCell)
	If *this
		ProcedureReturn *this\value
	EndIf
EndProcedure

Procedure _MyTable_Cell_SetTooltip(*this.strMyTableCell,tooltip.s)
	If *this
		*this\tooltip=tooltip
	EndIf
EndProcedure

Procedure _MyTable_Cell_SetText(*this.strMyTableCell,text.s)
	
	If *this
		If *this\text<>text
			*this\text=text
			*this\textwidth=0
			*this\textheight=0
			*this\dirty=#True
			_MyTableFillCellText(*this,text)
			_MyTable_Table_Redraw(*this\table)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Cell_SetValue(*this.strMyTableCell,value.d)
	If *this
		If *this\value<>value		
			*this\value=value		
			*this\textwidth=0
			*this\textheight=0
			*this\dirty=#True
			_MyTableFillCellValue(*this,value)
			_MyTable_Table_Redraw(*this\table)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Cell_CellFlags(*this.strMyTableCell,flags.i)
	If *this
		If *this\flags<>flags		
			If *this\flags=*this\col\flags
				*this\flags=0
			Else
				*this\flags=flags		
			EndIf
			*this\textwidth=0
			*this\textheight=0
			*this\dirty=#True
			_MyTable_Table_Recalc(*this\table)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Cell_GetFlags(*this.strMyTableCell)
	If *this
		If *this\flags
			ProcedureReturn *this\flags
		Else
			ProcedureReturn *this\col\flags
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Cell_GetChecked(*this.strMyTableCell)
	If *this
		ProcedureReturn *this\checked
	EndIf
EndProcedure

Procedure _MyTable_Cell_GetData(*this.strMyTableCell)
	If *this
		ProcedureReturn *this\data
	EndIf
EndProcedure

Procedure _MyTable_Cell_GetImage(*this.strMyTableCell)
	If *this		
		ProcedureReturn *this\image
	EndIf
EndProcedure

Procedure _MyTable_Cell_SetChecked(*this.strMyTableCell,checked.b)
	If *this
		If *this\checked<>checked
			*this\value=checked		
			*this\checked=checked		
			*this\textwidth=0
			*this\textheight=0
			*this\dirty=#True				
			*this\text=Str(checked)		
			_MyTable_Table_Redraw(*this\table)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Cell_SetData(*this.strMyTableCell,*data)
	If *this
		*this\data=*data
	EndIf
EndProcedure


Procedure _MyTable_Cell_SetImage(*this.strMyTableCell,image.i)
	If *this
		If *this\image<>image
			*this\image=image		
			If IsImage(image)
				*this\textheight=ImageHeight(image)
				*this\textwidth=ImageWidth(image)
			Else
				*this\textheight=0
				*this\textwidth=0
			EndIf
			*this\dirty=#True							
			_MyTable_Table_Redraw(*this\table)
		EndIf
	EndIf
EndProcedure


Procedure _MyTable_Cell_SetFlags(*this.strMyTableCell,flags.i)
	If *this
		
		If *this\flags<>flags
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

Procedure _MyTable_Cell_SetFormat(*this.strMyTableCell,format.s)
	If *this
		If *this\format<>format
			*this\format=format
			*this\dirty=#True
			*this\textwidth=0
			*this\textheight=0
			*this\dirty=#True
			*this\table\dirty=#True
			_MyTableFillCellValue(*this,*this\value)			
			_MyTable_Table_Redraw(*this\table)
		EndIf
	EndIf
EndProcedure

Procedure.s _MyTable_Cell_GetFormat(*this.strMyTableCell)
	If *this
		If *this\format=""
			ProcedureReturn *this\col\format
		Else
			ProcedureReturn *this\format
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Cell_SetSelectedbackground(*this.strMyTableRow,color.q)
	
	If *this
		If *this\selectedbackground<>color
			*this\selectedbackground=color
			*this\dirty=#True
			_MyTable_Table_Redraw(*this\table)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Cell_SetBackground(*this.strMyTableRow,color.q)
	
	If *this
		If *this\background<>color
			*this\background=color
			*this\dirty=#True
			_MyTable_Table_Redraw(*this\table)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Cell_SetBackgroundFixed(*this.strMyTableRow,color.q)
	
	If *this
		If *this\backgroundfixed<>color
			*this\backgroundfixed=color
			*this\dirty=#True
			_MyTable_Table_Redraw(*this\table)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Cell_SetHeaderbackground1(*this.strMyTableRow,color.q)
	
	If *this
		If *this\headerbackground1<>color
			*this\headerbackground1=color
			*this\dirty=#True
			_MyTable_Table_Redraw(*this\table)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Cell_SetHeaderbackground2(*this.strMyTableRow,color.q)
	
	If *this
		If *this\headerbackground2<>color
			*this\headerbackground2=color
			*this\dirty=#True
			_MyTable_Table_Redraw(*this\table)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Cell_SetHeaderbackgroundFixed(*this.strMyTableRow,color.q)
	
	If *this
		If *this\headerbackgroundfixed<>color
			*this\headerbackgroundfixed=color
			*this\dirty=#True
			_MyTable_Table_Redraw(*this\table)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Cell_SetForecolor(*this.strMyTableRow,color.q)
	
	If *this
		If *this\forecolor<>color
			*this\forecolor=color
			*this\dirty=#True
			_MyTable_Table_Redraw(*this\table)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Cell_SetHeaderforecolor(*this.strMyTableRow,color.q)
	
	If *this
		If *this\headerforecolor<>color
			*this\headerforecolor=color
			*this\dirty=#True
			_MyTable_Table_Redraw(*this\table)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Cell_SetSelectedforecolor(*this.strMyTableRow,color.q)
	
	If *this
		If *this\selectedforecolor<>color
			*this\selectedforecolor=color
			*this\dirty=#True
			_MyTable_Table_Redraw(*this\table)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Cell_SetFont(*this.strMyTableRow,font.i)
	
	If *this
		If *this\font<>font And IsFont(font)
			*this\font=font
			*this\dirty=#True
			_MyTable_Table_Recalc(*this\table)
		EndIf
	EndIf
EndProcedure

Procedure.q _MyTable_Cell_GetSelectedbackground(*this.strMyTableCell)
	
	If *this
		ProcedureReturn *this\selectedbackground
	EndIf
EndProcedure

Procedure.q _MyTable_Cell_GetBackground(*this.strMyTableCell)
	
	If *this
		ProcedureReturn *this\background
	EndIf
EndProcedure

Procedure.q _MyTable_Cell_GetBackgroundFixed(*this.strMyTableCell)
	
	If *this
		ProcedureReturn *this\backgroundfixed
	EndIf
EndProcedure

Procedure.q _MyTable_Cell_GetHeaderbackground1(*this.strMyTableCell)
	
	If *this
		ProcedureReturn *this\headerbackground1
	EndIf
EndProcedure

Procedure.q _MyTable_Cell_GetHeaderbackground2(*this.strMyTableCell)
	
	If *this
		ProcedureReturn *this\headerbackground2
	EndIf
EndProcedure

Procedure.q _MyTable_Cell_GetHeaderbackgroundFixed(*this.strMyTableCell)
	
	If *this
		ProcedureReturn *this\headerbackgroundfixed
	EndIf
EndProcedure

Procedure.q _MyTable_Cell_GetForecolor(*this.strMyTableCell)
	
	If *this
		ProcedureReturn *this\forecolor
	EndIf
EndProcedure

Procedure.q _MyTable_Cell_GetHeaderforecolor(*this.strMyTableCell)
	
	If *this
		ProcedureReturn *this\headerforecolor
	EndIf
EndProcedure

Procedure.q _MyTable_Cell_GetSelectedforecolor(*this.strMyTableCell)
	
	If *this
		ProcedureReturn *this\selectedforecolor
	EndIf
EndProcedure

Procedure _MyTable_Cell_GetFont(*this.strMyTableCell)
	
	If *this
		ProcedureReturn *this\font
	EndIf
EndProcedure