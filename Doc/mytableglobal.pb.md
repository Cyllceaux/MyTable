## Macros

|Name|Return|Parameter|Comment|
| --- | --- | --- | --- |
|\_MyTable\_StyleMethods||gruppe , name , typ , sub = ||
|\_MyTable\_StyleMethodsRow||gruppe , name , typ , sub = ||
|\_MyTable\_StyleMethodsRowPointer||gruppe , name , typ , sub = ||
|\_MyTable\_StyleMethodsCol||gruppe , name , typ , sub = ||
|\_MyTable\_StyleBorderMethods||gruppe , name , pos , typ||
|\_MyTable\_IsTableNoGrid||name||
|\_MyTable\_IsTable||name||
|\_MyTable\_IsTableColNo||name||
|\_MyTable\_IsTableRow||name||
|\_MyTable\_IsTableRowColNo||name||
|\_MyTable\_IsTableAllNo||name||
|\_MyTable\_IsTableAll||name||
|\_MyTable\_IsTableNo||name||
|\_MyTable\_StylesBordersMethods||gruppe , name , typ||
|\_MyTable\_StylesMethods||gruppe||


## Constants

|Constants|Value|Comment|
| --- | --- | --- |
|<span style="color:#AAAAFF">\#PB\_Ignore,</span>|||
|<span style="color:#AAAAFF">\#PB\_Ignore,</span>|||
|<span style="color:#AAAAFF">\#PB\_Ignore,</span>|||
|<span style="color:#AAAAFF">\#PB\_Ignore)</span>|||
|<span style="color:#AAAAFF">\#PB\_Window\_BorderLess,</span>|||


## Procedures

|Name|Return|Parameter|Comment|
| --- | --- | --- | --- |
|\_MyTable\_IsSelected|b|<span style="color:#FFFFAA">*obj.strMyTableObject</span>||
|MyTableCreateApplication||flags.i = 0||
|MyTableLoadApplication||file.s||
|MyTableCreateTable||window.i , canvas.i , vscroll.i , hscroll.i , flags.i = <span style="color:#AAAAFF">\#MYTABLE\_TABLE\_FLAGS\_DEFAULT\_TABLE</span>||
|MyTableCreateTree||window.i , canvas.i , vscroll.i , hscroll.i , flags.i = <span style="color:#AAAAFF">\#MYTABLE\_TABLE\_FLAGS\_DEFAULT\_TREE</span>||
|MyTableCreateGrid||window.i , canvas.i , vscroll.i , hscroll.i , rows.i , cols.i , flags.i = <span style="color:#AAAAFF">\#MYTABLE\_TABLE\_FLAGS\_DEFAULT\_GRID</span>||
|MyTableCreateFont||name.s , size.i , flags.i = 0||
|\_MyTableInitStyleTable||<span style="color:#FFFFAA">*style.strMyTableStyle</span>||
|\_MyTableInitStyleTableSelected||<span style="color:#FFFFAA">*style.strMyTableStyle</span>||
|\_MyTableInitStyleTableElementSelected||<span style="color:#FFFFAA">*style.strMyTableStyle</span>||
|\_MyTableInitStyleTableZebra||<span style="color:#FFFFAA">*style.strMyTableStyle</span>||
|\_MyTableInitStyleTableMouseOver||<span style="color:#FFFFAA">*style.strMyTableStyle</span>||
|\_MyTableInitStyleTableFixed||<span style="color:#FFFFAA">*style.strMyTableStyle</span>||
|\_MyTableInitStyleTableTitle||<span style="color:#FFFFAA">*style.strMyTableStyle</span>||
|\_MyTableInitStyleTableEmpty||<span style="color:#FFFFAA">*style.strMyTableStyle</span>||
|\_MyTableInitStyleObject||<span style="color:#FFFFAA">*style.</span>strMyTableStyleObject , <span style="color:#FFFFAA">*this.</span>strMyTableObject , <span style="color:#FFFFAA">*s.strMyTableStyle</span>||
|\_MyTableInitStyles||<span style="color:#FFFFAA">*this.strMyTableObject</span>||
|\_MyTableInitApplication||<span style="color:#FFFFAA">*application.</span>strMyTableApplication , ||
|\_MyTableEvtScroll||||
|\_MyTableEvtResizeExp||<span style="color:#FFFFAA">*this.strMyTableTable</span>||
|\_MyTableEvtMoveExp||<span style="color:#FFFFAA">*this.strMyTableTable</span>||
|\_MyTableEvtResize||||
|\_MyTableEvtMove||||
|\_MyTableGetRowCol||<span style="color:#FFFFAA">*this.strMyTableTable</span>||
|\_MyTableEvtCanvasGotFocus||||
|\_MyTableEvtCanvasLostFocus||||
|\_MyTableEvtCanvasKeyUp||||
|\_MyTableEvtCanvasKeyDown||||
|\_MyTableSelectObject||<span style="color:#FFFFAA">*obj.</span>strMyTableObject , shift.b , pages.b||
|\_MyTableSelect||<span style="color:#FFFFAA">*this.</span>strMyTableTable , <span style="color:#FFFFAA">*rc.</span>strMyTableRowCol , temp.b||
|\_MyTable\_GetTooltip|s|<span style="color:#FFFFAA">*this.strMyTableObject</span>||
|\_MyTableLoadApp||<span style="color:#FFFFAA">*save.</span>strMyTableSaveApplication , <span style="color:#FFFFAA">*app.strMyTableApplication</span>||
|\_MyTableSaveApp||<span style="color:#FFFFAA">*app.</span>strMyTableApplication , <span style="color:#FFFFAA">*save.strMyTableSaveApplication</span>||
|\_MyTableEvtCanvasMouseMove||||
|\_MyTableEvtCanvasMouseLeftDown||||
|\_MyTableEvtCanvasMouseLeftUp||||
|\_MyTableEvtCanvasMouseLeftDouble||||
|\_MyTableEvtCanvasMouseRightDown||||
|\_MyTableEvtCanvasMouseRightUp||||
|\_MyTableEvtCanvasMouseRightDouble||||
|\_MyTableEvtCanvasMouseRightClick||||
|\_MyTableEvtCanvasMouseLeftClick||||
|\_MyTableEvtCanvasScroll||||
|\_MyTableInitTable||<span style="color:#FFFFAA">*application.</span>strMyTableApplication , ||
|\_MyTableInitTree||<span style="color:#FFFFAA">*application.</span>strMyTableApplication , ||
|\_MyTableInitGrid||<span style="color:#FFFFAA">*application.</span>strMyTableApplication , ||
|\_MyTableInitRow||<span style="color:#FFFFAA">*application.</span>strMyTableApplication , ||
|\_MyTableInitCol||<span style="color:#FFFFAA">*application.</span>strMyTableApplication , ||
|\_MyTableInitFont||<span style="color:#FFFFAA">*font.</span>strMyTableFont , ||
|\_MyTableInitCell||<span style="color:#FFFFAA">*application.</span>strMyTableApplication , ||
|\_MyTableCleanName|s|name.s||
|\_MyTableGetOrAddCell||<span style="color:#FFFFAA">*row.</span>strMyTableRow , idx.i , force.b||
|\_MyTableTextHeight||text.s||
|\_MyTableTextWidth||text.s||
|\_MyTableDrawTextCompleteCenter||by , text.s , color.q , maxlen.i||
|\_MyTableDrawText||x , y , text.s , color.q , maxlen.i||
|\_MyTable\_StopEdit||<span style="color:#FFFFAA">*this.</span>strMyTableTable , save.b||
|\_MyTable\_KeyEdit||||
|\_MyTableEditSetPos||Gadget , Position||
|\_MyTable\_StartEditCell||<span style="color:#FFFFAA">*cell.strMyTableCell</span>||
|\_MyTable\_StartEdit||<span style="color:#FFFFAA">*rc.strMyTableRowCol</span>||


