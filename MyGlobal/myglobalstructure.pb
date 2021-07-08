Structure strMy
	vtable.i
	type.i
	flags.i
EndStructure

Structure strMyGadget Extends strMy
	window.i
	canvas.i
	redraw.b
	
	x.i
	y.i
	w.i
	h.i
EndStructure

Structure strMyScrollableGadget Extends strMyGadget
	vscroll.i
	hscroll.i
	
	maxvscroll.i
	maxhscroll.i
EndStructure