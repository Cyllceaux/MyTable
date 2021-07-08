DeclareModule My
	
	Enumeration _my_type
		#MY_TYPE_NONE
		#MY_TYPE_FONT
		#MY_TYPE_IMAGE
	EndEnumeration
	
	Interface My
		GetType.i()
	EndInterface
	
	Interface MyGadget Extends My
		GetCanvas()
	EndInterface
	
	Interface MyScrollableGadget Extends MyGadget
		GetVScroll()
		GetHScroll()
	EndInterface
	
EndDeclareModule

XIncludeFile "My/my.pb"