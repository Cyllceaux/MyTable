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
		Protected *xywh.strXYWH=AllocateStructure(strXYWH)
		StartDrawing(CanvasOutput(*this\canvas))
		*xywh\ow=OutputWidth()
		*xywh\oh=OutputHeight()
		Box(0,0,*xywh\ow,*xywh\ow,#White)
		
		*xywh\w=*xywh\ow
		*xywh\h=*xywh\oh
		
		Protected custom.b=#False
		If *this\customDraw
			custom=*this\customDraw(*this,*xywh\x,*xywh\y,*xywh\w,*xywh\h)
		EndIf
		
		If Not custom
			
			
			*this\calcheight=0
			*this\calcwidth=0
			
			_MyText_DrawCell(*this,*xywh)
			
			
			If *this\text<>""
				_MyText_DrawText(*this,*xywh)
			EndIf
			
		EndIf
		
		StopDrawing()
		
		FreeStructure(*xywh)
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