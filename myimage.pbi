XIncludeFile "my.pbi"

DeclareModule MyImage
	
	#MYIMAGE_VERSION = 88
	#MYIMAGE_VERSION_DATE = 20210703
	
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