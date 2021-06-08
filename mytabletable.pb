Global MyTableW1=DesktopScaledX(1)
Global MyTableW2=DesktopScaledX(2)
Global MyTableW4=DesktopScaledX(4)
Global MyTableW7=DesktopScaledX(7)
Global MyTableW8=DesktopScaledX(8)
Global MyTableW10=DesktopScaledX(10)
Global MyTableW12=DesktopScaledX(12)
Global MyTableW14=DesktopScaledX(14)
Global MyTableW16=DesktopScaledX(16)
Global MyTableW20=DesktopScaledX(20)
Global MyTableH1=DesktopScaledY(1)
Global MyTableH2=DesktopScaledY(2)
Global MyTableH4=DesktopScaledY(4)
Global MyTableH6=DesktopScaledY(6)
Global MyTableH7=DesktopScaledY(7)
Global MyTableH8=DesktopScaledY(8)
Global MyTableH10=DesktopScaledY(10)
Global MyTableH12=DesktopScaledY(12)
Global MyTableH14=DesktopScaledY(14)
Global MyTableH16=DesktopScaledY(16)

Global MyTableDefaultImageSortAsc=CreateImage(#PB_Any,MyTableW16,MyTableH16,32,#PB_Image_Transparent)
Global MyTableDefaultImageSortDesc=CreateImage(#PB_Any,MyTableW16,MyTableH16,32,#PB_Image_Transparent)
Global MyTableDefaultImagePlus=CreateImage(#PB_Any,MyTableW16,MyTableH16,32,#PB_Image_Transparent)
Global MyTableDefaultImageMinus=CreateImage(#PB_Any,MyTableW16,MyTableH16,32,#PB_Image_Transparent)
Global MyTableDefaultImageCheckBox=CreateImage(#PB_Any,MyTableW16,MyTableH16,32,#PB_Image_Transparent)
Global MyTableDefaultImageCheckBoxChecked=CreateImage(#PB_Any,MyTableW16,MyTableH16,32,#PB_Image_Transparent)
Global MyTableDefaultImagePlusArrow=CreateImage(#PB_Any,MyTableW16,MyTableH16,32,#PB_Image_Transparent)
Global MyTableDefaultImageMinusArrow=CreateImage(#PB_Any,MyTableW16,MyTableH16,32,#PB_Image_Transparent)


StartDrawing(ImageOutput(MyTableDefaultImageSortAsc))
DrawingMode(#PB_2DDrawing_AlphaBlend)
LineXY(MyTableW2,MyTableH8,MyTableW8,MyTableH2,RGBA(0,0,0,255))
LineXY(MyTableW8,MyTableH2,MyTableW14,MyTableH8,RGBA(0,0,0,255))
LineXY(MyTableW2,MyTableH8,MyTableW14,MyTableH8,RGBA(0,0,0,255))
StopDrawing()

StartDrawing(ImageOutput(MyTableDefaultImageSortDesc))
DrawingMode(#PB_2DDrawing_AlphaBlend)
LineXY(MyTableW2,MyTableH8,MyTableW8,MyTableH14,RGBA(0,0,0,255))
LineXY(MyTableW8,MyTableH14,MyTableW14,MyTableH8,RGBA(0,0,0,255))
LineXY(MyTableW2,MyTableH8,MyTableW14,MyTableH8,RGBA(0,0,0,255))
StopDrawing()

StartDrawing(ImageOutput(MyTableDefaultImagePlus))
DrawingMode(#PB_2DDrawing_Outlined|#PB_2DDrawing_AlphaBlend)
Box(MyTableW2,MyTableH2,MyTableW12,MyTableH12,RGBA(0,0,0,255))
LineXY(MyTableW4,MyTableH7,MyTableW10,MyTableH7,RGBA(0,0,0,255))
LineXY(MyTableW7,MyTableH4,MyTableW7,MyTableH10,RGBA(0,0,0,255))
StopDrawing()

StartDrawing(ImageOutput(MyTableDefaultImageMinus))
DrawingMode(#PB_2DDrawing_Outlined|#PB_2DDrawing_AlphaBlend)
Box(MyTableW2,MyTableH2,MyTableW12,MyTableH12,RGBA(0,0,0,255))
LineXY(MyTableW4,MyTableH7,MyTableW10,MyTableH7,RGBA(0,0,0,255))
StopDrawing()

StartDrawing(ImageOutput(MyTableDefaultImageCheckBox))
DrawingMode(#PB_2DDrawing_Outlined|#PB_2DDrawing_AlphaBlend)
Box(MyTableW2,MyTableH2,MyTableW12,MyTableH12,RGBA(0,0,0,255))
StopDrawing()

StartDrawing(ImageOutput(MyTableDefaultImageCheckBoxChecked))
DrawingMode(#PB_2DDrawing_Outlined|#PB_2DDrawing_AlphaBlend)
Box(MyTableW2,MyTableH2,MyTableW12,MyTableH12,RGBA(0,0,0,255))
LineXY(MyTableW4,MyTableH4,MyTableW12,MyTableH12,RGBA(0,0,0,255))
LineXY(MyTableW4,MyTableH12,MyTableW12,MyTableH4,RGBA(0,0,0,255))
StopDrawing()

StartDrawing(ImageOutput(MyTableDefaultImagePlusArrow))
DrawingMode(#PB_2DDrawing_AlphaBlend)
LineXY(MyTableW8,MyTableH4,MyTableW12,MyTableH8,RGBA(0,0,0,255))
LineXY(MyTableW8,MyTableH12,MyTableW12,MyTableH8,RGBA(0,0,0,255))
StopDrawing()

StartDrawing(ImageOutput(MyTableDefaultImageMinusArrow))
DrawingMode(#PB_2DDrawing_AlphaBlend)
LineXY(MyTableW4,MyTableH6,MyTableW8,MyTableH10,RGBA(0,0,0,255))
LineXY(MyTableW8,MyTableH10,MyTableW12,MyTableH6,RGBA(0,0,0,255))
StopDrawing()

Procedure _MyTable_Table_GetType(*this.strMyTableTable)
	If *this
		ProcedureReturn *this\type
	EndIf
EndProcedure

Procedure _MyTable_Table_GetFlags(*this.strMyTableTable)
	If *this
		ProcedureReturn *this\flags
	EndIf
EndProcedure

Procedure _MyTable_Table_SetFlags(*this.strMyTableTable,value.i)
	If *this
		*this\flags=value
		*this\dirty=#True
		_MyTable_Table_Redraw(*this)
	EndIf
EndProcedure

Procedure.s _MyTable_Table_GetTitle(*this.strMyTableTable)
	If *this
		ProcedureReturn *this\title
	EndIf
EndProcedure

Procedure _MyTable_Table_SetTitle(*this.strMyTableTable,value.s)
	If *this
		*this\title=value
	EndIf
EndProcedure


Procedure.s _MyTable_Table_GetName(*this.strMyTableTable)
	If *this
		ProcedureReturn *this\name
	EndIf
EndProcedure

Procedure _MyTable_Table_SetName(*this.strMyTableTable,value.s)
	If *this
		Protected nname.s=_MyTableCleanName(value)
		If *this\application
			If nname<>*this\name
				If nname=""
					While _MyTable_Application_HasName(*this\application,"Table"+*this\application\lastindex)
						*this\application\lastindex+1
					Wend
					*this\name="Table"+*this\application\lastindex
				Else
					If Not _MyTable_Application_HasName(*this\application,nname)
						*this\name=nname
					EndIf
				EndIf
			EndIf
		Else
			*this\name=nname
		EndIf
	EndIf
EndProcedure


Procedure _MyTable_Table_AddRow(*this.strMyTableTable,text.s,sep.s="|",image.i=0,flags.i=0)
	If *this
		Protected *row.strMyTableRow=AddElement(*this\rows())
		_MyTableInitRow(*this\application,*this,0,*row,text,sep,image,flags)
		*this\dirty=#True
		_MyTable_Table_Predraw(*this)
		_MyTable_Table_Redraw(*this)
		ProcedureReturn *row
	EndIf
EndProcedure

Procedure _MyTable_Table_AddDirtyRows(*this.strMyTableTable,rows.i)
	If *this
		_callcountStart(table_adddirtyrows)
		Protected idx
		LastElement(*this\rows())
		For idx=1 To rows
			Protected *row.strMyTableRow=AddElement(*this\rows())
			_MyTableInitRow(*this\application,*this,0,*row,"","",0,0)
			*this\dirty=#True
		Next
		_callcountEnde(table_adddirtyrows)
		_MyTable_Table_Predraw(*this)
		_MyTable_Table_Redraw(*this)
	EndIf
EndProcedure

Procedure _MyTable_Table_AddCol(*this.strMyTableTable,text.s,width.i,image.i=0,flags.i=0)
	If *this
		Protected *col.strMyTableCol=AddElement(*this\cols())
		_MyTableInitCol(*this\application,*this,*col,text,width,image,flags)
		*this\dirty=#True
		_MyTable_Table_Predraw(*this)
		_MyTable_Table_Redraw(*this)
		ProcedureReturn *col
	EndIf
EndProcedure

Procedure _MyTable_Table_Delete(*this.strMyTableTable)
	If *this
		If IsGadget(*this\canvas)				
			UnbindGadgetEvent(*this\canvas,@_MyTableEvtResize(),#PB_EventType_Resize)
			UnbindGadgetEvent(*this\canvas,@_MyTableEvtCanvasScroll(),#PB_EventType_MouseWheel)
			UnbindGadgetEvent(*this\canvas,@_MyTableEvtCanvasMouseMove(),#PB_EventType_MouseMove)
			UnbindGadgetEvent(*this\canvas,@_MyTableEvtCanvasMouseLeftDown(),#PB_EventType_LeftButtonDown)
			UnbindGadgetEvent(*this\canvas,@_MyTableEvtCanvasMouseLeftUp(),#PB_EventType_LeftButtonUp)
			UnbindGadgetEvent(*this\canvas,@_MyTableEvtCanvasMouseLeftUp(),#PB_EventType_LostFocus)
			UnbindGadgetEvent(*this\canvas,@_MyTableEvtCanvasMouseLeftDouble(),#PB_EventType_LeftDoubleClick)
			UnbindGadgetEvent(*this\canvas,@_MyTableEvtCanvasMouseRightDown(),#PB_EventType_RightButtonDown)
			UnbindGadgetEvent(*this\canvas,@_MyTableEvtCanvasMouseRightUp(),#PB_EventType_RightButtonUp)
			UnbindGadgetEvent(*this\canvas,@_MyTableEvtCanvasMouseRightDouble(),#PB_EventType_RightDoubleClick)
			UnbindGadgetEvent(*this\canvas,@_MyTableEvtCanvasKeyDown(),#PB_EventType_KeyDown)
		EndIf
		If IsGadget(*this\vscroll)
			UnbindGadgetEvent(*this\vscroll,@_MyTableEvtScroll())
		EndIf
		If IsGadget(*this\hscroll)
			UnbindGadgetEvent(*this\hscroll,@_MyTableEvtScroll())
		EndIf
		
		If *this\application
			Protected idx=0
			ForEach *this\application\tables()
				If *this\application\tables()=*this
					DeleteElement(*this\application\tables())
				Else
					*this\application\tables()\listindex=idx
					idx+1
				EndIf
			Next
		Else
			FreeStructure(*this)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Table_Free(*this.strMyTableTable)
	_MyTable_Table_Delete(*this)
EndProcedure

Procedure _MyTable_Table_GetData(*this.strMyTableTable)
	If *this
		ProcedureReturn *this\data
	EndIf
EndProcedure

Procedure _MyTable_Table_SetData(*this.strMyTableTable,*value)
	If *this
		*this\data=*value
	EndIf
EndProcedure

Procedure _MyTable_Table_ClearRows(*this.strMyTableTable,*value)
	If *this
		ClearList(*this\rows())
		*this\dirty=#True
		_MyTable_Table_Predraw(*this)
		_MyTable_Table_Redraw(*this)
	EndIf
EndProcedure

Procedure _MyTable_Table_ClearCols(*this.strMyTableTable,*value)
	If *this
		ClearList(*this\cols())				
		ForEach *this\rows()
			If *this\rows()\cells				
				FreeStructure(*this\rows()\cells)
				*this\rows()\cells=0
			EndIf
		Next
		*this\dirty=#True
		_MyTable_Table_Predraw(*this)
		_MyTable_Table_Redraw(*this)
	EndIf
EndProcedure

Procedure.q _MyTable_GetBackColor(*this.strMyTableStyleObject)
	If *this
		Protected result.q=0
		_MyTableStyleGetRow(*this,backcolor)
		ProcedureReturn result
	EndIf
EndProcedure

Procedure.q _MyTable_GetFrontColor(*this.strMyTableStyleObject)
	If *this
		Protected result.q=0
		_MyTableStyleGetRow(*this,frontcolor)
		ProcedureReturn result
	EndIf
EndProcedure

Procedure.q _MyTable_GetForeColor(*this.strMyTableStyleObject)
	If *this
		Protected result.q=0
		_MyTableStyleGetRow(*this,forecolor)
		ProcedureReturn result
	EndIf
EndProcedure

Procedure.q _MyTable_GetSelectedColor(*this.strMyTableStyleObject)
	If *this
		Protected result.q=0
		_MyTableStyleGet(*this,selectedcolor)
		ProcedureReturn result
	EndIf
EndProcedure

Procedure.q _MyTable_GetSelectedForeColor(*this.strMyTableStyleObject)
	If *this
		Protected result.q=0
		_MyTableStyleGet(*this,selectedforecolor)
		ProcedureReturn result
	EndIf
EndProcedure

Procedure.q _MyTable_GetBorderColor(*this.strMyTableStyleObject)
	If *this
		Protected result.q=0
		_MyTableStyleGetRow(*this,border\bordercolor)
		ProcedureReturn result
	EndIf
EndProcedure

Procedure.q _MyTable_GetSelectedBorderColor(*this.strMyTableStyleObject)
	If *this
		Protected result.q=0
		_MyTableStyleGet(*this,border\selectedbordercolor)
		ProcedureReturn result
	EndIf
EndProcedure

Procedure _MyTable_GetVAlign(*this.strMyTableStyleObject)
	If *this
		Protected result.i=0
		_MyTableStyleGetRow(*this,valign)
		ProcedureReturn result
	EndIf
EndProcedure

Procedure _MyTable_GetHAlign(*this.strMyTableStyleObject)
	If *this
		Protected result.i=0
		_MyTableStyleGetCol(*this,halign)
		ProcedureReturn result
	EndIf
EndProcedure

Procedure _MyTable_Table_Draw_Header(*this.strMyTableTable,font.i,width.i,height.i,scrollx.i,scrolly.i)
	Protected bx=-scrollx
	ForEach *this\cols()
		Protected *col.strMyTableCol=*this\cols()
		Protected selected.b=Bool(*this\selectedcols(Str(*col)) Or *this\selectall)
		
		If *col\dirty
			*col\calcwidth=DesktopScaledX(*col\width)
			
			*col\textwidth=_MyTableTextWidth(*col\text)
			*col\textheight=_MyTableTextHeight(*col\text)
			
			*col\dirty=#False
		EndIf
		
		If *col\calcwidth>0
			
			Protected addx=DesktopScaledX(2)
			Protected addy=0
			Protected valign=_MyTable_GetVAlign(*col)
			Protected halign=_MyTable_GetHAlign(*col)
			
			
			
			DrawingMode(#PB_2DDrawing_Default)
			BackColor(_MyTable_GetBackColor(*col))
			FrontColor(_MyTable_GetFrontColor(*col))
			ClipOutput(bx,0,*col\calcwidth,*this\calcheaderheight)
			Box(bx,0,*col\calcwidth,*this\calcheaderheight,_MyTable_GetBackColor(*col))
			
			If *col\image\orig And IsImage(*col\image\orig)
				addx+DesktopScaledX(2)
				If Not *col\image\sized
					*col\image\sized=CopyImage(*col\image\orig,#PB_Any)
					ResizeImage(*col\image\sized,*this\calcheaderheight-MyTableW8,*this\calcheaderheight-MyTableH8)
				EndIf
				DrawingMode(#PB_2DDrawing_AlphaClip)
				DrawImage(ImageID(*col\image\sized),bx+addx,addy+MyTableW4)
				DrawingMode(#PB_2DDrawing_Default)
				addx+*this\calcheaderheight
			EndIf
			
			If halign=#MYTABLE_STYLE_HALIGN_CENTER
				If *col\sort
					addx+(*col\calcwidth /2- addx - MyTableW20)-*col\textwidth/2
				Else
					addx+(*col\calcwidth /2- addx)-*col\textwidth/2
				EndIf
			ElseIf halign=#MYTABLE_STYLE_HALIGN_RIGHT
				addx+*col\calcwidth - *col\textwidth - MyTableW8 - addx
				If *col\sort
					addx - MyTableW20
				EndIf
			Else
				addx+DesktopScaledX(2)
			EndIf
			
			If valign=#MYTABLE_STYLE_VALIGN_MIDDLE
				addy+*this\calcheaderheight/2 - *col\textheight/2
			ElseIf valign=#MYTABLE_STYLE_VALIGN_BOTTOM
				addy+*this\calcheaderheight-*col\textheight-MyTableH1			
			Else
				addy+DesktopScaledY(1)
			EndIf
			
			DrawingMode(#PB_2DDrawing_AlphaClip)
			Select *col\sort
				Case #MYTABLE_COL_SORT_ASC
					DrawImage(ImageID(MyTableDefaultImageSortAsc),bx+*col\calcwidth-MyTableW20,0)
				Case #MYTABLE_COL_SORT_DESC
					DrawImage(ImageID(MyTableDefaultImageSortDesc),bx+*col\calcwidth-MyTableW20,0)
			EndSelect
			
			DrawingMode(#PB_2DDrawing_Default)
			DrawText(bx+addx,addy,*col\text,_MyTable_GetForeColor(*col))
			DrawingMode(#PB_2DDrawing_Outlined)
			Box(bx,0,*col\calcwidth,*this\calcheaderheight,_MyTable_GetBorderColor(*col))
			UnclipOutput()
			bx+*col\calcwidth
			If bx>=width
				Break
			EndIf
		EndIf
	Next
	ProcedureReturn *this\calcheaderheight
EndProcedure

Procedure _MyTable_Table_Draw_Row(*this.strMyTableRow,by,cols,font.i,width.i,height.i,scrollx.i,scrolly.i)
	
	
	Protected bx=-scrollx
	Protected idx
	Protected hierarchical.b=Bool(*this\table\flags & #MYTABLE_TABLE_FLAGS_HIERARCHICAL)
	Protected checkboxes.b=#False
	Protected border.b=Bool(*this\table\flags & #MYTABLE_TABLE_FLAGS_BORDER)
	Protected callback.b=Bool(*this\table\flags & #MYTABLE_TABLE_FLAGS_CALLBACK)
	If callback And *this\dirty And *this\table\callback
		*this\table\callback(*this)
	EndIf
	Protected selected.b=#False
	For idx=1 To cols
		checkboxes=Bool(*this\table\flags & #MYTABLE_TABLE_FLAGS_CHECKBOXES)
		
		DrawingMode(#PB_2DDrawing_Default)			
		Protected *cell.strMyTableCell=_MyTableGetOrAddCell(*this,idx-1)
		
		
		selected=Bool(*this\table\selectedrows(Str(*this)) Or *this\table\selectall)
		selected=Bool(selected Or *this\table\selectedcols(Str(*cell\col)))
		selected=Bool(selected Or *this\table\selectedcells(Str(*cell)))
		selected=Bool(selected Or *this\table\tempselectedrows(Str(*this)))
		selected=Bool(selected Or *this\table\tempselectedcols(Str(*cell\col)))
		selected=Bool(selected Or *this\table\tempselectedcells(Str(*cell)))
		
		If *cell\dirty 
			If *cell\text<>""
				*cell\textheight=_MyTableTextHeight(*cell\text)
				*cell\textwidth=_MyTableTextWidth(*cell\text)
			Else
				*cell\textheight=0
				*cell\textwidth=0
			EndIf
			*cell\dirty=#False
		EndIf
		Protected *col.strMyTableCol=*cell\col
		If *col\calcwidth>0
			
			If selected
				Box(bx,by,*col\calcwidth,*this\calcheight,_MyTable_GetSelectedColor(*cell))
			Else
				Box(bx,by,*col\calcwidth,*this\calcheight,_MyTable_GetBackColor(*cell))
			EndIf
			
			
			Protected addx=DesktopScaledX(2)
			Protected addy=0
			Protected valign=_MyTable_GetVAlign(*cell)
			Protected halign=_MyTable_GetHAlign(*cell)
			
			If hierarchical
				If idx=1
					addx+*this\level*MyTableW20
					DrawingMode(#PB_2DDrawing_AlphaClip)
					If *this\rows
						If ListSize(*this\rows\rows())>0
							If *this\expanded
								DrawImage(ImageID(MyTableDefaultImageMinusArrow),bx+addx,by)
							Else
								DrawImage(ImageID(MyTableDefaultImagePlusArrow),bx+addx,by)
							EndIf
						EndIf
					EndIf
					DrawingMode(#PB_2DDrawing_Default)
					addx+MyTableW20
				EndIf
			EndIf
			
			If checkboxes
				If idx=1
					DrawingMode(#PB_2DDrawing_AlphaClip)				
					If *this\checked
						DrawImage(ImageID(MyTableDefaultImageCheckBoxChecked),bx+addx,by+MyTableH2)
					Else
						DrawImage(ImageID(MyTableDefaultImageCheckBox),bx+addx,by+MyTableH2)
					EndIf				
					DrawingMode(#PB_2DDrawing_Default)
					addx+MyTableW20
					
				EndIf
				
			EndIf
			checkboxes=#False
			checkboxes=Bool(checkboxes Or Bool(*cell\flags & #MYTABLE_CELL_FLAGS_CHECKBOXES) Or Bool(*col\flags & #MYTABLE_COL_FLAGS_CHECKBOXES))
			
			If idx=1
				If *this\image\orig And IsImage(*this\image\orig)
					addx+DesktopScaledX(2)
					If Not *this\image\sized
						*this\image\sized=CopyImage(*this\image\orig,#PB_Any)
						ResizeImage(*this\image\sized,*this\calcheight-MyTableW8,*this\calcheight-MyTableH8)
					EndIf
					DrawingMode(#PB_2DDrawing_AlphaClip)
					DrawImage(ImageID(*this\image\sized),bx+addx,by+addy+MyTableW4)
					DrawingMode(#PB_2DDrawing_Default)
					addx+*this\calcheight
				EndIf
			EndIf
			
			If *cell\image\orig And IsImage(*cell\image\orig)
				addx+DesktopScaledX(2)
				If Not *cell\image\sized
					*cell\image\sized=CopyImage(*cell\image\orig,#PB_Any)
					ResizeImage(*cell\image\sized,*this\calcheight-MyTableW8,*this\calcheight-MyTableH8)
				EndIf
				DrawingMode(#PB_2DDrawing_AlphaClip)
				DrawImage(ImageID(*cell\image\sized),bx+addx,by+addy+MyTableW4)
				DrawingMode(#PB_2DDrawing_Default)
				addx+*this\calcheight
			EndIf
			
			If halign=#MYTABLE_STYLE_HALIGN_CENTER
				If checkboxes And idx>1
					addx+(*col\calcwidth-addx - MyTableW20)/2-*cell\textwidth/2
				Else
					addx+(*col\calcwidth-addx)/2-*cell\textwidth/2
				EndIf
			ElseIf halign=#MYTABLE_STYLE_HALIGN_RIGHT
				addx+*col\calcwidth - *cell\textwidth - MyTableW8 -addx
				If checkboxes And idx>1
					addx-MyTableW20
				EndIf
			Else
				addx+DesktopScaledX(2)
			EndIf
			
			If valign=#MYTABLE_STYLE_VALIGN_MIDDLE
				addy+*this\calcheight/2 - *cell\textheight/2
			ElseIf valign=#MYTABLE_STYLE_VALIGN_BOTTOM
				addy+*this\calcheight-*cell\textheight-MyTableH1
			Else
				addy+DesktopScaledY(1)
			EndIf
			
			If checkboxes
				If idx>1
					DrawingMode(#PB_2DDrawing_AlphaClip)
					If *cell\checked
						DrawImage(ImageID(MyTableDefaultImageCheckBoxChecked),bx+addx,by+MyTableH2)
					Else
						DrawImage(ImageID(MyTableDefaultImageCheckBox),bx+addx,by+MyTableH2)
					EndIf
					DrawingMode(#PB_2DDrawing_Default)
					addx+MyTableW20
				EndIf			
			EndIf
			
			ClipOutput(bx,by,*col\calcwidth,*this\calcheight)
			If *cell\text<>""
				DrawingMode(#PB_2DDrawing_Transparent)	
				If selected
					DrawText(bx+addx,by+addy,*cell\text,_MyTable_GetSelectedForeColor(*cell))
				Else
					DrawText(bx+addx,by+addy,*cell\text,_MyTable_GetForeColor(*cell))
				EndIf
			EndIf
			If border
				DrawingMode(#PB_2DDrawing_Outlined)
				If selected
					Box(bx,by,*col\calcwidth,*this\calcheight,_MyTable_GetSelectedBorderColor(*cell))
				Else
					Box(bx,by,*col\calcwidth,*this\calcheight,_MyTable_GetBorderColor(*cell))
				EndIf
			EndIf
			UnclipOutput()
			bx+*col\calcwidth
			If bx>=width
				Break
			EndIf
		EndIf
	Next
	*this\dirty=#False
	ProcedureReturn *this\calcheight
EndProcedure

Procedure _MyTable_Table_Redraw(*this.strMyTableTable)
	If *this And *this\canvas
		_MyTable_Table_ClearMaps(*this)
		Protected redraw.b=Bool(*this\dirty And *this\redraw)
		Protected header.b=Bool(Not (*this\flags & #MYTABLE_TABLE_FLAGS_NO_HEADER))
		If *this\application
			redraw=Bool(redraw And *this\application\redraw)
		EndIf
		redraw=Bool(redraw And Not *this\drawing)
		If redraw
			_callcountStart(Redraw)
			If IsImage(*this\canvas)
				StartDrawing(ImageOutput(*this\canvas))
			EndIf
			If IsGadget(*this\canvas)
				StartDrawing(CanvasOutput(*this\canvas))
			EndIf
			*this\drawing=#True
			Protected font.i=*this\style\font
			Protected backcolor.q=_MyTable_GetBackColor(*this)
			Protected frontcolor.q=_MyTable_GetFrontColor(*this)
			
			Protected height=OutputHeight()
			Protected width=OutputWidth()
			
			Protected scrollx.i=*this\hscroll
			Protected scrolly.i=*this\vscroll
			If IsGadget(scrollx)
				scrollx=GetGadgetState(scrollx)
			EndIf
			If IsGadget(scrolly)
				scrolly=GetGadgetState(scrolly)
			EndIf
			
			scrollx=DesktopScaledX(scrollx)
			scrolly=DesktopScaledY(scrolly)
			
			If Not font 
				If *this\application
					font=*this\application\style\font
					If Not font
						font=GetGadgetFont(#PB_Default)
						*this\application\style\font=font
					EndIf
				Else
					font=GetGadgetFont(#PB_Default)
					*this\style\font=font
				EndIf
			EndIf
			
			DrawingFont(font)
			BackColor(backcolor)
			FrontColor(frontcolor)
			If backcolor<>frontcolor
				DrawingMode(#PB_2DDrawing_Gradient)
				LinearGradient(0,0,width,height)
			EndIf
			Box(0,0,width,height)
			
			Protected by=-scrolly
			If header
				by+*this\calcheaderheight
			EndIf
			Protected c=ListSize(*this\cols())
			ForEach *this\expRows()
				Protected *row.strMyTableRow=*this\expRows()
				If by+*row\calcheight>0
					_MyTable_Table_Draw_Row(*row,by,c,font,width,height,scrollx,scrolly)
				EndIf
				by+*row\calcheight
				If by>height
					Break
				EndIf
			Next
			
			If header
				_MyTable_Table_Draw_Header(*this,font,width,height,scrollx,scrolly)
			EndIf
			
			If IsGadget(*this\vscroll)
				BackColor(backcolor)
				FrontColor(frontcolor)
				DrawingMode(#PB_2DDrawing_Default)
				Box(width-GadgetWidth(*this\vscroll),height-GadgetHeight(*this\hscroll),GadgetWidth(*this\vscroll),GadgetHeight(*this\hscroll))
			EndIf
			*this\dirty=#False
			*this\drawing=#False
			StopDrawing()
			_callcountEnde(Redraw)
		EndIf
	EndIf
EndProcedure

Procedure.i _MyTable_Table_PredrawSub(*this.strMyTableTable,*row.strMyTableRow)
	Protected result.i=0
	If *row\rows
		ForEach *row\rows\rows()
			AddElement(*this\expRows())
			*this\expRows()=*row\rows\rows()
			result+*this\rows()\height
			If *row\rows\rows()\expanded And *row\rows\rows()\rows And ListSize(*row\rows\rows()\rows\rows())>0
				result+_MyTable_Table_PredrawSub(*this,*row\rows\rows())
			EndIf
		Next
	EndIf
	ProcedureReturn result
EndProcedure

Procedure _MyTable_Table_Predraw(*this.strMyTableTable)
	If *this
		If *this\redraw And *this\dirty And Not *this\drawing
			_callcountStart(Predraw)
			ClearList(*this\expRows())
			Protected h=0
			Protected w=0
			Protected hierarchical.b=Bool(*this\flags & #MYTABLE_TABLE_FLAGS_HIERARCHICAL)
			Protected header.b=Bool(Not(*this\flags & #MYTABLE_TABLE_FLAGS_NO_HEADER))
			If header
				h+*this\headerheight
			EndIf
			ForEach *this\rows()
				AddElement(*this\expRows())
				*this\expRows()=*this\rows()
				h+*this\rows()\height
				If hierarchical
					If *this\rows()\expanded And *this\rows()\rows And ListSize(*this\rows()\rows\rows())>0
						h+_MyTable_Table_PredrawSub(*this,*this\rows())
					EndIf
				EndIf
			Next
			
			Protected cw=0
			Protected ch=0
			
			If IsGadget(*this\canvas)
				cw=GadgetWidth(*this\canvas)
				ch=GadgetHeight(*this\canvas)
			EndIf
			If IsImage(*this\canvas)
				cw=ImageWidth(*this\canvas)
				ch=ImageHeight(*this\canvas)
			EndIf
			
			
			Protected cs.i=0
			ForEach *this\cols()
				If *this\cols()\stretched
					cs+1
				Else
					w+*this\cols()\width
				EndIf
			Next
			
			
			
			w-cw
			h-ch
			
			If IsGadget(*this\hscroll)
				If h>0
					w+GadgetWidth(*this\vscroll)
					ResizeGadget(*this\hscroll,#PB_Ignore,#PB_Ignore,cw-GadgetWidth(*this\vscroll),#PB_Ignore)
				ElseIf h=0
					ResizeGadget(*this\hscroll,#PB_Ignore,#PB_Ignore,cw,#PB_Ignore)
				Else
					ResizeGadget(*this\hscroll,#PB_Ignore,#PB_Ignore,cw-GadgetWidth(*this\vscroll),#PB_Ignore)
				EndIf
				
				If cs>0
					Protected cc=Abs(w)/cs
					Protected dcc=DesktopScaledX(cc)
					If cc>0
						ForEach *this\cols()
							If *this\cols()\stretched
								*this\cols()\width=cc
								*this\cols()\calcwidth=dcc
							EndIf
						Next
					Else
						ForEach *this\cols()
							If *this\cols()\stretched
								*this\cols()\width=0
								*this\cols()\calcwidth=0
							EndIf
						Next
					EndIf
				EndIf
				
				If w<0
					w=0
				EndIf
				
				If w>0
					HideGadget(*this\hscroll,#False)					
					SetGadgetAttribute(*this\hscroll,#PB_ScrollBar_Maximum,w)
				Else
					SetGadgetAttribute(*this\hscroll,#PB_ScrollBar_Maximum,0)
					HideGadget(*this\hscroll,#True)
					SetGadgetState(*this\hscroll,0)
				EndIf
			Else
				w-*this\hscroll
			EndIf
			
			If IsGadget(*this\vscroll)
				If w>0					
					h+GadgetHeight(*this\hscroll)		
					ResizeGadget(*this\vscroll,#PB_Ignore,#PB_Ignore,#PB_Ignore,ch-GadgetHeight(*this\hscroll))
				ElseIf w=0
					ResizeGadget(*this\vscroll,#PB_Ignore,#PB_Ignore,#PB_Ignore,ch)
				Else
					ResizeGadget(*this\vscroll,#PB_Ignore,#PB_Ignore,#PB_Ignore,ch-GadgetHeight(*this\hscroll))
				EndIf
				
				If h>0
					HideGadget(*this\vscroll,#False)
					SetGadgetAttribute(*this\vscroll,#PB_ScrollBar_Maximum,h)
				Else
					SetGadgetAttribute(*this\vscroll,#PB_ScrollBar_Maximum,0)
					HideGadget(*this\vscroll,#True)
					SetGadgetState(*this\vscroll,0)
				EndIf
			Else
				h-*this\vscroll
			EndIf
			
			_callcountEnde(Predraw)
		EndIf
	EndIf
EndProcedure

Procedure.b _MyTable_Table_GetRedraw(*this.strMyTableTable)
	If *this
		ProcedureReturn *this\redraw
	EndIf
EndProcedure

Procedure _MyTable_Table_SetRedraw(*this.strMyTableTable,value.b)
	If *this
		*this\redraw=value
		*this\dirty=#True
		If value
			_MyTable_Table_Predraw(*this)
			_MyTable_Table_Redraw(*this)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Table_Recalc(*this.strMyTableTable)
	If *this
		Protected recalc.b=*this\recalc
		If *this\application
			recalc=Bool(recalc And *this\application\recalc)
		EndIf
		If recalc And Not *this\drawing
			_callcountStart(Recalc)
			
			
			_callcountEnde(Recalc)
		EndIf
		
		_MyTable_Table_Redraw(*this)
	EndIf
EndProcedure

Procedure.b _MyTable_Table_GetRecalc(*this.strMyTableTable)
	If *this
		ProcedureReturn *this\recalc
	EndIf
EndProcedure

Procedure _MyTable_Table_SetRecalc(*this.strMyTableTable,value.b)
	If *this
		*this\recalc=value
		If value
			_MyTable_Table_Recalc(*this)
		EndIf
	EndIf
EndProcedure

Procedure.b _MyTable_Table_GetDirty(*this.strMyTableTable)
	If *this
		ProcedureReturn *this\dirty
	EndIf
EndProcedure

Procedure _MyTable_Table_GetHeaderHeight(*this.strMyTableTable)
	If *this
		ProcedureReturn *this\headerheight
	EndIf
EndProcedure

Procedure _MyTable_Table_GetDefaultRowHeight(*this.strMyTableTable)
	If *this
		ProcedureReturn *this\defaultrowheight
	EndIf
EndProcedure

Procedure _MyTable_Table_SetHeaderHeight(*this.strMyTableTable,value.i)
	If *this
		*this\headerheight=value
		*this\calcheaderheight=DesktopScaledY(*this\headerheight)
		*this\dirty=#True
		ForEach *this\cols()
			*this\cols()\dirty=#True
			If IsImage(*this\cols()\image\sized)
				FreeImage(*this\cols()\image\sized)
			EndIf
			*this\cols()\image\sized=0
		Next
		_MyTable_Table_Redraw(*this)
	EndIf
EndProcedure

Procedure _MyTable_Table_SetDefaultRowHeight(*this.strMyTableTable,value.i)
	If *this
		Protected old.i=*this\defaultrowheight
		*this\defaultrowheight=value
		*this\calcdefaultrowheight=DesktopScaledY(*this\defaultrowheight)
		*this\dirty=#True
		ForEach *this\rows()
			*this\rows()\dirty=#True
			If IsImage(*this\rows()\image\sized)
				FreeImage(*this\rows()\image\sized)
			EndIf
			*this\rows()\image\sized=0
			If *this\rows()\height=old
				*this\rows()\height=value
				*this\rows()\calcheight=*this\calcdefaultrowheight
			EndIf
		Next
		_MyTable_Table_Redraw(*this)
	EndIf
EndProcedure

Procedure _MyTable_Table_SetDirty(*this.strMyTableTable,value.b)
	If *this
		*this\dirty=value
		_MyTable_Table_Redraw(*this)
	EndIf
EndProcedure

Procedure _MyTable_Table_DeleteRow(*this.strMyTableTable,idx.i)
	If *this
		If ListSize(*this\rows())>idx
			_MyTable_Row_Delete(SelectElement(*this\rows(),idx))
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Table_DeleteCol(*this.strMyTableTable,idx.i)
	If *this
		If ListSize(*this\cols())>idx
			_MyTable_Col_Delete(SelectElement(*this\cols(),idx))
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Table_GetRow(*this.strMyTableTable,row.i)
	If *this
		If ListSize(*this\rows())>row
			ProcedureReturn SelectElement(*this\rows(),row)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Table_GetCol(*this.strMyTableTable,col.i)
	If *this
		If ListSize(*this\cols())>col
			ProcedureReturn SelectElement(*this\cols(),col)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Table_GetApplication(*this.strMyTableTable)
	If *this		
		ProcedureReturn *this\application
	EndIf
EndProcedure

Procedure _MyTable_Table_GetCell(*this.strMyTableTable,row.i,col.i)
	If *this
		If ListSize(*this\cols())>col And ListSize(*this\rows())>row
			ProcedureReturn _MyTableGetOrAddCell(SelectElement(*this\rows(),row),col)
		EndIf
	EndIf
EndProcedure

Procedure _MyTable_Table_GetStyle(*this.strMyTableTable)
	Protected *style.strMyTableStyleObject=AllocateStructure(strMyTableStyleObject)
	_MyTableInitStyleObject(*style,*this)
	ProcedureReturn *style
EndProcedure

Procedure _MyTable_Table_RowCount(*this.strMyTableTable)
	If *this
		ProcedureReturn ListSize(*this\rows())
	EndIf
EndProcedure

Procedure _MyTable_Table_ColCount(*this.strMyTableTable)
	If *this
		ProcedureReturn ListSize(*this\cols())
	EndIf
EndProcedure

Procedure _MyTable_Table_ClearMaps(*this.strMyTableTable)
	If *this
		If *this\selectall
			ClearMap(*this\selectedcells())
			ClearMap(*this\selectedrows())
			ClearMap(*this\selectedcols())
		Else
			ForEach *this\selectedcells()
				If Not *this\selectedcells()
					DeleteMapElement(*this\selectedcells())
				EndIf
			Next
			ForEach *this\selectedrows()
				If Not *this\selectedrows()
					DeleteMapElement(*this\selectedrows())
				EndIf
			Next
			ForEach *this\selectedcols()
				If Not *this\selectedcols()
					DeleteMapElement(*this\selectedcols())
				EndIf
			Next
		EndIf
	EndIf
EndProcedure

Procedure.b _MyTable_Table_GetSelected(*this.strMyTableTable)
	If *this
		ProcedureReturn *this\selectall
	EndIf
EndProcedure

Procedure _MyTable_Table_SetSelected(*this.strMyTableTable,value.b)
	If *this
		*this\selectall=value
		*this\dirty=#True
		_MyTable_Table_Redraw(*this)
	EndIf
EndProcedure

Procedure _MyTable_Table_RegisterEventCellChangedChecked(*this.strMyTableTable,event.MyTableProtoEventCellChangedChecked)
	If *this
		*this\EventCellChangedChecked=event
	EndIf
EndProcedure

Procedure _MyTable_Table_RegisterEventCellChangedUnChecked(*this.strMyTableTable,event.MyTableProtoEventCellChangedUnChecked)
	If *this
		*this\EventCellChangedUnChecked=event
	EndIf
EndProcedure

Procedure _MyTable_Table_RegisterEventCellChangedText(*this.strMyTableTable,event.MyTableProtoEventCellChangedText)
	If *this
		*this\EventCellChangedText=event
	EndIf
EndProcedure

Procedure _MyTable_Table_RegisterEventCellChangedValue(*this.strMyTableTable,event.MyTableProtoEventCellChangedValue)
	If *this
		*this\EventCellChangedValue=event
	EndIf
EndProcedure

Procedure _MyTable_Table_RegisterEventCellSelected(*this.strMyTableTable,event.MyTableProtoEventCellSelected)
	If *this
		*this\EventCellSelected=event
	EndIf
EndProcedure

Procedure _MyTable_Table_RegisterEventRowChangedChecked(*this.strMyTableTable,event.MyTableProtoEventRowChangedChecked)
	If *this
		*this\EventRowChangedChecked=event
	EndIf
EndProcedure

Procedure _MyTable_Table_RegisterEventRowChangedUnChecked(*this.strMyTableTable,event.MyTableProtoEventRowChangedUnChecked)
	If *this
		*this\EventRowChangedUnChecked=event
	EndIf
EndProcedure

Procedure _MyTable_Table_RegisterEventRowChangedExpanded(*this.strMyTableTable,event.MyTableProtoEventRowChangedExpanded)
	If *this
		*this\EventRowChangedExpanded=event
	EndIf
EndProcedure

Procedure _MyTable_Table_RegisterEventRowChangedCollapsed(*this.strMyTableTable,event.MyTableProtoEventRowChangedCollapsed)
	If *this
		*this\EventRowChangedCollapsed=event
	EndIf
EndProcedure

Procedure _MyTable_Table_RegisterEventRowSelected(*this.strMyTableTable,event.MyTableProtoEventRowSelected)
	If *this
		*this\EventRowSelected=event
	EndIf
EndProcedure

Procedure _MyTable_Table_RegisterCallback(*this.strMyTableTable,callback.MyTableProtoCallback)
	If *this
		*this\callback=callback
	EndIf
EndProcedure

