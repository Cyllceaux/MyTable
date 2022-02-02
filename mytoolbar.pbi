XIncludeFile "my.pbi"
XIncludeFile "myfont.pbi"
XIncludeFile "myimage.pbi"

DeclareModule MyToolbar
	
	#MYTOOLBAR_VERSION = 3
	#MYTOOLBAR_VERSION_DATE = 20220202
	
	Interface MyToolbarButton
		GetType()
		
		SetText(value.s):GetText.s()
		SetFlags(value.s):GetFlags.s()
		SetImage(*value.MyImage::MyImage):GetImage()
		SetData(*value):GetData()
		Free()
		Delete()
	EndInterface
	
	Interface MyToolbar
		GetType()
		SetFlags(value.s):GetFlags()
		
		AddButton(text.s="",*image.MyImage::MyImage=0,flags.i=0)
		AddSeparator(flags.i=0)
		
		SetData(*value):GetData()
		SetDirty(value.b):GetDirty.b()
		Free()		
	EndInterface
	
	Declare MyToolbarCreateToolbar(window.i,canvas.i,flags.i=0)	
	
	Declare MyToolbarCreateNewToolbar(x.i,y.i,width.i,height.i,flags.i=0)	
	
EndDeclareModule

XIncludeFile "MyToolbar/myToolbar.pb"