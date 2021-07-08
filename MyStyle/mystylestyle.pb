_MyDefaultMy(MyStyle,Style)
_MyDefaultGetterSetter(MyStyle,Style,BackColor,q)
_MyDefaultGetterSetter(MyStyle,Style,FrontColor,q)
_MyDefaultGetterSetter(MyStyle,Style,HAlign,i)
_MyDefaultGetterSetter(MyStyle,Style,VAlign,i)
_MyDefaultGetterSetterPointer(MyStyle,Style,Font)



Procedure _MyStyle_Style_GetBorder(*this.strMyStyleStyle,type.i)
	If *this
		Protected *result.strMyStyleBorder=0
		If type=0 Or type=#MYSTYLE_BORDER_DEFAULT
			*result= *this\bordersDefault
		ElseIf Bool(type & #MYSTYLE_BORDER_TOP)
			*result= *this\bordersTop
		ElseIf Bool(type & #MYSTYLE_BORDER_BOTTOM)
			*result= *this\bordersBottom
		ElseIf Bool(type & #MYSTYLE_BORDER_LEFT)
			*result= *this\bordersLeft
		ElseIf Bool(type & #MYSTYLE_BORDER_RIGHT)
			*result= *this\bordersRight
		EndIf
		If Not *result
			*result= *this\bordersDefault
		EndIf
		ProcedureReturn *result
	EndIf
EndProcedure

Procedure _MyStyle_Style_SetBorder(*this.strMyStyleStyle,type.i,*value.strMyStyleBorder)
	If *this
		If type=0 Or type=#MYSTYLE_BORDER_DEFAULT
			*this\bordersDefault=*value
		Else
			If Bool(type & #MYSTYLE_BORDER_TOP)
				*this\bordersTop=*value
			EndIf
			If Bool(type & #MYSTYLE_BORDER_BOTTOM)
				*this\bordersBottom=*value
			EndIf
			If Bool(type & #MYSTYLE_BORDER_LEFT)
				*this\bordersLeft=*value
			EndIf
			If Bool(type & #MYSTYLE_BORDER_RIGHT)
				*this\bordersRight=*value
			EndIf
		EndIf
	EndIf
EndProcedure