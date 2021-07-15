
# MySplitter

## Constants

|Constants|Value|Comment|
| --- | --- | --- |
|<span style="color:#AAAAFF">\#MYSPLITTER\_VERSION</span>| 158||
|<span style="color:#AAAAFF">\#MYSPLITTER\_VERSION\_DATE</span>| 20210715||


## EnumerationBinarys


### \_mysplitter\_flags
|Name|Value|Comment|
| --- | --- | --- |
|<span style="color:#AAAAFF">\#MYSPLITTER\_FLAGS\_VERTICAL</span>|1||
|<span style="color:#AAAAFF">\#MYSPLITTER\_FLAGS\_FIRSTFIXED</span>|2||
|<span style="color:#AAAAFF">\#MYSPLITTER\_FLAGS\_SECONDFIXED</span>|4||
|<span style="color:#AAAAFF">\#MYSPLITTER\_FLAGS\_NO\_SIZEABLE</span>|8||


## Prototypes

|Name|Return|Parameter|Comment|
| --- | --- | --- | --- |
|[MySplitter](#MySplitter)ProtoEventCustomDraw|b|<span style="color:#FFFFAA">*splitter</span>||


## Interfaces


### MySplitter
|Name|Return|Parameter|Comment|
| --- | --- | --- | --- |
|GetType||||
|SetFlags||value.i||
|GetFlags|i|||
|SetValue||value.i||
|GetValue|i|||
|SetGadget1||value.i||
|GetGadget1|i|||
|SetGadget2||value.i||
|GetGadget2|i|||
|SetMinSizeGadget1||value.i||
|GetMinSizeGadget1|i|||
|SetMinSizeGadget2||value.i||
|GetMinSizeGadget2|i|||
|SetSeparatorSize||value.i||
|GetSeparatorSize|i|||
|Resize||x.i = <span style="color:#AAAAFF">\#PB\_Ignore</span> , y.i = <span style="color:#AAAAFF">\#PB\_Ignore</span> , w.i = <span style="color:#AAAAFF">\#PB\_Ignore</span> , h.i = <span style="color:#AAAAFF">\#PB\_Ignore</span>||
|BindCustomDraw||<span style="color:#FFFFAA">*event.[MySplitter](#MySplitter)ProtoEventCustomDraw</span>||


## Declares

|Name|Return|Parameter|Comment|
| --- | --- | --- | --- |
|[MySplitter](#MySplitter)CreateSplitter||x.i , y.i , w.i , h.i , gadget1.i = 0 , gadget2.i = 0 , flags.i = 0||


