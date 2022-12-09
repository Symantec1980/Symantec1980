#include-once
#include <GUIConstants.au3>

Global $iWidthGui  = 450
Global $iHeightGui = 300

Global $hGui  = GUICreate("Glass GUI", $iWidthGui, $iHeightGui, -1, -1, -1, $WS_EX_TOPMOST)
Global $cExit = GUICtrlCreateButton("Exit", $iWidthGui / 2 - 50, $iHeightGui / 2 - 15, 100, 30)
GUISetState( @SW_SHOW, $hGui )

Func _aeroGlassEffect( $hWnd, $iLeft = @DesktopWidth, $iRight = @DesktopWidth, $iTop = @DesktopWidth, $iBottom = @DesktopWidth )
    $hStruct = DllStructCreate( 'int left; int right; int height; int bottom;' )
    DllStructSetData( $hStruct, 'left', $iLeft )
    DllStructSetData( $hStruct, 'right', $iRight )
    DllStructSetData( $hStruct, 'height', $iTop )
    DllStructSetData( $hStruct, 'bottom', $iBottom )
    GUISetBkColor( '0x000000' )
    Return DllCall( 'dwmapi.dll', 'int', 'DwmExtendFrameIntoClientArea', 'hWnd', $hWnd, 'ptr', DllStructGetPtr( $hStruct ) )
EndFunc

_aeroGlassEffect( $hGui )

While 1
    Switch GUIGetMsg()
        Case $GUI_EVENT_CLOSE, $cExit
            GUIDelete($hGui)
            ExitLoop
    EndSwitch
WEnd