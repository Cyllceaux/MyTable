Structure strMyVTable
	vtable.i
	type.i
EndStructure

Structure strMyGadget Extends strMyVTable
	window.i
	canvas.i
	flags.i
EndStructure

Structure strMyScrollGadget Extends strMyGadget
	vscroll.i
	hscroll.i
	maxvscroll.i
	maxhscroll.i
EndStructure