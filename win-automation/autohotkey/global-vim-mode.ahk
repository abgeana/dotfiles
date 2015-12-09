#NoEnv          ; avoid checking empty variables to see if they are environment variables
SendMode Input  ; more reliable than the default

;--------------------------------------------------
; Global variables
;--------------------------------------------------

; boolean which tells if vim mode is active
vimmode := "false"

; an initially empty collection of hotkeys
hotkeys := {}

;--------------------------------------------------
; Script functions
;--------------------------------------------------

CreateHotkey(hk, func, args*) {
    global hotkeys
    hotkeys[hk] := {}
    hotkeys[hk].func := func
    hotkeys[hk].args := args
    Hotkey, %hk%, HandleHotkey, Off
}

HandleHotkey() {
    global hotkeys
    hotkeys[A_ThisHotkey].func( hotkeys[A_ThisHotkey].args* )
}

DynamicSend(keys*) {
    for idx, key in keys {
        Send % key
    }
}

InitVim() {
    CreateHotkey(  "h",  "DynamicSend",  "{left}"   )
    CreateHotkey(  "j",  "DynamicSend",  "{down}"   )
    CreateHotkey(  "k",  "DynamicSend",  "{up}"     )
    CreateHotkey(  "l",  "DynamicSend",  "{right}"  )
    CreateHotkey(  "x",  "DynamicSend",  "{del}"    )
    CreateHotkey( "^d",  "DynamicSend",  "{pgdn}"   )
    CreateHotkey( "^u",  "DynamicSend",  "{pgup}"   )

    ; commands below are specific to windows text editors
    CreateHotkey(  "b",  "DynamicSend", "^{left}"   )
    CreateHotkey(  "w",  "DynamicSend", "^{right}"  )
}

EnableVim() {
    global vimmode, hotkeys
    vimmode := "true"
    for key, val in hotkeys
        Hotkey, %key%, On
    TrayTip, Vim Mode, Vim mode is now enabled., 5
}

DisableVim() {
    global vimmode, hotkeys
    vimmode := "false"
    for key, val in hotkeys
        Hotkey, %key%, Off
    TrayTip, Vim Mode, Vim mode is now disabled., 5
}

SwitchMode() {
    global vimmode
    if (vimmode == "false")
        EnableVim()
    else
        DisableVim()
}

;--------------------------------------------------
; Script initialization
;--------------------------------------------------

InitVim()

;--------------------------------------------------
; End of auto-execute section
;--------------------------------------------------

#esc::
    SwitchMode()
Return

$i::
    if (vimmode == "true")
        DisableVim()
    else
        Send, i
return

$+i::
    if (vimmode == "true") {
        Send, {home}
        DisableVim()
    } else
        Send, I
return

$a::
    if (vimmode == "true") {
        Send, {right}
        DisableVim()
    } else
        Send, a
return

$+a::
    if (vimmode == "true") {
        Send, {end}
        DisableVim()
    } else
        Send, A
return
