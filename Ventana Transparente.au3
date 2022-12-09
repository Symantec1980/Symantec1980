#include <GUIConstants.au3>

$iWidthGui = 450
$iHeightGui = 300

$hGui = GUICreate("Glass GUI", $iWidthGui, $iHeightGui, -1, -1, -1, $WS_EX_TOPMOST)
$cExit = GUICtrlCreateButton("Exit", $iWidthGui / 2 - 50, $iHeightGui / 2 - 15, 100, 30)
GUISetState( @SW_SHOW )

WinSetTrans($hGui, "", 180)

While 1
    Switch GUIGetMsg()
        Case $GUI_EVENT_CLOSE, $cExit
            GUIDelete($hGui)
            ExitLoop
    EndSwitch
WEnd