XIncludeFile "../template.pbi"
XIncludeFile "../my.pbi"
XIncludeFile "../myfont.pbi"
XIncludeFile "../myimage.pbi"


Macro AssertEquals(val1,val2)
	If val1<>val2
		DebuggerWarning("Not EQ")
	EndIf
EndMacro

Macro AssertNotEquals(val1,val2)
	If val1=val2
		DebuggerWarning("EQ")
	EndIf
EndMacro