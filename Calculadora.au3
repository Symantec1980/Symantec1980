Opt("GUIOnEventMode", 1)
DIM $BA[] = ["7","8","9","+","C","4","5","6","-","SqRt","1","2","3","*",".","0","(",")","/","="]
Global $x = 8, $y = 50
GUICreate("Calc", 360, 330, 229, 118)
$D = GUICtrlCreateInput("", 8, 8, 344, 31, BitOR(0x00000080,2))
For $j = 0 to Ubound($BA) - 1 ;make the buttons
    btn($BA[$j])
Next
GUISetState(@SW_SHOW)
GUISetOnEvent(-3, "Bye")
While 1
    Sleep(25) ;Throttle
WEnd
Func btn($t) ;make button, associate event for each button press
    GUICtrlCreateButton($t, $x, $y, 65, 63)
    GUICtrlSetOnEvent(-1, "BP")
    GUICtrlSetFont(-1, 18, 400, 0, "MS Sans Serif")
    $x += 70
    If $x > 350 Then ;move down and left for next row of buttons
        $x = 8
        $y += 70
    EndIf
EndFunc
Func BP() ;handle the button press
    $v = GuiCtrlRead(@GUI_CtrlId)
    If $v = "C" Then
        GuiCtrlSetData($D, "")
    ElseIf $v = "SqRt" Then ;Solve expression, then take sqrt.
        GuiCtrlSetData($D, Sqrt(Execute(GuiCtrlRead($D))))
    ElseIf $v = "=" Then ;solve the expression
        GuiCtrlSetData($D, Execute(GuiCtrlRead($D)))
    Else
        GuiCtrlSetData($D, GuiCtrlRead($D) & $v)
    EndIf
EndFunc
Func Bye()
    Exit
EndFunc