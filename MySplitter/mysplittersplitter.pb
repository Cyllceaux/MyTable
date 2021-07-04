_SimpleGetter(Mysplitter,Splitter,Type,i)
_SimpleSetterGetterRedraw(Mysplitter,Splitter,Value,i)
_SimpleSetterGetterRedraw(Mysplitter,Splitter,Flags,i)
_SimpleSetterGetterRedraw(Mysplitter,Splitter,Gadget1,i)
_SimpleSetterGetterRedraw(Mysplitter,Splitter,Gadget2,i)
_SimpleSetterGetterRedraw(Mysplitter,Splitter,MinSizeGadget1,i)
_SimpleSetterGetterRedraw(Mysplitter,Splitter,MinSizeGadget2,i)
_SimpleSetterGetterRedraw(Mysplitter,Splitter,SeparatorSize,i)
_BindEvent(MySplitter,Splitter,CustomDraw)

Procedure _MySplitter_Splitter_Draw(*this.strMySplitterSplitter)
	Protected customdraw.b=#False		
	
	StartDrawing(CanvasOutput(*this\canvas))
	If *this\EventCustomDraw
		CustomDraw=*this\EventCustomDraw(*this)
	EndIf
	
	If Not CustomDraw
		Box(0,0,OutputWidth(),OutputHeight(),RGBA(100,100,100,255))			
		Box(0,0,OutputWidth()-2,OutputHeight()-2,RGBA(200,200,200,255))
	EndIf

	StopDrawing()	
EndProcedure

Procedure _MySplitter_Splitter_Redraw(*this.strMySplitterSplitter)
	If *this
		Protected *obj.strMyVTable=0
		Protected *spl.MySplitter=0
		Protected vertical.b=_Mysplitter_Splitter_IsVertical(*this)
		_MySplitter_Splitter_Check(*this)
		If vertical
			ResizeGadget(*this\canvas,
			             *this\x+*this\value,
			             *this\y,
			             *this\separatorsize,
			             *this\y+*this\h)
			
			If *this\gadget1
				If IsGadget(*this\gadget1)
					ResizeGadget(*this\gadget1,
					             *this\x,
					             *this\y,
					             *this\value,
					             *this\h)
				Else
					*obj=*this\gadget1
					Select *obj\type
						Case my::#MY_TYPE_SPLITTER						
							*spl=*obj
							*spl\Resize(*this\x,
							            *this\y,
							            *this\value,
							            *this\h)
					EndSelect
				EndIf
			EndIf
			
			If *this\gadget2
				If IsGadget(*this\gadget2)
					ResizeGadget(*this\gadget2,
					             *this\x+*this\value+*this\separatorsize,
					             *this\y,
					             *this\w-*this\value-*this\separatorsize,
					             *this\h)
				Else
					*obj=*this\gadget2
					Select *obj\type
						Case my::#MY_TYPE_SPLITTER						
							*spl=*obj
							*spl\Resize(*this\x+*this\value+*this\separatorsize,
							            *this\y,
							            *this\w-*this\value-*this\separatorsize,
							            *this\h)
					EndSelect
				EndIf
			EndIf
			
		Else
			ResizeGadget(*this\canvas,
			             *this\x,
			             *this\y+*this\value,
			             *this\x+*this\w,
			             *this\separatorsize)
			
			If *this\gadget1
				If IsGadget(*this\gadget1)
					ResizeGadget(*this\gadget1,
					             *this\x,
					             *this\y,
					             *this\w,
					             *this\value)
				Else
					*obj=*this\gadget1
					Select *obj\type
						Case my::#MY_TYPE_SPLITTER						
							*spl=*obj
							*spl\Resize(*this\x,
							            *this\y,
							            *this\w,
							            *this\value)
					EndSelect
				EndIf
			EndIf
			
			If *this\gadget2
				If IsGadget(*this\gadget2)
					ResizeGadget(*this\gadget2,
					             *this\x,
					             *this\y+*this\value+*this\separatorsize,
					             *this\w,
					             *this\h-*this\value-*this\separatorsize)
				Else
					*obj=*this\gadget2
					Select *obj\type
						Case my::#MY_TYPE_SPLITTER						
							*spl=*obj
							*spl\Resize( *this\x,
							             *this\y+*this\value+*this\separatorsize,
							             *this\w,
							             *this\h-*this\value-*this\separatorsize)
					EndSelect
				EndIf
			EndIf
		EndIf
		
		_MySplitter_Splitter_Draw(*this)	
	EndIf
EndProcedure

Procedure _MySplitter_Splitter_Resize(*this.strMySplitterSplitter,x.i=#PB_Ignore,y.i=#PB_Ignore,w.i=#PB_Ignore,h.i=#PB_Ignore)
	If *this
		Protected nvalue.i=*this\value
		Protected mw=*this\x+*this\w
		Protected mh=*this\y+*this\h
		
		If x<>#PB_Ignore
			*this\x=x
		EndIf
		If y<>#PB_Ignore
			*this\y=y
		EndIf
		If w<>#PB_Ignore
			*this\w=w
		EndIf
		If h<>#PB_Ignore
			*this\h=h
		EndIf
		
		Protected nw=*this\x+*this\w
		Protected nh=*this\y+*this\h
		
		If nh<>mh Or nw<>mw
			
			Protected vertical.b=_Mysplitter_Splitter_IsVertical(*this)
			
			If _Mysplitter_Splitter_IsFirstFixed(*this)
				
			ElseIf _Mysplitter_Splitter_IsSecondFixed(*this)
				If vertical
					*this\value-(mw-nw)
				Else
					*this\value-(mh-nh)
				EndIf
			Else
				If vertical
					*this\value=*this\w/2-*this\separatorsize/2
				Else
					*this\value=*this\h/2-*this\separatorsize/2
				EndIf
			EndIf
		EndIf
	EndIf
	_MySplitter_Splitter_Redraw(*this)
EndProcedure