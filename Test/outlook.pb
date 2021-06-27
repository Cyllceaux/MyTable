EnableExplicit

XIncludeFile "declare.pb"

UseModule MyTable
	
	Global treeTitel=MyTableCreateFont("Arial",12)
	Global normal=MyTableCreateFont("Arial",10)
	Global mail=MyTableCreateFont("Arial",9)
	Global cursiv=MyTableCreateFont("Arial",10,#PB_Font_Italic)
	
	Global window=OpenWindow(#PB_Any,0,0,1000,800,"Outlook (lookalike)",#PB_Window_SystemMenu|#PB_Window_ScreenCentered|#PB_Window_SizeGadget|#PB_Window_MaximizeGadget|#PB_Window_MinimizeGadget)
	SmartWindowRefresh(window,#True)
	
	Global container=ContainerGadget(#PB_Any,0,0,0,0)
	Global favoriten=CanvasGadget(#PB_Any,0,0,0,0,#PB_Canvas_Container|#PB_Canvas_Keyboard)
	Global hscrollfavoriten=ScrollBarGadget(#PB_Any,0,0,0,20,0,0,0)
	Global vscrollfavoriten=ScrollBarGadget(#PB_Any,0,0,20,0,0,0,0,#PB_ScrollBar_Vertical)
	CloseGadgetList()
	
	Global trenn=CanvasGadget(#PB_Any,0,0,0,2)
	
	Global ordner=CanvasGadget(#PB_Any,0,0,0,0,#PB_Canvas_Container|#PB_Canvas_Keyboard)
	Global hscrollordner=ScrollBarGadget(#PB_Any,0,0,0,20,0,0,0)
	Global vscrollordner=ScrollBarGadget(#PB_Any,0,0,20,0,0,0,0,#PB_ScrollBar_Vertical)
	CloseGadgetList()
	CloseGadgetList()
	
	Global mails=CanvasGadget(#PB_Any,0,0,0,0,#PB_Canvas_Container|#PB_Canvas_Keyboard)
	Global hscrollmails=ScrollBarGadget(#PB_Any,0,0,0,20,0,0,0)
	Global vscrollmails=ScrollBarGadget(#PB_Any,0,0,20,0,0,0,0,#PB_ScrollBar_Vertical)
	CloseGadgetList()
	
	
	Global web=EditorGadget(#PB_Any,0,0,0,0,#PB_Editor_ReadOnly)
	SetGadgetText(web,"Hier könnte Ihre Werbung stehen")
	
	Global container2=ContainerGadget(#PB_Any,0,0,0,0)
	Global calendar=CalendarGadget(#PB_Any,0,0,0,0)
	Global termine=CanvasGadget(#PB_Any,0,0,0,0,#PB_Canvas_Container|#PB_Canvas_Keyboard)
	Global hscrolltermine=ScrollBarGadget(#PB_Any,0,0,0,20,0,0,0)
	Global vscrolltermine=ScrollBarGadget(#PB_Any,0,0,20,0,0,0,0,#PB_ScrollBar_Vertical)
	CloseGadgetList()
	CloseGadgetList()
	
	Global kontakte=CanvasGadget(#PB_Any,0,0,0,0,#PB_Canvas_Container|#PB_Canvas_Keyboard)
	Global hscrollkontakte=ScrollBarGadget(#PB_Any,0,0,0,20,0,0,0)
	Global vscrollkontakte=ScrollBarGadget(#PB_Any,0,0,20,0,0,0,0,#PB_ScrollBar_Vertical)
	CloseGadgetList()
	
	Global aufgaben=CanvasGadget(#PB_Any,0,0,0,0,#PB_Canvas_Container|#PB_Canvas_Keyboard)
	Global hscrollaufgaben=ScrollBarGadget(#PB_Any,0,0,0,20,0,0,0)
	Global vscrollaufgaben=ScrollBarGadget(#PB_Any,0,0,20,0,0,0,0,#PB_ScrollBar_Vertical)
	CloseGadgetList()
	
	Global splittera=SplitterGadget(#PB_Any,0,0,0,0,kontakte,aufgaben,#PB_Splitter_Separator|#PB_Splitter_Separator)
	Global splitterb=SplitterGadget(#PB_Any,0,0,0,0,container2,splittera,#PB_Splitter_Separator|#PB_Splitter_FirstFixed|#PB_Splitter_Separator)
	
	Global splitter2=SplitterGadget(#PB_Any,0,0,0,0,mails,web,#PB_Splitter_Vertical|#PB_Splitter_Separator|#PB_Splitter_FirstFixed)
	Global splitter1=SplitterGadget(#PB_Any,0,0,WindowWidth(window),WindowHeight(window),container,splitter2,#PB_Splitter_Vertical|#PB_Splitter_Separator|#PB_Splitter_FirstFixed)
	Global splitter0=SplitterGadget(#PB_Any,0,0,WindowWidth(window),WindowHeight(window),splitter1,splitterb,#PB_Splitter_Vertical|#PB_Splitter_Separator|#PB_Splitter_SecondFixed)
	
	
	SetGadgetState(splitter0,800)
	SetGadgetState(splitter1,200)
	SetGadgetState(splitter2,300)
	SetGadgetState(splitterb,400)
	
	
	Define *cell.MyTableCell=0,*cell2.MyTableCell=0,*cell3.MyTableCell=0
	Global *app.MyTableApplication=MyTableCreateApplication()
	Define *appstyle.MyTableStyle=*app\GetDefaultStyle()
	Define *colstyle.MyTableStyle=0
	Define *cellstyle.MyTableStyle=0
	*appstyle\SetFont(normal)
	Global *favoriten.MyTableTable=*app\AddTree(window,favoriten,vscrollfavoriten,hscrollfavoriten,"favoriten",#MYTABLE_TABLE_FLAGS_NO_HEADER|#MYTABLE_TABLE_FLAGS_NO_REDRAW|#MYTABLE_TABLE_FLAGS_FULLROWSELECT)
	Global *ordner.MyTableTable=*app\AddTree(window,ordner,vscrollordner,hscrollordner,"ordner",#MYTABLE_TABLE_FLAGS_NO_HEADER|#MYTABLE_TABLE_FLAGS_NO_REDRAW|#MYTABLE_TABLE_FLAGS_FULLROWSELECT)
	Global *mails.MyTableTable=*app\AddTree(window,mails,vscrollmails,hscrollmails,"mails",#MYTABLE_TABLE_FLAGS_NO_HEADER|#MYTABLE_TABLE_FLAGS_NO_REDRAW|#MYTABLE_TABLE_FLAGS_FULLROWSELECT|#MYTABLE_TABLE_FLAGS_BORDER)
	Global *termine.MyTableTable=*app\AddTree(window,termine,vscrolltermine,hscrolltermine,"termine",#MYTABLE_TABLE_FLAGS_NO_HEADER|#MYTABLE_TABLE_FLAGS_NO_REDRAW|#MYTABLE_TABLE_FLAGS_FULLROWSELECT)
	Global *kontakte.MyTableTable=*app\AddTree(window,kontakte,vscrollkontakte,hscrollkontakte,"kontakte",#MYTABLE_TABLE_FLAGS_NO_HEADER|#MYTABLE_TABLE_FLAGS_NO_REDRAW|#MYTABLE_TABLE_FLAGS_FULLROWSELECT)
	Global *aufgaben.MyTableTable=*app\AddTree(window,aufgaben,vscrollaufgaben,hscrollaufgaben,"aufgaben",#MYTABLE_TABLE_FLAGS_NO_HEADER|#MYTABLE_TABLE_FLAGS_NO_REDRAW|#MYTABLE_TABLE_FLAGS_FULLROWSELECT)
	
	*favoriten\SetDefaultImagePlusArrow(MyTableDefaultImagePlusArrow)
	*favoriten\SetDefaultImageMinusArrow(MyTableDefaultImageMinusArrow)
	*ordner\SetDefaultImagePlusArrow(MyTableDefaultImagePlusArrow)
	*ordner\SetDefaultImageMinusArrow(MyTableDefaultImageMinusArrow)
	*mails\SetDefaultImagePlusArrow(MyTableDefaultImagePlusArrow)
	*mails\SetDefaultImageMinusArrow(MyTableDefaultImageMinusArrow)
	*termine\SetDefaultImagePlusArrow(MyTableDefaultImagePlusArrow)
	*termine\SetDefaultImageMinusArrow(MyTableDefaultImageMinusArrow)
	*kontakte\SetDefaultImagePlusArrow(MyTableDefaultImagePlusArrow)
	*kontakte\SetDefaultImageMinusArrow(MyTableDefaultImageMinusArrow)
	*aufgaben\SetDefaultImagePlusArrow(MyTableDefaultImagePlusArrow)
	*aufgaben\SetDefaultImageMinusArrow(MyTableDefaultImageMinusArrow)
	
	*mails\SetEmptyText("Es wurden keine Elemente gefunden, die den Suchkriterien entsprechen")
	*kontakte\SetEmptyText("Klicken sie an eine beliebige Stelle in Office mit der rechten Maustaste auf eine Person, um diese ihren Favoriten hinzuzufügen")
	*termine\SetEmptyText("An diesen 7 Tagen ist nichts für sie geplant")
	
	Define *tablestyle.MyTableStyle=*favoriten\GetDefaultStyle()
	*tablestyle\SetBackColor(#Gray)
	*tablestyle\SetFrontColor(#Gray)
	*tablestyle\SetForeColor(#White)
	
	*tablestyle=*ordner\GetDefaultStyle()
	*tablestyle\SetBackColor(#Gray)
	*tablestyle\SetFrontColor(#Gray)
	*tablestyle\SetForeColor(#White)
	
	*tablestyle=*mails\GetDefaultStyle()
	*tablestyle\SetBackColor(#Gray)
	*tablestyle\SetFrontColor(#Gray)
	*tablestyle\SetForeColor(#White)
	Define *border.MyTableBorder=*tablestyle\getBorderDefault()
	*border\SetColor(#White)
	*border\SetWidth(1)

	
	Define *col.MyTableCol=*favoriten\AddCol("",#PB_Ignore)
	*col=*favoriten\AddCol("999",50)
	*colstyle=*col\GetDefaultStyle()
	*colstyle\SetHAlign(#MYTABLE_STYLE_HALIGN_RIGHT)
	*col=*ordner\AddCol("",#PB_Ignore)
	*col=*ordner\AddCol("999",50)
	*colstyle=*col\GetDefaultStyle()
	*colstyle\SetHAlign(#MYTABLE_STYLE_HALIGN_RIGHT)
	*col=*mails\AddCol("",#PB_Ignore)
	*col=*mails\AddCol("##:##",50)
	*colstyle=*col\GetDefaultStyle()
	*colstyle\SetHAlign(#MYTABLE_STYLE_HALIGN_RIGHT)
	*col=*mails\AddCol(" ",20)
	
	*col=*kontakte\AddCol(" ",#PB_Ignore)
	*col=*aufgaben\AddCol(" ",#PB_Ignore)
	*col=*aufgaben\AddCol(" ",20)
	*col=*termine\AddCol("##:##",20)
	*col=*termine\AddCol("##:##",20)
	*col=*termine\AddCol("##:##",#PB_Ignore)
	
	
	Define sum=0
	Define rand=0
	Define idx=1
	Define *row.MyTableRow=*favoriten\AddRow("Favoriten")
	Define *rowStyle.MyTableStyle=*row\GetDefaultStyle()
	*rowStyle\SetFont(treeTitel)
	*row\SetExpanded(#True)
	rand=Random(50,1):sum+rand
	*row\AddRow("Posteingang|"+rand)
	*row\AddRow("Gesendete Elemente")
	*row\AddRow("Gelöschte Elemente")
	*row\AddRow("Entwürfe|1")
	
	*row=*ordner\AddRow("Postfach 1")
	*rowStyle=*row\GetDefaultStyle()
	*rowStyle\SetFont(treeTitel)
	*row\SetExpanded(#True)
	*row\AddRow("Posteingang|"+rand)
	*row\AddRow("Gesendete Elemente")
	*row\AddRow("Gelöschte Elemente")
	*row\AddRow("Entwürfe|1")
	Define *sub.MyTableRow=*row\AddRow("Daten")
	*sub\SetExpanded(#True)
	Define *ssub.MyTableRow=*sub\AddRow("Telefon")
	*ssub\AddRow("Festnetz")
	*ssub\AddRow("Mobil")
	*sub\AddRow("Arbeit")
	*sub\AddRow("Privat")
	*row\AddRow("Privat")
	*sub=*row\AddRow("Familie")
	*sub\SetExpanded(#True)
	rand=Random(1000,1):sum+rand	
	*sub\AddRow("Mama|"+rand)
	*sub\AddRow("Vater")
	*ssub=*sub\AddRow("Bruder 1")
	rand=Random(10,1):sum+rand	
	*ssub\AddRow("Memes|"+rand)
	*sub\AddRow("Bruder 2")
	*sub\AddRow("Schwester")
	rand=Random(1000,1):sum+rand	
	*sub\AddRow("Katze|"+rand)
	*ssub=*sub\AddRow("Freundin")
	*ssub\SetExpanded(#True)
	*ssub\AddRow("Liebesbriefe")
	*ssub\AddRow("Langweiliger Kram")
	*sub=*row\AddRow("Suchordner")
	*sub\SetExpanded(#True)
	*ssub=*sub\AddRow("Heute")
	*rowStyle=*ssub\GetDefaultStyle()
	*rowStyle\SetFont(cursiv)
	*sub\AddRow("Mit Anhang")
	*sub\AddRow("Ungelesen oder zur Nachverfolgung|"+sum)
	*sub\AddRow("Wichtige Nachrichten")
	*sub\AddRow("zur Nachverfolgung")
	
	*row=*ordner\AddRow("Postfach 2")
	*rowStyle=*row\GetDefaultStyle()
	*rowStyle\SetFont(treeTitel)
	*row\AddRow("Posteingang")
	*row\AddRow("Gesendete Elemente")
	*row\AddRow("Gelöschte Elemente")
	*row\AddRow("Entwürfe")
	
	*row=*aufgaben\AddRow("Kein Datum","|",images(1))
	*row\SetExpanded(#True)
	*rowStyle=*row\GetDefaultStyle()
	*rowStyle\SetBackColor(RGBA(50,50,50,255))
	*rowStyle\SetForeColor(#White)
	*sub=*row\AddRow("Aufgabe 1")
	*cell=*sub\GetCell(1)
	*cell\SetImageRight(images(1))
	
	*row=*aufgaben\AddRow("Heute","|",images(1))
	*row\SetExpanded(#True)
	*rowStyle=*row\GetDefaultStyle()
	*rowStyle\SetBackColor(RGBA(50,50,50,255))
	*rowStyle\SetForeColor(#White)
	*sub=*row\AddRow("Aufgabe A")
	*cell=*sub\GetCell(1)
	*cell\SetImageRight(images(1))
	*sub=*row\AddRow("Aufgabe B")
	*cell=*sub\GetCell(1)
	*cell\SetImageRight(images(1))
	*sub=*row\AddRow("Aufgabe C")
	*cell=*sub\GetCell(1)
	*cell\SetImageRight(images(1))
	*sub=*row\AddRow("Aufgabe D")
	*cell=*sub\GetCell(1)
	*cell\SetImageRight(images(1))
	*sub=*row\AddRow("Aufgabe E")
	*cell=*sub\GetCell(1)
	*cell\SetImageRight(images(1))
	
	
	*row=*mails\AddRow("Heute")
	*rowStyle=*row\GetDefaultStyle()
	*rowStyle\SetBorder(#MYTABLE_STYLE_BORDER_TOP|#MYTABLE_STYLE_BORDER_BOTTOM)
	*rowStyle\SetBackColor(RGBA(50,50,50,255))
	*rowStyle\SetForeColor(#White)
	*row\SetExpanded(#True)
	For idx=1 To Random(10,1)
		*sub=*row\AddRow("Absender "+idx)
		*cell=*sub\GetCell(0)
		*cellstyle=*cell\GetDefaultStyle()
		*cellstyle\SetFont(treeTitel)
		If Random(1)
			*cell=*sub\GetCell(1)	
			*cell\SetImageRight(images(3))
			*cell=*sub\GetCell(0)	
		EndIf
		*cell2=*cell\AddCell("Betreff "+idx)
		*cell3=*cell\AddCell("Inhalt "+idx)
		*cell=*sub\GetCell(1)
		*cell2=*cell\AddCell(FormatDate("%hh:%ii",Random(100000)))
		*rowStyle=*sub\GetDefaultStyle()
		*rowStyle\SetBackColor(RGBA(240,240,240,255))
		*rowStyle\SetForeColor(RGBA(20,20,20,255))
		*rowStyle\SetFont(mail)
		*rowStyle\SetBorder(#MYTABLE_STYLE_BORDER_TOP|#MYTABLE_STYLE_BORDER_BOTTOM)
	Next
	*row=*mails\AddRow("Gestern")
	*rowStyle=*row\GetDefaultStyle()
	*rowStyle\SetBorder(#MYTABLE_STYLE_BORDER_TOP|#MYTABLE_STYLE_BORDER_BOTTOM)
	*rowStyle\SetBackColor(RGBA(50,50,50,255))
	*rowStyle\SetForeColor(#White)
	*row\SetExpanded(#True)
	For idx=1 To Random(10,1)
		*sub=*row\AddRow("Absender "+idx)
		*cell=*sub\GetCell(0)
		*cellstyle=*cell\GetDefaultStyle()
		*cellstyle\SetFont(treeTitel)		
		If Random(1)
			*cell=*sub\GetCell(1)	
			*cell\SetImageRight(images(3))
			*cell=*sub\GetCell(0)	
		EndIf
		*cell2=*cell\AddCell("Betreff "+idx)
		*cell3=*cell\AddCell("Inhalt "+idx)
		*cell=*sub\GetCell(1)
		*cell2=*cell\AddCell(FormatDate("%hh:%ii",Random(100000)))
		*rowStyle=*sub\GetDefaultStyle()
		*rowStyle\SetBackColor(RGBA(240,240,240,255))
		*rowStyle\SetForeColor(RGBA(20,20,20,255))
		*rowStyle\SetFont(mail)
		*rowStyle\SetBorder(#MYTABLE_STYLE_BORDER_TOP|#MYTABLE_STYLE_BORDER_BOTTOM)
	Next
	*row=*mails\AddRow("Letzte Woche")
	*rowStyle=*row\GetDefaultStyle()
	*rowStyle\SetBorder(#MYTABLE_STYLE_BORDER_TOP|#MYTABLE_STYLE_BORDER_BOTTOM)
	*rowStyle\SetBackColor(RGBA(50,50,50,255))
	*rowStyle\SetForeColor(#White)	
	*row\SetExpanded(#True)
	For idx=1 To Random(10,1)
		*sub=*row\AddRow("Absender "+idx)
		*cell=*sub\GetCell(0)
		*cellstyle=*cell\GetDefaultStyle()
		*cellstyle\SetFont(treeTitel)
		If Random(1)
			*cell=*sub\GetCell(1)	
			*cell\SetImageRight(images(3))
			*cell=*sub\GetCell(0)	
		EndIf
		*cell2=*cell\AddCell("Betreff "+idx)
		*cell3=*cell\AddCell("Inhalt "+idx)
		*cell=*sub\GetCell(1)
		*cell2=*cell\AddCell(FormatDate("%hh:%ii",Random(100000)))
		*rowStyle=*sub\GetDefaultStyle()
		*rowStyle\SetBackColor(RGBA(240,240,240,255))
		*rowStyle\SetForeColor(RGBA(20,20,20,255))
		*rowStyle\SetFont(mail)
		*rowStyle\SetBorder(#MYTABLE_STYLE_BORDER_TOP|#MYTABLE_STYLE_BORDER_BOTTOM)
	Next
	*row=*mails\AddRow("Vorletzte Woche")
	*rowStyle=*row\GetDefaultStyle()
	*rowStyle\SetBorder(#MYTABLE_STYLE_BORDER_TOP|#MYTABLE_STYLE_BORDER_BOTTOM)
	*rowStyle\SetBackColor(RGBA(50,50,50,255))
	*rowStyle\SetForeColor(#White)
	*row\SetExpanded(#True)
	For idx=1 To Random(10,1)
		*sub=*row\AddRow("Absender "+idx)
		*cell=*sub\GetCell(0)
		*cellstyle=*cell\GetDefaultStyle()
		*cellstyle\SetFont(treeTitel)
		If Random(1)
			*cell=*sub\GetCell(1)	
			*cell\SetImageRight(images(3))
			*cell=*sub\GetCell(0)	
		EndIf
		*cell2=*cell\AddCell("Betreff "+idx)
		*cell3=*cell\AddCell("Inhalt "+idx)
		*cell=*sub\GetCell(1)
		*cell2=*cell\AddCell(FormatDate("%hh:%ii",Random(100000)))
		*rowStyle=*sub\GetDefaultStyle()
		*rowStyle\SetBackColor(RGBA(240,240,240,255))
		*rowStyle\SetForeColor(RGBA(20,20,20,255))
		*rowStyle\SetFont(mail)
		*rowStyle\SetBorder(#MYTABLE_STYLE_BORDER_TOP|#MYTABLE_STYLE_BORDER_BOTTOM)
	Next
	*row=*mails\AddRow("Vorvorletzte Woche")
	*rowStyle=*row\GetDefaultStyle()
	*rowStyle\SetBorder(#MYTABLE_STYLE_BORDER_TOP|#MYTABLE_STYLE_BORDER_BOTTOM)
	*rowStyle\SetBackColor(RGBA(50,50,50,255))
	*rowStyle\SetForeColor(#White)
	*row\SetExpanded(#True)
	For idx=1 To Random(10,1)
		*sub=*row\AddRow("Absender "+idx)
		*cell=*sub\GetCell(0)
		*cellstyle=*cell\GetDefaultStyle()
		*cellstyle\SetFont(treeTitel)
		If Random(1)
			*cell=*sub\GetCell(1)	
			*cell\SetImageRight(images(3))
			*cell=*sub\GetCell(0)	
		EndIf
		*cell2=*cell\AddCell("Betreff "+idx)
		*cell3=*cell\AddCell("Inhalt "+idx)
		*cell=*sub\GetCell(1)
		*cell2=*cell\AddCell(FormatDate("%hh:%ii",Random(100000)))
		*rowStyle=*sub\GetDefaultStyle()
		*rowStyle\SetBackColor(RGBA(240,240,240,255))
		*rowStyle\SetForeColor(RGBA(20,20,20,255))
		*rowStyle\SetFont(mail)
		*rowStyle\SetBorder(#MYTABLE_STYLE_BORDER_TOP|#MYTABLE_STYLE_BORDER_BOTTOM)
	Next
	*mails\AutosizeRows()
	
	*favoriten\SetRedraw(#True)
	*ordner\SetRedraw(#True)
	*mails\SetRedraw(#True)
	*aufgaben\SetRedraw(#True)
	*termine\SetRedraw(#True)
	*kontakte\SetRedraw(#True)
	
	
	
	Procedure Resize()
		Protected fh=*favoriten\GetCalcHeight()
		*app\SetRedraw(#False)
		ResizeGadget(splitter0,
		             0,
		             0,
		             WindowWidth(window),
		             WindowHeight(window))
		
		ResizeGadget(ordner,
		             0,
		             fh+2,
		             GadgetWidth(container),
		             GadgetHeight(container)-fh-2)
		
		
		ResizeGadget(trenn,
		             0,
		             fh,
		             GadgetWidth(container),
		             #PB_Ignore)
		
		StartDrawing(CanvasOutput(trenn))
		Box(0,0,GadgetWidth(container),2,RGBA(50,50,50,255))
		StopDrawing()
		
		ResizeGadget(favoriten,
		             0,
		             0,
		             GadgetWidth(container),
		             fh)
		
		ResizeGadget(calendar,
		             0,
		             0,
		             GadgetWidth(container2),
		             200)
		
		ResizeGadget(termine,
		             0,
		             200,
		             GadgetWidth(container2),
		             GadgetHeight(container2)-200)
		
		*favoriten\AutosizeCols()
		*ordner\AutosizeCols()
		*mails\AutosizeCols()
		*aufgaben\AutosizeCols()
		*kontakte\AutosizeCols()
		*termine\AutosizeCols()
		*app\SetRedraw(#True)
	EndProcedure
	
	Procedure favExp(*row.MyTableRow)
		Resize()
	EndProcedure
	
	*favoriten\BindEventRowChangedExpanded(@favExp())
	*favoriten\BindEventRowChangedCollapsed(@favExp())
	
	
	BindEvent(#PB_Event_SizeWindow,@Resize(),window)
	BindEvent(#PB_Event_RestoreWindow,@Resize(),window)
	BindEvent(#PB_Event_MaximizeWindow,@Resize(),window)
	BindEvent(#PB_Event_MinimizeWindow,@Resize(),window)
	BindGadgetEvent(container,@Resize(),#PB_EventType_Resize)
	BindGadgetEvent(container2,@Resize(),#PB_EventType_Resize)
	
	PostEvent(#PB_Event_SizeWindow,window,0)
	
	
	Repeat:Until WaitWindowEvent()=#PB_Event_CloseWindow
	
	*app\Free()
	
UnuseModule MyTable