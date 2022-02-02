IncludeFile "../MyGlobal/myglobalstructure.pb"

Structure strMyToolbarButton Extends strMyVTable
	*data
	flags.i
	dirty.b
	*main.strMyToolbarToolbar
	text.s
	*image.MyImage::MyImage
EndStructure

Structure strMyToolbarToolbar Extends strMyGadget
	List buttons.strMyToolbarButton()
	*data
EndStructure