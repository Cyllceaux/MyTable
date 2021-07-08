_MyDefaultMyGadget(MyText,Text)
_MyDefaultGetterSetterRedraw(MyText,Text,Text,s)
_MyDefaultGetterSetterPointerRedraw(MyText,Text,Style)

Procedure _MyText_Text_Redraw(*this.strMyTextText)
	If *this And *this\redraw
		StartDrawing(CanvasOutput(*this\canvas))
		Protected ow=OutputWidth()
		Protected oh=OutputHeight()
		
		Protected x,y
		
		If *this\style
			
			Protected *font.MyFont::MyFont=*this\style\GetFont()
			Protected *borderTop.MyStyle::MyBorder=*this\style\GetBorder(MyStyle::#MYSTYLE_BORDER_TOP)
			Protected *borderLeft.MyStyle::MyBorder=*this\style\GetBorder(MyStyle::#MYSTYLE_BORDER_LEFT)
			
			BackColor(*this\style\GetBackColor())
			FrontColor(*this\style\GetFrontColor())
			If *font
				DrawingFont(*font\GetFontID())
			EndIf
			Box(0,0,ow,oh,*this\style\GetBackColor())
		Else
			Box(0,0,ow,oh)
		EndIf
		
		
		DrawingMode(#PB_2DDrawing_Transparent)
		DrawText(x,y,*this\text)
		
		StopDrawing()
	EndIf
EndProcedure

Procedure _MyText_Text_Resize(*this.strMyTextText,x.i,y.i,w.i,h.i)
	If *this
		ResizeGadget(*this\canvas,x,y,w,h)
		*this\x=GadgetX(*this\canvas)
		*this\y=GadgetY(*this\canvas)
		*this\w=GadgetWidth(*this\canvas)
		*this\h=GadgetHeight(*this\canvas)
		_MyText_Text_Redraw(*this)
	EndIf
EndProcedure

Procedure _MyText_Text_Free(*this.strMyTextText)
	If *this
		FreeGadget(*this\canvas)
		FreeStructure(*this)
	EndIf
EndProcedure