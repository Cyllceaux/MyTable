Module MyStyle
	EnableExplicit
	
	
	XIncludeFile "mystylemacro.pb"
	XIncludeFile "mystylestructure.pb"
	XIncludeFile "mystyledeclare.pb"
	XIncludeFile "mystyleautodeclare.pb"
	XIncludeFile "mystyleglobal.pb"
	XIncludeFile "mystyleborder.pb"
	XIncludeFile "mystylestyle.pb"
	
	DataSection
		vtable_mystyle:
		_MyDataSectionDefault(MyStyle,Style)
		_MyDataSectionGetterSetter(MyStyle,Style,BackColor)
		_MyDataSectionGetterSetter(MyStyle,Style,FrontColor)
		_MyDataSectionGetterSetter(MyStyle,Style,Font)
		_MyDataSectionGetterSetter(MyStyle,Style,Border)
		_MyDataSectionGetterSetter(MyStyle,Style,VAlign)
		_MyDataSectionGetterSetter(MyStyle,Style,HAlign)
		
		vtable_myborder:
		_MyDataSectionDefault(MyStyle,Border)
		_MyDataSectionGetterSetter(MyStyle,Border,Margin)
		_MyDataSectionGetterSetter(MyStyle,Border,Padding)
		_MyDataSectionGetterSetter(MyStyle,Border,Size)
		_MyDataSectionGetterSetter(MyStyle,Border,Color)
	EndDataSection	
EndModule
