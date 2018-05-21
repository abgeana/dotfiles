;-------------------------------------------------------------------------
; script configuration
;-------------------------------------------------------------------------

#NoEnv                  ; avoid checking empty variables to see if they are environment variables
SendMode Input          ; more reliable than the default
SetTitleMatchMode 2     ; wintitle anywhere inside to be a match

;-------------------------------------------------------------------------
; global variables for the script
;-------------------------------------------------------------------------

LockingEnabled := "true"
ZshAlwaysOnTop := "false"

;-------------------------------------------------------------------------
; execution of the powershell script which enables/disables win-l
;-------------------------------------------------------------------------


!l:: ; alt-l
    global LockingEnabled
    Run powershell.exe -windowstyle hidden C:\cygwin64\home\Alexandru\win-automation\powershell\switch-workstation-lock.ps1
    if (LockingEnabled == "false") {
        TrayTip, Windows Locking, Lock is now enabled., 5
        LockingEnabled := "true"
    } else {
        TrayTip, Windows Locking, Lock is now disabled., 5
        LockingEnabled := "false"
    }
Return

;-------------------------------------------------------------------------
; bring zsh window to top and activate it
;-------------------------------------------------------------------------

#z:: ; win-z
    WinSet, Top,, zsh
    WinActivate, zsh
Return

#+z:: ; win-shift-z
    if (ZshAlwaysOnTop == "false") {
        WinSet, AlwaysOnTop, On, zsh
        WinActivate, zsh
        TrayTip, zsh, Enabled windows always on top., 5
        ZshAlwaysOnTop := "true"
    } else {
        WinSet, AlwaysOnTop, Off, zsh
        TrayTip, zsh, Disabled windows always on top., 5
        ZshAlwaysOnTop := "false"
    }
Return

;-------------------------------------------------------------------------
; string expansions
;-------------------------------------------------------------------------

::br::Best regards,`nAlex Geana
