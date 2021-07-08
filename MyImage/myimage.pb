Module MyImage
	EnableExplicit
	
	
	XIncludeFile "myimagemacro.pb"
	XIncludeFile "myimagestructure.pb"
	XIncludeFile "myimagedeclare.pb"
	XIncludeFile "myimageautodeclare.pb"
	XIncludeFile "myimageglobal.pb"
	XIncludeFile "myimageimage.pb"
	
	DataSection
		vtable_myimage:
		_MyDataSectionDefault(MyImage,Image)
		_MyDataSectionGetter(MyImage,Image,Image)
		_MyDataSectionGetter(MyImage,Image,ImageID)
		_MyDataSectionGetter(MyImage,Image,SizedImage)		
		_MyDataSectionGetter(MyImage,Image,SizedImageID)		
	EndDataSection	
EndModule
