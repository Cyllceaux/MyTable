CompilerIf Not Defined(NO_WINDOW,#PB_Constant)
	#NO_WINDOW=0
CompilerEndIf


XIncludeFile "../template.pbi"
XIncludeFile "../my.pbi"
XIncludeFile "../mystyle.pbi"
XIncludeFile "../myfont.pbi"
XIncludeFile "../myimage.pbi"
XIncludeFile "../mytext.pbi"


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

UseModule MyTemplate:UseModule My:UseModule MyFont:UseModule MyImage:UseModule MyText:UseModule MyStyle
						
						
CompilerIf Not #NO_WINDOW						
	Global window=OpenWindow(#PB_Any,0,0,800,600,"Text 1",#PB_Window_SystemMenu|#PB_Window_SizeGadget|#PB_Window_ScreenCentered|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget)
CompilerEndIf