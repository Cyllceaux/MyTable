;/ ===========================
;/ =   mytableapplication.pb =
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


Procedure _MyTable_Application_Register(*application.strMyTableApplication,window,canvas,hscroll,vscroll,flags.i=#MYTABLE_TABLE_FLAGS_DEFAULT,callback.MyTableProtoEventCallback=0,name.s="")
	Protected *this.strMyTableTable=_MyTableRegister(*application,window,canvas,hscroll,vscroll,flags,callback,name)
	BindGadgetEvent(canvas,@MyTableEvtResize(),#PB_EventType_Resize)
	_MyTableResize(*this)
	
	ProcedureReturn *this
EndProcedure

Procedure _MyTable_Application_RegisterDialog(*application.strMyTableApplication,window,canvas,hscroll,vscroll,flags.i=#MYTABLE_TABLE_FLAGS_DEFAULT,callback.MyTableProtoEventCallback=0,name.s="")
	Protected *this.strMyTableTable=_MyTableRegister(*application,window,canvas,hscroll,vscroll,flags,callback,name)	
	BindGadgetEvent(canvas,@MyTableEvtDialogResize(),#PB_EventType_Resize)
	_MyTable_Table_Recalc(*this)
	ProcedureReturn *this
EndProcedure

Procedure _MyTable_Application_GridRegister(*application.strMyTableApplication,window,canvas,hscroll,vscroll,rows.i,cols.i,flags.i=#MYTABLE_TABLE_FLAGS_GRID_DEFAULT,callback.MyTableProtoEventCallback=0,name.s="")
	Protected *this.strMyTableTable=_MyTableGridRegister(*application,window,canvas,hscroll,vscroll,rows,cols,flags,callback,name)
	BindGadgetEvent(canvas,@MyTableEvtResize(),#PB_EventType_Resize)
	_MyTableResize(*this)
	ProcedureReturn *this
EndProcedure

Procedure _MyTable_Application_GridRegisterDialog(*application.strMyTableApplication,window,canvas,hscroll,vscroll,rows.i,cols.i,flags.i=#MYTABLE_TABLE_FLAGS_GRID_DEFAULT,callback.MyTableProtoEventCallback=0,name.s="")
	Protected *this.strMyTableTable=_MyTableGridRegister(*application,window,canvas,hscroll,vscroll,rows,cols,flags,callback,name)	
	BindGadgetEvent(canvas,@MyTableEvtDialogResize(),#PB_EventType_Resize)
	_MyTable_Table_Recalc(*this)
	ProcedureReturn *this
EndProcedure

Procedure _MyTable_Application_Unregister(*this.strMyTableApplication)
	If *this
		While ListSize(*this\tables())>0
			_MyTable_Table_Unregister(*this\tables())
		Wend
		FreeStructure(*this)
	EndIf
EndProcedure