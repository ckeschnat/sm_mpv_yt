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


global URL:=""
global Title:=""

#IfWinActive ahk_class MozillaWindowClass
NumpadSub::
Send, ^l
Send, ^c
URL=%clipboard%
MsgBox, %URL%
Gui, New
;Gui, Add, Text,, URL
;Gui, Add, Edit, vURL
Gui, Add, Text,, Title
Gui, Add, Edit, vTitle
Gui, Add, Button, Default gOK, OK
Gui, Show
return
OK:
Gui, Submit
create_element()
URL:=""
Title:=""
return


create_element(){
	if WinExist("ahk_exe sm18.exe") {
		WinActivate, ahk_exe sm18.exe
	}
	else  {
		MsgBox, 4, , SuperMemo is not running.`n`nRun SuperMemo now?, 5  ; 5-second timeout.
		IfMsgBox, No
			Return  ; User pressed the "No" button.
		IfMsgBox, Timeout
			Return ; Assume "No" if timed out.
		; Otherwise, continue:
		Run E:\SuperMemo\sm18.exe ; Replace with correct path to sm16.exe
		WinWait, ahk_class TElWind
		WinActivate
	}
	strng=
	loop, 10
		strng .= rdm09azAZ()
	Send, !n
	sleep, 200

	SendRaw, #Link:
	Send, :%Clipboard%
	thefile = C:\docs\supermemo\mpv_yt\link_files\smytmpv_%strng%.bat
	FileAppend, "C:\Program Files\mpv\mpv.exe" %clipboard%, %thefile%
	clipboard = %thefile%
	Send, `n
	Send, \n
	Send, %Clipboard%
	sleep, 200
	Send, !{Left}
	sleep, 200
	Send, !{Right}
	return
}



#IfWinActive ahk_group SuperMemo
NumpadSub::
{
	strng=
	loop, 10
		strng .= rdm09azAZ()
	Send, !n
	sleep, 200
	SendRaw, #Link:
	Send, :%Clipboard%
	thefile = C:\docs\supermemo\mpv_yt\link_files\smytmpv_%strng%.bat
	FileAppend, "C:\Program Files\mpv\mpv.exe" %clipboard%, %thefile%
	clipboard = %thefile%
	Send, `n
	Send, \n
	Send, %Clipboard%
	sleep, 200
	Send, !{Left}
	sleep, 200
	Send, !{Right}
	return
}
return


