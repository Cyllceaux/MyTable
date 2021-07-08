IncludeFile "../MyGlobal/myglobalstructure.pb"

Structure strImage
	image.i
	imageid.i
	
	width.i
	height.i
	scaled.b
EndStructure

Structure strMyImageImage Extends strMy
	image.i
	imageid.i
	List sized.strImage()
EndStructure