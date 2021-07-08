_MyDefaultMyGadget(MyText,Text)
_MyDefaultGetter(MyText,Text,Text,s)
_MyDefaultGetterSetterPointerRedraw(MyText,Text,Style)

Procedure _MyText_Text_SetText(*this.strMyTextText,text.s)
	If *this
		*this\text=text
		*this\textheight=0
		*this\textwidth=0
		_MyText_Text_Redraw(*this)
	EndIf
EndProcedure


Procedure _MyText_Text_Redraw(*this.strMyTextText)
	If *this And *this\redraw
		StartDrawing(CanvasOutput(*this\canvas))
		Protected ow=OutputWidth()
		Protected oh=OutputHeight()
		
		Protected x,y,w,h
		Protected color.q
		w=ow
		h=oh
		
		Protected valign=MyStyle::#MYSTYLE_VALIGN_TOP
		Protected halign=MyStyle::#MYSTYLE_HALIGN_LEFT
		
		If *this\text<>""
			If *this\textheight=0
				*this\textheight=_My_TextHeight(*this\text)
			EndIf
			
			If *this\textwidth=0
				*this\textwidth=_My_TextWidth(*this\text)
			EndIf
		EndIf
		
		*this\calcheight=*this\textheight
		*this\calcwidth=*this\textwidth
		
		If *this\style
			
			Box(0,0,ow,oh,*this\style\GetBackColor())
			
			BackColor(*this\style\GetBackColor())
			FrontColor(*this\style\GetFrontColor())
			
			color=*this\style\GetFrontColor()
			
			Protected *font.MyFont::MyFont=*this\style\GetFont()
			Protected *borderTop.MyStyle::MyBorder=*this\style\GetBorder(MyStyle::#MYSTYLE_BORDER_TOP)
			Protected *borderLeft.MyStyle::MyBorder=*this\style\GetBorder(MyStyle::#MYSTYLE_BORDER_LEFT)
			Protected *borderRight.MyStyle::MyBorder=*this\style\GetBorder(MyStyle::#MYSTYLE_BORDER_RIGHT)
			Protected *borderBottom.MyStyle::MyBorder=*this\style\GetBorder(MyStyle::#MYSTYLE_BORDER_BOTTOM)
			
			If *borderTop
				y+*borderTop\GetMargin()
				h-*borderTop\GetMargin()
				
				*this\calcheight+*borderTop\GetMargin()
			EndIf
			
			If *borderLeft
				x+*borderLeft\GetMargin()
				w-*borderLeft\GetMargin()
				
				*this\calcwidth+*borderLeft\GetMargin()
			EndIf
			
			If *borderBottom
				h-*borderBottom\GetMargin()
				
				*this\calcheight+*borderBottom\GetMargin()
			EndIf
			
			If *borderRight
				w-*borderRight\GetMargin()
				
				*this\calcwidth+*borderRight\GetMargin()
			EndIf
			
			If *borderTop And *borderTop\GetSize()
				Box(x,y,w,*borderTop\GetSize(),*borderTop\GetColor())
				y+*borderTop\GetSize()
				h-*borderTop\GetSize()
				
				*this\calcheight+*borderTop\GetSize()
			EndIf
			
			If *borderLeft And *borderLeft\GetSize()
				Box(x,y,*borderLeft\GetSize(),h,*borderLeft\GetColor())
				x+*borderLeft\GetSize()
				w-*borderLeft\GetSize()
				
				*this\calcwidth+*borderLeft\GetSize()
			EndIf
			
			If *borderBottom And *borderBottom\GetSize()
				Box(x,y+h-*borderBottom\GetSize(),w,*borderBottom\GetSize(),*borderBottom\GetColor())
				h-*borderBottom\GetSize()
				
				*this\calcheight+*borderBottom\GetSize()
			EndIf
			
			If *borderRight And *borderRight\GetSize()
				Box(x+w-*borderRight\GetSize(),y,*borderRight\GetSize(),h,*borderRight\GetColor())
				w-*borderRight\GetSize()
				
				*this\calcwidth+*borderRight\GetSize()
			EndIf
			
			If *borderTop
				y+*borderTop\GetPadding()
				h-*borderTop\GetPadding()
				
				*this\calcheight+*borderTop\GetPadding()
			EndIf
			
			If *borderLeft
				x+*borderLeft\GetPadding()
				w-*borderLeft\GetPadding()
				
				*this\calcwidth+*borderLeft\GetPadding()
			EndIf
			
			If *borderBottom
				h-*borderBottom\GetPadding()
				
				*this\calcheight+*borderBottom\GetPadding()
			EndIf
			
			If *borderRight
				w-*borderRight\GetPadding()
				
				*this\calcwidth+*borderRight\GetPadding()
			EndIf
			
			valign=*this\style\GetVAlign()
			halign=*this\style\GetHAlign()
			
			If *font And *this\text<>""
				DrawingFont(*font\GetFontID())
			EndIf
			
		Else
			Box(0,0,ow,oh)
		EndIf
		
		If *this\text<>""
			_MyText_DrawText(*this\text,x,y,w,h,*this\textwidth,*this\textheight,valign,halign,color)
		EndIf
		
		
		
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