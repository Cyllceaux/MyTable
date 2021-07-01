IncludeFile "../MyGlobal/myglobalstructure.pb"

Structure strMyImage
	image.i
	imageID.i
EndStructure

Structure strMyImageImage Extends strMyVTable
	image.strMyImage
	Map images.strMyImage()
EndStructure