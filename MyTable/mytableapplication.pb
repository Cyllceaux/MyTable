_MyTableSimpleSetterGetter(Application,Tooltip,s)
_MyTableSimpleSetterGetter(Application,Dirty,b)
_MyTableSimpleSetterGetter(Application,Disabled,b)
_MyTableSimpleSetterGetter(Application,Flags,i)
_MyTableSimpleSetterGetterPointer(Application,Data)
_MyTableSimpleGetter(Application,Type,i)


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

Procedure _MyTable_Application_AddTree(*this.strMyTableApplication,window.i,canvas.i,vscroll.i,hscroll.i,name.s="",flags.i=#MYTABLE_TABLE_FLAGS_DEFAULT_TREE)
	If *this
		*this\lastindex+1
		Protected *table.strMyTableTree=AddElement(*this\tables())
		_MyTableInitTree(*this,*table,window,canvas,vscroll,hscroll,flags)
		Protected nname.s=_MyTableCleanName(name)
		
		If nname=""
			While _MyTable_Application_HasName(*this,"Tree"+*this\lastindex)
				*this\lastindex+1
			Wend
			*table\name="Tree"+*this\lastindex
		Else
			If _MyTable_Application_HasName(*this,nname)
				While _MyTable_Application_HasName(*this,"Tree"+*this\lastindex)
					*this\lastindex+1
				Wend
				*table\name="Tree"+*this\lastindex
			Else
				*table\name=nname
			EndIf
		EndIf
		ProcedureReturn *table
	EndIf
EndProcedure

Procedure _MyTable_Application_AddGrid(*this.strMyTableApplication,window.i,canvas.i,vscroll.i,hscroll.i,rows.i,cols.i,name.s="",flags.i=#MYTABLE_TABLE_FLAGS_DEFAULT_GRID)
	If *this
		*this\lastindex+1
		Protected *table.strMyTableGrid=AddElement(*this\tables())
		_MyTableInitGrid(*this,*table,window,canvas,vscroll,hscroll,rows,cols,flags)
		Protected nname.s=_MyTableCleanName(name)
		
		If nname=""
			While _MyTable_Application_HasName(*this,"Grid"+*this\lastindex)
				*this\lastindex+1
			Wend
			*table\name="Grid"+*this\lastindex
		Else
			If _MyTable_Application_HasName(*this,nname)
				While _MyTable_Application_HasName(*this,"Grid"+*this\lastindex)
					*this\lastindex+1
				Wend
				*table\name="Grid"+*this\lastindex
			Else
				*table\name=nname
			EndIf
		EndIf
		ProcedureReturn *table
	EndIf
EndProcedure

Procedure _MyTable_Application_AddNewTable(*this.strMyTableApplication,x.i,y.i,w.i,h.i,name.s="",flags.i=#MYTABLE_TABLE_FLAGS_DEFAULT_TABLE)
	Protected window=GetActiveWindow()
	Protected canvas=CanvasGadget(#PB_Any,x,y,w,h,#PB_Canvas_Container|#PB_Canvas_Keyboard)
	Protected hscroll=ScrollBarGadget(#PB_Any,0,0,0,20,0,0,0)
	Protected vscroll=ScrollBarGadget(#PB_Any,0,0,20,0,0,0,0,#PB_ScrollBar_Vertical)
	CloseGadgetList()
	
	ProcedureReturn _MyTable_Application_AddTable(*this,window,canvas,vscroll,hscroll,name,flags)
EndProcedure

Procedure _MyTable_Application_AddNewTree(*this.strMyTableApplication,x.i,y.i,w.i,h.i,name.s="",flags.i=#MYTABLE_TABLE_FLAGS_DEFAULT_TREE)
	Protected window=GetActiveWindow()
	Protected canvas=CanvasGadget(#PB_Any,x,y,w,h,#PB_Canvas_Container|#PB_Canvas_Keyboard)
	Protected hscroll=ScrollBarGadget(#PB_Any,0,0,0,20,0,0,0)
	Protected vscroll=ScrollBarGadget(#PB_Any,0,0,20,0,0,0,0,#PB_ScrollBar_Vertical)
	CloseGadgetList()
	
	ProcedureReturn _MyTable_Application_AddTree(*this,window,canvas,vscroll,hscroll,name,flags)
EndProcedure

Procedure _MyTable_Application_AddNewGrid(*this.strMyTableApplication,x.i,y.i,w.i,h.i,rows.i,cols.i,name.s="",flags.i=#MYTABLE_TABLE_FLAGS_DEFAULT_GRID)
	Protected window=GetActiveWindow()
	Protected canvas=CanvasGadget(#PB_Any,x,y,w,h,#PB_Canvas_Container|#PB_Canvas_Keyboard)
	Protected hscroll=ScrollBarGadget(#PB_Any,0,0,0,20,0,0,0)
	Protected vscroll=ScrollBarGadget(#PB_Any,0,0,20,0,0,0,0,#PB_ScrollBar_Vertical)
	CloseGadgetList()
	
	ProcedureReturn _MyTable_Application_AddGrid(*this,window,canvas,vscroll,hscroll,rows,cols,name,flags)
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


_MyTable_GetStylesApplication()


Procedure _MyTable_Application_Free(*this.strMyTableApplication)
	If *this
		While ListSize(*this\tables())>0
			FirstElement(*this\tables())
			_MyTable_Table_Delete(*this\tables())
		Wend
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

Procedure.b _MyTable_Application_Save(*this.strMyTableApplication,file.s)
	Protected xml=CreateXML(#PB_Any,#PB_UTF8)
	Protected *save.strMyTableSaveApplication=AllocateStructure(strMyTableSaveApplication)
	_MyTableSaveApp(*this,*save)
	InsertXMLStructure(RootXMLNode(xml),*save,strMyTableSaveApplication)
	SetXMLEncoding(xml,#PB_UTF8)
	SetXMLStandalone(xml,#PB_XML_StandaloneYes)
	FormatXML(xml,#PB_XML_ReFormat|#PB_XML_ReIndent)
	Protected result.b=Bool(SaveXML(xml,file)<>#False)
	FreeXML(xml)
	ProcedureReturn result
EndProcedure