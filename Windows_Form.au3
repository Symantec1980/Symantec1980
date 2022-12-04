#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GuiMenu.au3>

$hGUI = GUICreate("Test", 500, 500)

GUISetState()

$hSystemMenu = _GUICtrlMenu_GetSystemMenu($hGUI)
_GUICtrlMenu_GetItemCount($hSystemMenu)
_GUICtrlMenu_AppendMenu($hSystemMenu, $MF_SEPARATOR, 0, "")
_GUICtrlMenu_AppendMenu($hSystemMenu, $MF_STRING, 0x3000, "New Sysmenu Item") ; You need to set the CmdID value here

GUIRegisterMsg($WM_SYSCOMMAND, "_WM_SYSCOMMAND")

$sMenuSelection = ""

While 1

    Switch GUIGetMsg()
        Case $GUI_EVENT_CLOSE
            Exit
    EndSwitch

    If $sMenuSelection <> "" Then
        MsgBox(0, "New Menu", "You selected " & $sMenuSelection)
        $sMenuSelection = ""
    EndIf

WEnd

Func _WM_SYSCOMMAND($hGUI, $iMsg, $wParam, $lParam)

    If $iMsg = $WM_SYSCOMMAND Then
        If _WinAPI_LoWord($wParam) = 0x3000 Then ; So you can detect it here!
            $sMenuSelection = "New Sysmenu Item"
        EndIf
    EndIf

EndFunc