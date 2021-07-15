XIncludeFile "my.pbi"

DeclareModule MyImage
	
	#MYIMAGE_VERSION = 250
	#MYIMAGE_VERSION_DATE = 20210715
	
	Interface MyImage
		GetType()
		
		GetImage()
		GetImageID()
		
		GetSized(size.i)
		GetSizedID(size.i)
	EndInterface
	
	Declare MyImageCreateImage(image.i)	
	
EndDeclareModule

XIncludeFile "MyImage/myimage.pb"