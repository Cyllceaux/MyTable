Procedure _MyTable_Application_GetType(*this.strMyTableApplication)
	If *this
		ProcedureReturn *this\type
	EndIf
EndProcedure

Procedure _MyTable_Application_GetFlags(*this.strMyTableApplication)
	If *this
		ProcedureReturn *this\flags
	EndIf
EndProcedure

Procedure _MyTable_Application_SetFlags(*this.strMyTableApplication,value.i)
	If *this
		*this\flags=value
	EndIf
EndProcedure

Procedure.b _MyTable_Application_HasName(*this.strMyTableApplication,name.s)
	ForEach *this\tables()
		If LCase(*this\tables()\name)=LCase(name)
			ProcedureReturn #True
		EndIf
	Next
	ProcedureReturn #False
EndProcedure

Procedure _MyTable_Application_AddTable(*this.strMyTableApplication,window.i,canvas.i,vscroll.i,hscroll.i,name.s="",flags.i=#MYTABLE_TABLE_FLAGS_DEFAULT_TABLE)
	If *this
		*this\lastindex+1
		Protected *table.strMyTableTable=AddElement(*this\tables())
		_MyTableInitTable(*this,*table,window,canvas,vscroll,hscroll,flags)
		Protected nname.s=_MyTableCleanName(name)
		
		If nname=""
			While _MyTable_Application_HasName(*this,"Table"+*this\lastindex)
				*this\lastindex+1
			Wend
			*table\name="Table"+*this\lastindex
		Else
			If _MyTable_Application_HasName(*this,nname)
				While _MyTable_Application_HasName(*this,"Table"+*this\lastindex)
					*this\lastindex+1
				Wend
				*table\name="Table"+*this\lastindex
			Else
				*table\name=nname
			EndIf
		EndIf
		ProcedureReturn *table
	EndIf
EndProcedure

Procedure _MyTable_Application_GetData(*this.strMyTableApplication)
	If *this
		ProcedureReturn *this\data
	EndIf
EndProcedure

Procedure _MyTable_Application_SetData(*this.strMyTableApplication,*value)
	If *this
		*this\data=*value
	EndIf
EndProcedure

Procedure _MyTable_Application_Redraw(*this.strMyTableApplication)
	If *this
		ForEach *this\tables()
			*this\tables()\dirty=#True
			_MyTable_Table_Redraw(*this\tables())
		Next
	EndIf
EndProcedure

Procedure.b _MyTable_Application_GetRedraw(*this.strMyTableApplication)
	If *this
		ProcedureReturn *this\redraw
	EndIf
EndProcedure

Procedure _MyTable_Application_SetRedraw(*this.strMyTableApplication,value.b)
	If *this
		*this\redraw=value
		If value
			_MyTable_Application_Redraw(*this)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Application_Recalc(*this.strMyTableApplication)
	If *this
		ForEach *this\tables()
			*this\tables()\dirty=#True
			_MyTable_Table_Recalc(*this\tables())
		Next
	EndIf
EndProcedure

Procedure.b _MyTable_Application_GetRecalc(*this.strMyTableApplication)
	If *this
		ProcedureReturn *this\recalc
	EndIf
EndProcedure

Procedure _MyTable_Application_SetRecalc(*this.strMyTableApplication,value.b)
	If *this
		*this\recalc=value
		If value
			_MyTable_Application_Recalc(*this)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Application_ClearTables(*this.strMyTableApplication)
	If *this
		ClearList(*this\tables())
	EndIf
EndProcedure

Procedure _MyTable_Application_GetDirty(*this.strMyTableApplication)
	If *this
		ProcedureReturn *this\dirty
	EndIf
EndProcedure

Procedure _MyTable_Application_SetDirty(*this.strMyTableApplication,value.b)
	If *this
		*this\dirty=value
	EndIf
EndProcedure

Procedure _MyTable_Application_GetStyle(*this.strMyTableApplication)
	Protected *style.strMyTableStyleObject=AllocateStructure(strMyTableStyleObject)
	_MyTableInitStyleObject(*style,*this)
	ProcedureReturn *style
EndProcedure

Procedure _MyTable_Application_Free(*this.strMyTableApplication)
	If *this
		FreeStructure(*this)
	EndIf
EndProcedure

Procedure.b _MyTable_Application_GetSelected(*this.strMyTableApplication)
	If *this
		Protected result.b=#True
		ForEach *this\tables()
			result=Bool(result And _MyTable_Table_GetSelected(*this\tables()))
		Next
		ProcedureReturn result
	EndIf
EndProcedure

Procedure _MyTable_Application_SetSelected(*this.strMyTableApplication,value.b)
	If *this
		ForEach *this\tables()
			_MyTable_Table_SetSelected(*this\tables(),value)
		Next
	EndIf
EndProcedure

Procedure _MyTable_Application_Autosize(*this.strMyTableApplication)
	If *this
		ForEach *this\tables()
			_MyTable_Table_Autosize(*this\tables())
		Next
	EndIf
EndProcedure