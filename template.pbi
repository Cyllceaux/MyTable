XIncludeFile "my.pbi"

DeclareModule MyTemplate 
	Interface MyTemplate Extends My::My
		
	EndInterface
	
	Declare MyTemplateCreate()
	
	
EndDeclareModule

XIncludeFile "template/template.pb"