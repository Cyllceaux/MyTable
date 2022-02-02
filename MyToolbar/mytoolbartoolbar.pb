_SimpleGetter(MyToolbar,Toolbar,Type,i)
_SimpleSetterGetterRedraw(MyToolbar,Toolbar,Flags,i)
_SimpleSetterGetterRedraw(MyToolbar,Toolbar,Dirty,b)
_SimpleSetterGetterPointer(MyToolbar,Toolbar,Data)

Procedure _MyToolbar_WinRepaint()
	ForEach gadgets()
		_MyToolbar_Toolbar_Draw(gadgets())
	Next
EndProcedure

Procedure _MyToolbarInitToolbar(*toolbar.strMyToolbarToolbar,window.i,canvas.i,flags.i)
	With *toolbar
		\flags=flags
		\type=My::#MY_TYPE_TOOLBAR
		\vtable=?vtable_toolbar		
		\window=window
		\canvas=canvas
		\dirty=#True
		
		SetGadgetData(\canvas,*toolbar)
		
		UnbindEvent(#PB_Event_Repaint,@_MyToolbar_WinRepaint(),\window)
		BindEvent(#PB_Event_Repaint,@_MyToolbar_WinRepaint(),\window)
		
		_MyToolbar_Toolbar_Redraw(*toolbar)
	EndWith
EndProcedure

Procedure _MyToolbar_Toolbar_Redraw(*toolbar.strMyToolbarToolbar)
	
EndProcedure

Procedure _MyToolbar_Toolbar_Draw(*toolbar.strMyToolbarToolbar)
	
EndProcedure

Procedure _MyToolbar_Toolbar_Free(*toolbar.strMyToolbarToolbar)
	
EndProcedure