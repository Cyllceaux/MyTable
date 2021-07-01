
# MyApplication

## Constants

|Constants|Value|Comment|
| --- | --- | --- |
|<span style="color:#AAAAFF">\#VERSION</span>|5||
|<span style="color:#AAAAFF">\#VERSION\_DATE</span>|20210701||


## Interfaces


### MyApplication
|Name|Return|Parameter|Comment|
| --- | --- | --- | --- |
|SetRedraw||value.b||
|GetRedraw|b|||
|SetRecalc||value.b||
|GetRecalc|b|||
|AddTable||window.i , canvas.i , vscroll.i , hscroll.i , name.s = <span style="color:#AAFFAA">""</span> , flags.i = <span style="color:#AAAAFF">\#PB\_Ignore</span>||
|AddTree||window.i , canvas.i , vscroll.i , hscroll.i , name.s = <span style="color:#AAFFAA">""</span> , flags.i = <span style="color:#AAAAFF">\#PB\_Ignore</span>||
|AddGrid||window.i , canvas.i , vscroll.i , hscroll.i , rows.i , cols.i , name.s = <span style="color:#AAFFAA">""</span> , flags.i = <span style="color:#AAAAFF">\#PB\_Ignore</span>||
|AddNewTable||x.i , y.i , w.i , h.i , name.s = <span style="color:#AAFFAA">""</span> , flags.i = <span style="color:#AAAAFF">\#PB\_Ignore</span>||
|AddNewTree||x.i , y.i , w.i , h.i , name.s = <span style="color:#AAFFAA">""</span> , flags.i = <span style="color:#AAAAFF">\#PB\_Ignore</span>||
|AddNewGrid||x.i , y.i , w.i , h.i , rows.i , cols.i , name.s = <span style="color:#AAFFAA">""</span> , flags.i = <span style="color:#AAAAFF">\#PB\_Ignore</span>||
|ClearTables||||
|Redraw||||
|Recalc||||
|Free||||
|Save|b|file.s|TODO|


## Declares

|Name|Return|Parameter|Comment|
| --- | --- | --- | --- |
|[MyApplication](#MyApplication)CreateApplication||flags.i = 0||
|[MyApplication](#MyApplication)LoadApplication||file.s|TODO|


