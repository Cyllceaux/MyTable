Macro MM
	"
EndMacro

CompilerIf #PB_Compiler_Debugger And Defined(AUTODECLARE,#PB_Module)
	Macro _AddAutoDeclare(name)
		AddElement(AUTODECLARE::autodeclare())		
		AUTODECLARE::autodeclare()=Trim(MM#name#MM)
		If Left(AUTODECLARE::autodeclare(),1)="."
			AUTODECLARE::autodeclare()="Declare"+AUTODECLARE::autodeclare()
		Else
			AUTODECLARE::autodeclare()="Declare "+AUTODECLARE::autodeclare()
		EndIf		
	EndMacro	
CompilerElse
	Macro _AddAutoDeclare(name):EndMacro
CompilerEndIf


;{
;- workaround for MacOS. thx to mestnyi (https://www.purebasic.fr/english/viewtopic.php?p=571500#p571500)
	Macro PB( _pb_function_name_ ) 
		_pb_function_name_
	EndMacro
	Macro ClipOutput(_x_,_y_,_width_,_height_)
		CompilerIf #PB_Compiler_OS <> #PB_OS_MacOS
			PB(ClipOutput)(_x_,_y_,_width_,_height_)
		CompilerEndIf
	EndMacro
	Macro UnclipOutput()
		CompilerIf #PB_Compiler_OS <> #PB_OS_MacOS
			PB(UnclipOutput)()
		CompilerEndIf
	EndMacro
	Macro DrawingFont(_font_id_)
		CompilerIf #PB_Compiler_OS = #PB_OS_MacOS
			If _font_id_
				PB(DrawingFont)(_font_id_)
			EndIf
		CompilerElse
			PB(DrawingFont)(_font_id_)
		CompilerEndIf
	EndMacro
;}



Macro _BindEvent(projekt,name)
	_AddAutoDeclare(_#projekt#_Table_BindEvent#name(*this.str#projekt#Table,event.MyTableProtoEvent#name))
	Procedure _#projekt#_Table_BindEvent#name(*this.str#projekt#Table,event.MyTableProtoEvent#name)
		If *this
			*this\Event#name=event
		EndIf
	EndProcedure
EndMacro


Macro _SimpleGetterPointer(projekt,gruppe,name)
	_AddAutoDeclare(_#projekt#_#gruppe#_Get#name(*this.str#projekt#gruppe))
	Procedure _#projekt#_#gruppe#_Get#name(*this.str#projekt#gruppe)
		If *this
			ProcedureReturn *this\name
		EndIf
	EndProcedure
EndMacro

Macro _SimpleGetter(projekt,gruppe,name,typ)
	_AddAutoDeclare(.typ _#projekt#_#gruppe#_Get#name(*this.str#projekt#gruppe))
	Procedure.typ _#projekt#_#gruppe#_Get#name(*this.str#projekt#gruppe)
		If *this
			ProcedureReturn *this\name
		EndIf
	EndProcedure
EndMacro

Macro _SimpleSetter(projekt,gruppe,name,typ)
	_AddAutoDeclare(_#projekt#_#gruppe#_Set#name(*this.str#projekt#gruppe,value.typ))
	Procedure _#projekt#_#gruppe#_Set#name(*this.str#projekt#gruppe,value.typ)
		If *this
			*this\name=value
			*this\dirty=#True
		EndIf
	EndProcedure
EndMacro

Macro _SimpleSetterPointer(projekt,gruppe,name)
	_AddAutoDeclare(_#projekt#_#gruppe#_Set#name(*this.str#projekt#gruppe,*value))
	Procedure _#projekt#_#gruppe#_Set#name(*this.str#projekt#gruppe,*value)
		If *this
			*this\name=*value
			*this\dirty=#True
		EndIf
	EndProcedure
EndMacro

Macro _SimpleSetterPointerStructure(projekt,gruppe,name,typ)
	_AddAutoDeclare(_#projekt#_#gruppe#_Set#name(*this.str#projekt#gruppe,*value.typ))
	Procedure _#projekt#_#gruppe#_Set#name(*this.str#projekt#gruppe,*value.typ)
		If *this
			*this\name=*value
			*this\dirty=#True
		EndIf
	EndProcedure
EndMacro

Macro _SimpleSetterRedraw(projekt,gruppe,name,typ)
	_AddAutoDeclare(_#projekt#_#gruppe#_Set#name(*this.str#projekt#gruppe,value.typ))
	Procedure _#projekt#_#gruppe#_Set#name(*this.str#projekt#gruppe,value.typ)
		If *this
			*this\name=value
			*this\dirty=#True			
			_#projekt#_Table_Redraw(*this)						
		EndIf
	EndProcedure
EndMacro

Macro _SimpleSetterSubRedraw(projekt,gruppe,name,typ)
	_AddAutoDeclare(_#projekt#_#gruppe#_Set#name(*this.str#projekt#gruppe,value.typ))
	Procedure _#projekt#_#gruppe#_Set#name(*this.str#projekt#gruppe,value.typ)
		If *this
			*this\name=value
			*this\dirty=#True			
			*this\table\dirty=#True
			_#projekt#_Table_Redraw(*this\table)						
		EndIf
	EndProcedure
EndMacro

Macro _SimpleSetterSubPredraw(projekt,gruppe,name,typ)
	_AddAutoDeclare(_#projekt#_#gruppe#_Set#name(*this.str#projekt#gruppe,value.typ))
	Procedure _#projekt#_#gruppe#_Set#name(*this.str#projekt#gruppe,value.typ)
		If *this
			*this\name=value
			*this\dirty=#True			
			*this\table\dirty=#True
			_#projekt#_Table_Predraw(*this\table)						
			_#projekt#_Table_Redraw(*this\table)						
		EndIf
	EndProcedure
EndMacro

Macro _SimpleSetterPredraw(projekt,gruppe,name,typ)
	_AddAutoDeclare(_#projekt#_#gruppe#_Set#name(*this.str#projekt#gruppe,value.typ))
	Procedure _#projekt#_#gruppe#_Set#name(*this.str#projekt#gruppe,value.typ)
		If *this
			*this\name=value
			*this\dirty=#True			
			*this\dirty=#True
			_#projekt#_Table_Predraw(*this)						
			_#projekt#_Table_Redraw(*this)						
		EndIf
	EndProcedure
EndMacro

Macro _SimpleSetterGetter(projekt,gruppe,name,typ)
	_SimpleGetter(projekt,gruppe,name,typ)
	_SimpleSetter(projekt,gruppe,name,typ)
EndMacro

Macro _SimpleSetterGetterRedraw(projekt,gruppe,name,typ)
	_SimpleGetter(projekt,gruppe,name,typ)
	_SimpleSetterRedraw(projekt,gruppe,name,typ)
EndMacro

Macro _SimpleSetterGetterPointer(projekt,gruppe,name)
	_SimpleGetterPointer(projekt,gruppe,name)
	_SimpleSetterPointer(projekt,gruppe,name)
EndMacro

Macro _SimpleSetterGetterPointerStructure(projekt,gruppe,name,typ)
	_SimpleGetterPointer(projekt,gruppe,name)
	_SimpleSetterPointerStructure(projekt,gruppe,name,typ)
EndMacro

Macro _SimpleSetterGetterSubRedraw(projekt,gruppe,name,typ)
	_SimpleGetter(projekt,gruppe,name,typ)
	_SimpleSetterSubRedraw(projekt,gruppe,name,typ)
EndMacro

Macro _SimpleSetterGetterSubPredraw(projekt,gruppe,name,typ)
	_SimpleGetter(projekt,gruppe,name,typ)
	_SimpleSetterSubPredraw(projekt,gruppe,name,typ)
EndMacro

Macro _SimpleSetterGetterPredraw(projekt,gruppe,name,typ)
	_SimpleGetter(projekt,gruppe,name,typ)
	_SimpleSetterPredraw(projekt,gruppe,name,typ)
EndMacro




Macro _DataSectionMethode(projekt,gruppe,methode)
	Data.i @_#projekt#_#gruppe#_#methode()
EndMacro

Macro _DataSectionSetter(projekt,gruppe,name)
	_DataSectionMethode(projekt,gruppe,Set#name)
EndMacro

Macro _DataSectionGetter(projekt,gruppe,name)
	_DataSectionMethode(projekt,gruppe,Get#name)
EndMacro

Macro _DataSectionSetterGetter(projekt,gruppe,name)
	_DataSectionSetter(projekt,gruppe,name)
	_DataSectionGetter(projekt,gruppe,name)
EndMacro
