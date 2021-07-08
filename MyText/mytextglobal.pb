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