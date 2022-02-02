EnableExplicit

XIncludeFile "declare.pb"


UseModule MyToolbar
	UseModule MyFont
		UseModule MyImage
			
			Global window=OpenWindow(#PB_Any,0,0,800,600,"Toolbar",#PB_Window_SystemMenu|#PB_Window_ScreenCentered|#PB_Window_SizeGadget|#PB_Window_MaximizeGadget|#PB_Window_MinimizeGadget)
			
			
			Repeat:Until WaitWindowEvent()=#PB_Event_CloseWindow
			
		UnuseModule MyImage
	UnuseModule MyFont
UnuseModule MyToolbar
