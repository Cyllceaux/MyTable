Procedure.s _MyTableGridColumnName(col.i)
	Protected ac=Asc("A")
	Protected result.s=""	
	While col > 0
		Protected ic = col % 26
		If ic = 0
			result + "Z"
			col = (col / 26) - 1
		Else
			result + Chr(ac+(ic-1))
			col = col / 26
		EndIf
	Wend
	
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

Procedure _MyTable_Grid_ResizeGrid(*this.strMyTableTable,rows.i=#PB_Ignore,cols.i=#PB_Ignore)
	If *this
		Protected cc
		_callcountStart()
		If rows<>#PB_Ignore
			While ListSize(*this\rows())>rows
				LastElement(*this\rows())
				DeleteElement(*this\rows())
			Wend		
			cc=rows-ListSize(*this\rows())
			_MyTable_Table_AddDirtyRows(*this,cc)
			ForEach *this\rows()
				Protected *cell.strMyTableCell=_MyTableGetOrAddCell(*this\rows(),0,#True)
				*cell\value=ListIndex(*this\rows())+1
				*cell\text=Str(*cell\value)
				*cell\textwidth=0
				*cell\textheight=0
				*cell\dirty=#True
			Next
		EndIf
		If cols<>#PB_Ignore
			While ListSize(*this\cols())>(cols+1)
				LastElement(*this\cols())
				DeleteElement(*this\cols())
			Wend		
			cc=(cols+1)-ListSize(*this\cols())
			While cc>0
				_MyTable_Table_AddCol(*this,"",100)				
				cc-1
			Wend
			ForEach *this\cols()
				If ListIndex(*this\cols())>0
					*this\cols()\listindex=ListIndex(*this\cols())
					*this\cols()\text=_MyTableGridColumnName(*this\cols()\listindex)
					*this\cols()\dirty=#True
				EndIf
			Next
		EndIf
		_callcountEnde()
		*this\dirty=#True
		_MyTable_Table_Predraw(*this)
		_MyTable_Col_Autosize(FirstElement(*this\cols()))
		_MyTable_Table_Redraw(*this)
	EndIf
EndProcedure