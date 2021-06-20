
# MyTable

## Constants

|Constants|Value|Comment|
| --- | --- | --- |
|<span style="color:#AAAAFF">\#MYTABLE\_VERSION</span>| 2962||
|<span style="color:#AAAAFF">\#MYTABLE\_VERSION\_DATE</span>| 20210620||
|<span style="color:#AAAAFF">\#MYTABLE\_STYLE\_BORDER\_ALL</span>|<span style="color:#AAAAFF">\#MYTABLE\_STYLE\_BORDER\_TOP \| \#MYTABLE\_STYLE\_BORDER\_RIGHT \| \#MYTABLE\_STYLE\_BORDER\_BOTTOM \| \#MYTABLE\_STYLE\_BORDER\_LEFT</span>||
|<span style="color:#AAAAFF">\#MYTABLE\_TABLE\_FLAGS\_DEFAULT\_TABLE</span>|<span style="color:#AAAAFF">\#MYTABLE\_TABLE\_FLAGS\_BORDER \| \#MYTABLE\_TABLE\_FLAGS\_SORTABLE \| \#MYTABLE\_TABLE\_FLAGS\_RESIZABLE</span>||
|<span style="color:#AAAAFF">\#MYTABLE\_TABLE\_FLAGS\_DEFAULT\_TREE</span>|<span style="color:#AAAAFF">\#MYTABLE\_TABLE\_FLAGS\_BORDER \| \#MYTABLE\_TABLE\_FLAGS\_HIERARCHICAL</span>||
|<span style="color:#AAAAFF">\#MYTABLE\_TABLE\_FLAGS\_DEFAULT\_GRID</span>|<span style="color:#AAAAFF">\#MYTABLE\_TABLE\_FLAGS\_BORDER \| \#MYTABLE\_TABLE\_FLAGS\_GRID \| \#MYTABLE\_TABLE\_FLAGS\_RESIZABLE \| \#MYTABLE\_TABLE\_FLAGS\_MULTISELECT \| \#MYTABLE\_TABLE\_FLAGS\_EDITABLE</span>||


## Enumerations


### \_mytable\_type
|Name|Value|Comment|
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
|<span style="color:#AAAAFF">\#MYTABLE\_TYPE\_BORDER</span>|10||

### \_mytable\_style\_valign
|Name|Value|Comment|
| --- | --- | --- |
|<span style="color:#AAAAFF">\#MYTABLE\_STYLE\_VALIGN\_TOP</span>|0||
|<span style="color:#AAAAFF">\#MYTABLE\_STYLE\_VALIGN\_MIDDLE</span>|1||
|<span style="color:#AAAAFF">\#MYTABLE\_STYLE\_VALIGN\_BOTTOM</span>|2||

### \_mytable\_style\_halign
|Name|Value|Comment|
| --- | --- | --- |
|<span style="color:#AAAAFF">\#MYTABLE\_STYLE\_HALIGN\_LEFT</span>|0||
|<span style="color:#AAAAFF">\#MYTABLE\_STYLE\_HALIGN\_CENTER</span>|1||
|<span style="color:#AAAAFF">\#MYTABLE\_STYLE\_HALIGN\_RIGHT</span>|2||

### \_mytable\_datatype
|Name|Value|Comment|
| --- | --- | --- |
|<span style="color:#AAAAFF">\#MYTABLE\_DATATYPE\_DEFAULT</span>|0||
|<span style="color:#AAAAFF">\#MYTABLE\_DATATYPE\_NUMBER</span>|1||
|<span style="color:#AAAAFF">\#MYTABLE\_DATATYPE\_DATE</span>|2||
|<span style="color:#AAAAFF">\#MYTABLE\_DATATYPE\_TEXT</span>|3||

### \_mytable\_col\_sort
|Name|Value|Comment|
| --- | --- | --- |
|<span style="color:#AAAAFF">\#MYTABLE\_COL\_SORT\_NONE</span>|0||
|<span style="color:#AAAAFF">\#MYTABLE\_COL\_SORT\_ASC</span>|1||
|<span style="color:#AAAAFF">\#MYTABLE\_COL\_SORT\_DESC</span>|2||


## EnumerationBinarys


### \_mytable\_style\_border
|Name|Value|Comment|
| --- | --- | --- |
|<span style="color:#AAAAFF">\#MYTABLE\_STYLE\_BORDER\_NONE</span>|1||
|<span style="color:#AAAAFF">\#MYTABLE\_STYLE\_BORDER\_TOP</span>|2||
|<span style="color:#AAAAFF">\#MYTABLE\_STYLE\_BORDER\_RIGHT</span>|4||
|<span style="color:#AAAAFF">\#MYTABLE\_STYLE\_BORDER\_BOTTOM</span>|8||
|<span style="color:#AAAAFF">\#MYTABLE\_STYLE\_BORDER\_LEFT</span>|16||

### \_mytable\_cell
|Name|Value|Comment|
| --- | --- | --- |
|<span style="color:#AAAAFF">\#MYTABLE\_CELL\_FLAGS\_CHECKBOXES</span>|1||
|<span style="color:#AAAAFF">\#MYTABLE\_CELL\_FLAGS\_EDITABLE</span>|2||
|<span style="color:#AAAAFF">\#MYTABLE\_CELL\_FLAGS\_NO\_EDITABLE</span>|4||

### \_mytable\_col
|Name|Value|Comment|
| --- | --- | --- |
|<span style="color:#AAAAFF">\#MYTABLE\_COL\_FLAGS\_CHECKBOXES</span>|1||
|<span style="color:#AAAAFF">\#MYTABLE\_COL\_FLAGS\_SORTABLE</span>|2||
|<span style="color:#AAAAFF">\#MYTABLE\_COL\_FLAGS\_NO\_SORTABLE</span>|4||
|<span style="color:#AAAAFF">\#MYTABLE\_COL\_FLAGS\_RESIZABLE</span>|8||
|<span style="color:#AAAAFF">\#MYTABLE\_COL\_FLAGS\_NO\_RESIZABLE</span>|16||
|<span style="color:#AAAAFF">\#MYTABLE\_COL\_FLAGS\_EDITABLE</span>|32||
|<span style="color:#AAAAFF">\#MYTABLE\_COL\_FLAGS\_NO\_EDITABLE</span>|64||

### \_mytable\_row
|Name|Value|Comment|
| --- | --- | --- |
|<span style="color:#AAAAFF">\#MYTABLE\_ROW\_FLAGS\_RESIZABLE</span>|1|Row is resizeable|
|<span style="color:#AAAAFF">\#MYTABLE\_ROW\_FLAGS\_NO\_RESIZABLE</span>|2|if table is resizeable, this stops the row to be resizeable|
|<span style="color:#AAAAFF">\#MYTABLE\_ROW\_FLAGS\_HIERARCHICAL\_ALWAYS\_EXPANDED</span>|4|always expand the row|
|<span style="color:#AAAAFF">\#MYTABLE\_ROW\_FLAGS\_EDITABLE</span>|8||
|<span style="color:#AAAAFF">\#MYTABLE\_ROW\_FLAGS\_NO\_EDITABLE</span>|16||
|<span style="color:#AAAAFF">\#MYTABLE\_ROW\_FLAGS\_CHECKBOXES</span>|32||

### \_mytable\_table
|Name|Value|Comment|
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


## Prototypes

|Name|Return|Parameter|Comment|
| --- | --- | --- | --- |
|MyTableProtoEventColLeftClick|b|<span style="color:#FFFFAA">*col.[MyTableCol](#MyTableCol)</span>||
|MyTableProtoEventColRightClick|b|<span style="color:#FFFFAA">*col.[MyTableCol](#MyTableCol)</span>||
|MyTableProtoEventColLeftDoubleClick|b|<span style="color:#FFFFAA">*col.[MyTableCol](#MyTableCol)</span>||
|MyTableProtoEventColRightDoubleClick|b|<span style="color:#FFFFAA">*col.[MyTableCol](#MyTableCol)</span>||
|MyTableProtoEventColSelected|b|<span style="color:#FFFFAA">*col.[MyTableCol](#MyTableCol)</span>||
|MyTableProtoEventCellChangedChecked|b|<span style="color:#FFFFAA">*cell.[MyTableCell](#MyTableCell)</span>||
|MyTableProtoEventCellChangedUnChecked|b|<span style="color:#FFFFAA">*cell.[MyTableCell](#MyTableCell)</span>||
|MyTableProtoEventCellChangedText|b|<span style="color:#FFFFAA">*cell.</span>MyTableCell , old.s||
|MyTableProtoEventCellChangedValue|b|<span style="color:#FFFFAA">*cell.</span>MyTableCell , old.d||
|MyTableProtoEventCellSelected|b|<span style="color:#FFFFAA">*cell.[MyTableCell](#MyTableCell)</span>||
|MyTableProtoEventCellLeftClick|b|<span style="color:#FFFFAA">*cell.[MyTableCell](#MyTableCell)</span>||
|MyTableProtoEventCellRightClick|b|<span style="color:#FFFFAA">*cell.[MyTableCell](#MyTableCell)</span>||
|MyTableProtoEventCellLeftDoubleClick|b|<span style="color:#FFFFAA">*cell.[MyTableCell](#MyTableCell)</span>||
|MyTableProtoEventCellRightDoubleClick|b|<span style="color:#FFFFAA">*cell.[MyTableCell](#MyTableCell)</span>||
|MyTableProtoEventRowChangedChecked|b|<span style="color:#FFFFAA">*row.[MyTableRow](#MyTableRow)</span>||
|MyTableProtoEventRowChangedUnChecked|b|<span style="color:#FFFFAA">*row.[MyTableRow](#MyTableRow)</span>||
|MyTableProtoEventRowChangedExpanded|b|<span style="color:#FFFFAA">*row.[MyTableRow](#MyTableRow)</span>||
|MyTableProtoEventRowChangedCollapsed|b|<span style="color:#FFFFAA">*row.[MyTableRow](#MyTableRow)</span>||
|MyTableProtoEventRowSelected|b|<span style="color:#FFFFAA">*row.[MyTableRow](#MyTableRow)</span>||
|MyTableProtoEventRowLeftClick|b|<span style="color:#FFFFAA">*cell.[MyTableRow](#MyTableRow)</span>||
|MyTableProtoEventRowRightClick|b|<span style="color:#FFFFAA">*cell.[MyTableRow](#MyTableRow)</span>||
|MyTableProtoEventRowLeftDoubleClick|b|<span style="color:#FFFFAA">*cell.[MyTableRow](#MyTableRow)</span>||
|MyTableProtoEventRowRightDoubleClick|b|<span style="color:#FFFFAA">*cell.[MyTableRow](#MyTableRow)</span>||
|MyTableProtoEventCustomCellDraw|b|<span style="color:#FFFFAA">*cell.</span>MyTableCell , x , y , w , h|Return #True if custom cell is drawn|
|MyTableProtoEventCustomCellEdit|b|<span style="color:#FFFFAA">*cell.[MyTableCell](#MyTableCell)</span>|Return #True if custom cell is edited|
|MyTableProtoCallback||<span style="color:#FFFFAA">*row.[MyTableRow](#MyTableRow)</span>||


## Interfaces


### MyTableFont
|Name|Return|Parameter|Comment|
| --- | --- | --- | --- |
|GetType||||
|GetFlags||||
|GetName|s|||
|GetSize||||

### MyTableBorder
|Name|Return|Parameter|Comment|
| --- | --- | --- | --- |
|GetType||||
|GetObject||||
|GetStyle||||
|SetColor||value.q||
|GetColor|q|||
|SetWidth||value.i||
|GetWidth|i|||
|Free||||
|Delete||||

### MyTableStyle
|Name|Return|Parameter|Comment|
| --- | --- | --- | --- |
|GetType||||
|GetObject||||
|getBorderDefault||||
|getBorderTop||||
|getBorderLeft||||
|getBorderRight||||
|getBorderBottom||||
|SetFont||<span style="color:#FFFFAA">*font.[MyTableFont](#MyTableFont)</span>||
|GetFont||||
|SetBackColor||value.q||
|GetBackColor|q|||
|SetFrontColor||value.q||
|GetFrontColor|q|||
|SetForeColor||value.q||
|GetForeColor|q|||
|SetHAlign||value.i||
|GetHAlign||||
|SetVAlign||value.i||
|GetVAlign||||
|SetBorder||value.i||
|GetBorder||||
|Free||||
|Delete||||

### MyTableObject
|Name|Return|Parameter|Comment|
| --- | --- | --- | --- |
|GetType||||
|GetDefaultStyle||||
|GetSelectedStyle||||
|GetMouseOverStyle||||
|GetFixedStyle||||
|SetFlags||value.i||
|GetFlags||||
|SetData||<span style="color:#FFFFAA">*value</span>||
|GetData||||
|SetDirty||value.b||
|GetDirty|b|||
|SetSelected||value.b||
|GetSelected|b|||
|SetTooltip||value.s||
|GetTooltip|s|||
|Autosize||||

### MyTableCell : [MyTableObject](#MyTableObject)
|Name|Return|Parameter|Comment|
| --- | --- | --- | --- |
|GetApplication||||
|GetTable||||
|GetRow||||
|GetCol||||
|GetParent||||
|SetText||value.s||
|GetText|s|||
|SetFormula||value.s||
|GetFormula|s|||
|SetMask||value.s||
|GetMask|s|||
|SetDatatype||value.i||
|GetDatatype|i|||
|SetValue||value.d||
|GetValue|d|||
|SetImageLeft||value.i||
|GetImageLeft|i|||
|SetImageRight||value.i||
|GetImageRight|i|||
|SetChecked||value.b||
|GetChecked|b|||
|AddCell||text.s , image.i = 0 , flags.i = 0||
|DeleteCell||row.i||
|GetCell||row.i||
|CountCells||||
|ScrollTo||setSelect.b = <span style="color:#AAAAFF">\#False</span> , redraw.b = <span style="color:#AAAAFF">\#True</span>||
|StartEdit||||
|StopEdit||||

### MyTableCol : [MyTableObject](#MyTableObject)
|Name|Return|Parameter|Comment|
| --- | --- | --- | --- |
|GetElementSelectedStyle||||
|GetApplication||||
|GetTable||||
|GetPosition||||
|SetText||value.s||
|GetText|s|||
|SetMask||value.s||
|GetMask|s|||
|SetDatatype||value.i||
|GetDatatype|i|||
|SetImage||value.i||
|GetImage|i|||
|SetWidth||value.i||
|GetWidth|i|||
|SetSort||value.i||
|GetSort|i|||
|SetColspan||value.i||
|GetColspan|i|||
|Delete||||
|ScrollTo||setSelect.b = <span style="color:#AAAAFF">\#False</span> , redraw.b = <span style="color:#AAAAFF">\#True</span>||

### MyTableRow : [MyTableObject](#MyTableObject)
|Name|Return|Parameter|Comment|
| --- | --- | --- | --- |
|GetElementSelectedStyle||||
|GetApplication||||
|GetTable||||
|GetParent||||
|GetPosition||||
|GetLevel||||
|SetExpanded||value.b||
|GetExpanded|b|||
|SetImage||value.i||
|GetImage|i|||
|SetChecked||value.b||
|GetChecked|b|||
|AddDirtyRows||rows.i||
|AddRow||text.s , sep.s = <span style="color:#AAFFAA">" \| "</span> , image.i = 0 , flags.i = 0||
|DeleteRow||row.i||
|GetRow||row.i||
|RowCount||||
|GetCell||col.i||
|Delete||||
|ScrollTo||setSelect.b = <span style="color:#AAAAFF">\#False</span> , redraw.b = <span style="color:#AAAAFF">\#True</span>||

### MyTableTableObject : [MyTableObject](#MyTableObject)
|Name|Return|Parameter|Comment|
| --- | --- | --- | --- |
|GetElementSelectedStyle||||
|GetZebraStyle||||
|GetTitleStyle||||
|GetEmptyStyle||||
|GetApplication||||
|GetPages||||
|SetName||value.s||
|GetName|s|||
|SetTitle||value.s||
|GetTitle|s|||
|SetRedraw||value.b||
|GetRedraw|b|||
|SetRecalc||value.b||
|GetRecalc|b|||
|SetHeaderHeight||value.i||
|GetHeaderHeight|i|||
|SetTitleHeight||value.i||
|GetTitleHeight|i|||
|SetDefaultRowHeight||value.i||
|GetDefaultRowHeight|i|||
|SetFixedCols||value.i||
|GetFixedCols|i|||
|SetEmptyText||value.s||
|GetEmptyText|s|||
|SetPage||value.i||
|GetPage|i|||
|SetPageElements||value.i||
|GetPageElements|i|||
|GetSelectedRows||List rows.[MyTableRow](#MyTableRow)||
|GetSelectedCells||List cells.[MyTableCell](#MyTableCell)||
|GetSelectedCols||List cols.[MyTableCol](#MyTableCol)||
|GetCalcHeight||||
|GetCalcWidth||||
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
|GetCell||row.i , col.i||
|Delete||||
|GetRow||row.i||
|RowCount||||
|VisibleRowCount||||
|GetCol||col.i||
|ColCount||||

### MyTableTable : [MyTableTableObject](#MyTableTableObject)
|Name|Return|Parameter|Comment|
| --- | --- | --- | --- |
|SetDefaultImageSortAsc||value.i||
|GeDefaultImageSortAsc|i|||
|SetDefaultImageSortDesc||value.i||
|GeDefaultImageSortDesc|i|||
|SetDefaultImagePlus||value.i||
|GeDefaultImagePlus|i|||
|SetDefaultImageMinus||value.i||
|GeDefaultImageMinus|i|||
|SetDefaultImageCheckBox||value.i||
|GeDefaultImageCheckBox|i|||
|SetDefaultImageCheckBoxChecked||value.i||
|GeDefaultImageCheckBoxChecked|i|||
|SetDefaultImagePlusArrow||value.i||
|GeDefaultImagePlusArrow|i|||
|SetDefaultImageMinusArrow||value.i||
|GeDefaultImageMinusArrow|i|||
|AddDirtyRows||rows.i||
|AddRow||text.s , sep.s = <span style="color:#AAFFAA">" \| "</span> , image.i = 0 , flags.i = 0||
|DeleteRow||row.i||
|AddCol||text.s , width.i , image.i = 0 , flags.i = 0||
|DeleteCol||col.i||
|ClearRows||||
|ClearCols||||

### MyTableTree : [MyTableTable](#MyTableTable)
|Name|Return|Parameter|Comment|
| --- | --- | --- | --- |

### MyTableGrid : [MyTableTableObject](#MyTableTableObject)
|Name|Return|Parameter|Comment|
| --- | --- | --- | --- |
|ResizeGrid||rows.i = <span style="color:#AAAAFF">\#PB\_Ignore</span> , cols.i = <span style="color:#AAAAFF">\#PB\_Ignore</span>||
|RegisterEventColSelected||event.MyTableProtoEventColSelected||

### MyTableApplication : [MyTableObject](#MyTableObject)
|Name|Return|Parameter|Comment|
| --- | --- | --- | --- |
|GetElementSelectedStyle||||
|GetZebraStyle||||
|GetTitleStyle||||
|GetEmptyStyle||||
|SetRedraw||value.b||
|GetRedraw|b|||
|SetRecalc||value.b||
|GetRecalc|b|||
|AddTable||window.i , canvas.i , vscroll.i , hscroll.i , name.s = <span style="color:#AAFFAA">""</span> , flags.i = <span style="color:#AAAAFF">\#MYTABLE\_TABLE\_FLAGS\_DEFAULT\_TABLE</span>||
|AddTree||window.i , canvas.i , vscroll.i , hscroll.i , name.s = <span style="color:#AAFFAA">""</span> , flags.i = <span style="color:#AAAAFF">\#MYTABLE\_TABLE\_FLAGS\_DEFAULT\_TREE</span>||
|AddGrid||window.i , canvas.i , vscroll.i , hscroll.i , rows.i , cols.i , name.s = <span style="color:#AAFFAA">""</span> , flags.i = <span style="color:#AAAAFF">\#MYTABLE\_TABLE\_FLAGS\_DEFAULT\_GRID</span>||
|ClearTables||||
|Redraw||||
|Recalc||||
|Free||||
|Save|b|file.s||


## Declares

|Name|Return|Parameter|Comment|
| --- | --- | --- | --- |
|MyTableCreateApplication||flags.i = 0||
|MyTableLoadApplication||file.s||
|MyTableCreateTable||window.i , canvas.i , vscroll.i , hscroll.i , flags.i = <span style="color:#AAAAFF">\#MYTABLE\_TABLE\_FLAGS\_DEFAULT\_TABLE</span>||
|MyTableCreateTree||window.i , canvas.i , vscroll.i , hscroll.i , flags.i = <span style="color:#AAAAFF">\#MYTABLE\_TABLE\_FLAGS\_DEFAULT\_TREE</span>||
|MyTableCreateGrid||window.i , canvas.i , vscroll.i , hscroll.i , rows.i , cols.i , flags.i = <span style="color:#AAAAFF">\#MYTABLE\_TABLE\_FLAGS\_DEFAULT\_GRID</span>||
|MyTableCreateFont||name.s , size.i , flags.i = 0||


