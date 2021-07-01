CompilerIf Defined(MYTABLE_DEBUG,#PB_Constant) And #PB_Compiler_Debugger
	CompilerIf #MYTABLE_DEBUG
		DeclareModule MYTABLE_DEBUG:EndDeclareModule:Module MYTABLE_DEBUG:EndModule
		DeclareModule MYTABLE_DEBUG_MS_MAX:#MYTABLE_DEBUG_MS_MAX=200:EndDeclareModule:Module MYTABLE_DEBUG_MS_MAX:EndModule
		
		CompilerIf Not Defined(MYTABLE_DEBUG_LEVEL,#PB_Constant)
			#MYTABLE_DEBUG_LEVEL=0
			
		CompilerEndIf
	CompilerEndIf
CompilerEndIf


CompilerIf Defined(MYTABLE_DEBUG_LEVEL,#PB_Constant) And Defined(MYTABLE_DEBUG,#PB_Module) And #PB_Compiler_Debugger
	CompilerSelect #MYTABLE_DEBUG_LEVEL
			CompilerCase 1: DeclareModule MYTABLE_DEBUG_LEVEL:#MYTABLE_DEBUG_LEVEL=1:EndDeclareModule:Module MYTABLE_DEBUG_LEVEL:EndModule
			CompilerCase 2: DeclareModule MYTABLE_DEBUG_LEVEL:#MYTABLE_DEBUG_LEVEL=2:EndDeclareModule:Module MYTABLE_DEBUG_LEVEL:EndModule
			CompilerCase 3: DeclareModule MYTABLE_DEBUG_LEVEL:#MYTABLE_DEBUG_LEVEL=3:EndDeclareModule:Module MYTABLE_DEBUG_LEVEL:EndModule
			CompilerCase 4: DeclareModule MYTABLE_DEBUG_LEVEL:#MYTABLE_DEBUG_LEVEL=4:EndDeclareModule:Module MYTABLE_DEBUG_LEVEL:EndModule
			CompilerCase 5: DeclareModule MYTABLE_DEBUG_LEVEL:#MYTABLE_DEBUG_LEVEL=5:EndDeclareModule:Module MYTABLE_DEBUG_LEVEL:EndModule
			CompilerCase 6: DeclareModule MYTABLE_DEBUG_LEVEL:#MYTABLE_DEBUG_LEVEL=6:EndDeclareModule:Module MYTABLE_DEBUG_LEVEL:EndModule
			CompilerCase 7: DeclareModule MYTABLE_DEBUG_LEVEL:#MYTABLE_DEBUG_LEVEL=7:EndDeclareModule:Module MYTABLE_DEBUG_LEVEL:EndModule
			CompilerCase 8: DeclareModule MYTABLE_DEBUG_LEVEL:#MYTABLE_DEBUG_LEVEL=8:EndDeclareModule:Module MYTABLE_DEBUG_LEVEL:EndModule
			CompilerCase 9: DeclareModule MYTABLE_DEBUG_LEVEL:#MYTABLE_DEBUG_LEVEL=9:EndDeclareModule:Module MYTABLE_DEBUG_LEVEL:EndModule
			CompilerDefault: DeclareModule MYTABLE_DEBUG_LEVEL:#MYTABLE_DEBUG_LEVEL=0:EndDeclareModule:Module MYTABLE_DEBUG_LEVEL:EndModule
	CompilerEndSelect
CompilerEndIf

CompilerIf Defined(AUTODECLARE,#PB_Constant) And #PB_Compiler_Debugger
	CompilerIf #AUTODECLARE
		DeclareModule AUTODECLARE
			Global NewList autodeclare.s()
		EndDeclareModule
		Module AUTODECLARE:EndModule
	CompilerEndIf
CompilerEndIf