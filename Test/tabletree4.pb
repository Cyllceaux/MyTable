EnableExplicit

XIncludeFile "declare.pb"

UseModule MyTable
	
	Global window=OpenWindow(#PB_Any,0,0,800,600,"TableTree 4 (Fixed cols, Editable col 3)",#PB_Window_SystemMenu|#PB_Window_ScreenCentered|#PB_Window_SizeGadget|#PB_Window_MaximizeGadget|#PB_Window_MinimizeGadget)
	Global canvas=CanvasGadget(#PB_Any,0,0,WindowWidth(window),WindowHeight(window),#PB_Canvas_Container|#PB_Canvas_Keyboard)
	Global hscroll=ScrollBarGadget(#PB_Any,0,0,0,20,0,0,0)
	Global vscroll=ScrollBarGadget(#PB_Any,0,0,20,0,0,0,0,#PB_ScrollBar_Vertical)
	CloseGadgetList()
	
	Global *tree.MyTableTable=MyTableCreateTree(window,canvas,vscroll,hscroll,#MYTABLE_TABLE_FLAGS_CHECKBOXES|#MYTABLE_TABLE_FLAGS_BORDER|#MYTABLE_TABLE_FLAGS_MULTISELECT|#MYTABLE_TABLE_FLAGS_SORTABLE|#MYTABLE_TABLE_FLAGS_RESIZABLE)
	*tree\SetRedraw(#False)
	Define *col.MyTableCol,*stamm.MyTableRow,*ast.MyTableRow,*zweig.MyTableRow,*blatt.MyTableRow
	*col=*tree\AddCol("Test 1 (fix)",200,rowImage)
	*col=*tree\AddCol("Test 2",200,rowImageSub,#MYTABLE_COL_FLAGS_NO_SORTABLE)
	*col=*tree\AddCol("Test 3",500,rowImageSub2,#MYTABLE_COL_FLAGS_NO_SORTABLE|#MYTABLE_COL_FLAGS_EDITABLE)
	
	*tree\SetFixedCols(1)
	#Rows=10
	
	Define i,g,h,j
	For i=1 To #Rows
		*stamm=*tree\AddRow("Stamm "+i+"|Inhalt "+i+"|Sub Inhalt "+i+#CRLF$+"Sub Sub","|",images(0))
		*stamm\SetExpanded(Random(1,0))
		*stamm\SetChecked(Random(1,0))
		For g=1 To Random(#rows)
			*ast=*stamm\AddRow("Ast "+g+"|Inhalt "+g+"|Sub Inhalt "+g,"|",images(1))
			*ast\SetExpanded(Random(1,0))
			*ast\SetChecked(Random(1,0))
			For h=1 To Random(#rows)
				*zweig=*ast\AddRow("Zweig "+h+"|Inhalt "+h+"|Sub Inhalt "+h,"|",images(2))
				*zweig\SetExpanded(Random(1,0))
				*zweig\SetChecked(Random(1,0))
				For j=1 To Random(#rows)
					*blatt=*zweig\AddRow("Blatt "+j+"|Inhalt "+j+"|Sub Inhalt "+j+#CRLF$+"Sub Sub"+#CRLF$+"Sub Sub","|",images(3))
					*blatt\SetChecked(Random(1,0))
				Next
			Next
		Next
	Next
	
	*tree\AutosizeRows()
	*tree\SetRedraw(#True)
	
	Procedure RC(*row.MyTableRow)
		Debug "RowCheck "+*row\GetPosition()
	EndProcedure
	Procedure RU(*row.MyTableRow)
		Debug "RowUnCheck "+*row\GetPosition()
	EndProcedure
	Procedure RS(*row.MyTableRow)
		Debug "RowSelect "+*row\GetPosition()
	EndProcedure
	Procedure CS(*cell.MyTableCell)
		Protected *row.MyTableRow=*cell\getRow()
		Protected *col.MyTableCol=*cell\getCol()
		Debug "CellSelect "+*row\GetPosition()+" / "+*col\GetPosition()
	EndProcedure
	Procedure RE(*row.MyTableRow)
		Debug "RowExpand "+*row\GetPosition()
	EndProcedure
	Procedure RCo(*row.MyTableRow)
		Debug "RowCollpased "+*row\GetPosition()
	EndProcedure
	Procedure RCt(*cell.MyTableCell,old.s)
		Protected *row.MyTableRow=*cell\getRow()
		Protected *col.MyTableCol=*cell\getCol()
		Debug "ChangeText "+*row\GetPosition()+" / "+*col\GetPosition()+"  ("+old+"->"+*cell\GetText()+")"
	EndProcedure
	
	*tree\BindEventCellSelected(@CS())
	*tree\BindEventCellChangedText(@RCt())
	*tree\BindEventRowChangedChecked(@RC())
	*tree\BindEventRowChangedUnChecked(@RU())
	*tree\BindEventRowChangedExpanded(@RE())
	*tree\BindEventRowChangedCollapsed(@RCo())
	*tree\BindEventRowSelected(@RS())
	
	Procedure Resize()
		ResizeGadget(canvas,
		             #PB_Ignore,
		             #PB_Ignore,
		             WindowWidth(window),
		             WindowHeight(window))
	EndProcedure
	
	BindEvent(#PB_Event_SizeWindow,@Resize(),window)
	BindEvent(#PB_Event_RestoreWindow,@Resize(),window)
	BindEvent(#PB_Event_MaximizeWindow,@Resize(),window)
	BindEvent(#PB_Event_MinimizeWindow,@Resize(),window)
	
	Repeat:Until WaitWindowEvent()=#PB_Event_CloseWindow
	
	*tree\Free()
	
	
UnuseModule MyTable