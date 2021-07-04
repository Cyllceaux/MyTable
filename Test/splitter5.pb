EnableExplicit

XIncludeFile "declare.pb"

UseModule MySplitter
	
	Global window=OpenWindow(#PB_Any,0,0,800,600,"Splitter5",#PB_Window_SystemMenu|#PB_Window_ScreenCentered|#PB_Window_SizeGadget|#PB_Window_MaximizeGadget|#PB_Window_MinimizeGadget)
	Global *splitter.MySplitter=MySplitterCreateSplitter(0,0,WindowWidth(window),WindowHeight(window),0,0,#MYSPLITTER_FLAGS_VERTICAL)
	
	
	*splitter\SetGadget1(ButtonGadget(#PB_Any,0,0,0,0,"First"))
	*splitter\SetGadget2(ButtonGadget(#PB_Any,0,0,0,0,"Second"))
	
	Procedure.b CustomDraw(*splitter.MySplitter)
		Box(0,0,OutputWidth(),OutputHeight(),#Red)
		ProcedureReturn #True
	EndProcedure
	
	*splitter\BindCustomDraw(@CustomDraw())
	
	Procedure resize()
		*splitter\Resize(#PB_Ignore,#PB_Ignore,WindowWidth(window),WindowHeight(window))
	EndProcedure
	
	BindEvent(#PB_Event_SizeWindow,@resize())
	BindEvent(#PB_Event_MaximizeWindow,@resize())
	BindEvent(#PB_Event_RestoreWindow,@resize())
	
	Repeat:Until WaitWindowEvent()=#PB_Event_CloseWindow

UnuseModule MySplitter