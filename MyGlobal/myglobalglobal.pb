Procedure _My_TextHeight(text.s)
	Protected result.i=TextHeight(text)
	result*(FindString(text,#CRLF$)+1)
	ProcedureReturn result
EndProcedure

Procedure _My_TextWidth(text.s)
	Protected result.i=0
	Protected c=CountString(text,#CRLF$)
	If c
		c+1
		Protected i=1
		For i=1 To c
			Protected w=TextWidth(StringField(text,i,#CRLF$))
			If w>result
				result=w
			EndIf
		Next		
	Else
		result=TextWidth(text)
	EndIf
	ProcedureReturn result
EndProcedure

