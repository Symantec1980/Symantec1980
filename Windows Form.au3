#cs ----------------------------------------------------------------------------
 AutoIt Version: 3.3.14.5
 Author:         myName
 Script Function:
	Template AutoIt script.
#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

GUICreate("Practica",800,800)
GUICtrlCreateButton("Press ME",100,100,300,100)
GUISetState(@SW_SHOW)

While 1
   $nMsg = GUIGetMsg()
   Switch $nMsg
	  Case $GUI_EVENT_CLOSE
	  Exit

	  EndSwitch
	  Wend