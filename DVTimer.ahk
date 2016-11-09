#NoTrayIcon
#SingleInstance, Force
#Persistent
#KeyHistory, 0

SetBatchLines, -1

; =========
; Main Body - v1.0
; =========

FileInstall, DVTimer.wav, %A_ScriptDir%\DVTimer.wav
FileInstall, DVTimer0.ico, %A_ScriptDir%\DVTimer0.ico
FileInstall, DVTimer1.ico, %A_ScriptDir%\DVTimer1.ico

WinTitle = Activity Reminder

Menu, Tray, Icon, %A_ScriptDir%\DVTimer0.ico,, 1	; not yet shown, but used by possible InputBox

IfEqual, 1,		; was the timer period not provided on command line?
{
  InputBox, PeriodM, %WinTitle%, Enter the timer period (in minutes):,, 250, 130,,,,, 75
  IfNotEqual, ErrorLevel, 0, ExitApp, 1
}
Else
  PeriodM = %1%

ToGo := Period := PeriodM * 60000
Interval := 6000		; TrayTip update interval (6 seconds / 0.1 minute)

SetFormat, Float, 0.1 
SetTimer, TimeCheck, %Interval%

GoSub, mNewTime

Menu, Tray, Icon
Menu, Tray, Tip, %WinTitle%:`nNext Walk at %TimeM% ; `n is a line break.
Menu, Tray, NoStandard

Stopped = 0	; to keep track of timer stopped/started state
StartText = Start timer
StopText = Stop timer
Menu, Tray, Add, Next Walk at %TimeM%, mDoNothing
Menu, Tray, Default, Next Walk at %TimeM%
Menu, Tray, Disable, Next Walk at %TimeM%
Menu, Tray, Add      ; time for a nice separator
Menu, Tray, Add, %StopText%, mStopStart
Menu, Tray, Add, Restart timer, mRestart
Menu, Tray, Add, Change timer period, mChange
Menu, Tray, Add      ; time for a nice separator
Menu, Tray, Add, Exit %WinTitle%, mExit

Return

; ======
mChange:
; ======

PeriodM =

; =======
mRestart:
; =======

Run, %A_ScriptFullPath% %PeriodM%, %A_WorkingDir%, UseErrorLevel

Return     ; failsafe / probably never hits this line

; ====
mExit:
; ====

ExitApp, 0

; =======
mStopStart:
; =======

Stopped := 1 - Stopped
IfEqual, Stopped, 1
{
  Menu, Tray, Rename, %StopText%, %StartText%
  Menu, Tray, Icon, %A_ScriptDir%\DVTimer1.ico
  SetTimer, TimeCheck, Off
  Menu, Tray, Tip, %WinTitle%:`nCurrently stopped!
  Menu, Tray, Disable, Restart timer
  Menu, Tray, Rename, Next Walk at %TimeM%, Blood Clots FORMING!
}
Else
{
  GoSub, mNewTime
  Menu, Tray, Rename, %StartText%, %StopText%
  Menu, Tray, Icon, %A_ScriptDir%\DVTimer0.ico
  ToGo := Period
  SetTimer, TimeCheck, On		; restart timer with original period
  Menu, Tray, Tip, %WinTitle%:`nNext Walk at %TimeM%.
  Menu, Tray, Enable, Restart timer
  Menu, Tray, Rename, Blood Clots FORMING!, Next Walk at %TimeM%
}

Return

; =====
mDoNothing: ; for labels.
; =====

Return

; =====
mNewTime: ; Sets up time Variable.
; =====
  TimeM = 
  TimeM += %PeriodM%, Minutes
  FormatTime, TimeM, %TimeM%, Time

Return

; =====
; Timer
; =====

TimeCheck:

ToGo := ToGo - Interval

IfGreater, ToGo, 3000		; not yet time if more than 3 seconds to go (instead of 0, to account for cumulative "drift")
{
  TipTime := (ToGo // 6000) / 10
  Menu, Tray, Tip, %WinTitle%:`nNext Walk %TimeM% (in ~%TipTime% minutes).
  Return
}

GoSub, mStopStart			; stop timer
Menu, Tray, Disable, %StartText%	; don't allow timer restart until upcoming MsgBox is dismissed!

SoundPlay, %A_ScriptDir%\DVTimer.wav, Wait
MsgBox, 4160, %WinTitle%, Time to take a walk, buddy!`n`nClick OK to restart the timer.

Menu, Tray, Enable, %StartText%		; re-enable timer stop/start menu item
GoSub, mStopStart			; start fresh timer

Return
