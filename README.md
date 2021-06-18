
# MyTable

## Interfaces


### MyTableFont
|Procedure|Return|Parameter|Comment|
| --- | --- | --- | --- |
|GetType||||
|GetFlags||||
|GetName|s|||
|GetSize||||

### MyTableStyle
|Procedure|Return|Parameter|Comment|
| --- | --- | --- | --- |
|GetType||||
|GetObject||||
|SetFont||*font.[MyTableFont](#MyTableFont)||
|SetBackColor||value.q||
|SetFrontColor||value.q||
|SetForeColor||value.q||
|SetHAlign||value.i||
|SetVAlign||value.i||
|SetBorder||value.i||
|SetBorderColor||value.q||
|SetBorderWidth||value.i||
|Free||||
|Delete||||

### MyTableObject
|Procedure|Return|Parameter|Comment|
| --- | --- | --- | --- |
|GetType||||
|GetDefaultStyle||||
|GetSelectedStyle||||
|GetMouseOverStyle||||
|GetFixedStyle||||
|SetFlags||value.i||
|SetData||*value||
|SetDirty||value.b||
|SetSelected||value.b||
|SetTooltip||value.s||
|Autosize||||

### MyTableCell
|Procedure|Return|Parameter|Comment|
| --- | --- | --- | --- |
|GetApplication||||
|GetTable||||
|GetRow||||
|GetCol||||
|GetParent||||
|SetText||value.s||
|SetFormula||value.s||
|SetMask||value.s||
|SetDatatype||value.i||
|SetValue||value.d||
|SetImageLeft||value.i||
|SetImageRight||value.i||
|SetChecked||value.b||
|AddCell||text.s , image.i = 0 , flags.i = 0||
|DeleteCell||row.i||
|GetCell||row.i||
|CountCells||||
|ScrollTo||setSelect.b = <span style="color:#AAAAFF">\#False</span> , redraw.b = <span style="color:#AAAAFF">\#True</span>||
|StartEdit||||
|StopEdit||||

### MyTableCol
|Procedure|Return|Parameter|Comment|
| --- | --- | --- | --- |
|GetElementSelectedStyle||||
|GetApplication||||
|GetTable||||
|GetPosition||||
|SetText||value.s||
|SetMask||value.s||
|SetDatatype||value.i||
|SetImage||value.i||
|SetWidth||value.i||
|SetSort||value.i||
|SetColspan||value.i||
|Delete||||
|ScrollTo||setSelect.b = <span style="color:#AAAAFF">\#False</span> , redraw.b = <span style="color:#AAAAFF">\#True</span>||

### MyTableRow
|Procedure|Return|Parameter|Comment|
| --- | --- | --- | --- |
|GetElementSelectedStyle||||
|GetApplication||||
|GetTable||||
|GetParent||||
|GetPosition||||
|GetLevel||||
|SetExpanded||value.b||
|SetImage||value.i||
|SetChecked||value.b||
|AddDirtyRows||rows.i||
|AddRow||text.s , sep.s = " \| " , image.i = 0 , flags.i = 0||
|DeleteRow||row.i||
|GetRow||row.i||
|RowCount||||
|GetCell||col.i||
|Delete||||
|ScrollTo||setSelect.b = <span style="color:#AAAAFF">\#False</span> , redraw.b = <span style="color:#AAAAFF">\#True</span>||

### MyTableTable
|Procedure|Return|Parameter|Comment|
| --- | --- | --- | --- |
|GetElementSelectedStyle||||
|GetZebraStyle||||
|GetTitleStyle||||
|GetEmptyStyle||||
|GetApplication||||
|GetPages||||
|SetName||value.s||
|SetTitle||value.s||
|SetRedraw||value.b||
|SetRecalc||value.b||
|SetHeaderHeight||value.i||
|SetTitleHeight||value.i||
|SetDefaultRowHeight||value.i||
|SetFixedCols||value.i||
|SetEmptyText||value.s||
|SetPage||value.i||
|SetPageElements||value.i||
|SetDefaultImageSortAsc||value.i||
|SetDefaultImageSortDesc||value.i||
|SetDefaultImagePlus||value.i||
|SetDefaultImageMinus||value.i||
|SetDefaultImageCheckBox||value.i||
|SetDefaultImageCheckBoxChecked||value.i||
|SetDefaultImagePlusArrow||value.i||
|SetDefaultImageMinusArrow||value.i||
|GetSelectedRows||List rows.[MyTableRow](#MyTableRow)||
|GetSelectedCells||List cells.[MyTableCell](#MyTableCell)||
|GetSelectedCols||List cols.[MyTableCol](#MyTableCol)||
|GetCalcHeight||||
|GetCalcWidth||||
|AddDirtyRows||rows.i||
|AddRow||text.s , sep.s = " \| " , image.i = 0 , flags.i = 0||
|DeleteRow||row.i||
|GetRow||row.i||
|RowCount||||
|VisibleRowCount||||
|AddCol||text.s , width.i , image.i = 0 , flags.i = 0||
|DeleteCol||col.i||
|GetCol||col.i||
|ColCount||||
|GetCell||row.i , col.i||
|Delete||||
|ClearRows||||
|ClearCols||||
|Redraw||||
|Recalc||||
|Free||||
|ScrollToPos||row.i , setSelect.b = <span style="color:#AAAAFF">\#False</span>||
|ScrollToCellPos||row.i , col.i , setSelect.b = <span style="color:#AAAAFF">\#False</span>||
|AutosizeRows||||
|AutosizeCols||||
|AutosizeHeader||||
|RegisterEventColLeftClick||event.MyTableProtoEventColLeftClick||
|RegisterEventColLeftDoubleClick||event.MyTableProtoEventColLeftDoubleClick||
|RegisterEventColRightClick||event.MyTableProtoEventColRightClick||
|RegisterEventColRightDoubleClick||event.MyTableProtoEventColRightDoubleClick||
|RegisterEventCellChangedChecked||event.MyTableProtoEventCellChangedChecked||
|RegisterEventCellChangedUnChecked||event.MyTableProtoEventCellChangedUnChecked||
|RegisterEventCellChangedText||event.MyTableProtoEventCellChangedText||
|RegisterEventCellChangedValue||event.MyTableProtoEventCellChangedValue||
|RegisterEventCellSelected||event.MyTableProtoEventCellSelected||
|RegisterEventCellLeftClick||event.MyTableProtoEventCellLeftClick||
|RegisterEventCellLeftDoubleClick||event.MyTableProtoEventCellLeftDoubleClick||
|RegisterEventCellRightClick||event.MyTableProtoEventCellRightClick||
|RegisterEventCellRightDoubleClick||event.MyTableProtoEventCellRightDoubleClick||
|RegisterEventRowChangedChecked||event.MyTableProtoEventRowChangedChecked||
|RegisterEventRowChangedUnChecked||event.MyTableProtoEventRowChangedUnChecked||
|RegisterEventRowChangedExpanded||event.MyTableProtoEventRowChangedExpanded||
|RegisterEventRowChangedCollapsed||event.MyTableProtoEventRowChangedCollapsed||
|RegisterEventRowSelected||event.MyTableProtoEventRowSelected||
|RegisterEventRowLeftClick||event.MyTableProtoEventRowLeftClick||
|RegisterEventRowLeftDoubleClick||event.MyTableProtoEventRowLeftDoubleClick||
|RegisterEventRowRightClick||event.MyTableProtoEventRowRightClick||
|RegisterEventRowRightDoubleClick||event.MyTableProtoEventRowRightDoubleClick||
|RegisterEventCustomCellDraw||event.MyTableProtoEventCustomCellDraw||
|RegisterEventCustomCellEdit||event.MyTableProtoEventCustomCellEdit||
|RegisterCallback||callback.MyTableProtoCallback||

### MyTableTree
|Procedure|Return|Parameter|Comment|
| --- | --- | --- | --- |

### MyTableGrid
|Procedure|Return|Parameter|Comment|
| --- | --- | --- | --- |
|ResizeGrid||rows.i = <span style="color:#AAAAFF">\#PB\_Ignore</span> , cols.i = <span style="color:#AAAAFF">\#PB\_Ignore</span>||

### MyTableApplication
|Procedure|Return|Parameter|Comment|
| --- | --- | --- | --- |
|GetElementSelectedStyle||||
|GetZebraStyle||||
|GetTitleStyle||||
|GetEmptyStyle||||
|SetRedraw||value.b||
|SetRecalc||value.b||
|AddTable||window.i , canvas.i , vscroll.i , hscroll.i , name.s = "" , flags.i = <span style="color:#AAAAFF">\#MYTABLE\_TABLE\_FLAGS\_DEFAULT\_TABLE</span>||
|AddTree||window.i , canvas.i , vscroll.i , hscroll.i , name.s = "" , flags.i = <span style="color:#AAAAFF">\#MYTABLE\_TABLE\_FLAGS\_DEFAULT\_TREE</span>||
|AddGrid||window.i , canvas.i , vscroll.i , hscroll.i , rows.i , cols.i , name.s = "" , flags.i = <span style="color:#AAAAFF">\#MYTABLE\_TABLE\_FLAGS\_DEFAULT\_GRID</span>||
|ClearTables||||
|Redraw||||
|Recalc||||
|Free||||
|Save|b|file.s||


## Enumerations


### \_mytable\_type
|Enumeration|Value|Comment|
| --- | --- | --- |
|<span style="color:#AAAAFF">\#MYTABLE\_TYPE\_NONE</span>|0||
|<span style="color:#AAAAFF">\#MYTABLE\_TYPE\_CELL</span>|1||
|<span style="color:#AAAAFF">\#MYTABLE\_TYPE\_ROW</span>|2||
|<span style="color:#AAAAFF">\#MYTABLE\_TYPE\_COL</span>|3||
|<span style="color:#AAAAFF">\#MYTABLE\_TYPE\_TABLE</span>|4||
|<span style="color:#AAAAFF">\#MYTABLE\_TYPE\_TREE</span>|5||
|<span style="color:#AAAAFF">\#MYTABLE\_TYPE\_GRID</span>|6||
|<span style="color:#AAAAFF">\#MYTABLE\_TYPE\_APPLICATION</span>|7||
|<span style="color:#AAAAFF">\#MYTABLE\_TYPE\_STYLE</span>|8||
|<span style="color:#AAAAFF">\#MYTABLE\_TYPE\_FONT</span>|9||

### \_mytable\_style\_valign
|Enumeration|Value|Comment|
| --- | --- | --- |
|<span style="color:#AAAAFF">\#MYTABLE\_STYLE\_VALIGN\_TOP</span>|0||
|<span style="color:#AAAAFF">\#MYTABLE\_STYLE\_VALIGN\_MIDDLE</span>|1||
|<span style="color:#AAAAFF">\#MYTABLE\_STYLE\_VALIGN\_BOTTOM</span>|2||

### \_mytable\_style\_halign
|Enumeration|Value|Comment|
| --- | --- | --- |
|<span style="color:#AAAAFF">\#MYTABLE\_STYLE\_HALIGN\_LEFT</span>|0||
|<span style="color:#AAAAFF">\#MYTABLE\_STYLE\_HALIGN\_CENTER</span>|1||
|<span style="color:#AAAAFF">\#MYTABLE\_STYLE\_HALIGN\_RIGHT</span>|2||

### \_mytable\_datatype
|Enumeration|Value|Comment|
| --- | --- | --- |
|<span style="color:#AAAAFF">\#MYTABLE\_DATATYPE\_DEFAULT</span>|0||
|<span style="color:#AAAAFF">\#MYTABLE\_DATATYPE\_NUMBER</span>|1||
|<span style="color:#AAAAFF">\#MYTABLE\_DATATYPE\_DATE</span>|2||
|<span style="color:#AAAAFF">\#MYTABLE\_DATATYPE\_TEXT</span>|3||

### \_mytable\_col\_sort
|Enumeration|Value|Comment|
| --- | --- | --- |
|<span style="color:#AAAAFF">\#MYTABLE\_COL\_SORT\_NONE</span>|0||
|<span style="color:#AAAAFF">\#MYTABLE\_COL\_SORT\_ASC</span>|1||
|<span style="color:#AAAAFF">\#MYTABLE\_COL\_SORT\_DESC</span>|2||


## EnumerationBinarys


### \_mytable\_style\_border
|EnumerationBinary|Value|Comment|
| --- | --- | --- |
|<span style="color:#AAAAFF">\#MYTABLE\_STYLE\_BORDER\_TOP</span>|1||
|<span style="color:#AAAAFF">\#MYTABLE\_STYLE\_BORDER\_RIGHT</span>|2||
|<span style="color:#AAAAFF">\#MYTABLE\_STYLE\_BORDER\_BOTTOM</span>|4||
|<span style="color:#AAAAFF">\#MYTABLE\_STYLE\_BORDER\_LEFT</span>|8||

### \_mytable\_cell
|EnumerationBinary|Value|Comment|
| --- | --- | --- |
|<span style="color:#AAAAFF">\#MYTABLE\_CELL\_FLAGS\_CHECKBOXES</span>|1||
|<span style="color:#AAAAFF">\#MYTABLE\_CELL\_FLAGS\_EDITABLE</span>|2||
|<span style="color:#AAAAFF">\#MYTABLE\_CELL\_FLAGS\_NO\_EDITABLE</span>|4||

### \_mytable\_col
|EnumerationBinary|Value|Comment|
| --- | --- | --- |
|<span style="color:#AAAAFF">\#MYTABLE\_COL\_FLAGS\_CHECKBOXES</span>|1||
|<span style="color:#AAAAFF">\#MYTABLE\_COL\_FLAGS\_SORTABLE</span>|2||
|<span style="color:#AAAAFF">\#MYTABLE\_COL\_FLAGS\_NO\_SORTABLE</span>|4||
|<span style="color:#AAAAFF">\#MYTABLE\_COL\_FLAGS\_RESIZABLE</span>|8||
|<span style="color:#AAAAFF">\#MYTABLE\_COL\_FLAGS\_NO\_RESIZABLE</span>|16||
|<span style="color:#AAAAFF">\#MYTABLE\_COL\_FLAGS\_EDITABLE</span>|32||
|<span style="color:#AAAAFF">\#MYTABLE\_COL\_FLAGS\_NO\_EDITABLE</span>|64||

### \_mytable\_row
|EnumerationBinary|Value|Comment|
| --- | --- | --- |
|<span style="color:#AAAAFF">\#MYTABLE\_ROW\_FLAGS\_RESIZABLE</span>|1|Row is resizeable|
|<span style="color:#AAAAFF">\#MYTABLE\_ROW\_FLAGS\_NO\_RESIZABLE</span>|2|if table is resizeable, this stops the row to be resizeable|
|<span style="color:#AAAAFF">\#MYTABLE\_ROW\_FLAGS\_HIERARCHICAL\_ALWAYS\_EXPANDED</span>|4|always expand the row|
|<span style="color:#AAAAFF">\#MYTABLE\_ROW\_FLAGS\_EDITABLE</span>|8||
|<span style="color:#AAAAFF">\#MYTABLE\_ROW\_FLAGS\_NO\_EDITABLE</span>|16||

### \_mytable\_table
|EnumerationBinary|Value|Comment|
| --- | --- | --- |
|<span style="color:#AAAAFF">\#MYTABLE\_TABLE\_FLAGS\_HIERARCHICAL</span>|1|Tree|
|<span style="color:#AAAAFF">\#MYTABLE\_TABLE\_FLAGS\_HIERARCHICAL\_ALWAYS\_EXPANDED</span>|2|always expanded rows in tree|
|<span style="color:#AAAAFF">\#MYTABLE\_TABLE\_FLAGS\_CHECKBOXES</span>|4|rows woth checkboxes|
|<span style="color:#AAAAFF">\#MYTABLE\_TABLE\_FLAGS\_FULLROWSELECT</span>|8|select always rows|
|<span style="color:#AAAAFF">\#MYTABLE\_TABLE\_FLAGS\_MULTISELECT</span>|16|can select more rows/cells/cols|
|<span style="color:#AAAAFF">\#MYTABLE\_TABLE\_FLAGS\_BORDER</span>|32|draw a grid|
|<span style="color:#AAAAFF">\#MYTABLE\_TABLE\_FLAGS\_NO\_HEADER</span>|64|no header will drawn|
|<span style="color:#AAAAFF">\#MYTABLE\_TABLE\_FLAGS\_NO\_REDRAW</span>|128|stops redrawing. setRedraw(#True) will activate it again|
|<span style="color:#AAAAFF">\#MYTABLE\_TABLE\_FLAGS\_CALLBACK</span>|256|Table has callbacks for dynamic loads|
|<span style="color:#AAAAFF">\#MYTABLE\_TABLE\_FLAGS\_SORTABLE</span>|512|Table is sortable|
|<span style="color:#AAAAFF">\#MYTABLE\_TABLE\_FLAGS\_RESIZABLE</span>|1024|Cols and Rows are Resizeable|
|<span style="color:#AAAAFF">\#MYTABLE\_TABLE\_FLAGS\_PAGES</span>|2048|Table can have pages|
|<span style="color:#AAAAFF">\#MYTABLE\_TABLE\_FLAGS\_TITLE</span>|4096|draw the title|
|<span style="color:#AAAAFF">\#MYTABLE\_TABLE\_FLAGS\_MARK\_MOUSE\_OVER</span>|8192|MouseOver marks the cell|
|<span style="color:#AAAAFF">\#MYTABLE\_TABLE\_FLAGS\_EDITABLE</span>|16384|Editable|
|<span style="color:#AAAAFF">\#MYTABLE\_TABLE\_FLAGS\_ZEBRA</span>|32768|Zebra Layout|
|<span style="color:#AAAAFF">\#MYTABLE\_TABLE\_FLAGS\_GRID</span>|65536|Grid (Excel-like) Layout|


## Constants

|Constants|Value|Comment|
| --- | --- | --- |
|<span style="color:#AAAAFF">\#MYTABLE\_VERSION</span>| 2577||
|<span style="color:#AAAAFF">\#MYTABLE\_VERSION\_DATE</span>| 20210618||
|<span style="color:#AAAAFF">\#MYTABLE\_TABLE\_FLAGS\_DEFAULT\_TABLE</span>|<span style="color:#AAAAFF">\#MYTABLE\_TABLE\_FLAGS\_BORDER \| \#MYTABLE\_TABLE\_FLAGS\_SORTABLE \| \#MYTABLE\_TABLE\_FLAGS\_RESIZABLE</span>||
|<span style="color:#AAAAFF">\#MYTABLE\_TABLE\_FLAGS\_DEFAULT\_TREE</span>|<span style="color:#AAAAFF">\#MYTABLE\_TABLE\_FLAGS\_BORDER \| \#MYTABLE\_TABLE\_FLAGS\_HIERARCHICAL</span>||
|<span style="color:#AAAAFF">\#MYTABLE\_TABLE\_FLAGS\_DEFAULT\_GRID</span>|<span style="color:#AAAAFF">\#MYTABLE\_TABLE\_FLAGS\_BORDER \| \#MYTABLE\_TABLE\_FLAGS\_GRID \| \#MYTABLE\_TABLE\_FLAGS\_RESIZABLE \| \#MYTABLE\_TABLE\_FLAGS\_MULTISELECT \| \#MYTABLE\_TABLE\_FLAGS\_EDITABLE</span>||


## Procedures

|Procedure|Return|Parameter|Comment|
| --- | --- | --- | --- |
|Declare MyTableCreateApplication||flags.i = 0||
|Declare MyTableLoadApplication||file.s||
|Declare MyTableCreateTable||window.i , canvas.i , vscroll.i , hscroll.i , flags.i = <span style="color:#AAAAFF">\#MYTABLE\_TABLE\_FLAGS\_DEFAULT\_TABLE</span>||
|Declare MyTableCreateTree||window.i , canvas.i , vscroll.i , hscroll.i , flags.i = <span style="color:#AAAAFF">\#MYTABLE\_TABLE\_FLAGS\_DEFAULT\_TREE</span>||
|Declare MyTableCreateGrid||window.i , canvas.i , vscroll.i , hscroll.i , rows.i , cols.i , flags.i = <span style="color:#AAAAFF">\#MYTABLE\_TABLE\_FLAGS\_DEFAULT\_GRID</span>||
|Declare MyTableCreateFont||name.s , size.i , flags.i = 0||


