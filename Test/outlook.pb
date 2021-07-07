EnableExplicit

XIncludeFile "declare.pb"

UseModule MyTable
	UseModule MyFont
		UseModule MySplitter
			
			Global treeTitel=MyFontCreateFont("Arial",12)
			Global normal=MyFontCreateFont("Arial",10)
			Global mail=MyFontCreateFont("Arial",9)
			Global cursiv=MyFontCreateFont("Arial",10,#PB_Font_Italic)
			
			Global window=OpenWindow(#PB_Any,0,0,1000,800,"Outlook (lookalike)",#PB_Window_SystemMenu|#PB_Window_ScreenCentered|#PB_Window_SizeGadget|#PB_Window_MaximizeGadget|#PB_Window_MinimizeGadget)
			SmartWindowRefresh(window,#True)
			
			Global favoriten=CanvasGadget(#PB_Any,0,0,0,0,#PB_Canvas_Container|#PB_Canvas_Keyboard)
			Global hscrollfavoriten=ScrollBarGadget(#PB_Any,0,0,0,20,0,0,0)
			Global vscrollfavoriten=ScrollBarGadget(#PB_Any,0,0,20,0,0,0,0,#PB_ScrollBar_Vertical)
			CloseGadgetList()
			
			Global ordner=CanvasGadget(#PB_Any,0,0,0,0,#PB_Canvas_Container|#PB_Canvas_Keyboard)
			Global hscrollordner=ScrollBarGadget(#PB_Any,0,0,0,20,0,0,0)
			Global vscrollordner=ScrollBarGadget(#PB_Any,0,0,20,0,0,0,0,#PB_ScrollBar_Vertical)
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
			
			Global *splitterF.MySplitter=MySplitterCreateSplitter(0,0,0,0,favoriten,ordner,#MYSPLITTER_FLAGS_NO_SIZEABLE|#MYSPLITTER_FLAGS_FIRSTFIXED)
			
			
			Global *splittera.MySplitter=MySplitterCreateSplitter(0,0,0,0,kontakte,aufgaben)
			Global *splitterb.MySplitter=MySplitterCreateSplitter(0,0,0,0,container2,*splittera,#MYSPLITTER_FLAGS_FIRSTFIXED)
			
			Global *splitter2.MySplitter=MySplitterCreateSplitter(0,0,0,0,mails,web,#MYSPLITTER_FLAGS_VERTICAL|#MYSPLITTER_FLAGS_FIRSTFIXED)
			Global *splitter1.MySplitter=MySplitterCreateSplitter(0,0,WindowWidth(window),WindowHeight(window),*splitterF,*splitter2,#MYSPLITTER_FLAGS_VERTICAL|#MYSPLITTER_FLAGS_FIRSTFIXED)
			Global *splitter0.MySplitter=MySplitterCreateSplitter(0,0,WindowWidth(window),WindowHeight(window),*splitter1,*splitterb,#MYSPLITTER_FLAGS_VERTICAL|#MYSPLITTER_FLAGS_SECONDFIXED)
			
			
			
			
			
			Define *cell.MyTableCell=0,*cell2.MyTableCell=0,*cell3.MyTableCell=0
			
			
			Define *colstyle.MyTableStyle=0
			Define *cellstyle.MyTableStyle=0
			Global *favoriten.MyTableTable=MyTableCreateTree(window,favoriten,vscrollfavoriten,hscrollfavoriten,#MYTABLE_TABLE_FLAGS_NO_HEADER|#MYTABLE_TABLE_FLAGS_NO_REDRAW|#MYTABLE_TABLE_FLAGS_FULLROWSELECT)
			Global *ordner.MyTableTable=MyTableCreateTree(window,ordner,vscrollordner,hscrollordner,#MYTABLE_TABLE_FLAGS_NO_HEADER|#MYTABLE_TABLE_FLAGS_NO_REDRAW|#MYTABLE_TABLE_FLAGS_FULLROWSELECT)
			Global *mails.MyTableTable=MyTableCreateTree(window,mails,vscrollmails,hscrollmails,#MYTABLE_TABLE_FLAGS_NO_HEADER|#MYTABLE_TABLE_FLAGS_NO_REDRAW|#MYTABLE_TABLE_FLAGS_FULLROWSELECT|#MYTABLE_TABLE_FLAGS_BORDER)
			Global *termine.MyTableTable=MyTableCreateTree(window,termine,vscrolltermine,hscrolltermine,#MYTABLE_TABLE_FLAGS_NO_HEADER|#MYTABLE_TABLE_FLAGS_NO_REDRAW|#MYTABLE_TABLE_FLAGS_FULLROWSELECT)
			Global *kontakte.MyTableTable=MyTableCreateTree(window,kontakte,vscrollkontakte,hscrollkontakte,#MYTABLE_TABLE_FLAGS_NO_HEADER|#MYTABLE_TABLE_FLAGS_NO_REDRAW|#MYTABLE_TABLE_FLAGS_FULLROWSELECT)
			Global *aufgaben.MyTableTable=MyTableCreateTree(window,aufgaben,vscrollaufgaben,hscrollaufgaben,#MYTABLE_TABLE_FLAGS_NO_HEADER|#MYTABLE_TABLE_FLAGS_NO_REDRAW|#MYTABLE_TABLE_FLAGS_FULLROWSELECT)
			
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
				*splitter0\Resize(0,
				                  0,
				                  WindowWidth(window),
				                  WindowHeight(window))
				
				*splitterF\SetValue(fh)
				
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
			BindGadgetEvent(container2,@Resize(),#PB_EventType_Resize)
			
			PostEvent(#PB_Event_SizeWindow,window,0)
			
			*splitter0\SetValue(800)
			*splitter1\SetValue(200)
			*splitter2\SetValue(300)
			*splitterb\SetValue(400)
			*splittera\SetValue(200)
			
			Repeat:Until WaitWindowEvent()=#PB_Event_CloseWindow
			
		UnuseModule MySplitter
	UnuseModule MyFont
UnuseModule MyTable
