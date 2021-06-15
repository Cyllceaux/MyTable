;- Images
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

Global tMyTableDefaultImageSortAsc=CreateImage(#PB_Any,MyTableW16,MyTableH16,32,#PB_Image_Transparent)
Global tMyTableDefaultImageSortDesc=CreateImage(#PB_Any,MyTableW16,MyTableH16,32,#PB_Image_Transparent)
Global tMyTableDefaultImagePlus=CreateImage(#PB_Any,MyTableW16,MyTableH16,32,#PB_Image_Transparent)
Global tMyTableDefaultImageMinus=CreateImage(#PB_Any,MyTableW16,MyTableH16,32,#PB_Image_Transparent)
Global tMyTableDefaultImageCheckBox=CreateImage(#PB_Any,MyTableW16,MyTableH16,32,#PB_Image_Transparent)
Global tMyTableDefaultImageCheckBoxChecked=CreateImage(#PB_Any,MyTableW16,MyTableH16,32,#PB_Image_Transparent)
Global tMyTableDefaultImagePlusArrow=CreateImage(#PB_Any,MyTableW16,MyTableH16,32,#PB_Image_Transparent)
Global tMyTableDefaultImageMinusArrow=CreateImage(#PB_Any,MyTableW16,MyTableH16,32,#PB_Image_Transparent)


StartDrawing(ImageOutput(tMyTableDefaultImageSortAsc))
DrawingMode(#PB_2DDrawing_AlphaBlend)
LineXY(MyTableW2,MyTableH8,MyTableW8,MyTableH2,RGBA(0,0,0,255))
LineXY(MyTableW8,MyTableH2,MyTableW14,MyTableH8,RGBA(0,0,0,255))
LineXY(MyTableW2,MyTableH8,MyTableW14,MyTableH8,RGBA(0,0,0,255))
StopDrawing()

StartDrawing(ImageOutput(tMyTableDefaultImageSortDesc))
DrawingMode(#PB_2DDrawing_AlphaBlend)
LineXY(MyTableW2,MyTableH8,MyTableW8,MyTableH14,RGBA(0,0,0,255))
LineXY(MyTableW8,MyTableH14,MyTableW14,MyTableH8,RGBA(0,0,0,255))
LineXY(MyTableW2,MyTableH8,MyTableW14,MyTableH8,RGBA(0,0,0,255))
StopDrawing()

StartDrawing(ImageOutput(tMyTableDefaultImagePlus))
DrawingMode(#PB_2DDrawing_Outlined|#PB_2DDrawing_AlphaBlend)
Box(MyTableW2,MyTableH2,MyTableW12,MyTableH12,RGBA(0,0,0,255))
LineXY(MyTableW4,MyTableH7,MyTableW10,MyTableH7,RGBA(0,0,0,255))
LineXY(MyTableW7,MyTableH4,MyTableW7,MyTableH10,RGBA(0,0,0,255))
StopDrawing()

StartDrawing(ImageOutput(tMyTableDefaultImageMinus))
DrawingMode(#PB_2DDrawing_Outlined|#PB_2DDrawing_AlphaBlend)
Box(MyTableW2,MyTableH2,MyTableW12,MyTableH12,RGBA(0,0,0,255))
LineXY(MyTableW4,MyTableH7,MyTableW10,MyTableH7,RGBA(0,0,0,255))
StopDrawing()

StartDrawing(ImageOutput(tMyTableDefaultImageCheckBox))
DrawingMode(#PB_2DDrawing_Outlined|#PB_2DDrawing_AlphaBlend)
Box(MyTableW2,MyTableH2,MyTableW12,MyTableH12,RGBA(0,0,0,255))
StopDrawing()

StartDrawing(ImageOutput(tMyTableDefaultImageCheckBoxChecked))
DrawingMode(#PB_2DDrawing_Outlined|#PB_2DDrawing_AlphaBlend)
Box(MyTableW2,MyTableH2,MyTableW12,MyTableH12,RGBA(0,0,0,255))
LineXY(MyTableW4,MyTableH4,MyTableW12,MyTableH12,RGBA(0,0,0,255))
LineXY(MyTableW4,MyTableH12,MyTableW12,MyTableH4,RGBA(0,0,0,255))
StopDrawing()

StartDrawing(ImageOutput(tMyTableDefaultImagePlusArrow))
DrawingMode(#PB_2DDrawing_AlphaBlend)
LineXY(MyTableW8,MyTableH4,MyTableW12,MyTableH8,RGBA(0,0,0,255))
LineXY(MyTableW8,MyTableH12,MyTableW12,MyTableH8,RGBA(0,0,0,255))
StopDrawing()

StartDrawing(ImageOutput(tMyTableDefaultImageMinusArrow))
DrawingMode(#PB_2DDrawing_AlphaBlend)
LineXY(MyTableW4,MyTableH6,MyTableW8,MyTableH10,RGBA(0,0,0,255))
LineXY(MyTableW8,MyTableH10,MyTableW12,MyTableH6,RGBA(0,0,0,255))
StopDrawing()


;- Global
Declare _MyTableInitStyleTable(*style.strMyTableStyle)
Declare _MyTableInitStyleObject(*style.strMyTableStyleObject,
                                *this.strMyTableObject)
Declare _MyTableInitApplication(*application.strMyTableApplication,
                                flags.i)
Declare _MyTableInitTable(*application.strMyTableApplication,
                          *table.strMyTableTable,
                          window.i,
                          canvas.i,
                          vscroll.i,
                          hscroll.i,
                          flags.i)
Declare _MyTableInitRow(*application.strMyTableApplication,
                        *table.strMyTableTable,
                        *parent.strMyTableRow,
                        *row.strMyTableRow,
                        text.s,
                        sep.s,
                        image.i,
                        flags.i)
Declare _MyTableInitCol(*application.strMyTableApplication,
                        *table.strMyTableTable,
                        *col.strMyTableCol,
                        text.s,
                        width.i,
                        image.i,
                        flags.i)
Declare _MyTableInitCell(*application.strMyTableApplication,
                         *table.strMyTableTable,
                         *row.strMyTableRow,
                         *col.strMyTableCol,
                         *parent.strMyTableCell,
                         *cell.strMyTableCell,
                         flags.i)

Declare.s _MyTableCleanName(name.s)
Declare _MyTableTextHeight(text.s)
Declare _MyTableTextWidth(text.s)
Declare _MyTableDrawText(x,y,text.s,color.q,maxlen.i)
Declare _MyTableDrawTextCompleteCenter(by,text.s,color.q,maxlen.i)
Declare _MyTableGetOrAddCell(*row.strMyTableRow,idx.i)

;- Application
Declare.b _MyTable_Application_HasName(*this.strMyTableApplication,name.s)
Declare _MyTable_Application_Redraw(*this.strMyTableApplication)

;- Tables
Declare _MyTable_Table_Redraw(*this.strMyTableTable)
Declare _MyTable_Table_Predraw(*this.strMyTableTable,force.b=#False)
Declare _MyTable_Table_Recalc(*this.strMyTableTable)
Declare _MyTable_Table_ClearMaps(*this.strMyTableTable)
Declare.b _MyTable_Table_GetSelected(*this.strMyTableTable)
Declare _MyTable_Table_SetSelected(*this.strMyTableTable,value.b)
Declare _MyTable_Table_Autosize(*this.strMyTableTable)

Declare _MyTableEvtResize()
Declare _MyTableEvtCanvasKeyDown()
Declare _MyTableEvtCanvasMouseMove()
Declare _MyTableEvtCanvasMouseLeftDown()
Declare _MyTableEvtCanvasMouseLeftUp()
Declare _MyTableEvtCanvasMouseLeftDouble()
Declare _MyTableEvtCanvasMouseRightDown()
Declare _MyTableEvtCanvasMouseRightUp()
Declare _MyTableEvtCanvasMouseRightDouble()
Declare _MyTableEvtCanvasScroll()
Declare _MyTableEvtScroll()

;- Rows
Declare _MyTable_Row_Delete(*this.strMyTableRow)
Declare _MyTable_Row_Autosize(*this.strMyTableRow)
Declare _MyTable_Row_ScrollTo(*this.strMyTableRow,setSelect.b=#False,redraw.b=#True)


;-Cols
Declare _MyTable_Col_Delete(*this.strMyTableCol)
Declare _MyTable_Col_Autosize(*this.strMyTableCol)
Declare _MyTable_Col_Sort(*this.strMyTableCol,sort.i)
Declare _MyTable_Col_ScrollTo(*this.strMyTableCol,setSelect.b=#False,redraw.b=#True)

;- Cells
Declare _MyTable_Cell_ScrollTo(*this.strMyTableCell,setSelect.b=#False,redraw.b=#True)

;- Styled
Declare _MyTable_Style_Redraw(*this.strMyTableStyleObject)

;- Macros

Macro MM
	"
EndMacro

CompilerIf #PB_Compiler_Debugger And Defined(MYTABLE_DEBUG,#PB_Module)
	Procedure.s _MyTableDebugGetName(*this.strMyTableVTable)
		Select *this\type
			Case #MYTABLE_TYPE_CELL
				Protected *cell.strMyTableCell=*this
				ProcedureReturn *cell\table\name
			Case #MYTABLE_TYPE_ROW
				Protected *row.strMyTableRow=*this
				ProcedureReturn *row\table\name
			Case #MYTABLE_TYPE_COL
				Protected *col.strMyTableCol=*this
				ProcedureReturn *col\table\name
			Case #MYTABLE_TYPE_TABLE
				Protected *table.strMyTableTable=*this
				ProcedureReturn *table\name
			Case #MYTABLE_TYPE_APPLICATION
				ProcedureReturn ""
			Case #MYTABLE_TYPE_STYLE
				Protected *style.strMyTableStyleObject=*this
				ProcedureReturn _MyTableDebugGetName(*style\obj)
		EndSelect
	EndProcedure
	
	Procedure _MyTableDebugGetCanvas(*this.strMyTableVTable)
		Select *this\type
			Case #MYTABLE_TYPE_CELL
				Protected *cell.strMyTableCell=*this
				ProcedureReturn *cell\table\canvas
			Case #MYTABLE_TYPE_ROW
				Protected *row.strMyTableRow=*this
				ProcedureReturn *row\table\canvas
			Case #MYTABLE_TYPE_COL
				Protected *col.strMyTableCol=*this
				ProcedureReturn *col\table\canvas
			Case #MYTABLE_TYPE_TABLE
				Protected *table.strMyTableTable=*this
				ProcedureReturn *table\canvas
			Case #MYTABLE_TYPE_APPLICATION
				ProcedureReturn 0
			Case #MYTABLE_TYPE_STYLE
				Protected *style.strMyTableStyleObject=*this
				ProcedureReturn _MyTableDebugGetCanvas(*style\obj)
		EndSelect
	EndProcedure
CompilerEndIf


CompilerIf #PB_Compiler_Debugger And Defined(MYTABLE_DEBUG,#PB_Module)
	Macro _callcountStart(sname)
		Static NewMap callcount.i()
		Static NewMap callms.i()
		Static NewMap callmssum.i()					
		callms(MM#sname#MM+"_"+Str(_MyTableDebugGetCanvas(*this)))=ElapsedMilliseconds()		
		
		
	EndMacro
	
	Macro _callcountEnde(sname)
		
		Protected _#sname#ms=ElapsedMilliseconds()-callms(MM#sname#MM+"_"+Str(_MyTableDebugGetCanvas(*this)))
		callcount(MM#sname#MM+"_"+Str(_MyTableDebugGetCanvas(*this)))+1
		callmssum(MM#sname#MM+"_"+Str(_MyTableDebugGetCanvas(*this)))+_#sname#ms
		
		Protected tname.s=""
		If _MyTableDebugGetName(*this)=""
			tname=Str(_MyTableDebugGetCanvas(*this))
		Else
			tname=_MyTableDebugGetName(*this)
		EndIf
		
		Protected debugline.s=LSet(tname+":",16," ")
		debugline + LSet(MM#sname#MM+": "+callcount(MM#sname#MM+"_"+Str(_MyTableDebugGetCanvas(*this))),20," ")
		
		CompilerIf Defined(MYTABLE_DEBUG_MS_MAX,#PB_Module)
			If _#sname#ms>MYTABLE_DEBUG_MS_MAX::#MYTABLE_DEBUG_MS_MAX
				DebuggerWarning(MM#sname#MM+" für "+tname+" > "+Str(MYTABLE_DEBUG_MS_MAX::#MYTABLE_DEBUG_MS_MAX)+"ms ( "+Str(_#sname#ms)+" )")
			EndIf
		CompilerEndIf
		debugline + Str(_#sname#ms)+"ms / "+Str(callmssum(MM#sname#MM+"_"+Str(_MyTableDebugGetCanvas(*this))))+"ms / " +Str(callmssum(MM#sname#MM+"_"+Str(_MyTableDebugGetCanvas(*this)))/callcount(MM#sname#MM+"_"+Str(_MyTableDebugGetCanvas(*this))))+ "ms"
		CompilerIf Defined(MYTABLE_DEBUG_LEVEL,#PB_Module)
			Debug debugline,MYTABLE_DEBUG_LEVEL::#MYTABLE_DEBUG_LEVEL
		CompilerElse
			Debug debugline
		CompilerEndIf
	EndMacro
CompilerElse
	Macro _callcountStart(sname):EndMacro
	Macro _callcountEnde(sname):EndMacro
CompilerEndIf


Macro _MyTableSimpleGetterPointer(gruppe,name)
	Procedure _MyTable_#gruppe#_Get#name(*this.strMyTable#gruppe)
		If *this
			ProcedureReturn *this\name
		EndIf
	EndProcedure
EndMacro

Macro _MyTableSimpleGetter(gruppe,name,typ)
	Procedure.typ _MyTable_#gruppe#_Get#name(*this.strMyTable#gruppe)
		If *this
			ProcedureReturn *this\name
		EndIf
	EndProcedure
EndMacro

Macro _MyTableSimpleSetter(gruppe,name,typ)
	Procedure _MyTable_#gruppe#_Set#name(*this.strMyTable#gruppe,value.typ)
		If *this
			*this\name=value
			*this\dirty=#True
		EndIf
	EndProcedure
EndMacro

Macro _MyTableSimpleSetterPointer(gruppe,name)
	Procedure _MyTable_#gruppe#_Set#name(*this.strMyTable#gruppe,*value)
		If *this
			*this\name=*value
			*this\dirty=#True
		EndIf
	EndProcedure
EndMacro

Macro _MyTableSimpleSetterRedraw(gruppe,name,typ)
	Procedure _MyTable_#gruppe#_Set#name(*this.strMyTable#gruppe,value.typ)
		If *this
			*this\name=value
			*this\dirty=#True			
			_MyTable_Table_Redraw(*this)						
		EndIf
	EndProcedure
EndMacro

Macro _MyTableSimpleSetterSubRedraw(gruppe,name,typ)
	Procedure _MyTable_#gruppe#_Set#name(*this.strMyTable#gruppe,value.typ)
		If *this
			*this\name=value
			*this\dirty=#True			
			*this\table\dirty=#True
			_MyTable_Table_Redraw(*this\table)						
		EndIf
	EndProcedure
EndMacro

Macro _MyTableSimpleSetterSubPredraw(gruppe,name,typ)
	Procedure _MyTable_#gruppe#_Set#name(*this.strMyTable#gruppe,value.typ)
		If *this
			*this\name=value
			*this\dirty=#True			
			*this\table\dirty=#True
			_MyTable_Table_Predraw(*this\table)						
			_MyTable_Table_Redraw(*this\table)						
		EndIf
	EndProcedure
EndMacro

Macro _MyTableSimpleSetterPredraw(gruppe,name,typ)
	Procedure _MyTable_#gruppe#_Set#name(*this.strMyTable#gruppe,value.typ)
		If *this
			*this\name=value
			*this\dirty=#True			
			*this\dirty=#True
			_MyTable_Table_Predraw(*this)						
			_MyTable_Table_Redraw(*this)						
		EndIf
	EndProcedure
EndMacro

Macro _MyTableSimpleSetterGetter(gruppe,name,typ)
	_MyTableSimpleGetter(gruppe,name,typ)
	_MyTableSimpleSetter(gruppe,name,typ)
EndMacro

Macro _MyTableSimpleSetterGetterRedraw(gruppe,name,typ)
	_MyTableSimpleGetter(gruppe,name,typ)
	_MyTableSimpleSetterRedraw(gruppe,name,typ)
EndMacro

Macro _MyTableSimpleSetterGetterPointer(gruppe,name)
	_MyTableSimpleGetterPointer(gruppe,name)
	_MyTableSimpleSetterPointer(gruppe,name)
EndMacro

Macro _MyTableSimpleSetterGetterSubRedraw(gruppe,name,typ)
	_MyTableSimpleGetter(gruppe,name,typ)
	_MyTableSimpleSetterSubRedraw(gruppe,name,typ)
EndMacro

Macro _MyTableSimpleSetterGetterSubPredraw(gruppe,name,typ)
	_MyTableSimpleGetter(gruppe,name,typ)
	_MyTableSimpleSetterSubPredraw(gruppe,name,typ)
EndMacro

Macro _MyTableSimpleSetterGetterPredraw(gruppe,name,typ)
	_MyTableSimpleGetter(gruppe,name,typ)
	_MyTableSimpleSetterPredraw(gruppe,name,typ)
EndMacro

;{
;- workaround for MacOS. thx to mestnyi (https://www.purebasic.fr/english/viewtopic.php?p=571500#p571500)
	Macro PB( _pb_function_name_ ) 
		_pb_function_name_
	EndMacro
	Macro ClipOutput(_x_,_y_,_width_,_height_)
		CompilerIf #PB_Compiler_OS <> #PB_OS_MacOS
			PB(ClipOutput)(_x_,_y_,_width_,_height_)
		CompilerEndIf
	EndMacro
	Macro UnclipOutput()
		CompilerIf #PB_Compiler_OS <> #PB_OS_MacOS
			PB(UnclipOutput)()
		CompilerEndIf
	EndMacro
	Macro DrawingFont(_font_id_)
		CompilerIf #PB_Compiler_OS = #PB_OS_MacOS
			If _font_id_
				PB(DrawingFont)(_font_id_)
			EndIf
		CompilerElse
			PB(DrawingFont)(_font_id_)
		CompilerEndIf
	EndMacro
;}

;- Includes
XIncludeFile "mytablestyle.pb"
XIncludeFile "mytableapplication.pb"
XIncludeFile "mytabletable.pb"
XIncludeFile "mytablerow.pb"
XIncludeFile "mytablecol.pb"
XIncludeFile "mytablecell.pb"