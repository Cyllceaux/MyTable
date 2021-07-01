CompilerIf Defined(AUTODECLARE,#PB_Constant) And #PB_Compiler_Debugger
	CompilerIf #AUTODECLARE
		DeclareModule AUTODECLARE
			Structure strAutodeclare
				List autodeclare.s()
			EndStructure
			Global NewMap autodeclare.strAutodeclare()
		EndDeclareModule
		Module AUTODECLARE:EndModule
	CompilerEndIf
CompilerEndIf