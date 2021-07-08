Structure strMy
	vtable.i
	type.i
EndStructure

Structure strMyGadget Extends strMy
	canvas.i
EndStructure

Structure strMyScrollableGadget Extends strMyGadget
	vscroll.i
	hscroll.i
	
	maxvscroll.i
	maxhscroll.i
EndStructure