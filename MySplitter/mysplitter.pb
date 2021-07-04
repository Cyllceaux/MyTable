Module MySplitter	
	EnableExplicit	
	
	IncludeFile "mysplitterstructure.pb"
	IncludeFile "../MyGlobal/myglobalmacro.pb"
	IncludeFile "../MyGlobal/myglobaldeclare.pb"
	IncludeFile "mysplitterdeclare.pb"
	IncludeFile "mysplitterautodeclare.pb"
	IncludeFile "mysplitterglobal.pb"
	IncludeFile "mysplittersplitter.pb"
	IncludeFile "../MyGlobal/myglobalglobal.pb"
	
	DataSection
		vtable_splitter: ;- Splitter
		_DataSectionGetter(MySplitter,splitter,Type)
		_DataSectionSetterGetter(MySplitter,splitter,Flags)
		_DataSectionSetterGetter(MySplitter,splitter,Value)
		_DataSectionSetterGetter(MySplitter,splitter,Gadget1)
		_DataSectionSetterGetter(MySplitter,splitter,Gadget2)
		_DataSectionSetterGetter(MySplitter,splitter,MinSizeGadget1)
		_DataSectionSetterGetter(MySplitter,splitter,MinSizeGadget2)
		_DataSectionSetterGetter(MySplitter,splitter,SeparatorSize)
		_DataSectionMethode(MySplitter,splitter,Resize)
		
		_DataSectionMethode(MySplitter,splitter,BindEventCustomDraw)
	EndDataSection
EndModule
