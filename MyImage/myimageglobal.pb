IncludeFile "../MyGlobal/myglobalglobal.pb"


Global NewList images.strMyImageImage()

Procedure MyImageCreate(image.i)
	ForEach images()
		If images()\image=image
			ProcedureReturn images()
		EndIf
	Next
	If IsImage(image)
		Protected *this.strMyImageImage=AddElement(images())
		With *this
			\vtable=?vtable_myimage
			\type=My::#MY_TYPE_IMAGE
			\image=image
			\imageid=ImageID(image)
		EndWith
		ProcedureReturn *this
	EndIf
EndProcedure