﻿Procedure _MyTable_Style_GetObject(*this.strMyTableStyleObject)
	If *this
		ProcedureReturn *this\obj
	EndIf
EndProcedure

Procedure _MyTable_Style_GetType(*this.strMyTableStyleObject)
	If *this
		ProcedureReturn *this\type
	EndIf
EndProcedure



_MyTableStyleBorder(Default);}
_MyTableStyleBorder(Top)
_MyTableStyleBorder(Left)
_MyTableStyleBorder(Right)
_MyTableStyleBorder(Bottom)


Procedure _MyTable_Style_Redraw(*this.strMyTableStyleObject)
	Select *this\obj\type
		Case My::#MY_TYPE_TABLE,My::#MY_TYPE_GRID,My::#MY_TYPE_TREE
			Protected *table.strMyTableTable=*this\obj
			*table\dirty=#True
			_MyTable_Table_Predraw(*table)
			_MyTable_Table_Redraw(*table)
		Case My::#MY_TYPE_ROW
			Protected *row.strMyTableRow=*this\obj
			*row\dirty=#True
			*row\main\dirty=#True
			_MyTable_Table_Predraw(*row\main)
			_MyTable_Table_Redraw(*row\main)
		Case My::#MY_TYPE_COL
			Protected *col.strMyTableCol=*this\obj
			*col\dirty=#True
			*col\main\dirty=#True
			_MyTable_Table_Predraw(*col\main)
			_MyTable_Table_Redraw(*col\main)
		Case My::#MY_TYPE_CELL
			Protected *cell.strMyTableCell=*this\obj
			*cell\dirty=#True
			*cell\main\dirty=#True
			_MyTable_Table_Predraw(*cell\main)
			_MyTable_Table_Redraw(*cell\main)
	EndSelect
EndProcedure


Procedure _MyTable_Style_Free(*this.strMyTableStyleObject)
	If *this
		FreeStructure(*this)
	EndIf
EndProcedure

Procedure _MyTable_Style_Delete(*this.strMyTableStyleObject)
	If *this
		*this\style\backcolor=0
		*this\style\border\border=0
		*this\style\border\borderDefault\color=0
		*this\style\border\borderDefault\width=0
		*this\style\border\borderTop\color=0
		*this\style\border\borderTop\width=0
		*this\style\border\borderLeft\color=0
		*this\style\border\borderLeft\width=0
		*this\style\border\borderRight\color=0
		*this\style\border\borderRight\width=0
		*this\style\border\borderBottom\color=0
		*this\style\border\borderBottom\width=0
		*this\style\font=0
		*this\style\forecolor=0
		*this\style\frontcolor=0
		*this\style\halign=0
		*this\style\valign=0
		_MyTable_Style_Redraw(*this)
	EndIf
EndProcedure



_MyTable_Style_GetterSetterPointer(Font,MyFont::MyFont)
_MyTable_Style_GetterSetter(HAlign,i)
_MyTable_Style_GetterSetter(VAlign,i)
_MyTable_Style_GetterSetter(BackColor,q)
_MyTable_Style_GetterSetter(FrontColor,q)
_MyTable_Style_GetterSetter(ForeColor,q)
_MyTable_Style_GetterSetter(Border,i,border\)
_MyTable_Style_GetterSetterBorders(Color,q)
_MyTable_Style_GetterSetterBorders(Width,i)