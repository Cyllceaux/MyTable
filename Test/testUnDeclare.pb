
CompilerIf Not #NO_WINDOW
	Repeat:Until WaitWindowEvent()=#PB_Event_CloseWindow
CompilerEndIf

UnuseModule MyTemplate:UnuseModule My:UnuseModule MyFont:UnuseModule MyImage:UnuseModule MyText:UnuseModule MyStyle