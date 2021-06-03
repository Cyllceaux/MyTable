

Macro DQ
	"
EndMacro

Macro _makeTimestamp(name)
	CompilerIf #PB_Compiler_Debugger 
		CompilerIf #MYTABLE_DEBUG
			Debug "",#MYTABLE_DEBUG_LEVEL
			Debug "------------------"+DQ#name#DQ+"------Dauer: "+Str(ElapsedMilliseconds()-timestamp)+"ms -----------------------------------------------",#MYTABLE_DEBUG_LEVEL
			timestamp=ElapsedMilliseconds()
			Debug "",#MYTABLE_DEBUG_LEVEL
			
		CompilerEndIf
	CompilerEndIf
EndMacro