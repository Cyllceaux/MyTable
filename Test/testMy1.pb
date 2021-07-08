EnableExplicit

XIncludeFile "testDeclare.pb"

Define *font1.MyFont::MyFont=MyFont::MyFontCreate("Arial",12)
Define *font2.MyFont::MyFont=MyFont::MyFontCreate("Arial",13)
Define *font3.MyFont::MyFont=MyFont::MyFontCreate("Arial",12)

AssertEquals(*font1,*font3)
AssertNotEquals(*font1,*font2)

Define *img1.MyImage::MyImage=MyImage::MyImageCreate(CreateImage(#PB_Any,32,32,32))
Define *img2.MyImage::MyImage=MyImage::MyImageCreate(CreateImage(#PB_Any,32,32,32))
Define *img3.MyImage::MyImage=MyImage::MyImageCreate(*img1\GetImage())

AssertEquals(*img1,*img3)
AssertEquals(*img1\GetSizedImage(16,16),*img3\GetSizedImage(16,16))
AssertNotEquals(*img1\GetSizedImage(16,16),*img3\GetSizedImage(16,32))
AssertNotEquals(*img1,*img2)