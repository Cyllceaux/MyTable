XIncludeFile "mytable.pbi"

DeclareModule MyApplication
	#VERSION=5
	#VERSION_DATE=20210701
	
	Interface MyApplication
		
		
		SetRedraw(value.b):GetRedraw.b()
		SetRecalc(value.b):GetRecalc.b()
		
		AddTable(window.i,canvas.i,vscroll.i,hscroll.i,name.s="",flags.i=#PB_Ignore)			
		AddTree(window.i,canvas.i,vscroll.i,hscroll.i,name.s="",flags.i=#PB_Ignore)			
		AddGrid(window.i,canvas.i,vscroll.i,hscroll.i,rows.i,cols.i,name.s="",flags.i=#PB_Ignore)
		
		AddNewTable(x.i,y.i,w.i,h.i,name.s="",flags.i=#PB_Ignore)			
		AddNewTree(x.i,y.i,w.i,h.i,name.s="",flags.i=#PB_Ignore)			
		AddNewGrid(x.i,y.i,w.i,h.i,rows.i,cols.i,name.s="",flags.i=#PB_Ignore)			
		
		ClearTables()
		Redraw()
		Recalc()
		Free()
		Save.b(file.s); TODO
	EndInterface
	
	Declare MyApplicationCreateApplication(flags.i=0)	
	Declare MyApplicationLoadApplication(file.s); TODO
	
EndDeclareModule

XIncludeFile "MyApplication/myapplication.pb"