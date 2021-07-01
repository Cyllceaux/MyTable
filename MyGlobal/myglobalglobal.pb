Procedure _MyTableTextHeight(text.s)
	ProcedureReturn TextHeight(text) * (CountString(text,#CRLF$) + 1)
EndProcedure

Procedure  _MyTableTextWidth(text.s)
	Protected c=CountString(text,#CRLF$)
	If c
		Protected result.i=0,idx=0
		For idx=0 To c
			Protected w=TextWidth(StringField(text,idx+1,#CRLF$))
			If w>result
				result=w
			EndIf
		Next
		ProcedureReturn result
	Else
		ProcedureReturn TextWidth(text)
	EndIf
EndProcedure

Procedure _MyTableDrawTextCompleteCenter(by,text.s,color.q,maxlen.i)
	Protected tt.s=text
	Protected tw=_MyTableTextWidth(text)
	Protected c=CountString(text,#CRLF$)
	Protected bx=0
	Protected idx
	If c>0
		For idx=0 To c
			tt=StringField(text,idx+1,#CRLF$)
			tw=TextWidth(tt)
			bx=maxlen/2-tw/2
			DrawText(bx,by,tt,color)
			by+TextHeight(tt)
		Next
	Else
		If tw>maxlen
			Protected result.s=""
			c=CountString(tt," ")
			For idx=0 To c
				Protected ts.s=StringField(tt,idx+1," ")
				If _MyTableTextWidth(result+" "+ts)>maxlen
					result+#CRLF$
				EndIf
				If result=""
					result=ts
				Else
					result=Trim(result+" "+ts)
				EndIf
			Next
			_MyTableDrawTextCompleteCenter(by,result,color,maxlen)
		Else
			bx=maxlen/2-tw/2
			DrawText(bx,by,tt,color)
		EndIf
	EndIf
EndProcedure

Procedure _MyTableDrawText(x,y,text.s,color.q,maxlen.i)
	If text<>"" And maxlen>0 And maxlen>TextWidth("...")
		Protected c=CountString(text,#CRLF$)
		Protected tw=0
		Protected tt.s=""		
		Protected h=0
		If c>0
			Protected idx=0
			DrawingMode(#PB_2DDrawing_Transparent)
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
				
				DrawText(x,y+h,tt,color)	
				h+TextHeight(tt)
			Next
		Else
			tt=text
			tw=TextWidth(tt)
			DrawingMode(#PB_2DDrawing_Transparent)
			If tw>maxlen
				While tw>maxlen
					tt=Mid(tt,1,Len(tt)-1)
					tw=TextWidth(tt+"...")						
				Wend
				tt+"..."
			EndIf		
			DrawText(x,y,tt,color)
			h+TextHeight(tt)
		EndIf
		ProcedureReturn h
	EndIf	
EndProcedure

Procedure.s _MyTableCleanName(name.s)
	Protected result.s=Trim(name)
	If result<>""
		Protected regex=CreateRegularExpression(#PB_Any,"[^\w\d_]")
		result=ReplaceString(result," ","_")
		
		If ExamineRegularExpression(regex,result)
			While NextRegularExpressionMatch(regex)
				Protected op.s=RegularExpressionMatchString(regex)
				result=ReplaceString(result,op,"")
			Wend
		EndIf
		
		FreeRegularExpression(regex)
	EndIf
	ProcedureReturn result
EndProcedure