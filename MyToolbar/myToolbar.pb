Module MyToolbar
	EnableExplicit
	
	IncludeFile "mytoolbarstructure.pb"
	IncludeFile "../MyGlobal/myglobalmacro.pb"
	IncludeFile "../MyGlobal/myglobaldeclare.pb"
	IncludeFile "mytoolbardeclare.pb"
	IncludeFile "mytoolbarautodeclare.pb"
	IncludeFile "mytoolbarglobal.pb"
	IncludeFile "mytoolbartoolbar.pb"
	IncludeFile "mytoolbarbutton.pb"
	IncludeFile "../MyGlobal/myglobalglobal.pb"
	
	DataSection
		vtable_toolbar: ;- Toolbar
		_DataSectionGetter(MyToolbar,Toolbar,Type)
		_DataSectionSetterGetter(MyToolbar,Toolbar,Flags)
		
		_DataSectionSetterGetter(MyToolbar,Toolbar,Data)
		_DataSectionSetterGetter(MyToolbar,Toolbar,Dirty)
		_DataSectionMethode(MyToolbar,Toolbar,Free)
		
		vtable_toolbar_button: ;- Toolbar
		_DataSectionGetter(MyToolbar,Button,Type)
		_DataSectionSetterGetter(MyToolbar,Button,Text)
		_DataSectionSetterGetter(MyToolbar,Button,Flags)
		_DataSectionSetterGetter(MyToolbar,Button,Image)
		_DataSectionSetterGetter(MyToolbar,Button,Data)
		_DataSectionMethode(MyToolbar,Button,Free)
		_DataSectionMethode(MyToolbar,Button,Delete)
	EndDataSection
	
EndModule