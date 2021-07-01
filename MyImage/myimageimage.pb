_SimpleGetter(MyImage,Image,Type,i)
_SimpleGetter(MyImage,Image,Image,i,image\)
_SimpleGetter(MyImage,Image,ImageID,i,image\)

Procedure _MyImage_ResizeImage(image,size)
	ResizeImage(image,size,size)
EndProcedure

Procedure _MyImage_Image_GetSized(*this.strMyImageImage,size.i)
	If *this
		Protected *img.strMyImage=FindMapElement(*this\images(),Str(size))
		If Not *img
			*img=AddMapElement(*this\images(),Str(size))
			*img\image=CopyImage(*this\image\image,#PB_Any)
			_MyImage_ResizeImage(*img\image,size)
			*img\imageID=ImageID(*img\image)
		EndIf
		ProcedureReturn *img\image
	EndIf
EndProcedure


Procedure _MyImage_Image_GetSizedID(*this.strMyImageImage,size.i)
	If *this
		Protected *img.strMyImage=FindMapElement(*this\images(),Str(size))
		If Not *img
			*img=AddMapElement(*this\images(),Str(size))
			*img\image=CopyImage(*this\image\image,#PB_Any)
			_MyImage_ResizeImage(*img\image,size)
			*img\imageID=ImageID(*img\image)
		EndIf
		ProcedureReturn *img\imageID
	EndIf
EndProcedure