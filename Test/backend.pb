EnableExplicit

#UPDATE_VERSION=1
#UPDATE_DOC=1
#AUTODECLARE=1

XIncludeFile "declare.pb"

UseModule MyTable
	
	Define image=CreateImage(#PB_Any,800,600,32)
	Define image2=CreateImage(#PB_Any,800,600,32)
	Define *table.MyTableTable=MyTableCreateTable(0,image,0,0)
	Define *apptable.MyTableTable=MyTableCreateTable(0,image2,0,0)
	
	*table\SetName("Hallo Welt 1234!!")
	
	
	AssertNotEquals(*table\GetName(),*apptable\GetName())
	AssertNotEmpty(*table\GetName())
	
	*table\SetRedraw(#False)
	
	
	
	*table\SetRedraw(#True)
	
	FreeImage(image)
	FreeImage(image2)
	
	*table\Free()
	

UnuseModule MyTable