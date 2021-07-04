Procedure _MySplitter_LeftButtonUp()
	Protected *this.strMySplitterSplitter=GetGadgetData(EventGadget())
EndProcedure

Procedure _MySplitter_LeftButtonDown()
	Protected *this.strMySplitterSplitter=GetGadgetData(EventGadget())
	Protected vertical.b=_Mysplitter_Splitter_IsVertical(*this)
	*this\oldx=GetGadgetAttribute(*this\canvas,#PB_Canvas_MouseX)
	*this\oldy=GetGadgetAttribute(*this\canvas,#PB_Canvas_MouseY)
EndProcedure

Procedure _MySplitter_MouseMove()
	Protected *this.strMySplitterSplitter=GetGadgetData(EventGadget())
	Protected vertical.b=_Mysplitter_Splitter_IsVertical(*this)
	Protected md.b=Bool(GetGadgetAttribute(*this\canvas,#PB_Canvas_Buttons) & #PB_Canvas_LeftButton)
	Protected x=GetGadgetAttribute(*this\canvas,#PB_Canvas_MouseX)
	Protected y=GetGadgetAttribute(*this\canvas,#PB_Canvas_MouseY)
	If _Mysplitter_Splitter_IsSizeable(*this)
		If vertical
			SetGadgetAttribute(*this\canvas,#PB_Canvas_Cursor,#PB_Cursor_LeftRight)
			If md
				*this\value-(*this\oldx-x)			
				_MySplitter_Splitter_Redraw(*this)			
			EndIf
		Else
			SetGadgetAttribute(*this\canvas,#PB_Canvas_Cursor,#PB_Cursor_UpDown)
			If md
				*this\value-(*this\oldy-y)
				_MySplitter_Splitter_Redraw(*this)			
			EndIf
		EndIf
	EndIf
EndProcedure

Procedure _MySplitterInitSplitter(*splitter.strMySplitterSplitter,
                                  x.i,
                                  y.i,
                                  w.i,
                                  h.i,
                                  gadget1.i,
                                  gadget2.i,
                                  flags.i)
	With *splitter
		\flags=flags
		\type=My::#MY_TYPE_SPLITTER
		\vtable=?vtable_splitter
		\gadget1=gadget1
		\gadget2=gadget2
		\x=x
		\y=y
		\w=w
		\h=h
		\separatorsize=5
		If _Mysplitter_Splitter_IsVertical(*splitter)
			\value=w/2-\separatorsize/2
		Else
			\value=h/2-\separatorsize/2
		EndIf			
		\canvas=CanvasGadget(#PB_Any,0,0,0,0)		
		SetGadgetData(\canvas,*splitter)
		BindGadgetEvent(\canvas,@_MySplitter_MouseMove(),#PB_EventType_MouseMove)
		BindGadgetEvent(\canvas,@_MySplitter_LeftButtonDown(),#PB_EventType_LeftButtonDown)
		BindGadgetEvent(\canvas,@_MySplitter_LeftButtonUp(),#PB_EventType_LeftButtonUp)
		
		_MySplitter_Splitter_Redraw(*splitter)
	EndWith
EndProcedure


Procedure MySplitterCreateSplitter(x.i,y.i,w.i,h.i,gadget1.i=0,gadget2.i=0,flags.i=0)
	Protected *this.strMySplitterSplitter=AllocateStructure(strMySplitterSplitter)
	_MySplitterInitSplitter(*this,x,y,w,h,gadget1,gadget2,flags)
	ProcedureReturn *this
EndProcedure

Procedure.b _Mysplitter_Splitter_IsVertical(*this.strMySplitterSplitter)
	If *this
		ProcedureReturn Bool(*this\flags & #MYSPLITTER_FLAGS_VERTICAL)
	EndIf
EndProcedure

Procedure.b _Mysplitter_Splitter_IsFirstFixed(*this.strMySplitterSplitter)
	If *this
		ProcedureReturn Bool(*this\flags & #MYSPLITTER_FLAGS_FIRSTFIXED)
	EndIf
EndProcedure

Procedure.b _Mysplitter_Splitter_IsSecondFixed(*this.strMySplitterSplitter)
	If *this
		ProcedureReturn Bool(*this\flags & #MYSPLITTER_FLAGS_SECONDFIXED)
	EndIf
EndProcedure

Procedure.b _Mysplitter_Splitter_IsSizeable(*this.strMySplitterSplitter)
	If *this
		ProcedureReturn Bool(Not Bool(*this\flags & #MYSPLITTER_FLAGS_NO_SIZEABLE))
	EndIf
EndProcedure

Procedure _MySplitter_Splitter_Check(*this.strMySplitterSplitter)
	Protected vertical.b=_Mysplitter_Splitter_IsVertical(*this)
	If vertical				
		If *this\value<*this\minsizegadget1
			*this\value=*this\minsizegadget1
		EndIf
		If *this\value>(*this\w-*this\minsizegadget2-*this\separatorsize)
			*this\value=(*this\w-*this\minsizegadget2-*this\separatorsize)
		EndIf		
	Else		
		If *this\value<*this\minsizegadget1
			*this\value=*this\minsizegadget1
		EndIf
		If *this\value>(*this\h-*this\minsizegadget2-*this\separatorsize)
			*this\value=(*this\h-*this\minsizegadget2-*this\separatorsize)
		EndIf		
	EndIf
EndProcedure