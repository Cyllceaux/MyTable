_MyDefaultMy(MyStyle,Border)
_MyDefaultGetterSetterRedraw(MyStyle,Border,Margin,i)
_MyDefaultGetterSetterRedraw(MyStyle,Border,Padding,i)
_MyDefaultGetterSetterRedraw(MyStyle,Border,Size,i)
_MyDefaultGetterSetterRedraw(MyStyle,Border,Color,q)


Procedure _MyStyle_Border_Redraw(*this.strMyStyleBorder)
	ForEach *this\styles()
		_MyStyle_Style_Redraw(*this\styles())
	Next
EndProcedure