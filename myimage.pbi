XIncludeFile "my.pbi"

DeclareModule MyImage
	
	Interface MyImage Extends My::My
		GetImage()
		GetImageID()
		GetSizedImage(width.i,height.i,scaled.b=#False)
		GetSizedImageID(width.i,height.i,scaled.b=#False)
	EndInterface
	
	Declare MyImageCreate(image.i)
	
EndDeclareModule

XIncludeFile "MyImage/myimage.pb"