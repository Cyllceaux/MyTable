
# MyToolbar

## Constants

|Constants|Value|Comment|
| --- | --- | --- |
|<span style="color:#AAAAFF">\#MYTOOLBAR\_VERSION</span>| 3||
|<span style="color:#AAAAFF">\#MYTOOLBAR\_VERSION\_DATE</span>| 20220202||


## Interfaces


### MyToolbarButton
|Name|Return|Parameter|Comment|
| --- | --- | --- | --- |
|GetType||||
|SetText||value.s||
|GetText|s|||
|SetFlags||value.s||
|GetFlags|s|||
|SetImage||<span style="color:#FFFFAA">*value.MyImage</span>||
|||||
|MyImage)||||
|GetImage||||
|SetData||<span style="color:#FFFFAA">*value</span>||
|GetData||||
|Free||||
|Delete||||

### MyToolbar
|Name|Return|Parameter|Comment|
| --- | --- | --- | --- |
|GetType||||
|SetFlags||value.s||
|GetFlags||||
|AddButton||text.s = <span style="color:#AAFFAA">""</span> , <span style="color:#FFFFAA">*image.MyImage</span>||
|||||
|MyImage=0,flags|i=0)|||
|AddSeparator||flags.i = 0||
|SetData||<span style="color:#FFFFAA">*value</span>||
|GetData||||
|SetDirty||value.b||
|GetDirty|b|||
|Free||||


## Declares

|Name|Return|Parameter|Comment|
| --- | --- | --- | --- |
|[MyToolbar](#MyToolbar)CreateToolbar||window.i , canvas.i , flags.i = 0||
|[MyToolbar](#MyToolbar)CreateNewToolbar||x.i , y.i , width.i , height.i , flags.i = 0||


