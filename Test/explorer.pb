EnableExplicit

XIncludeFile "declare.pb"


UseModule MyTable
	UseModule MySplitter
		UseModule MyToolbar
			UseModule MyFont
				
				Global window=OpenWindow(#PB_Any,0,0,800,600,"Explorer (lookalike)",#PB_Window_SystemMenu|#PB_Window_ScreenCentered|#PB_Window_SizeGadget|#PB_Window_MaximizeGadget|#PB_Window_MinimizeGadget)
				
				
				Repeat:Until WaitWindowEvent()=#PB_Event_CloseWindow
				
			UnuseModule MyFont
		UnuseModule MyToolbar
	UnuseModule MySplitter
UnuseModule MyTable