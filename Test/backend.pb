EnableExplicit

#MYTABLE_AUTODECLARE=1

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
	
	CompilerIf Defined(MYTABLE_AUTODECLARE,#PB_Module)
		SortList(MYTABLE_AUTODECLARE::autodeclare(),#PB_Sort_Ascending)
		Define file=CreateFile(#PB_Any,"../autodeclare.pb")
		Define line.s="; auto-generated"
		ForEach MYTABLE_AUTODECLARE::autodeclare()
			line+#CRLF$+MYTABLE_AUTODECLARE::autodeclare()
		Next
		WriteString(file,line)
		CloseFile(file)
	CompilerEndIf
UnuseModule MyTable