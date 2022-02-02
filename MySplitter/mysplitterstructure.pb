IncludeFile "../MyGlobal/myglobalstructure.pb"

Structure strMySplitterSplitter Extends strMyGadget
	value.i
	
	gadget1.i
	gadget2.i
	x.i
	y.i
	w.i
	h.i
	minsizegadget1.i
	minsizegadget2.i	
	separatorsize.i
	
	oldx.i
	oldy.i
	*EventCustomDraw.MySplitterProtoEventCustomDraw
EndStructure