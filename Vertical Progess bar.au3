#cs ----------------------------------------------------------------------------
AutoIt Version: 3.3.4.0
Author:      myName
Script Function:
Template AutoIt script.
#ce ----------------------------------------------------------------------------

; #include <GUIConstantsEx.au3>
Global Const $GUI_HIDE = 32
Global Const $GUI_SHOW = 16
Global Const $GUI_EVENT_CLOSE = -3
; #include <ProgressConstants.au3>
Global Const $PBS_VERTICAL = 0x04
Global Const $PBM_SETSTATE = 0x0410
; #Include <WinAPI.au3>
Global Const $tagFLASHWINFO = "uint Size;hwnd hWnd;dword Flags;uint Count;dword TimeOut"
Global Const $__WINAPICONSTANT_FLASHW_CAPTION = 0x00000001
Global Const $__WINAPICONSTANT_FLASHW_TRAY  = 0x00000002
Global Const $__WINAPICONSTANT_FLASHW_TIMER  = 0x00000004
Global Const $__WINAPICONSTANT_FLASHW_TIMERNOFG = 0x0000000C

Dim $o_Percentage

$Form1 = GUICreate("Progress Bar Exemple", 150, 450, -1, -1)
$Progress1 = GUICtrlCreateProgress(10, 10, 10, 400, $PBS_VERTICAL)
$Label1 = GUICtrlCreateLabel ( "---------------", 50, 225)
GUICtrlSetFont ($Label1, 12, 600)
GUISetState(@SW_SHOW)
GUICtrlSetState($Progress1, $GUI_HIDE)
$Start_Time = TimerInit()
$Time_To_Wait = 30000 ; miliseconden
GUICtrlSetData($Progress1, 100)
Sleep(500)
GUICtrlSetState($Progress1, $GUI_SHOW)
While 1
$nMsg = GUIGetMsg()
Switch $nMsg
  Case $GUI_EVENT_CLOSE
   Exit
EndSwitch
Sleep(10)
If WinActive($Form1) Then
  $Start_Time = TimerInit()
EndIf
$Current_Time_Difference = TimerDiff($Start_Time)
If $Current_Time_Difference > $Time_To_Wait Then
  ;ProgressSet(100, "Done!")
  Sleep(750)
  ;ProgressOff()
  Exit
Else
  $Percentage = 100 - Round((100/$Time_To_Wait) * $Current_Time_Difference)
  GuiCtrlSetData($Label1, String($Percentage) & " %")
  GUICtrlSetData($Progress1, $Percentage)
  If $o_Percentage >= 100 Then
   _SendMessage(GUICtrlGetHandle($Progress1), $PBM_SETSTATE, 1) ; green
  EndIf
  If $o_Percentage >= 66 and $Percentage < 66 Then
   _SendMessage(GUICtrlGetHandle($Progress1), $PBM_SETSTATE, 3) ; yellow
   _WinAPI_FlashWindowEx($Form1, 3, 3, 200)
  EndIf
  If $o_Percentage >= 33 and $Percentage < 33 Then
   _SendMessage(GUICtrlGetHandle($Progress1), $PBM_SETSTATE, 2) ; red
   _WinAPI_FlashWindowEx($Form1, 3, 3, 100)
  EndIf
  $o_Percentage = $Percentage
EndIf
WEnd

Func _SendMessage($hWnd, $iMsg, $wParam = 0, $lParam = 0, $iReturn = 0, $wParamType = "wparam", $lParamType = "lparam", $sReturnType = "lresult")
Local $aResult = DllCall("user32.dll", $sReturnType, "SendMessageW", "hwnd", $hWnd, "uint", $iMsg, $wParamType, $wParam, $lParamType, $lParam)
If @error Then Return SetError(@error, @extended, "")
If $iReturn >= 0 And $iReturn <= 4 Then Return $aResult[$iReturn]
Return $aResult
EndFunc   ;==>_SendMessage
; #FUNCTION# ====================================================================================================================
; Name...........: _WinAPI_FlashWindowEx
; Description ...: Flashes the specified window
; Syntax.........: _WinAPI_FlashWindowEx($hWnd[, $iFlags = 3[, $iCount = 3[, $iTimeout = 0]]])
; Parameters ....: $hWnd        - Handle to the window to be flashed. The window can be either open or minimized.
;                 $iFlags     - The flash status. Can be one or more of the following values:
;                 |0 - Stop flashing. The system restores the window to its original state.
;                 |1 - Flash the window caption
;                 |2 - Flash the taskbar button
;                 |4 - Flash continuously until stopped
;                 |8 - Flash continuously until the window comes to the foreground
;                 $iCount     - The number of times to flash the window
;                 $iTimeout - The rate at which the window is to be flashed, in  milliseconds.  If 0, the function  uses  the
;                 +default cursor blink rate.
; Return values .: Success    - True
;                 Failure     - False
; Author ........: Yoan Roblet (arcker)
; Modified.......:
; Remarks .......: Typically, you flash a window to inform the user that the window requires attention  but  does  not  currently
;                 have the keyboard focus.  When a window flashes, it appears to change  from  inactive  to  active  status.  An
;                 inactive caption bar changes to an active caption bar; an active caption bar changes to  an  inactive  caption
;                 bar.
; Related .......: _WinAPI_FlashWindow
; Link ..........: @@MsdnLink@@ FlashWindowEx
; Example .......: Yes
; ===============================================================================================================================
Func _WinAPI_FlashWindowEx($hWnd, $iFlags = 3, $iCount = 3, $iTimeout = 0)
Local $tFlash = DllStructCreate($tagFLASHWINFO)
Local $pFlash = DllStructGetPtr($tFlash)
Local $iFlash = DllStructGetSize($tFlash)
Local $iMode = 0
If BitAND($iFlags, 1) <> 0 Then $iMode = BitOR($iMode, $__WINAPICONSTANT_FLASHW_CAPTION)
If BitAND($iFlags, 2) <> 0 Then $iMode = BitOR($iMode, $__WINAPICONSTANT_FLASHW_TRAY)
If BitAND($iFlags, 4) <> 0 Then $iMode = BitOR($iMode, $__WINAPICONSTANT_FLASHW_TIMER)
If BitAND($iFlags, 8) <> 0 Then $iMode = BitOR($iMode, $__WINAPICONSTANT_FLASHW_TIMERNOFG)
DllStructSetData($tFlash, "Size", $iFlash)
DllStructSetData($tFlash, "hWnd", $hWnd)
DllStructSetData($tFlash, "Flags", $iMode)
DllStructSetData($tFlash, "Count", $iCount)
DllStructSetData($tFlash, "Timeout", $iTimeout)
Local $aResult = DllCall("user32.dll", "bool", "FlashWindowEx", "ptr", $pFlash)
If @error Then Return SetError(@error, @extended, False)
Return $aResult[0]
EndFunc   ;==>_WinAPI_FlashWindowEx