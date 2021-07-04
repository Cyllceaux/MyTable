EnableExplicit

#UPDATE_VERSION=1
#UPDATE_DOC=1
#AUTODECLARE=1

XIncludeFile "declare.pb"

UseModule MyTable
	
	Define image=CreateImage(#PB_Any,800,600,32)
	Define image2=CreateImage(#PB_Any,800,600,32)
	Define *application.MyTableApplication=MyTableCreateApplication()
	Define *table.MyTableTable=MyTableCreateTable(0,image,0,0)
	Define *apptable.MyTableTable=*application\AddTable(0,image2,0,0,"Hallo Welt 1234!!")
	
	*table\SetName("Hallo Welt 1234!!")
	
	AssertEquals(*table\GetName(),*apptable\GetName())
	AssertNotEmpty(*table\GetName())
	
	*table\SetRedraw(#False)
	*apptable\SetRedraw(#False)
	
	
	
	*table\SetRedraw(#True)
	*apptable\SetRedraw(#True)
	
	FreeImage(image)
	FreeImage(image2)
	
	*application\Free()
	*table\Free()
	

UnuseModule MyTable