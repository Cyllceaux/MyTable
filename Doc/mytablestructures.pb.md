## Structures


### strMyTableVTable
|Field|Type|Comment|
| --- | --- | --- |
|vtable|i||
|type|i||

### strMyTableFont : [strMyTableVTable](#strMyTableVTable)
|Field|Type|Comment|
| --- | --- | --- |
|name|s||
|size|i||
|flags|i||
|font|i||
|fontid|i||

### strMyTableStyleBorderStyle
|Field|Type|Comment|
| --- | --- | --- |
|color|q||
|width|i||

### strMyTableStyleBorder
|Field|Type|Comment|
| --- | --- | --- |
|border|i||
|borderDefault|[strMyTableStyleBorderStyle](#strMyTableStyleBorderStyle)||
|borderLeft|[strMyTableStyleBorderStyle](#strMyTableStyleBorderStyle)||
|borderRight|[strMyTableStyleBorderStyle](#strMyTableStyleBorderStyle)||
|borderTop|[strMyTableStyleBorderStyle](#strMyTableStyleBorderStyle)||
|borderBottom|[strMyTableStyleBorderStyle](#strMyTableStyleBorderStyle)||

### strMyTableStyle
|Field|Type|Comment|
| --- | --- | --- |
|<span style="color:#FFFFAA">*font|[strMyTableFont](#strMyTableFont)</span>||
|backcolor|q||
|frontcolor|q||
|forecolor|q||
|valign|i||
|halign|i||
|border|[strMyTableStyleBorder](#strMyTableStyleBorder)||

### strMyTableObject : [strMyTableVTable](#strMyTableVTable)
|Field|Type|Comment|
| --- | --- | --- |
|flags|i||
|<span style="color:#FFFFAA">*data</span>||
|dirty|b||
|defaultStyle|[strMyTableStyle](#strMyTableStyle)||
|selectedStyle|[strMyTableStyle](#strMyTableStyle)||
|zebraStyle|[strMyTableStyle](#strMyTableStyle)||
|fixedStyle|[strMyTableStyle](#strMyTableStyle)||
|elementselectedStyle|[strMyTableStyle](#strMyTableStyle)||
|titleStyle|[strMyTableStyle](#strMyTableStyle)||
|mouseoverStyle|[strMyTableStyle](#strMyTableStyle)||
|emptyStyle|[strMyTableStyle](#strMyTableStyle)||
|tooltip|s||

### strMyTableStyleObject : [strMyTableVTable](#strMyTableVTable)
|Field|Type|Comment|
| --- | --- | --- |
|<span style="color:#FFFFAA">*obj|[strMyTableObject](#strMyTableObject)</span>||
|<span style="color:#FFFFAA">*cellStyle|[strMyTableStyle](#strMyTableStyle)</span>||
|<span style="color:#FFFFAA">*rowStyle|[strMyTableStyle](#strMyTableStyle)</span>||
|<span style="color:#FFFFAA">*colStyle|[strMyTableStyle](#strMyTableStyle)</span>||
|<span style="color:#FFFFAA">*tableStyle|[strMyTableStyle](#strMyTableStyle)</span>||
|<span style="color:#FFFFAA">*applicationStyle|[strMyTableStyle](#strMyTableStyle)</span>||
|<span style="color:#FFFFAA">*style|[strMyTableStyle](#strMyTableStyle)</span>||

### strMyTableImage
|Field|Type|Comment|
| --- | --- | --- |
|orig|i||
|sized|i||
|resize|b||

### strMyTableCell : [strMyTableObject](#strMyTableObject)
|Field|Type|Comment|
| --- | --- | --- |
|<span style="color:#FFFFAA">*parent|[strMyTableCell](#strMyTableCell)</span>||
|<span style="color:#FFFFAA">*col|[strMyTableCol](#strMyTableCol)</span>||
|<span style="color:#FFFFAA">*row|[strMyTableRow](#strMyTableRow)</span>||
|<span style="color:#FFFFAA">*table|[strMyTableTable](#strMyTableTable)</span>||
|<span style="color:#FFFFAA">*application|[strMyTableApplication](#strMyTableApplication)</span>||
|listindex|i||
|text|s||
|value|d||
|checked|b||
|formula|s||
|mask|s||
|datatype|i||
|<span style="color:#FFFFAA">*cells|[strMyTableCell](#strMyTableCell)List</span>||
|imageLeft|[strMyTableImage](#strMyTableImage)||
|imageRight|[strMyTableImage](#strMyTableImage)||
|textwidth|i||
|textheight|i||
|startx|i||
|starty|i||

### strMyTableCol : [strMyTableObject](#strMyTableObject)
|Field|Type|Comment|
| --- | --- | --- |
|<span style="color:#FFFFAA">*table|[strMyTableTable](#strMyTableTable)</span>||
|<span style="color:#FFFFAA">*application|[strMyTableApplication](#strMyTableApplication)</span>||
|<span style="color:#FFFFAA">*parent|[strMyTableCol](#strMyTableCol)</span>||
|listindex|i||
|text|s||
|image|[strMyTableImage](#strMyTableImage)||
|stretched|b||
|width|i||
|calcwidth|i||
|minwidth|i||
|calcminwidth|i||
|textwidth|i||
|textheight|i||
|sort|i||
|colspan|i||
|mask|s||
|datatype|i||

### strMyTableRow : [strMyTableObject](#strMyTableObject)
|Field|Type|Comment|
| --- | --- | --- |
|<span style="color:#FFFFAA">*table|[strMyTableTable](#strMyTableTable)</span>||
|<span style="color:#FFFFAA">*application|[strMyTableApplication](#strMyTableApplication)</span>||
|<span style="color:#FFFFAA">*cells|[strMyTableCell](#strMyTableCell)List</span>||
|<span style="color:#FFFFAA">*rows|[strMyTableRow](#strMyTableRow)List</span>||
|level|i||
|<span style="color:#FFFFAA">*parent|[strMyTableRow](#strMyTableRow)</span>||
|listindex|i||
|expanded|b||
|image|[strMyTableImage](#strMyTableImage)||
|height|i||
|calcheight|i||
|checked|b||
|sorts|s||
|sortd|d||
|explistindex|i||

### strMyTableTableEdit
|Field|Type|Comment|
| --- | --- | --- |
|<span style="color:#FFFFAA">*cell|[strMyTableCell](#strMyTableCell)</span>||
|window|i||
|gadget|i||
|menu|i||

### strMyTableTable : [strMyTableObject](#strMyTableObject)
|Field|Type|Comment|
| --- | --- | --- |
|<span style="color:#FFFFAA">*application|[strMyTableApplication](#strMyTableApplication)</span>||
|List rows|[strMyTableRow](#strMyTableRow)()||
|List expRows|i()||
|List cols|[strMyTableCol](#strMyTableCol)()||
|listindex|i||
|name|s||
|title|s||
|textheight|i||
|textwidth|i||
|titleHeight|i||
|calctitleHeight|i||
|redraw|b||
|recalc|b||
|datagrid|b||
|emptytext|s||
|drawing|b||
|window|i||
|canvas|i||
|vscroll|i||
|hscroll|i||
|maxvscroll|i||
|maxhscroll|i||
|fixedcols|i||
|defaultheaderheight|i||
|calcdefaultheaderheight|i||
|headerheight|i||
|calcheaderheight|i||
|defaultrowheight|i||
|calcdefaultrowheight|i||
|Map selectedCells|b()||
|Map selectedRows|b()||
|Map selectedCols|b()||
|Map tempselectedCells|b()||
|Map tempselectedRows|b()||
|Map tempselectedCols|b()||
|selectall|b||
|md|b||
|mxd|i||
|myd|i||
|<span style="color:#FFFFAA">*lastcell|[strMyTableCell](#strMyTableCell)</span>||
|<span style="color:#FFFFAA">*shiftcell|[strMyTableCell](#strMyTableCell)</span>||
|<span style="color:#FFFFAA">*lastrow|[strMyTableRow](#strMyTableRow)</span>||
|<span style="color:#FFFFAA">*lastcol|[strMyTableCol](#strMyTableCol)</span>||
|<span style="color:#FFFFAA">*mvcell|[strMyTableCell](#strMyTableCell)</span>||
|<span style="color:#FFFFAA">*mvrow|[strMyTableRow](#strMyTableRow)</span>||
|<span style="color:#FFFFAA">*mvcol|[strMyTableCol](#strMyTableCol)</span>||
|<span style="color:#FFFFAA">*resizeRow|[strMyTableRow](#strMyTableRow)</span>||
|<span style="color:#FFFFAA">*resizeCol|[strMyTableCol](#strMyTableCol)</span>||
|eventColLeftClick|MyTableProtoEventColLeftClick||
|eventColRightClick|MyTableProtoEventColRightClick||
|eventColLeftDoubleClick|MyTableProtoEventColLeftDoubleClick||
|eventColRightDoubleClick|MyTableProtoEventColRightDoubleClick||
|eventColSelected|MyTableProtoEventColSelected||
|eventCellChangedChecked|MyTableProtoEventCellChangedChecked||
|eventCellChangedUnChecked|MyTableProtoEventCellChangedUnChecked||
|eventCellChangedText|MyTableProtoEventCellChangedText||
|eventCellChangedValue|MyTableProtoEventCellChangedValue||
|eventCellSelected|MyTableProtoEventCellSelected||
|eventCellLeftClick|MyTableProtoEventCellLeftClick||
|eventCellRightClick|MyTableProtoEventCellRightClick||
|eventCellLeftDoubleClick|MyTableProtoEventCellLeftDoubleClick||
|eventCellRightDoubleClick|MyTableProtoEventCellRightDoubleClick||
|eventRowChangedChecked|MyTableProtoEventRowChangedChecked||
|eventRowChangedUnChecked|MyTableProtoEventRowChangedUnChecked||
|eventRowChangedExpanded|MyTableProtoEventRowChangedExpanded||
|eventRowChangedCollapsed|MyTableProtoEventRowChangedCollapsed||
|eventRowSelected|MyTableProtoEventRowSelected||
|eventRowLeftClick|MyTableProtoEventRowLeftClick||
|eventRowRightClick|MyTableProtoEventRowRightClick||
|eventRowLeftDoubleClick|MyTableProtoEventRowLeftDoubleClick||
|eventRowRightDoubleClick|MyTableProtoEventRowRightDoubleClick||
|eventCustomCellDraw|MyTableProtoEventCustomCellDraw||
|eventCustomCellEdit|MyTableProtoEventCustomCellEdit||
|callback|MyTableProtoCallback||
|DefaultImageSortAsc|i||
|DefaultImageSortDesc|i||
|DefaultImagePlus|i||
|DefaultImageMinus|i||
|DefaultImageCheckBox|i||
|DefaultImageCheckBoxChecked|i||
|DefaultImagePlusArrow|i||
|DefaultImageMinusArrow|i||
|pageElements|i||
|page|i||
|List expRowsPage|i()||
|edit|[strMyTableTableEdit](#strMyTableTableEdit)||
|oldwith|i||
|oldheight|i||

### strMyTableTree : [strMyTableTable](#strMyTableTable)
|Field|Type|Comment|
| --- | --- | --- |

### strMyTableGrid : [strMyTableTable](#strMyTableTable)
|Field|Type|Comment|
| --- | --- | --- |

### strMyTableApplication : [strMyTableObject](#strMyTableObject)
|Field|Type|Comment|
| --- | --- | --- |
|List tables|[strMyTableTable](#strMyTableTable)()||
|lastindex|i||
|redraw|b||
|recalc|b||

### strMyTableRowCol
|Field|Type|Comment|
| --- | --- | --- |
|row|i||
|col|i||
|bottom|b||
|right|b||
|exp|b||
|check|b||
|<span style="color:#FFFFAA">*trow|[strMyTableRow](#strMyTableRow)</span>||
|<span style="color:#FFFFAA">*tcol|[strMyTableCol](#strMyTableCol)</span>||
|<span style="color:#FFFFAA">*tcell|[strMyTableCell](#strMyTableCell)</span>||
|mx|i||
|my|i||
|startx|i||
|starty|i||

### strMyTableCellList
|Field|Type|Comment|
| --- | --- | --- |
|List cells|[strMyTableCell](#strMyTableCell)()||

### strMyTableRowList
|Field|Type|Comment|
| --- | --- | --- |
|List rows|[strMyTableRow](#strMyTableRow)()||

### strMyTableSaveStyleFont
|Field|Type|Comment|
| --- | --- | --- |
|name|s||
|size|i||
|flags|i||

### strMyTableSaveStyleBorder
|Field|Type|Comment|
| --- | --- | --- |
|color|q||
|width|i||

### strMyTableSaveStyle
|Field|Type|Comment|
| --- | --- | --- |
|border|i||
|boderDefault|[strMyTableSaveStyleBorder](#strMyTableSaveStyleBorder)||
|boderTop|[strMyTableSaveStyleBorder](#strMyTableSaveStyleBorder)||
|boderBottom|[strMyTableSaveStyleBorder](#strMyTableSaveStyleBorder)||
|boderLeft|[strMyTableSaveStyleBorder](#strMyTableSaveStyleBorder)||
|boderRight|[strMyTableSaveStyleBorder](#strMyTableSaveStyleBorder)||
|font|[strMyTableSaveStyleFont](#strMyTableSaveStyleFont)||
|backcolor|q||
|frontcolor|q||
|forecolor|q||

### strMyTableSaveObject
|Field|Type|Comment|
| --- | --- | --- |
|flags|i||

### strMyTableSaveCell : [strMyTableSaveObject](#strMyTableSaveObject)
|Field|Type|Comment|
| --- | --- | --- |
|text|s||
|value|d||
|checked|b||
|selected|b||

### strMyTableSaveRow : [strMyTableSaveObject](#strMyTableSaveObject)
|Field|Type|Comment|
| --- | --- | --- |
|checked|b||
|selected|b||

### strMyTableSaveCol : [strMyTableSaveObject](#strMyTableSaveObject)
|Field|Type|Comment|
| --- | --- | --- |
|text|s||
|selected|b||

### strMyTableSaveTable : [strMyTableSaveObject](#strMyTableSaveObject)
|Field|Type|Comment|
| --- | --- | --- |
|name|s||
|title|s||
|List cols|[strMyTableSaveCol](#strMyTableSaveCol)()||
|List rows|[strMyTableSaveRow](#strMyTableSaveRow)()||

### strMyTableSaveApplication : [strMyTableSaveObject](#strMyTableSaveObject)
|Field|Type|Comment|
| --- | --- | --- |
|List tables|[strMyTableSaveTable](#strMyTableSaveTable)()||


