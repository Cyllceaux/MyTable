XIncludeFile "MyGlobal/global.pb"

DeclareModule My
	
	#VERSION = 236
	#VERSION_DATE = 20210704
		
	Enumeration _my_type
		#MY_TYPE_NONE
		#MY_TYPE_CELL
		#MY_TYPE_ROW
		#MY_TYPE_COL
		#MY_TYPE_TABLE
		#MY_TYPE_TREE
		#MY_TYPE_GRID
		#MY_TYPE_APPLICATION
		#MY_TYPE_STYLE
		#MY_TYPE_FONT
		#MY_TYPE_BORDER
		#MY_TYPE_IMAGE
		#MY_TYPE_SPLITTER
	EndEnumeration
	
EndDeclareModule

Module My:EndModule