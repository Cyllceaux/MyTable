Module MyImage
	EnableExplicit
	
	IncludeFile "myimagestructure.pb"
	IncludeFile "../MyGlobal/myglobalmacro.pb"
	IncludeFile "../MyGlobal/myglobaldeclare.pb"
	IncludeFile "myimagedeclare.pb"
	IncludeFile "myimageautodeclare.pb"
	IncludeFile "myimageglobal.pb"
	IncludeFile "myimageimage.pb"
	IncludeFile "../MyGlobal/myglobalglobal.pb"
	
	DataSection
		vtable_image: ;- Image
		_DataSectionGetter(MyImage,Image,Type)
		
		_DataSectionGetter(MyImage,Image,Image)
		_DataSectionGetter(MyImage,Image,ImageID)
		
		_DataSectionGetter(MyImage,Image,Sized)
		_DataSectionGetter(MyImage,Image,SizedID)
	EndDataSection
	
EndModule