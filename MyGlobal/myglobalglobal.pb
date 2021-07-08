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
	result+2
	ProcedureReturn result
EndProcedure

Procedure.s _My_ShortText(text.s,maxlen.i)
	Protected result.s=""
	If text<>"" And maxlen>0 And maxlen>TextWidth("...")
		Protected c=CountString(text,#CRLF$)
		Protected tw=0
		Protected tt.s=""		
		Protected h=0
		If c>0
			Protected idx=0
			For idx=0 To c
				tt=StringField(text,idx+1,#CRLF$)
				tw=TextWidth(tt)
				If tw>maxlen
					While tw>maxlen
						tt=Mid(tt,1,Len(tt)-1)
						tw=TextWidth(tt+"...")						
					Wend
					tt+"..."
				EndIf
				result=tt
			Next
		Else
			tt=text
			tw=TextWidth(tt)
			If tw>maxlen
				While tw>maxlen
					tt=Mid(tt,1,Len(tt)-1)
					tw=TextWidth(tt+"...")						
				Wend
				tt+"..."
			EndIf		
			result=tt
		EndIf
	EndIf	
	
	ProcedureReturn result
EndProcedure

Procedure.s _My_LineBreakText(text.s,maxlen.i)
	Protected tt.s=text
	Protected tw=_My_TextWidth(text)
	Protected c=CountString(text,#CRLF$)
	Protected bx=0
	Protected idx
	Protected result.s=""
	If c>0
		For idx=0 To c
			tt=StringField(text,idx+1,#CRLF$)
			tw=TextWidth(tt)
			If result<>""
				result+#CRLF$
			EndIf
			result+tt
		Next
	Else
		If tw>maxlen
			result.s=""
			c=CountString(tt," ")
			For idx=0 To c
				Protected ts.s=StringField(tt,idx+1," ")
				If _My_TextWidth(result+" "+ts)>maxlen
					result+#CRLF$
					result=Trim(result+ts)
				Else					
					If result=""
						result=ts
					Else
						result=Trim(result+" "+ts)
					EndIf
				EndIf
			Next
			result=_My_LineBreakText(result,maxlen)		
		EndIf
	EndIf
	ProcedureReturn result
EndProcedure