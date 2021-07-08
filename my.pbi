﻿DeclareModule My
	
	Enumeration _my_type
		#MY_TYPE_NONE
		#MY_TYPE_FONT
		#MY_TYPE_IMAGE
		#MY_TYPE_STYLE
		#MY_TYPE_BORDER
	EndEnumeration
	
	Interface My
		GetType.i()
	EndInterface
	
	Prototype.b CustomDraw(*my,x,y,w,h)
	
	Interface MyGadget Extends My
		GetX():GetY():GetW():GetH()
		GetCalcHeight():GetCalcWidth()
		GetRedraw.b():SetRedraw(value.b)
		Redraw()
		
		Resize(x.i,y.i,w.i,h.i)		
		Free()
		BindCustomDraw(*cust.CustomDraw)
	EndInterface
	
	Interface MyScrollableGadget Extends MyGadget
		
	EndInterface
	
EndDeclareModule

XIncludeFile "My/my.pb"