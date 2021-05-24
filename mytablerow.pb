;/ ===========================
;/ =   mytablerow.pb       =
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

Procedure _MyTable_Row_GetID(*this.strMyTableRow)
	ProcedureReturn *this\id
EndProcedure

Procedure _MyTable_Row_GetType(*this.strMyTableRow)
	ProcedureReturn *this\type
EndProcedure

Procedure _MyTable_Row_GetCell(*this.strMyTableRow,col.i)
	ProcedureReturn _MyTableGetOrAddCell(*this,col)
EndProcedure

Procedure _MyTable_Row_GetTable(*this.strMyTableRow)
	ProcedureReturn *this\table
EndProcedure

Procedure _MyTable_Row_AddDirtyRows(*this.strMyTableRow,rows.i)
	If *this
		_callcountStart(addrowdirtyrows)
		Protected i=0
		Protected *row.strMyTableRow=0
		
		
		LastElement(*this\rows())
		For i=1 To rows
			*row=AddElement(*this\rows())					
			_MyTableAddDirtyRow(*this,*row)
			*this\level=*this\level+1
		Next
		
		*this\dirty=#True
		_callcountEnde(addrowdirtyrows)
		_MyTable_Table_Recalc(*this\table)
	EndIf	
EndProcedure

Procedure _MyTable_Row_SetImage(*this.strMyTableRow,image.i)
	
	If *this
		
		If *this\image<>image
			*this\image=image
			*this\dirty=#True
			*this\dirty=#True
			If IsImage(*this\sclaedimage)
				FreeImage(*this\sclaedimage)				
			EndIf
			If IsImage(image)				
				*this\sclaedimage=CopyImage(image,#PB_Any)
				ResizeImage(*this\sclaedimage,MyTableW16,MyTableH16)
			EndIf
			_MyTable_Table_Redraw(*this\table)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Row_SetData(*this.strMyTableRow,*data)
	
	If *this
		
		*this\data=*data		
	EndIf
EndProcedure

Procedure _MyTable_Row_SetTooltip(*this.strMyTableRow,tooltip.s)
	
	If *this
		
		*this\tooltip=tooltip		
	EndIf
EndProcedure


Procedure _MyTable_Row_SetDirty(*this.strMyTableRow)
	
	If *this
		
		*this\dirty=#True
		_MyTable_Table_Redraw(*this\table)
	EndIf
EndProcedure

Procedure _MyTable_Row_SetChecked(*this.strMyTableRow,checked.b)
	
	If *this
		
		If *this\checked<>checked
			*this\checked=checked
			*this\dirty=#True
			*this\dirty=#True
			_MyTable_Table_Redraw(*this\table)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Row_SetExpanded(*this.strMyTableRow,expanded.b)
	
	If *this
		
		If *this\expanded<>expanded
			*this\expanded=expanded
			*this\dirty=#True
			*this\dirty=#True
			_MyTable_Table_Recalc(*this\table)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Row_SetHeight(*this.strMyTableRow,height.i)
	
	If *this
		
		If *row
			If *this\height<>height
				*this\height=height
				*this\dirty=#True
				*this\dirty=#True
				_MyTable_Table_Recalc(*this\table)
			EndIf
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Row_GetImage(*this.strMyTableRow)
	
	If *this
		
		ProcedureReturn *this\image
	EndIf
EndProcedure

Procedure _MyTable_Row_GetData(*this.strMyTableRow)
	
	If *this
		
		ProcedureReturn *this\data
	EndIf
EndProcedure

Procedure.s _MyTable_Row_GetTooltip(*this.strMyTableRow)
	
	If *this
		
		ProcedureReturn *this\tooltip
	EndIf
EndProcedure

Procedure _MyTable_Row_GetHeight(*this.strMyTableRow)
	
	If *this
		
		ProcedureReturn *this\height
	EndIf
EndProcedure



Procedure.b _MyTable_Row_GetChecked(*this.strMyTableRow)
	
	If *this
		
		ProcedureReturn *this\checked
	EndIf
EndProcedure

Procedure.b _MyTable_Row_GetExpanded(*this.strMyTableRow)
	
	If *this
		
		ProcedureReturn *this\expanded
	EndIf
EndProcedure

Procedure _MyTable_Row_GetFlags(*this.strMyTableRow)
	If *this
		ProcedureReturn *this\flags
	EndIf
EndProcedure

Procedure _MyTable_Row_SetFlags(*this.strMyTableRow,flags.i)
	If *this
		
		If *this\flags<>flags
			*this\flags=flags
			*this\dirty=#True
			*this\dirty=#True
			*this\table\dirty=#True			
			_MyTable_Table_Redraw(*this\table)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Row_SetSelectedbackground(*this.strMyTableRow,color.q)
	
	If *this
		If *this\selectedbackground<>color
			*this\selectedbackground=color
			*this\dirty=#True
			_MyTable_Table_Redraw(*this\table)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Row_SetBackground(*this.strMyTableRow,color.q)
	
	If *this
		If *this\background<>color
			*this\background=color
			*this\dirty=#True
			_MyTable_Table_Redraw(*this\table)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Row_SetBackgroundFixed(*this.strMyTableRow,color.q)
	
	If *this
		If *this\backgroundfixed<>color
			*this\backgroundfixed=color
			*this\dirty=#True
			_MyTable_Table_Redraw(*this\table)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Row_SetHeaderbackground1(*this.strMyTableRow,color.q)
	
	If *this
		If *this\headerbackground1<>color
			*this\headerbackground1=color
			*this\dirty=#True
			_MyTable_Table_Redraw(*this\table)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Row_SetHeaderbackground2(*this.strMyTableRow,color.q)
	
	If *this
		If *this\headerbackground2<>color
			*this\headerbackground2=color
			*this\dirty=#True
			_MyTable_Table_Redraw(*this\table)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Row_SetHeaderbackgroundFixed(*this.strMyTableRow,color.q)
	
	If *this
		If *this\headerbackgroundfixed<>color
			*this\headerbackgroundfixed=color
			*this\dirty=#True
			_MyTable_Table_Redraw(*this\table)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Row_SetForecolor(*this.strMyTableRow,color.q)
	
	If *this
		If *this\forecolor<>color
			*this\forecolor=color
			*this\dirty=#True
			_MyTable_Table_Redraw(*this\table)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Row_SetHeaderforecolor(*this.strMyTableRow,color.q)
	
	If *this
		If *this\headerforecolor<>color
			*this\headerforecolor=color
			*this\dirty=#True
			_MyTable_Table_Redraw(*this\table)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Row_SetSelectedforecolor(*this.strMyTableRow,color.q)
	
	If *this
		If *this\selectedforecolor<>color
			*this\selectedforecolor=color
			*this\dirty=#True
			_MyTable_Table_Redraw(*this\table)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Row_SetFont(*this.strMyTableRow,font.i)
	
	If *this
		If *this\font<>font And IsFont(font)
			*this\font=font
			*this\dirty=#True
			_MyTable_Table_Recalc(*this\table)
		EndIf
	EndIf
EndProcedure

Procedure.q _MyTable_Row_GetSelectedbackground(*this.strMyTableRow)
	
	If *this
		ProcedureReturn *this\selectedbackground
	EndIf
EndProcedure

Procedure.q _MyTable_Row_GetBackground(*this.strMyTableRow)
	
	If *this
		ProcedureReturn *this\background
	EndIf
EndProcedure

Procedure.q _MyTable_Row_GetBackgroundFixed(*this.strMyTableRow)
	
	If *this
		ProcedureReturn *this\backgroundfixed
	EndIf
EndProcedure

Procedure.q _MyTable_Row_GetHeaderbackground1(*this.strMyTableRow)
	
	If *this
		ProcedureReturn *this\headerbackground1
	EndIf
EndProcedure

Procedure.q _MyTable_Row_GetHeaderbackground2(*this.strMyTableRow)
	
	If *this
		ProcedureReturn *this\headerbackground2
	EndIf
EndProcedure

Procedure.q _MyTable_Row_GetHeaderbackgroundFixed(*this.strMyTableRow)
	
	If *this
		ProcedureReturn *this\headerbackgroundfixed
	EndIf
EndProcedure

Procedure.q _MyTable_Row_GetForecolor(*this.strMyTableRow)
	
	If *this
		ProcedureReturn *this\forecolor
	EndIf
EndProcedure

Procedure.q _MyTable_Row_GetHeaderforecolor(*this.strMyTableRow)
	
	If *this
		ProcedureReturn *this\headerforecolor
	EndIf
EndProcedure

Procedure.q _MyTable_Row_GetSelectedforecolor(*this.strMyTableRow)
	
	If *this
		ProcedureReturn *this\selectedforecolor
	EndIf
EndProcedure

Procedure _MyTable_Row_GetFont(*this.strMyTableRow)
	
	If *this
		ProcedureReturn *this\font
	EndIf
EndProcedure

Procedure _MyTable_Row_AddRow(*this.strMyTableRow,text.s,sep.s="|",id.q=#PB_Ignore,image.i=0,*data=0,checked.b=#False,expanded.b=#False,tooltip.s="")
	If *this
		Protected *row.strMyTableRow=0
		Protected *cell.strMyTableCell=0
		Protected *col.strMyTableCol=0
		
		
		LastElement(*this\rows())
		*row=AddElement(*this\rows())
		
		With *row
			\vtable=?vtable_row
			\height=*this\table\rowheight
			\brow=#True
			\checked=checked
			\expanded=expanded
			\data=*data
			\image=image
			\type=#MYTABLE_TYPE_ROW
			\tooltip=tooltip
			\level=*this\level+1
			If IsImage(image)				
				\sclaedimage=CopyImage(image,#PB_Any)
				ResizeImage(\sclaedimage,MyTableW16,MyTableH16)
			EndIf
			If id=#PB_Ignore Or id<=*this\table\lastRowid
				*this\table\lastRowid+1
				\id=*this\table\lastRowid
			Else
				\id=id
				*this\table\lastRowid=id
			EndIf
			\dirty=#True
			\table=*this\table
			
			
			Protected i=0
			
			If text<>""
				Protected c=CountString(text,sep)+1
				If c=1
					*cell=_MyTableGetOrAddCell(*row,0)
					_MyTableFillCellText(*cell,text)
				Else
					For i=1 To c
						*cell=_MyTableGetOrAddCell(*row,i-1)
						_MyTableFillCellText(*cell,StringField(text,i,sep))
					Next
				EndIf
			EndIf
		EndWith
		*this\table\rowsById(Str(*row\id))=*row
		*this\dirty=#True
		_MyTable_Table_Recalc(*this\table)
		ProcedureReturn *row
	EndIf
EndProcedure

Procedure _MyTable_Row_GetRowHeight(*this.strMyTableRow)
	
	If *this
		ProcedureReturn *this\height
	EndIf
EndProcedure

Procedure _MyTable_Row_SetRowHeight(*this.strMyTableRow,rowheight.i)
	
	If *this
		Protected old=*this\height
		If *this\height<>rowheight
			*this\height=rowheight
			*this\dirty=#True
			*this\table\dirty=#True
			_MyTable_Table_Recalc(*this\table)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Row_Dirty(*this.strMyTableRow)
	*this\dirty=#True
EndProcedure