; ! Alt
; + Shift
; ^ Ctrl
; # Win

;incremental youtube with mpv
;
; Modify:
; line 74 (thefile=...): (empty) folder on your machine, used to temporarily store the script
; line 75: path to mpv.exe
;
; Requirements:
; - SM template with a script component. this needs to be used by the active concept (so new elements get created with it)
; - mpv and youtube-dl must be be installed
; - "save-position-on-quit=yes" in mpv.conf so videos start where you left off
; 
; Usage:
; - copy a youtube url to the clipboard
; - activate SM and press minus on the numpad
; - click the script component (important, because the scripts waits for that)
; - enter the title, I copy it from youtube

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
;create_element()
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
	SendRaw, #Link:
	Send, %URL%
	sleep, 200
	Send, !{Left}
	sleep, 200
	Send, !{Right}
	Send, q
	Sleep, 100
	Send, {DOWN}
	Send, %Title%
    SendInput, {HOME}{shift down}{END}{shift up}
	sleep, 200
	Send, !t

	return
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
	Send, ^g
	sleep, 100
	Send, 1
	sleep, 100
	Send, {ENTER}
	strng=
	loop, 10
		strng .= rdm09azAZ()
	Send, !n
	sleep, 200
	SendRaw, #Link:
	Send, %Clipboard%
	thefile = C:\docs\supermemo\mpv_yt\link_files\smytmpv_%strng%.bat
	FileAppend, Start "" "C:\Program Files\mpv\mpv.exe" %clipboard%, %thefile%
	clipboard = %thefile%
	Send, `n
	Send, %Clipboard%
	
	;sleep, 200
	;Send, `n
	;Send, #v
	;sleep, 100
	;Send, {DOWN}
	;sleep, 5000
	;Send, {DOWN}
	;sleep, 5000
	;Send, {ENTER}
	
	Send, !{Left}
	sleep, 200
	Send, !{Right}
	sleep, 200
	;keywait, LButton, D T10
	CoordMode, Mouse, Window
    Click, 1174,250
	sleep, 200
	send, ^q
	sleep, 100
	send, {TAB}
	sleep, 100
	send, {TAB}
	sleep, 100
	send, {TAB}
	sleep, 100
	send, {TAB}
	sleep, 100
	send, ^v
	sleep, 100
	Send, {ENTER}
	return
}
return


