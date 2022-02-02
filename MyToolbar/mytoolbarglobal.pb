Global NewList gadgets.strMyToolbarToolbar()


Procedure MyToolbarCreateToolbar(window.i,canvas.i,flags.i=0)	
	Protected *this.strMyToolbarToolbar=AddElement(gadgets())
	_MyToolbarInitToolbar(*this,window,canvas,flags)
	ProcedureReturn *this
EndProcedure
	
Procedure  MyToolbarCreateNewToolbar(x.i,y.i,w.i,h.i,flags.i=0)	
	Protected window=GetActiveWindow()
	Protected canvas=CanvasGadget(#PB_Any,x,y,w,h,#PB_Canvas_Container|#PB_Canvas_Keyboard)
	CloseGadgetList()
	
	ProcedureReturn MyToolbarCreateToolbar(window,canvas,flags)
EndProcedure
