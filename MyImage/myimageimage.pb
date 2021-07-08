_MyDefaultGetter(MyImage,Image,Type,i)
_MyDefaultGetter(MyImage,Image,Image,i)
_MyDefaultGetter(MyImage,Image,ImageID,i)

Procedure MyImage_Image_GetAddSizedImage(*this.strMyImageImage,width.i,height.i,scaled.b)
	ForEach *this\sized()
		If *this\sized()\width=width And *this\sized()\height=height And *this\sized()\scaled=scaled
			ProcedureReturn *this\sized()
		EndIf
	Next
	Protected *image.strImage=AddElement(*this\sized())
	With *image
		\height=height
		\width=width
		\image=CopyImage(*this\image,#PB_Any)
		If scaled
			ResizeImage(\image,width,height)
		Else
			ResizeImage(\image,width,height)
		EndIf
		\imageid=ImageID(\image)
	EndWith
	ProcedureReturn *image
EndProcedure

Procedure _MyImage_Image_GetSizedImage(*this.strMyImageImage,width.i,height.i,scaled.b=#False)
	Protected *img.strImage=MyImage_Image_GetAddSizedImage(*this,width,height,scaled)
	If *img
		ProcedureReturn *img\image
	EndIf
EndProcedure

Procedure _MyImage_Image_GetSizedImageID(*this.strMyImageImage,width.i,height.i,scaled.b=#False)
	Protected *img.strImage=MyImage_Image_GetAddSizedImage(*this,width,height,scaled)
	If *img
		ProcedureReturn *img\imageid
	EndIf
EndProcedure