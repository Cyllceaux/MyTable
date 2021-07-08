IncludeFile "../MyGlobal/myglobalglobal.pb"

Global defaultfont=GetGadgetFont(#PB_Default)

Procedure MyTextCreate(x.i,y.i,w.i,h.i,text.s)
	Protected *this.strMyTextText=AllocateStructure(strMyTextText)
	With *this
		\vtable=?vtable_mytext
		\text=text
		\canvas=CanvasGadget(#PB_Any,x,y,w,h,#PB_Canvas_Keyboard)
		\x=GadgetX(\canvas)
		\y=GadgetY(\canvas)
		\w=GadgetWidth(\canvas)
		\h=GadgetHeight(\canvas)
		\window=GetActiveWindow()
		\redraw=#True
		\style=MyStyle::MyStyleCreate()
	EndWith
	_MyText_Text_Redraw(*this)
	ProcedureReturn *this
EndProcedure

Procedure _MyText_DrawText(*this.strMyTextText,*xywh.strXYWH)
	
	Protected color.q=0
	
	Protected valign=MyStyle::#MYSTYLE_VALIGN_TOP
	Protected halign=MyStyle::#MYSTYLE_HALIGN_LEFT
	
	If *this\style
		color=*this\style\GetFrontColor()
		valign=*this\style\GetVAlign()
		halign=*this\style\GetHAlign()
		
		Protected *font.MyFont::MyFont=*this\style\GetFont()
		If *font And *this\text<>""
			DrawingFont(*font\GetFontID())
		Else
			DrawingFont(defaultfont)
		EndIf
		
	Else
		DrawingFont(defaultfont)
	EndIf
	
	If *this\text<>""
		If *this\textheight=0
			*this\textheight=_My_TextHeight(*this\text)
		EndIf
		
		If *this\textwidth=0
			*this\textwidth=_My_TextWidth(*this\text)
		EndIf
	EndIf
	
	If *this\text<>""
		ClipOutput(*xywh\x,*xywh\y,*xywh\w,*xywh\h)
		
		If valign=MyStyle::#MYSTYLE_VALIGN_MIDDLE
			*xywh\y+(*xywh\h/2 - *this\textheight/2)
		ElseIf valign=MyStyle::#MYSTYLE_VALIGN_BOTTOM
			*xywh\y+*xywh\h-*this\textheight
		EndIf
		
		
		
		DrawingMode(#PB_2DDrawing_Transparent)
		Protected ttext.s=""
		If *this\style And *this\style\GetLinebreak()
			ttext=_My_LineBreakText(*this\text,*xywh\w)
		Else
			ttext=_My_ShortText(*this\text,*xywh\w)
		EndIf
		Protected c=CountString(ttext,#CRLF$)+1
		Protected i
		For i=1 To c
			Protected tt.s=StringField(ttext,i,#CRLF$)
			
			Protected x=*xywh\x
			
			If halign=MyStyle::#MYSTYLE_HALIGN_CENTER
				x+(*xywh\w/2-TextWidth(tt)/2)
			ElseIf halign=MyStyle::#MYSTYLE_HALIGN_RIGHT
				x+*xywh\w-TextWidth(tt)
			EndIf
			
			DrawText(x,*xywh\y,tt,color)
			*xywh\y+TextHeight(tt)
		Next
		UnclipOutput()
		*this\calcheight+*this\textheight
		*this\calcwidth+*this\textwidth
	EndIf
EndProcedure

Procedure _MyText_DrawCell(*this.strMyTextText,*xywh.strXYWH)
	If *this\style
		
		Box(0,0,*xywh\ow,*xywh\oh,*this\style\GetBackColor())
		
		
		Protected *borderTop.MyStyle::MyBorder=*this\style\GetBorder(MyStyle::#MYSTYLE_BORDER_TOP)
		Protected *borderLeft.MyStyle::MyBorder=*this\style\GetBorder(MyStyle::#MYSTYLE_BORDER_LEFT)
		Protected *borderRight.MyStyle::MyBorder=*this\style\GetBorder(MyStyle::#MYSTYLE_BORDER_RIGHT)
		Protected *borderBottom.MyStyle::MyBorder=*this\style\GetBorder(MyStyle::#MYSTYLE_BORDER_BOTTOM)
		
		If *borderTop
			*xywh\y+*borderTop\GetMargin()
			*xywh\h-*borderTop\GetMargin()
			
			*this\calcheight+*borderTop\GetMargin()
		EndIf
		
		If *borderLeft
			*xywh\x+*borderLeft\GetMargin()
			*xywh\w-*borderLeft\GetMargin()
			
			*this\calcwidth+*borderLeft\GetMargin()
		EndIf
		
		If *borderBottom
			*xywh\h-*borderBottom\GetMargin()
			
			*this\calcheight+*borderBottom\GetMargin()
		EndIf
		
		If *borderRight
			*xywh\w-*borderRight\GetMargin()
			
			*this\calcwidth+*borderRight\GetMargin()
		EndIf
		
		If *borderTop And *borderTop\GetSize()
			Box(*xywh\x,*xywh\y,*xywh\w,*borderTop\GetSize(),*borderTop\GetColor())
			*xywh\y+*borderTop\GetSize()
			*xywh\h-*borderTop\GetSize()
			
			*this\calcheight+*borderTop\GetSize()
		EndIf
		
		If *borderLeft And *borderLeft\GetSize()
			Box(*xywh\x,*xywh\y,*borderLeft\GetSize(),*xywh\h,*borderLeft\GetColor())
			*xywh\x+*borderLeft\GetSize()
			*xywh\w-*borderLeft\GetSize()
			
			*this\calcwidth+*borderLeft\GetSize()
		EndIf
		
		If *borderBottom And *borderBottom\GetSize()
			Box(*xywh\x,*xywh\y+*xywh\h-*borderBottom\GetSize(),*xywh\w,*borderBottom\GetSize(),*borderBottom\GetColor())
			*xywh\h-*borderBottom\GetSize()
			
			*this\calcheight+*borderBottom\GetSize()
		EndIf
		
		If *borderRight And *borderRight\GetSize()
			Box(*xywh\x+*xywh\w-*borderRight\GetSize(),*xywh\y,*borderRight\GetSize(),*xywh\h,*borderRight\GetColor())
			*xywh\w-*borderRight\GetSize()
			
			*this\calcwidth+*borderRight\GetSize()
		EndIf
		
		If *borderTop
			*xywh\y+*borderTop\GetPadding()
			*xywh\h-*borderTop\GetPadding()
			
			*this\calcheight+*borderTop\GetPadding()
		EndIf
		
		If *borderLeft
			*xywh\x+*borderLeft\GetPadding()
			*xywh\w-*borderLeft\GetPadding()
			
			*this\calcwidth+*borderLeft\GetPadding()
		EndIf
		
		If *borderBottom
			*xywh\h-*borderBottom\GetPadding()
			
			*this\calcheight+*borderBottom\GetPadding()
		EndIf
		
		If *borderRight
			*xywh\w-*borderRight\GetPadding()
			
			*this\calcwidth+*borderRight\GetPadding()
		EndIf
		
		
	Else
		Box(0,0,*xywh\ow,*xywh\oh)
	EndIf
EndProcedure