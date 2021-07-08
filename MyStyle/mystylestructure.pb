IncludeFile "../MyGlobal/myglobalstructure.pb"

Structure strMyStyleBorder Extends strMy
	margin.i
	padding.i
	size.i
	color.q
EndStructure

Structure strMyStyleStyle Extends strMy
	backcolor.q
	frontcolor.q
	valign.i
	halign.i
	*font.MyFont::MyFont	
	*bordersDefault.strMyStyleBorder
	*bordersLeft.strMyStyleBorder
	*bordersRight.strMyStyleBorder
	*bordersBottom.strMyStyleBorder
	*bordersTop.strMyStyleBorder
EndStructure
