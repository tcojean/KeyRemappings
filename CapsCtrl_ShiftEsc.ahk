CapsWaitingForCtrlInput := false
CapsSentCtrlDownWithKey := false
CapsLastDownTime := 0

SC028WaitingForCtrlInput := false
SC028SentCtrlDownWithKey := false
SC028LastDownTime := 0

MaxPressTime := 1000

*CapsLock::
    key :=
    CapsLastDownTime := A_TickCount
    CapsWaitingForCtrlInput := true
    ; If we use this key together with another: this is used as control
    Input, key, B C L1 T1, {Esc}
    CapsWaitingForCtrlInput := false
    ; We got a key
    if (ErrorLevel = "Max") {
        CapsSentCtrlDownWithKey := true
        Send {Ctrl Down}%key%
    }
    KeyWait, CapsLock
    Return

*CapsLock up::
    current_time := A_TickCount
    time_elapsed := current_time - CapsLastDownTime
    ; We used this key as control
    if (CapsSentCtrlDownWithKey) {
        Send {Ctrl Up}
        CapsSentCtrlDownWithKey := false
    } else { ; we did not press another key
        if (time_elapsed < MaxPressTime) {
            ; We need to cancel the matching pending Input
            if (CapsWaitingForCtrlInput) {
                Send, {Esc}
            }
            SetCapsLockState % !GetKeyState("CapsLock", "T")
        }
    }
    Return

SC028::
    key :=
    SC028LastDownTime := A_TickCount
    SC028WaitingForCtrlInput := true
    ; If we use this key together with another: this is used as control
    Input, key, B C L1 T1, {Esc}
    SC028WaitingForCtrlInput := false
    ; We got a key
    if (ErrorLevel = "Max") {
        SC028SentCtrlDownWithKey := true
        Send {Ctrl Down}%key%
    }
    KeyWait, SC028
    Return

SC028 up::
    current_time := A_TickCount
    time_elapsed := current_time - SC028LastDownTime
    ; We used this key as control
    if (SC028SentCtrlDownWithKey) {
        Send {Ctrl Up}
        SC028SentCtrlDownWithKey := false
    } else { ; we did not press another key
        if (time_elapsed < MaxPressTime) {
            ; We need to cancel the matching pending Input
            if (SC028WaitingForCtrlInput) {
                Send, {Esc}
            }
            SendEvent {SC028}
        }
    }
    Return


; Use shift as Escape
;
; We can reuse the existing configuration. If the previous key was a Shift
; (pressed shift and released alone), consider this as an escape.
~*Shift up::
    if (A_PriorKey ~= "(L|R)Shift")
        Send {Esc}
    Return
