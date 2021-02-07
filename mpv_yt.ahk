; ! Alt
; + Shift
; ^ Ctrl
; # Win

;incremental youtube with mpv
;
; Modify:
; thefile=...: (empty) folder on your machine, used to temporarily store the script
; next line: path to mpv.exe
; coordinates of the 
;
; Requirements:
; - SM template with a script component. this needs to be used by the active concept (so new elements get created with it)
; - mpv and youtube-dl must be be installed
; - "save-position-on-quit=yes" in mpv.conf so videos start where you left off
; 
; Usage:
; - copy a youtube url to the clipboard
; - activate SM and press minus on the numpad
; - enter the title, I copy it from youtube

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
CoordMode, Mouse, Screen
#SingleInstance, force
SetTitleMatchMode,2

I_Icon = C:\Program Files\mpv\installer\mpv-icon.ico
IfExist, %I_Icon%
    Menu, Tray, Icon, %I_Icon%
;return

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

#IfWinActive ahk_group SuperMemo
NumpadSub::
{
    ; go to the first SM element so that alt-left doesn't open another video element and start the video
	Send, ^g
	sleep, 100
	Send, 1
	sleep, 100
	Send, {ENTER}
	
	; create a random string to use as part of a file name
	strng=
	loop, 10
		strng .= rdm09azAZ()
	
	; create a new element
	Send, !n
	sleep, 200
	
	; write "#Link:https://..." into the element. this will be turned into a link reference automatically by SM (see below)
	SendRaw, #Link:
	Send, %Clipboard%
	
	; temproray file to store the bat script
	thefile = C:\docs\supermemo\mpv_yt\link_files\smytmpv_%strng%.bat
	
	; script content: run mpv with the youtube url as parameter
	FileAppend, Start "" "C:\Program Files\mpv\mpv.exe" %clipboard%, %thefile%
	
	; a) put the path to that file into the clipboard and b) paste it into the element (b) is optional and can be removed. no purpose other than information)
	clipboard = %thefile%
	Send, `n
	Send, %Clipboard%
	
	; close and open the element so that SM creates the 'Link' reference
	Send, !{Left}
	sleep, 200
	Send, !{Right}
	sleep, 200
	; click on the script component (adjust coordinates)
	CoordMode, Mouse, Window
    Click, 1174,250
	sleep, 200
	
	; Ctrl-q to choose the script
	send, ^q
	sleep, 100
	
	; go to the input field
	send, {TAB}
	sleep, 100
	send, {TAB}
	sleep, 100
	send, {TAB}
	sleep, 100
	send, {TAB}
	sleep, 100
	
	; paste the path to the script (we put it into the clipboard above)
	send, ^v
	sleep, 100
	Send, {ENTER}
	
	; everything done. SM should now ask for the title. choose what you like (i copy the video title from youtube)
	; when you open the element for the first time, SM asks if you want to trust the script. choose yes
	return
}
return


