CompilerIf Not Defined(UPDATE_DOC,#PB_Constant)
	#UPDATE_DOC=0
CompilerEndIf

CompilerIf Not Defined(UPDATE_VERSION,#PB_Constant)
	#UPDATE_VERSION=0
CompilerEndIf

CompilerIf #PB_Compiler_Debugger
	CompilerIf #UPDATE_DOC
		
		Procedure.s parseParameter(line.s,split.b)
			Protected result.s=line
			result=ReplaceString(result,","," , ")
			result=ReplaceString(result,"="," = ")
			result=ReplaceString(result,"\|"," \| ")
			While FindString(result,"  ")
				result=ReplaceString(result,"  "," ")
			Wend			
			Protected fif,fef,fek,fel,ll
			fif=FindString(result,~"\"")
			While fif
				fef=FindString(result,~"\"",fif+1)
				If fef>0
					ll=Len(result)
					result=InsertString(result,~"</span>",fef+1)
					result=InsertString(result,~"<span style=\"color:#AAFFAA\">",fif)
					fif=FindString(result,~"\"",fef+(Len(result)-ll)+1)
				Else
					result+~"</span>"
					result=InsertString(result,~"<span style=\"color:#AAFFAA\">",fif)
					fif=0
				EndIf
			Wend
			
			fif=FindString(result,~"*")
			While fif
				fef=FindString(result,",",fif+1)
				fek=FindString(result," ",fif+1)
				fel=FindString(result,".",fif+1)
				If fek<fef And fek>0
					fef=fek
				EndIf
				If fel<fef And fel>0
					fef=fel
				EndIf
				If fef>0
					ll=Len(result)
					result=InsertString(result,~"</span>",fef+1)
					result=InsertString(result,~"<span style=\"color:#FFFFAA\">",fif)
					fif=FindString(result,~"*",fef+(Len(result)-ll)+1)
				Else
					result+~"</span>"
					result=InsertString(result,~"<span style=\"color:#FFFFAA\">",fif)
					fif=0
				EndIf
			Wend
			
			fif=FindString(result,"\#")
			While fif
				fef=FindString(result,",",fif+1)
				fek=FindString(result," ",fif+1)
				If fek<fef And fek>0
					fef=fek
				EndIf
				If fef>0
					ll=Len(result)
					result=InsertString(result,~"</span>",fef)
					result=InsertString(result,~"<span style=\"color:#AAAAFF\">",fif)
					fif=FindString(result,"\#",fef+(Len(result)-ll)+1)
				Else
					result+~"</span>"
					result=InsertString(result,~"<span style=\"color:#AAAAFF\">",fif)
					fif=0
				EndIf
			Wend
			If split
				result=ReplaceString(result,".","|")
			EndIf
			ProcedureReturn result
		EndProcedure
		
		Procedure.s splitProcedure(line.s,comment.s)
			Protected typ.s=""
			Protected c=CountString(line,":")
			If c>0
				Protected i
				Protected nresult.s=""
				For i=0 To c
					Protected ll.s=StringField(line,i+1,":")
					If nresult<>""
						nresult+#CRLF$
					EndIf
					nresult+splitProcedure(ll,comment)
				Next
				ProcedureReturn nresult
			EndIf
			If Left(line,8)="Declare."
				typ=StringField(line,2,".")
				typ=StringField(typ,1," ")
				typ=Trim(typ)
				line=Trim(Mid(line,FindString(line," ")))
				
			EndIf
			If Left(line,10)="Procedure." Or Left(line,10)="Prototype."
				typ=StringField(line,2,".")
				typ=StringField(typ,1," ")
				typ=Trim(typ)
				line=Trim(Mid(line,FindString(line," ")))
			EndIf
			
			If Left(line,7)="Declare"
				line=Trim(Mid(line,8))
			EndIf
			If Left(line,9)="Procedure" Or Left(line,9)="Prototype"
				line=Trim(Mid(line,10))
			EndIf
			If Left(line,5)="Macro"
				line=Trim(Mid(line,6))
			EndIf
			Protected result.s="|"
			Protected prk.s=StringField(line,1,"(")
			If typ=""
				typ=StringField(prk,2,".")
			EndIf
			prk=StringField(prk,1,".")
			Protected para.s=StringField(line,2,"(")
			para=StringField(para,1,")")			
			para=parseParameter(para,#False)
			result+prk+"|"+typ+"|"+para+"|"+comment+"|"
			
			ProcedureReturn result
		EndProcedure
		
		Procedure updateDoc(fromPfad.s,toPfad.s)
			If FileSize("../update")=0
				Protected file=OpenFile(#PB_Any,fromPfad)
				Protected result.s=""
				Protected modules.s=""
				Protected interfaces.s=""
				Protected enumerations.s=""
				Protected enumerationbinarys.s=""
				Protected constants.s=""
				Protected procedures.s=""
				Protected v.s=""
				Protected declares.s=""
				Protected macros.s=""
				Protected structures.s=""
				Protected prototypes.s=""
				
				Protected bmoduless.b=#False
				Protected binterfaces.b=#False
				Protected benumerations.b=#False
				Protected benumerationbinarys.b=#False
				Protected bconstants.b=#False
				Protected bprocedures.b=#False			
				Protected bmacros.b=#False
				Protected bstructures.b=#False
				Protected NewList interfacesList.s()
				
				Protected idx=0
				
				If file
					While Not Eof(file)
						Protected inhalt.s=Trim(ReplaceString(ReadString(file),#TAB$,""))
						Protected comment.s=Trim(StringField(inhalt,2,";"))
						inhalt=Trim(StringField(inhalt,1,";"))
						inhalt=ReplaceString(inhalt,"|","\|")
						inhalt=ReplaceString(inhalt,"_","\_")
						inhalt=ReplaceString(inhalt,"#","\#")
						If inhalt<>""						
							If FindString(inhalt,"DeclareModule")=1 And Not FindString(inhalt,"EndDeclareModule",0,#PB_String_NoCase) And Not bmacros
								modules+#CRLF$+"# "+StringField(inhalt,2," ")+#CRLF$+#CRLF$		
								bmoduless=#True
							ElseIf  FindString(inhalt,"EndDeclareModule",0,#PB_String_NoCase) And Not bmacros
								bmoduless=#False
							ElseIf FindString(inhalt,"Interface ")=1 And Not FindString(inhalt,"EndInterface",0,#PB_String_NoCase) And Not bmacros
								interfaces+#CRLF$+"### "+Trim(StringField(inhalt,2," "))
								If Trim(StringField(inhalt,3," "))="Extends"
									interfaces+" : ["+Trim(StringField(inhalt,4," "))+"](#"+Trim(StringField(inhalt,4," "))+")"
								EndIf
								interfaces+#CRLF$
								Interfaces+"|Name|Return|Parameter|Comment|"+#CRLF$
								Interfaces+"| --- | --- | --- | --- |"+#CRLF$
								binterfaces=#True
								AddElement(interfacesList())
								interfacesList()=Trim(StringField(inhalt,2," "))
							ElseIf FindString(inhalt,"Structure ",0,#PB_String_NoCase)=1 And Not FindString(inhalt,"EndStructure",0,#PB_String_NoCase) And Not bmacros
								structures+#CRLF$+"### "+Trim(StringField(inhalt,2," "))
								If Trim(StringField(inhalt,3," "))="Extends"
									structures+" : ["+Trim(StringField(inhalt,4," "))+"](#"+Trim(StringField(inhalt,4," "))+")"
								EndIf
								structures+#CRLF$
								structures+"|Field|Type|Comment|"+#CRLF$
								structures+"| --- | --- | --- |"+#CRLF$
								bstructures=#True
								AddElement(interfacesList())
								interfacesList()=Trim(StringField(inhalt,2," "))
							ElseIf FindString(inhalt,"EndInterface",0,#PB_String_NoCase) And Not bmacros
								binterfaces=#False							
							ElseIf FindString(inhalt,"EndMacro",0,#PB_String_NoCase)
								bmacros=#False
							ElseIf FindString(inhalt,"EndStructure",0,#PB_String_NoCase)
								bstructures=#False
							ElseIf FindString(inhalt,"EndProcedure",0,#PB_String_NoCase) And Not bmacros
								bprocedures=#False
							ElseIf FindString(inhalt,"EndEnumeration",0,#PB_String_NoCase) And Not bmacros
								benumerations=#False
								benumerationbinarys=#False
							ElseIf FindString(inhalt,"Enumeration ")=1 And Not FindString(inhalt,"EndEnumeration",0,#PB_String_NoCase) And Not bmacros
								enumerations+#CRLF$+"### "+StringField(inhalt,2," ")+#CRLF$
								enumerations+"|Name|Value|Comment|"+#CRLF$
								enumerations+"| --- | --- | --- |"+#CRLF$
								benumerations=#True
								idx=0
							ElseIf FindString(inhalt,"EnumerationBinary ")=1 And Not FindString(inhalt,"EndEnumeration",0,#PB_String_NoCase) And Not bmacros							
								enumerationbinarys+#CRLF$+"### "+StringField(inhalt,2," ")+#CRLF$
								enumerationbinarys+"|Name|Value|Comment|"+#CRLF$
								enumerationbinarys+"| --- | --- | --- |"+#CRLF$
								benumerationbinarys=#True			
								idx=1
							ElseIf (FindString(inhalt,"Procedure ")=1 Or FindString(inhalt,"Procedure.")=1) And Not FindString(inhalt,"EndProcedure",0,#PB_String_NoCase) And Not bmacros
								If procedures=""
									procedures+"|Name|Return|Parameter|Comment|"+#CRLF$
									procedures+"| --- | --- | --- | --- |"+#CRLF$
								EndIf
								procedures+splitProcedure(inhalt,comment)+#CRLF$
								bprocedures=#True
							ElseIf FindString(inhalt,"Macro")=1 And Not FindString(inhalt,"EndMacro",0,#PB_String_NoCase) And Not bmacros
								If macros=""
									macros+"|Name|Return|Parameter|Comment|"+#CRLF$
									macros+"| --- | --- | --- | --- |"+#CRLF$
								EndIf
								macros+splitProcedure(inhalt,comment)+#CRLF$
								bmacros=#True
							ElseIf FindString(inhalt,"Declare ",0,#PB_String_NoCase)=1 Or FindString(inhalt,"Declare.",0,#PB_String_NoCase)=1
								If declares=""
									declares+"|Name|Return|Parameter|Comment|"+#CRLF$
									declares+"| --- | --- | --- | --- |"+#CRLF$
								EndIf
								declares+splitProcedure(inhalt,comment)+#CRLF$
							ElseIf FindString(inhalt,"Prototype ",0,#PB_String_NoCase)=1 Or FindString(inhalt,"Prototype.",0,#PB_String_NoCase)=1
								If prototypes=""
									prototypes+"|Name|Return|Parameter|Comment|"+#CRLF$
									prototypes+"| --- | --- | --- | --- |"+#CRLF$
								EndIf
								prototypes+splitProcedure(inhalt,comment)+#CRLF$
							ElseIf Not bmacros
								If bstructures								
									structures+"|"+parseParameter(inhalt,#True)+"|"+comment+"|"+#CRLF$
								ElseIf Left(inhalt,1)="#" Or Left(inhalt,2)="\#"
									If benumerations
										v=Trim(StringField(inhalt,2,"="))
										If v=""
											v=Str(idx)
										Else
											idx=Val(v)
										EndIf
										v=parseParameter(v,#False)
										Enumerations+~"|<span style=\"color:#AAAAFF\">"+Trim(StringField(inhalt,1,"="))+"</span>|"+v+"|"+comment+"|"+#CRLF$
										idx+1
									ElseIf benumerationbinarys
										v=Trim(StringField(inhalt,2,"="))
										If v=""
											v=Str(idx)
										Else
											idx=Val(v)
										EndIf
										v=parseParameter(v,#False)
										enumerationbinarys+~"|<span style=\"color:#AAAAFF\">"+Trim(StringField(inhalt,1,"="))+"</span>|"+v+"|"+comment+"|"+#CRLF$
										idx*2
									Else
										If constants=""
											constants+"|Constants|Value|Comment|"+#CRLF$
											constants+"| --- | --- | --- |"+#CRLF$
										EndIf
										constants+~"|<span style=\"color:#AAAAFF\">"+Trim(StringField(inhalt,1,"="))+"</span>|"+parseParameter(StringField(inhalt,2,"="),#False)+"|"+comment+"|"+#CRLF$									
									EndIf
								Else
									If binterfaces
										interfaces+splitProcedure(inhalt,comment)+#CRLF$
									EndIf
								EndIf
							EndIf
						EndIf
					Wend
					CloseFile(file)
					result=modules
					If structures<>""
						result+"## Structures"+#CRLF$+#CRLF$+structures+#CRLF$+#CRLF$
					EndIf				
					If macros<>""
						result+"## Macros"+#CRLF$+#CRLF$+macros+#CRLF$+#CRLF$
					EndIf
					If constants<>""
						result+"## Constants"+#CRLF$+#CRLF$+constants+#CRLF$+#CRLF$
					EndIf
					If enumerations<>""
						result+"## Enumerations"+#CRLF$+#CRLF$+enumerations+#CRLF$+#CRLF$
					EndIf
					If enumerationbinarys<>""
						result+"## EnumerationBinarys"+#CRLF$+#CRLF$+enumerationbinarys+#CRLF$+#CRLF$
					EndIf
					
					If prototypes<>""
						result+"## Prototypes"+#CRLF$+#CRLF$+prototypes+#CRLF$+#CRLF$
					EndIf
					If interfaces<>""
						result+"## Interfaces"+#CRLF$+#CRLF$+interfaces+#CRLF$+#CRLF$
					EndIf
					If declares<>""
						result+"## Declares"+#CRLF$+#CRLF$+declares+#CRLF$+#CRLF$
					EndIf
					If Procedures<>""
						result+"## Procedures"+#CRLF$+#CRLF$+Procedures+#CRLF$+#CRLF$
					EndIf
					ForEach interfacesList()
						result=ReplaceString(result,"."+interfacesList(),".["+interfacesList()+"](#"+interfacesList()+")")
						result=ReplaceString(result,"|"+interfacesList(),"|["+interfacesList()+"](#"+interfacesList()+")")
					Next
					file=CreateFile(#PB_Any,toPfad,#PB_UTF8)
					WriteString(file,result,#PB_UTF8)
					CloseFile(file)				
					FreeList(interfacesList())
				EndIf
			EndIf
		EndProcedure
		
		
	CompilerEndIf
	
	CompilerIf #UPDATE_VERSION 
		
		Procedure updateVersion(pfad.s)
			If FileSize("../update")=0
				Protected file=OpenFile(#PB_Any,pfad)
				If file
					Protected inhalt.s=ReadString(file,#PB_File_IgnoreEOL,Lof(file))
					Protected regexversion=CreateRegularExpression(#PB_Any,"VERSION\s*=\s*(\d+)")
					Protected regexversiondate=CreateRegularExpression(#PB_Any,"VERSION_DATE\s*=\s*(\d+)")
					If ExamineRegularExpression(regexversion,inhalt)
						While NextRegularExpressionMatch(regexversion)
							Protected line.s=RegularExpressionMatchString(regexversion)
							Protected op.s=RegularExpressionGroup(regexversion,1)
							Protected newline.s=ReplaceString(line,op,Str(Val(op)+1))
							inhalt=ReplaceString(inhalt,line,newline)
						Wend
					EndIf
					If ExamineRegularExpression(regexversiondate,inhalt)
						While NextRegularExpressionMatch(regexversiondate)
							line=RegularExpressionMatchString(regexversiondate)
							op=RegularExpressionGroup(regexversiondate,1)
							newline=ReplaceString(line,op,FormatDate("%yyyy%mm%dd",Date()))
							inhalt=ReplaceString(inhalt,line,newline)
						Wend
					EndIf
					FreeRegularExpression(regexversion)
					FreeRegularExpression(regexversiondate)
					CloseFile(file)
					file=CreateFile(#PB_Any,pfad)
					WriteString(file,inhalt)
					CloseFile(file)
				EndIf
			EndIf
		EndProcedure
		
	CompilerEndIf
CompilerEndIf

CompilerIf #PB_Compiler_Debugger
	CompilerIf #UPDATE_VERSION 
		If ExamineDirectory(0,"../","*.pbi")
			While NextDirectoryEntry(0)
				updateVersion("../"+DirectoryEntryName(0))
			Wend
			FinishDirectory(0)
		EndIf
		updateVersion("../README.md")
	CompilerEndIf
	
	CompilerIf #UPDATE_DOC
		
		Procedure.s parsePBFiles(pfad.s,titel.s,version.q=0,versiondate.q=0)
			Protected readme.s=""
			If titel<>""
				readme+"## "+titel+#CRLF$+#CRLF$
			EndIf
			If version
				readme+"VERSION = "+version+#CRLF$+#CRLF$
			EndIf
			If versiondate
				readme+"VERSION_DATE = "+versiondate+#CRLF$+#CRLF$
			EndIf
			
			If ExamineDirectory(0,pfad,"*.pb*")
				While NextDirectoryEntry(0)
					If GetExtensionPart(DirectoryEntryName(0))<>"pbp"
						updateDoc(pfad+DirectoryEntryName(0),"../Doc/"+DirectoryEntryName(0)+".md")
						readme+"["+DirectoryEntryName(0)+"](Doc/"+DirectoryEntryName(0)+".md)"+#CRLF$+#CRLF$
					EndIf
				Wend
				FinishDirectory(0)
			EndIf
			ProcedureReturn readme
		EndProcedure
		
		
		Define readme.s="# My"+#CRLF$+#CRLF$
		readme+"VERSION = "+My::#VERSION+#CRLF$+#CRLF$
		readme+"VERSION_DATE = "+My::#VERSION_DATE+#CRLF$+#CRLF$
		
		DeleteDirectory("../Doc","*.md",#PB_FileSystem_Force)
		readme+parsePBFiles("../","")
		readme+parsePBFiles("../MyGlobal/","MyGlobal")
		readme+parsePBFiles("../MyFont/","MyFont",MyFont::#MYFONT_VERSION,MyFont::#MYFONT_VERSION_DATE)
		readme+parsePBFiles("../MyImage/","MyImage",MyImage::#MYIMAGE_VERSION,MyImage::#MYIMAGE_VERSION_DATE)
		readme+parsePBFiles("../MyTable/","MyTable",MyTable::#MYTABLE_VERSION,MyTable::#MYTABLE_VERSION_DATE)
		readme+parsePBFiles("../MySplitter/","MySplitter",MySplitter::#MYSPLITTER_VERSION,MySplitter::#MYSPLITTER_VERSION_DATE)
		
		
		CreateFile(0,"../README.md",#PB_UTF8)
		WriteString(0,readme)
		CloseFile(0)
	CompilerEndIf
CompilerEndIf