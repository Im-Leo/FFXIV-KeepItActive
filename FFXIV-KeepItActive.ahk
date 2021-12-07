;
; Simple AHK script that sends keystrokes to the FFXIV client to avoid being disconnected due inactivity (particularly useful now, due long queue times)
; 
; How to use:
; 
; 	1 - Save the script locally (use whichever name you want, but needs to have .ahk extension)
;	  2 - Download & install AHK (https://www.autohotkey.com/download/ahk-install.exe)
; 	3 - Compile the script (right click ->  Compile script)
;	  4 - Execute the script as admnin (right click -> Run as administrator)
;	  5 - Use the control keybinds to start (Insert), pause/toggle (Home) and close (End) the script
; 
; You can monitor the execution status (Running or Paused) on the top left corner
; The script will send keypresses directly to the client as long as you start the script while the client is targeted.
; 

#SingleInstance Force
#InstallKeybdHook
SendMode Input
DetectHiddenWindows, On
SetKeyDelay , 50, 30,   ;First value is default delay between presses, second value is press length in ms
CoordMode, ToolTip, Screen

global scriptStatus := "Running"

if !A_IsAdmin { ;Run in admin
	Run *RunAs "%A_ScriptFullPath%"
	ExitApp
}

Insert::
	ID := WinExist("A")
	ToolTip , FFXIV - Keep it alive`nStatus: %scriptStatus%, 0, 0
	
	loop {
		ControlSend,,{numpad0}, ahk_id %ID%
		sleep, 3000
	}
return

UpdateTooltip() {
	scriptStatus := (scriptStatus == "Running") ? "Paused" : "Running"
	ToolTip , FFXIV - Keep it alive`nStatus: %scriptStatus%, 0, 0
}

Home::Pause, Toggle, % UpdateTooltip()
End::ExitApp
