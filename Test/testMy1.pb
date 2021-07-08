EnableExplicit

#NO_WINDOW=1

XIncludeFile "testDeclare.pb"


Define *font1.MyFont=MyFontCreate("Arial",12)
Define *font2.MyFont=MyFontCreate("Arial",13)
Define *font3.MyFont=MyFontCreate("Arial",12)

AssertEquals(*font1,*font3)
AssertNotEquals(*font1,*font2)

Define *img1.MyImage=MyImageCreate(CreateImage(#PB_Any,32,32,32))
Define *img2.MyImage=MyImageCreate(CreateImage(#PB_Any,32,32,32))
Define *img3.MyImage=MyImageCreate(*img1\GetImage())

AssertEquals(*img1,*img3)
AssertEquals(*img1\GetSizedImage(16,16),*img3\GetSizedImage(16,16))
AssertNotEquals(*img1\GetSizedImage(16,16),*img3\GetSizedImage(16,32))
AssertNotEquals(*img1,*img2)


XIncludeFile "testUnDeclare.pb"