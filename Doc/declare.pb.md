## Macros

|Name|Return|Parameter|Comment|
| --- | --- | --- | --- |
|MM||||
|\_MyTable\_GetStyleCell||name||
|\_MyTable\_GetStyleCol||name||
|\_MyTable\_GetStyleRow||name||
|\_MyTable\_GetStyleTable||name||
|\_MyTable\_GetStyleApplication||name||
|\_MyTable\_GetStylesApplication||||
|\_MyTable\_GetStylesTable||||
|\_MyTable\_GetStylesRow||||
|\_MyTable\_GetStylesCol||||
|\_MyTable\_GetStylesCell||||
|\_callcountStart||||
|\_callcountEnde||||
|\_MyTableSimpleGetterPointer||gruppe , name||
|\_MyTableSimpleGetter||gruppe , name , typ||
|\_MyTableSimpleSetter||gruppe , name , typ||
|\_MyTableSimpleSetterPointer||gruppe , name||
|\_MyTableSimpleSetterPointerStructure||gruppe , name , typ||
|\_MyTableSimpleSetterRedraw||gruppe , name , typ||
|\_MyTableSimpleSetterSubRedraw||gruppe , name , typ||
|\_MyTableSimpleSetterSubPredraw||gruppe , name , typ||
|\_MyTableSimpleSetterPredraw||gruppe , name , typ||
|\_MyTableSimpleSetterGetter||gruppe , name , typ||
|\_MyTableSimpleSetterGetterRedraw||gruppe , name , typ||
|\_MyTableSimpleSetterGetterPointer||gruppe , name||
|\_MyTableSimpleSetterGetterPointerStructure||gruppe , name , typ||
|\_MyTableSimpleSetterGetterSubRedraw||gruppe , name , typ||
|\_MyTableSimpleSetterGetterSubPredraw||gruppe , name , typ||
|\_MyTableSimpleSetterGetterPredraw||gruppe , name , typ||
|PB|| \_pb\_function\_name\_ ||
|ClipOutput||\_x\_ , \_y\_ , \_width\_ , \_height\_||
|UnclipOutput||||
|DrawingFont||\_font\_id\_||


## Declares

|Name|Return|Parameter|Comment|
| --- | --- | --- | --- |
|\_MyTableInitFont||<span style="color:#FFFFAA">*font.</span>strMyTableFont , ||
|\_MyTableInitStyleTable||<span style="color:#FFFFAA">*style.strMyTableStyle</span>||
|\_MyTableInitStyleObject||<span style="color:#FFFFAA">*style.</span>strMyTableStyleObject , ||
|\_MyTableInitApplication||<span style="color:#FFFFAA">*application.</span>strMyTableApplication , ||
|\_MyTableInitTable||<span style="color:#FFFFAA">*application.</span>strMyTableApplication , ||
|\_MyTableInitTree||<span style="color:#FFFFAA">*application.</span>strMyTableApplication , ||
|\_MyTableInitGrid||<span style="color:#FFFFAA">*application.</span>strMyTableApplication , ||
|\_MyTableInitRow||<span style="color:#FFFFAA">*application.</span>strMyTableApplication , ||
|\_MyTableInitCol||<span style="color:#FFFFAA">*application.</span>strMyTableApplication , ||
|\_MyTableInitCell||<span style="color:#FFFFAA">*application.</span>strMyTableApplication , ||
|\_MyTableCleanName|s|name.s||
|\_MyTableTextHeight||text.s||
|\_MyTableTextWidth||text.s||
|\_MyTableDrawText||x , y , text.s , color.q , maxlen.i||
|\_MyTableDrawTextCompleteCenter||by , text.s , color.q , maxlen.i||
|\_MyTableGetOrAddCell||<span style="color:#FFFFAA">*row.</span>strMyTableRow , idx.i , force.b||
|\_MyTable\_StartEdit||<span style="color:#FFFFAA">*rc.strMyTableRowCol</span>||
|\_MyTable\_StartEditCell||<span style="color:#FFFFAA">*cll.strMyTableCell</span>||
|\_MyTable\_StopEdit||<span style="color:#FFFFAA">*this.</span>strMyTableTable , save.b||
|\_MyTableSelectObject||<span style="color:#FFFFAA">*obj.</span>strMyTableObject , shift.b , pages.b||
|\_MyTableLoadApp||<span style="color:#FFFFAA">*save.</span>strMyTableSaveApplication , <span style="color:#FFFFAA">*app.strMyTableApplication</span>||
|\_MyTableSaveApp||<span style="color:#FFFFAA">*app.</span>strMyTableApplication , <span style="color:#FFFFAA">*save.strMyTableSaveApplication</span>||
|\_MyTable\_IsHierarchical|b|<span style="color:#FFFFAA">*obj.strMyTableObject</span>||
|\_MyTable\_IsCheckboxes|b|<span style="color:#FFFFAA">*obj.strMyTableObject</span>||
|\_MyTable\_IsSortable|b|<span style="color:#FFFFAA">*obj.strMyTableObject</span>||
|\_MyTable\_IsResizable|b|<span style="color:#FFFFAA">*obj.strMyTableObject</span>||
|\_MyTable\_IsTitle|b|<span style="color:#FFFFAA">*obj.strMyTableObject</span>||
|\_MyTable\_IsPages|b|<span style="color:#FFFFAA">*obj.strMyTableObject</span>||
|\_MyTable\_IsEditable|b|<span style="color:#FFFFAA">*obj.strMyTableObject</span>||
|\_MyTable\_IsZebra|b|<span style="color:#FFFFAA">*obj.strMyTableObject</span>||
|\_MyTable\_IsGrid|b|<span style="color:#FFFFAA">*obj.strMyTableObject</span>||
|\_MyTable\_IsCallback|b|<span style="color:#FFFFAA">*obj.strMyTableObject</span>||
|\_MyTable\_IsBorder|b|<span style="color:#FFFFAA">*obj.strMyTableObject</span>||
|\_MyTable\_IsMultiselect|b|<span style="color:#FFFFAA">*obj.strMyTableObject</span>||
|\_MyTable\_IsFullrowselect|b|<span style="color:#FFFFAA">*obj.strMyTableObject</span>||
|\_MyTable\_IsMark\_Mouse\_Over|b|<span style="color:#FFFFAA">*obj.strMyTableObject</span>||
|\_MyTable\_IsHierarchical\_Always\_Expanded|b|<span style="color:#FFFFAA">*obj.strMyTableObject</span>||
|\_MyTable\_IsHeader|b|<span style="color:#FFFFAA">*obj.strMyTableObject</span>||
|\_MyTable\_IsRedraw|b|<span style="color:#FFFFAA">*obj.strMyTableObject</span>||
|\_MyTable\_Application\_HasName|b|<span style="color:#FFFFAA">*this.</span>strMyTableApplication , name.s||
|\_MyTable\_Application\_Redraw||<span style="color:#FFFFAA">*this.strMyTableApplication</span>||
|\_MyTable\_Table\_Redraw||<span style="color:#FFFFAA">*this.strMyTableTable</span>||
|\_MyTable\_Table\_Predraw||<span style="color:#FFFFAA">*this.</span>strMyTableTable , force.b = <span style="color:#AAAAFF">\#False</span>||
|\_MyTable\_Table\_Recalc||<span style="color:#FFFFAA">*this.strMyTableTable</span>||
|\_MyTable\_Table\_ClearMaps||<span style="color:#FFFFAA">*this.strMyTableTable</span>||
|\_MyTable\_Table\_GetSelected|b|<span style="color:#FFFFAA">*this.strMyTableTable</span>||
|\_MyTable\_Table\_SetSelected||<span style="color:#FFFFAA">*this.</span>strMyTableTable , value.b||
|\_MyTable\_Table\_Autosize||<span style="color:#FFFFAA">*this.strMyTableTable</span>||
|\_MyTable\_Table\_Delete||<span style="color:#FFFFAA">*this.strMyTableTable</span>||
|\_MyTable\_Table\_AddCol||<span style="color:#FFFFAA">*this.</span>strMyTableTable , text.s , width.i , image.i = 0 , flags.i = 0||
|\_MyTable\_IsSelected|b|<span style="color:#FFFFAA">*obj.strMyTableObject</span>||
|\_MyTableEvtResize||||
|\_MyTableEvtMove||||
|\_MyTableEvtCanvasKeyDown||||
|\_MyTableEvtCanvasKeyUp||||
|\_MyTableEvtCanvasMouseMove||||
|\_MyTableEvtCanvasMouseLeftDown||||
|\_MyTableEvtCanvasMouseLeftUp||||
|\_MyTableEvtCanvasMouseLeftDouble||||
|\_MyTableEvtCanvasMouseRightDown||||
|\_MyTableEvtCanvasMouseRightUp||||
|\_MyTableEvtCanvasMouseRightDouble||||
|\_MyTableEvtCanvasScroll||||
|\_MyTableEvtScroll||||
|\_MyTable\_Grid\_ResizeGrid||<span style="color:#FFFFAA">*this.</span>strMyTableTable , rows.i = <span style="color:#AAAAFF">\#PB\_Ignore</span> , cols.i = <span style="color:#AAAAFF">\#PB\_Ignore</span>||
|\_MyTableGridColumnName|s|col.i||
|\_MyTableGridColumnFromColumnName||col.s||
|\_MyTable\_Row\_Delete||<span style="color:#FFFFAA">*this.strMyTableRow</span>||
|\_MyTable\_Row\_Autosize||<span style="color:#FFFFAA">*this.strMyTableRow</span>||
|\_MyTable\_Row\_ScrollTo||<span style="color:#FFFFAA">*this.</span>strMyTableRow , setSelect.b = <span style="color:#AAAAFF">\#False</span> , redraw.b = <span style="color:#AAAAFF">\#True</span>||
|\_MyTable\_Row\_Expand||<span style="color:#FFFFAA">*this.</span>strMyTableRow , value.b||
|\_MyTable\_Col\_Delete||<span style="color:#FFFFAA">*this.strMyTableCol</span>||
|\_MyTable\_Col\_Autosize||<span style="color:#FFFFAA">*this.strMyTableCol</span>||
|\_MyTable\_Col\_Sort||<span style="color:#FFFFAA">*this.</span>strMyTableCol , sort.i||
|\_MyTable\_Col\_ScrollTo||<span style="color:#FFFFAA">*this.</span>strMyTableCol , setSelect.b = <span style="color:#AAAAFF">\#False</span> , redraw.b = <span style="color:#AAAAFF">\#True</span>||
|\_MyTable\_Col\_SetSort||<span style="color:#FFFFAA">*this.</span>strMyTableCol , value.i||
|\_MyTable\_Cell\_ScrollTo||<span style="color:#FFFFAA">*this.</span>strMyTableCell , setSelect.b = <span style="color:#AAAAFF">\#False</span> , redraw.b = <span style="color:#AAAAFF">\#True</span>||
|\_MyTable\_Cell\_Autosize||<span style="color:#FFFFAA">*this.strMyTableCell</span>||
|\_MyTable\_Cell\_SetText||<span style="color:#FFFFAA">*this.</span>strMyTableCell , value.s||
|\_MyTable\_Cell\_SetFormula||<span style="color:#FFFFAA">*this.</span>strMyTableCell , value.s||
|\_MyTable\_Cell\_SetValue||<span style="color:#FFFFAA">*this.</span>strMyTableCell , value.d||
|\_MyTable\_Style\_Redraw||<span style="color:#FFFFAA">*this.strMyTableStyleObject</span>||


## Procedures

|Name|Return|Parameter|Comment|
| --- | --- | --- | --- |
|\_MyTableDebugGetName|s|<span style="color:#FFFFAA">*this.strMyTableVTable</span>||
|\_MyTableDebugGetCanvas||<span style="color:#FFFFAA">*this.strMyTableVTable</span>||


