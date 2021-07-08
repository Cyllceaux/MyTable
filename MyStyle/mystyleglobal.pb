IncludeFile "../MyGlobal/myglobalglobal.pb"

Procedure MyStyleCreate()
	Protected *this.strMyStyleStyle=AllocateStructure(strMyStyleStyle)
	With *this
		\vtable=?vtable_mystyle
		\type=my::#MY_TYPE_STYLE
		\frontcolor=RGBA(10,10,10,255)
		\backcolor=RGBA(230,230,230,255)
		\font=MyFont::MyFontCreate("Arial",10,#PB_Font_HighQuality)
	EndWith
	ProcedureReturn *this
EndProcedure

Procedure MyBorderCreate(margin.i=1,padding.i=1,size.i=1,color.q=#Black)
	Protected *this.strMyStyleBorder=AllocateStructure(strMyStyleBorder)
	With *this
		\vtable=?vtable_myborder
		\type=my::#MY_TYPE_BORDER		
		\margin=margin
		\padding=padding
		\size=size
		\color=color
	EndWith
	ProcedureReturn *this
EndProcedure