#include <GUIConstants.au3>
#include <ARRAY.AU3>

Global $turn = True;true means player false means ai
Global $grid[4][4]
Global $button[4][4]
Global $string_eval[9]
Global $content[9]
Global $moves = 0
Global $computer_win = 0
Global $total = 0
Global $playerwin = 0

$content[1] = "31,32,33"
$content[2] = "21,22,23"
$content[3] = "11,12,13"
$content[4] = "11,22,33"
$content[5] = "11,21,31"
$content[6] = "12,22,32"
$content[7] = "13,23,33"
$content[8] = "13,22,31"
$Form1 = GUICreate("Beat-me Tic-Tac-Toe – Created By Darknight", 420, 347, 420, 125)
GUICtrlCreateLabel("Computer Win", 10, 10, 71, 17)
$cwin = GUICtrlCreateLabel("00", 90, 10, 25, 17)
GUICtrlCreateLabel("Player Win", 140, 10, 55, 17)
$pwin = GUICtrlCreateLabel("00", 205, 10, 25, 17)
GUICtrlCreateLabel("Games", 250, 10, 37, 17)
$games = GUICtrlCreateLabel("00", 295, 10, 16, 17)
$Button[1][1] = GUICtrlCreateButton("", 44, 72, 57, 57, 0)
GUICtrlSetFont(-1, 20, 800, 0, "MS Sans Serif")
$Button[1][2] = GUICtrlCreateButton("", 134, 72, 57, 57, 0)
GUICtrlSetFont(-1, 20, 800, 0, "MS Sans Serif")
$Button[1][3] = GUICtrlCreateButton("", 224, 72, 57, 57, 0)
GUICtrlSetFont(-1, 20, 800, 0, "MS Sans Serif")
$Button[2][3] = GUICtrlCreateButton("", 224, 152, 57, 57, 0)
GUICtrlSetFont(-1, 20, 800, 0, "MS Sans Serif")
$Button[2][1] = GUICtrlCreateButton("", 44, 152, 57, 57, 0)
GUICtrlSetFont(-1, 20, 800, 0, "MS Sans Serif")
$Button[2][2] = GUICtrlCreateButton("", 134, 152, 57, 57, 0)
GUICtrlSetFont(-1, 20, 800, 0, "MS Sans Serif")
$Button[3][3] = GUICtrlCreateButton("", 224, 232, 57, 57, 0)
GUICtrlSetFont(-1, 20, 800, 0, "MS Sans Serif")
$Button[3][2] = GUICtrlCreateButton("", 134, 232, 57, 57, 0)
GUICtrlSetFont(-1, 20, 800, 0, "MS Sans Serif")
$Button[3][1] = GUICtrlCreateButton("", 44, 232, 57, 57, 0)
GUICtrlSetFont(-1, 20, 800, 0, "MS Sans Serif")
$Label1 = GUICtrlCreateLabel("Press any Button", 100, 40, 200, 17)
GUICtrlSetFont(-1, 12, 800, 0, "MS Sans Serif")
$reset = GUICtrlCreateButton("Reset", 112, 312, 97, 25, 0)
GUISetState(@SW_SHOW)
For $i = 1 to 3;column
    For $j = 1 to 3;row
        $grid[$i][$j] = 0
    Next
Next

While 1
    $nMsg = GUIGetMsg()
    Switch $nMsg
        Case $GUI_EVENT_CLOSE
            Exit
        Case $button [1][1]
            If $grid[1][1] = 0 And BitAND(GUICtrlGetState($button [1][1]),$GUI_ENABLE) Then
                _clicked (1,1)
            EndIf
         Case $button [1][2]
            If $grid[1][2] = 0 And BitAND(GUICtrlGetState($button [1][2]),$GUI_ENABLE) Then
                _clicked (1,2)
            EndIf

        Case $button [1][3]
            If $grid[1][3] = 0 And BitAND(GUICtrlGetState($button [1][3]),$GUI_ENABLE) Then
                _clicked (1,3)
            EndIf

        Case $button [2][1]
            If $grid[2][1] = 0 And BitAND(GUICtrlGetState($button [2][1]),$GUI_ENABLE) Then
                _clicked (2,1)
            EndIf

        Case $button [2][2]
            If $grid[2][2] = 0 And BitAND(GUICtrlGetState($button [2][2]),$GUI_ENABLE) Then
                _clicked (2,2)
            EndIf

        Case $button [2][3]
            If $grid[2][3] = 0 And BitAND(GUICtrlGetState($button [2][3]),$GUI_ENABLE) Then
                _clicked (2,3)
            EndIf

        Case $button [3][1]
            If $grid[3][1] = 0 And BitAND(GUICtrlGetState($button [3][1]),$GUI_ENABLE) Then
                _clicked (3,1)
            EndIf

        Case $button[3][2]
             If $grid[3][2] = 0 And BitAND(GUICtrlGetState($button [3][2]),$GUI_ENABLE) Then
                _clicked (3,2)
            EndIf

        Case $button [3][3]
            If $grid[3][3] = 0 And BitAND(GUICtrlGetState($button [3][3]),$GUI_ENABLE) Then
                _clicked (3,3)
            EndIf
        Case $reset
            If $computer_win = 1 Then GUICtrlSetData($cwin, GUICtrlRead($cwin)+1)
            If $playerwin = 1 Then GUICtrlSetData($pwin, GUICtrlRead($pwin)+1)
            GUICtrlSetData ($Label1, "Your Turn")
            For $i = 1 to 3;column
                For $j = 1 to 3;row
                    $grid[$i][$j] = 0
                    GUICtrlSetState($button[$i][$j], $GUI_ENABLE)
                    GUICtrlSetData($button[$i][$j], "")
                Next
            Next
            $moves = 0
            $turn = True
            $total +=1
            $computer_win = 0
            $playerwin = 0
            GUICtrlSetData($games, $total)
    EndSwitch
    If $moves = 9 And $computer_win = 0 Then
        GUICtrlSetData ($Label1, "Nobody won")

        $moves = 0
    EndIf
WEnd

Func string_eval()
    For $j=1 To 8
        $string_eval[$j] = 0
    Next
    For $j=1 To 3
        $string_eval[1] +=  $grid[3][$j]
        $string_eval[2] +=  $grid[2][$j]
        $string_eval[3] +=  $grid[1][$j]
        $string_eval[5] +=  $grid[$j][1]
        $string_eval[6] +=  $grid[$j][2]
        $string_eval[7] +=  $grid[$j][3]
    Next
    $string_eval[4] =  $grid[1][1]+$grid[2][2]+$grid[3][3]
    $string_eval[8] =  $grid[1][3]+$grid[2][2]+$grid[3][1]
EndFunc

Func _clicked ($row, $column)
    If $moves = 9 Then Return
    Local $found_win = 0
        If $turn = true Then
            If BitAND(GUICtrlGetState($button [$row][$column]),$GUI_ENABLE) Then
                GUICtrlSetData ($button[$row][$column], "X")
                GUICtrlSetState ($button[$row][$column], $gui_disable)
                GUICtrlSetData ($Label1, "Thinking...")
                $grid[$row][$column] = 5
                $turn = False
                $moves +=1
                string_eval()
                For $i=1 To 8
                    If $string_eval[$i] = 15 Then   ;player won
                        $playerwin = 1
                        GUICtrlSetData ($Label1, "You Won")
                        Return
                    EndIf
                Next
                If $moves = 9 Then Return
            Else
                Return
            EndIf
        EndIf
        If $turn = False Then
            Select
                Case $moves = 1
                    If $grid[2][2] = 5 Then
                        GUICtrlSetData ($button[1][1], "O")
                        GUICtrlSetState ($button[1][1], $gui_disable)
                        GUICtrlSetData ($Label1, "Your Turn...")
                        $grid[1][1] = 1
                        $moves +=1
                        If $moves = 9 Then Return
                        $turn = True
                        Return
                    EndIf
                    If $grid[2][2] = 0 Then
                        GUICtrlSetData ($button[2][2], "O")
                        GUICtrlSetState ($button[2][2], $gui_disable)
                        GUICtrlSetData ($Label1, "Your Turn...")
                        $grid[2][2] = 1
                        $moves +=1
                        If $moves = 9 Then Return
                        $turn = True
                        Return
                    EndIf
                Case $moves >2
                    string_eval()
                    For $i=1 To 8
                        If $string_eval[$i] = 2 Then    ;go for win
                            $found_win = 1
                            $row_played = StringSplit($content[$i], ",")
                            For $k=1 To 3
                                $ids = StringSplit($row_played[$k], "")
                                If $grid[$ids[1]][$ids[2]] = 0 Then     ;3rd empty - play there
                                    GUICtrlSetData ($button[$ids[1]][$ids[2]], "O")
                                    GUICtrlSetState ($button[$ids[1]][$ids[2]], $gui_disable)
                                    GUICtrlSetData ($Label1, "I Won")
                                    $computer_win=1
                                    $grid[$ids[1]][$ids[2]] = 1
                                    Return
                                EndIf
                            Next
                        EndIf
                    Next
                    For $i=1 To 8
                        If $string_eval[$i] = 10 Then   ;2 in a row from player
                            $row_played = StringSplit($content[$i], ",")
                            For $k=1 To 3
                                $ids = StringSplit($row_played[$k], "")
                                If $grid[$ids[1]][$ids[2]] = 0 Then     ;3rd empty - play there
                                    GUICtrlSetData ($button[$ids[1]][$ids[2]], "O")
                                    GUICtrlSetState ($button[$ids[1]][$ids[2]], $gui_disable)
                                    GUICtrlSetData ($Label1, "Your Turn...")
                                    $grid[$ids[1]][$ids[2]] = 1
                                    $moves +=1
                                    If $moves = 9 Then Return
                                    $turn = True
                                    Return
                                EndIf
                            Next
                        EndIf
                    Next
                    If $string_eval[4] = 11 Then
                        If $grid [1][1] = 5 And $grid [3][3] = 5 And $moves < 4 Then
                            GUICtrlSetData ($button[1][2], "O")
                            GUICtrlSetState ($button[1][2], $gui_disable)
                            GUICtrlSetData ($Label1, "Your Turn...")
                            $grid[1][2] = 1
                            $moves +=1
                            If $moves = 9 Then Return
                            $turn = True
                            Return
                        EndIf
                        If $grid [2][2] = 5 And $grid [3][3] = 5 And $moves < 4 Then
                            GUICtrlSetData ($button[1][3], "O")
                            GUICtrlSetState ($button[1][3], $gui_disable)
                            GUICtrlSetData ($Label1, "Your Turn...")
                            $grid[1][3] = 1
                            $moves +=1
                            If $moves = 9 Then Return
                            $turn = True
                            Return
                        EndIf
                    EndIf
                    If $grid [1][2] = 5 And $grid [3][3] = 5 And $moves < 4 Then
                        GUICtrlSetData ($button[1][3], "O")
                        GUICtrlSetState ($button[1][3], $gui_disable)
                        GUICtrlSetData ($Label1, "Your Turn...")
                        $grid[1][3] = 1
                        $moves +=1
                        If $moves = 9 Then Return
                        $turn = True
                        Return
                    EndIf
                    If $grid [2][3] = 5 And $grid [3][2] = 5 And $moves < 4 Then
                        GUICtrlSetData ($button[3][3], "O")
                        GUICtrlSetState ($button[3][3], $gui_disable)
                        GUICtrlSetData ($Label1, "Your Turn...")
                        $grid[3][3] = 1
                        $moves +=1
                        If $moves = 9 Then Return
                        $turn = True
                        Return
                    EndIf
                    If $grid [1][2] = 5 And $grid [3][1] = 5 And $moves < 4 Then
                        GUICtrlSetData ($button[1][1], "O")
                        GUICtrlSetState ($button[1][1], $gui_disable)
                        GUICtrlSetData ($Label1, "Your Turn...")
                        $grid[1][1] = 1
                        $moves +=1
                        If $moves = 9 Then Return
                        $turn = True
                        Return
                    EndIf
                    For $x=1 To 8
                        If $string_eval[$x] <> 10 And $string_eval[$x] <> 2 Then    ;2 in a row from player
                            If $string_eval[$x] = 1 Then
                                $row_played = StringSplit($content[$x], ",")
                                For $k=1 To 3
                                    $ids = StringSplit($row_played[$k], "")
                                    If $grid[$ids[1]][$ids[2]] = 0 Then     ;3rd empty - play there
                                        GUICtrlSetData ($button[$ids[1]][$ids[2]], "O")
                                        GUICtrlSetState ($button[$ids[1]][$ids[2]], $gui_disable)
                                        GUICtrlSetData ($Label1, "Your Turn...")
                                        $grid[$ids[1]][$ids[2]] = 1
                                        $moves +=1
                                        If $moves = 9 Then Return
                                        $turn = True
                                        Return
                                    EndIf
                                Next
                            ElseIf $string_eval[$x] = 5 Then
                                $row_played = StringSplit($content[$x], ",")
                                For $k=1 To 3
                                    $ids = StringSplit($row_played[$k], "")
                                    If $grid[$ids[1]][$ids[2]] = 0 Then     ;3rd empty - play there
                                        GUICtrlSetData ($button[$ids[1]][$ids[2]], "O")
                                        GUICtrlSetState ($button[$ids[1]][$ids[2]], $gui_disable)
                                        GUICtrlSetData ($Label1, "Your Turn...")
                                        $grid[$ids[1]][$ids[2]] = 1
                                        $moves +=1
                                        If $moves = 9 Then Return
                                        $turn = True
                                        Return
                                    EndIf
                                Next
                            EndIf
                        EndIf
                    Next
            EndSelect
        EndIf
EndFunc