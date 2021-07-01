## Procedures

|Name|Return|Parameter|Comment|
| --- | --- | --- | --- |
|\_MyTable\_Table\_Reinit||<span style="color:#FFFFAA">*this.strMyTableTable</span>||
|\_MyTable\_Table\_SetFlags||<span style="color:#FFFFAA">*this.</span>strMyTableTable , value.i||
|\_MyTable\_Table\_GetPages||<span style="color:#FFFFAA">*this.strMyTableTable</span>||
|\_MyTable\_Table\_GetCalcHeight||<span style="color:#FFFFAA">*this.strMyTableTable</span>||
|\_MyTable\_Table\_GetCalcWidth||<span style="color:#FFFFAA">*this.strMyTableTable</span>||
|\_MyTable\_Table\_GetName|s|<span style="color:#FFFFAA">*this.strMyTableTable</span>||
|\_MyTable\_Table\_SetName||<span style="color:#FFFFAA">*this.</span>strMyTableTable , value.s||
|\_MyTable\_Table\_AddRow||<span style="color:#FFFFAA">*this.</span>strMyTableTable , text.s , sep.s = <span style="color:#AAFFAA">" \| "</span> , image.i = 0 , flags.i = 0||
|\_MyTable\_Table\_AddDirtyRows||<span style="color:#FFFFAA">*this.</span>strMyTableTable , rows.i||
|\_MyTable\_Table\_AddCol||<span style="color:#FFFFAA">*this.</span>strMyTableTable , text.s , width.i , image.i = 0 , flags.i = 0||
|\_MyTable\_Table\_Delete||<span style="color:#FFFFAA">*this.strMyTableTable</span>||
|\_MyTable\_Table\_Free||<span style="color:#FFFFAA">*this.strMyTableTable</span>||
|\_MyTable\_Table\_GetData||<span style="color:#FFFFAA">*this.strMyTableTable</span>||
|\_MyTable\_Table\_SetData||<span style="color:#FFFFAA">*this.</span>strMyTableTable , <span style="color:#FFFFAA">*value</span>||
|\_MyTable\_Table\_ClearRows||<span style="color:#FFFFAA">*this.</span>strMyTableTable , <span style="color:#FFFFAA">*value</span>||
|\_MyTable\_Table\_ClearCols||<span style="color:#FFFFAA">*this.</span>strMyTableTable , <span style="color:#FFFFAA">*value</span>||
|\_MyTable\_Table\_Draw\_Header||<span style="color:#FFFFAA">*this.</span>strMyTableTable , by , <span style="color:#FFFFAA">*font.MyFont</span>||
|||||
|MyFont,width|i,height|||
|\_MyTable\_Table\_Draw\_CellText||bx , by , addx , addy , <span style="color:#FFFFAA">*font.MyFont</span>||
|||||
|MyFont,fixed,selected,checkboxes,disabled,idx,*cell|strMyTableCell,cw)|||
|\_MyTable\_Table\_Draw\_Row||<span style="color:#FFFFAA">*this.</span>strMyTableRow , by , cols , <span style="color:#FFFFAA">*font.MyFont</span>||
|||||
|MyFont,width|i,height|||
|\_MyTable\_Table\_Redraw||<span style="color:#FFFFAA">*this.strMyTableTable</span>||
|\_MyTable\_Table\_PredrawSub|i|<span style="color:#FFFFAA">*this.</span>strMyTableTable , <span style="color:#FFFFAA">*row.</span>strMyTableRow , pages.b||
|\_MyTable\_Table\_Predraw||<span style="color:#FFFFAA">*this.</span>strMyTableTable , force.b = <span style="color:#AAAAFF">\#False</span>||
|\_MyTable\_Table\_GetRedraw|b|<span style="color:#FFFFAA">*this.strMyTableTable</span>||
|\_MyTable\_Table\_SetRedraw||<span style="color:#FFFFAA">*this.</span>strMyTableTable , value.b||
|\_MyTable\_Table\_Recalc||<span style="color:#FFFFAA">*this.strMyTableTable</span>||
|\_MyTable\_Table\_GetRecalc|b|<span style="color:#FFFFAA">*this.strMyTableTable</span>||
|\_MyTable\_Table\_SetRecalc||<span style="color:#FFFFAA">*this.</span>strMyTableTable , value.b||
|\_MyTable\_Table\_GetHeaderHeight||<span style="color:#FFFFAA">*this.strMyTableTable</span>||
|\_MyTable\_Table\_GetTitleHeight||<span style="color:#FFFFAA">*this.strMyTableTable</span>||
|\_MyTable\_Table\_GetDefaultRowHeight||<span style="color:#FFFFAA">*this.strMyTableTable</span>||
|\_MyTable\_Table\_SetHeaderHeight||<span style="color:#FFFFAA">*this.</span>strMyTableTable , value.i||
|\_MyTable\_Table\_SetTitleHeight||<span style="color:#FFFFAA">*this.</span>strMyTableTable , value.i||
|\_MyTable\_Table\_SetDefaultRowHeight||<span style="color:#FFFFAA">*this.</span>strMyTableTable , value.i||
|\_MyTable\_Table\_DeleteRow||<span style="color:#FFFFAA">*this.</span>strMyTableTable , idx.i||
|\_MyTable\_Table\_DeleteCol||<span style="color:#FFFFAA">*this.</span>strMyTableTable , idx.i||
|\_MyTable\_Table\_GetRow||<span style="color:#FFFFAA">*this.</span>strMyTableTable , row.i||
|\_MyTable\_Table\_GetCol||<span style="color:#FFFFAA">*this.</span>strMyTableTable , col.i||
|\_MyTable\_Table\_GetApplication||<span style="color:#FFFFAA">*this.strMyTableTable</span>||
|\_MyTable\_Table\_GetCell||<span style="color:#FFFFAA">*this.</span>strMyTableTable , row.i , col.i||
|\_MyTable\_Table\_RowCount||<span style="color:#FFFFAA">*this.strMyTableTable</span>||
|\_MyTable\_Table\_VisibleRowCount||<span style="color:#FFFFAA">*this.strMyTableTable</span>||
|\_MyTable\_Table\_ColCount||<span style="color:#FFFFAA">*this.strMyTableTable</span>||
|\_MyTable\_Table\_ClearMaps||<span style="color:#FFFFAA">*this.strMyTableTable</span>||
|\_MyTable\_Table\_GetSelected|b|<span style="color:#FFFFAA">*this.strMyTableTable</span>||
|\_MyTable\_Table\_SetSelected||<span style="color:#FFFFAA">*this.</span>strMyTableTable , value.b||
|\_MyTable\_Table\_BindCallback||<span style="color:#FFFFAA">*this.</span>strMyTableTable , callback.MyTableProtoCallback||
|\_MyTable\_Table\_GetSelectedRows||<span style="color:#FFFFAA">*this.</span>strMyTableTable , List rows.i||
|\_MyTable\_Table\_GetSelectedCells||<span style="color:#FFFFAA">*this.</span>strMyTableTable , List cells.i||
|\_MyTable\_Table\_GetSelectedCols||<span style="color:#FFFFAA">*this.</span>strMyTableTable , List cols.i||
|\_MyTable\_Table\_ScrollToPos||<span style="color:#FFFFAA">*this.</span>strMyTableTable , row.i , setSelect.b = <span style="color:#AAAAFF">\#False</span>||
|\_MyTable\_Table\_ScrollToCellPos||<span style="color:#FFFFAA">*this.</span>strMyTableTable , row.i , col.i , setSelect.b = <span style="color:#AAAAFF">\#False</span>||
|\_MyTable\_Table\_AutosizeRows||<span style="color:#FFFFAA">*this.strMyTableTable</span>||
|\_MyTable\_Table\_AutosizeCols||<span style="color:#FFFFAA">*this.strMyTableTable</span>||
|\_MyTable\_Table\_AutosizeHeader||<span style="color:#FFFFAA">*this.strMyTableTable</span>||
|\_MyTable\_Table\_Autosize||<span style="color:#FFFFAA">*this.strMyTableTable</span>||


