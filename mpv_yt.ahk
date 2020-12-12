;incremental youtube with mpv
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
CoordMode, Mouse, Screen
#SingleInstance, force
SetTitleMatchMode,2

GroupAdd, SuperMemo, ahk_class TBrowser ;Browser
GroupAdd, SuperMemo, ahk_class TContents ;Content Window (Knowledge Tree)
GroupAdd, SuperMemo, ahk_class TElWind ;Element window
GroupAdd, SuperMemo, ahk_class TSMMain ;Toolbar




;https://autohotkey.com/board/topic/88687-generate-file-name/
rdm09azAZ(){
restart:
random, oVar, 48, 122
if (ovar > 57 and ovar <65) OR (ovar > 90 and ovar <97)
	goto restart
return Chr(oVar)
}

rdm09(){
random, oVar, 0, 9
return oVar
}

rdmaz(){
random, oVar, 97, 122
return Chr(oVar)
}



#IfWinActive ahk_group SuperMemo
NumpadSub::
{
strng=
loop, 10
	strng .= rdm09azAZ()
thefile = C:\docs\supermemo\mpv_yt\link_files\smytmpv_%strng%.bat
FileAppend, "C:\Program Files\mpv\mpv.exe" %clipboard%, %thefile%
clipboard = %thefile%
Send, !n
return
}
return