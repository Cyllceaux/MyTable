Procedure _MyImageInitImage(*image.strMyImageImage,
                           image.i)
	With *image
		\vtable=?vtable_image
		\image\image=image
		\image\imageID=ImageID(image)
		\type=My::#MY_TYPE_IMAGE
	EndWith
	
EndProcedure

Global NewList images.strMyImageImage()

Procedure MyImageCreateImage(image.i)
	ForEach images()
		If images()\image\image=image
			ProcedureReturn images()
		EndIf
	Next
	
	If IsImage(image)
		Protected *this.strMyImageImage=AddElement(images())
		_MyImageInitImage(*this,image)
		ProcedureReturn *this
	EndIf
EndProcedure