EnableExplicit

XIncludeFile "declare.pb"

CompilerIf #PB_Compiler_OS=#PB_OS_Windows
#SEP="\"	
CompilerElse
#SEP="/"	
CompilerEndIf

Global compiler.s=#PB_Compiler_Home+#SEP+"Compilers"+#SEP+"pbcompiler"

Global errorlines.s=""
Procedure runFile(file.s)
	Protected line.s="-k -q "+file
	Protected errorline.s=""
	Protected comp=RunProgram(compiler,line,#PB_Compiler_FilePath,#PB_Program_Open | #PB_Program_Read | #PB_Program_Hide)
	While ProgramRunning(comp)
		If AvailableProgramOutput(comp)
			If errorline=""
				errorline=file+#CRLF$
			EndIf
			errorline+ReadProgramString(comp)+#CRLF$
		EndIf
	Wend
	CloseProgram(comp)
	If errorline<>""
		errorlines+errorline
	EndIf
EndProcedure

Define dir=ExamineDirectory(#PB_Any,#PB_Compiler_FilePath,"*.pb")
If dir
	While NextDirectoryEntry(dir)
		runFile(DirectoryEntryName(dir))
	Wend
	FinishDirectory(dir)
EndIf
If errorlines<>""
	MessageRequester("Fehler",errorlines,#PB_MessageRequester_Error)
Else
	MessageRequester("OK","OK",#PB_MessageRequester_Info)
EndIf