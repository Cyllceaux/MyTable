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
Declare _MyTableInitFont(*font.strMyTableFont,
                         name.s,
                         size.i,
                         flags.i,
                         font.i)
Declare _MyTableInitStyleTable(*style.strMyTableStyle)
Declare _MyTableInitStyleObject(*style.strMyTableStyleObject,
                                *this.strMyTableObject,
                                *s.strMyTableStyle)
Declare _MyTableInitBorderObject(*border.strMyTableBorderObject,
                                 *style.strMyTableStyleObject,
                                 *b.strMyTableStyleBorderStyle)
Declare _MyTableInitApplication(*application.strMyTableApplication,
                                flags.i)
Declare _MyTableInitTable(*application.strMyTableApplication,
                          *table.strMyTableTable,
                          window.i,
                          canvas.i,
                          vscroll.i,
                          hscroll.i,
                          flags.i)
Declare _MyTableInitTree(*application.strMyTableApplication,
                          *table.strMyTableTable,
                          window.i,
                          canvas.i,
                          vscroll.i,
                          hscroll.i,
                          flags.i)
Declare _MyTableInitGrid(*application.strMyTableApplication,
                         *table.strMyTableTable,
                         window.i,
                         canvas.i,
                         vscroll.i,
                         hscroll.i,
                         rows.i,
                         cols.i,
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

Declare _MyTableGetOrAddCell(*row.strMyTableRow,idx.i,force.b)
Declare _MyTable_StartEdit(*rc.strMyTableRowCol)
Declare _MyTable_StartEditCell(*cll.strMyTableCell)
Declare _MyTable_StopEdit(*this.strMyTableTable,save.b)
Declare _MyTableSelectObject(*obj.strMyTableObject,shift.b,pages.b)
Declare _MyTableLoadApp(*save.strMyTableSaveApplication,*app.strMyTableApplication)
Declare _MyTableSaveApp(*app.strMyTableApplication,*save.strMyTableSaveApplication)

Declare.b _MyTable_IsHierarchical(*obj.strMyTableObject)
Declare.b _MyTable_IsCheckboxes(*obj.strMyTableObject)
Declare.b _MyTable_IsSortable(*obj.strMyTableObject)
Declare.b _MyTable_IsResizable(*obj.strMyTableObject)
Declare.b _MyTable_IsTitle(*obj.strMyTableObject)
Declare.b _MyTable_IsPages(*obj.strMyTableObject)
Declare.b _MyTable_IsEditable(*obj.strMyTableObject)
Declare.b _MyTable_IsZebra(*obj.strMyTableObject)
Declare.b _MyTable_IsGrid(*obj.strMyTableObject)
Declare.b _MyTable_IsCallback(*obj.strMyTableObject)
Declare.b _MyTable_IsBorder(*obj.strMyTableObject)
Declare.b _MyTable_IsMultiselect(*obj.strMyTableObject)
Declare.b _MyTable_IsFullrowselect(*obj.strMyTableObject)
Declare.b _MyTable_IsMark_Mouse_Over(*obj.strMyTableObject)
Declare.b _MyTable_IsHierarchical_Always_Expanded(*obj.strMyTableObject)
Declare.b _MyTable_IsHeader(*obj.strMyTableObject)
Declare.b _MyTable_IsRedraw(*obj.strMyTableObject)
Declare.b _MyTable_IsElement_Selected(*obj.strMyTableObject)

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
Declare _MyTable_Table_Delete(*this.strMyTableTable)
Declare _MyTable_Table_AddCol(*this.strMyTableTable,text.s,width.i,image.i=0,flags.i=0)
Declare.b _MyTable_IsSelected(*obj.strMyTableObject)
Declare.b _MyTable_IsDisabled(*obj.strMyTableObject)

Declare _MyTableEvtResize()
Declare _MyTableEvtMove()
Declare _MyTableEvtCanvasKeyDown()
Declare _MyTableEvtCanvasKeyUp()
Declare _MyTableEvtCanvasMouseMove()
Declare _MyTableEvtCanvasMouseLeftDown()
Declare _MyTableEvtCanvasMouseLeftUp()
Declare _MyTableEvtCanvasMouseLeftDouble()
Declare _MyTableEvtCanvasMouseRightDown()
Declare _MyTableEvtCanvasMouseRightUp()
Declare _MyTableEvtCanvasMouseRightDouble()
Declare _MyTableEvtCanvasScroll()
Declare _MyTableEvtCanvasGotFocus()
Declare _MyTableEvtCanvasLostFocus()
Declare _MyTableEvtScroll()

;- Trees

;- Grids
Declare _MyTable_Grid_ResizeGrid(*this.strMyTableTable,rows.i=#PB_Ignore,cols.i=#PB_Ignore)
Declare.s _MyTableGridColumnName(col.i)
Declare _MyTableGridColumnFromColumnName(col.s)

;- Rows
Declare _MyTable_Row_Delete(*this.strMyTableRow)
Declare _MyTable_Row_Autosize(*this.strMyTableRow)
Declare _MyTable_Row_ScrollTo(*this.strMyTableRow,setSelect.b=#False,redraw.b=#True)
Declare _MyTable_Row_Expand(*this.strMyTableRow,value.b)

;-Cols
Declare _MyTable_Col_Delete(*this.strMyTableCol)
Declare _MyTable_Col_Autosize(*this.strMyTableCol)
Declare _MyTable_Col_Sort(*this.strMyTableCol,sort.i)
Declare _MyTable_Col_ScrollTo(*this.strMyTableCol,setSelect.b=#False,redraw.b=#True)
Declare _MyTable_Col_SetSort(*this.strMyTableCol,value.i)

;- Cells
Declare _MyTable_Cell_ScrollTo(*this.strMyTableCell,setSelect.b=#False,redraw.b=#True)
Declare _MyTable_Cell_Autosize(*this.strMyTableCell)
Declare _MyTable_Cell_SetText(*this.strMyTableCell,value.s)
Declare _MyTable_Cell_SetFormula(*this.strMyTableCell,value.s)
Declare _MyTable_Cell_SetValue(*this.strMyTableCell,value.d)
Declare _MyTable_Cell_SetTextExp(*this.strMyTableCell,value.s)


;- Style
Declare _MyTable_Style_Redraw(*this.strMyTableStyleObject)

;- Fonts
