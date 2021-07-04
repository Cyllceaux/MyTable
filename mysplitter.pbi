XIncludeFile "my.pbi"

DeclareModule MySplitter
	
	#MYSPLITTER_VERSION = 128
	#MYSPLITTER_VERSION_DATE = 20210704
	
	EnumerationBinary _mysplitter_flags
		#MYSPLITTER_FLAGS_VERTICAL
		#MYSPLITTER_FLAGS_FIRSTFIXED
		#MYSPLITTER_FLAGS_SECONDFIXED
		#MYSPLITTER_FLAGS_NO_SIZEABLE
	EndEnumeration
	
	Prototype.b MySplitterProtoEventCustomDraw(*splitter)
	
	Interface MySplitter
		GetType()		
		SetFlags(value.i):GetFlags.i()
		SetValue(value.i):GetValue.i()
		SetGadget1(value.i):GetGadget1.i()
		SetGadget2(value.i):GetGadget2.i()
		SetMinSizeGadget1(value.i):GetMinSizeGadget1.i()
		SetMinSizeGadget2(value.i):GetMinSizeGadget2.i()
		SetSeparatorSize(value.i):GetSeparatorSize.i()
		Resize(x.i=#PB_Ignore,y.i=#PB_Ignore,w.i=#PB_Ignore,h.i=#PB_Ignore)
		
		BindCustomDraw(*event.MySplitterProtoEventCustomDraw)
	EndInterface
	
	Declare MySplitterCreateSplitter(x.i,y.i,w.i,h.i,gadget1.i=0,gadget2.i=0,flags.i=0)	
	
EndDeclareModule

XIncludeFile "MySplitter/mysplitter.pb"