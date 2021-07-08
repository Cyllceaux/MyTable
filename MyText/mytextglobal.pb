IncludeFile "../MyGlobal/myglobalglobal.pb"

Procedure MyTextCreate(x.i,y.i,w.i,h.i,text.s)
	Protected *this.strMyTextText=AllocateStructure(strMyTextText)
	With *this
		\vtable=?vtable_mytext
		\text=text
		\canvas=CanvasGadget(#PB_Any,x,y,w,h,#PB_Canvas_Keyboard)
		\x=GadgetX(\canvas)
		\y=GadgetY(\canvas)
		\w=GadgetWidth(\canvas)
		\h=GadgetHeight(\canvas)
		\window=GetActiveWindow()
		\redraw=#True
		\style=MyStyle::MyStyleCreate()
	EndWith
	_MyText_Text_Redraw(*this)
	ProcedureReturn *this
EndProcedure

Procedure _MyText_DrawText(text.s,
                       x.i,
                       y.i,
                       w.i,
                       h.i,
                       textwidth.i,
                       textheight.i,
                       valign.i,
                       halign.i,
                       color.q)
	
	ClipOutput(x,y,w,h)
	
	If valign=MyStyle::#MYSTYLE_VALIGN_MIDDLE
		y+(h/2 - textheight/2)
	ElseIf valign=MyStyle::#MYSTYLE_VALIGN_BOTTOM
		y+h-textheight
	EndIf
	
	If halign=MyStyle::#MYSTYLE_HALIGN_CENTER
		x+(w/2-textwidth/2)
	ElseIf halign=MyStyle::#MYSTYLE_HALIGN_RIGHT
		x+w-textwidth
	EndIf
	
	DrawingMode(#PB_2DDrawing_Transparent)
	
	DrawText(x,y,text,color)
	UnclipOutput()
EndProcedure