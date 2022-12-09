;Idea taken from http://js1k.com/demo/528
;Ported to AutoIt by UEZ Build 2010-09-20
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/sf /sv /om /cs=0 /cn=0
#AutoIt3Wrapper_Run_After=del /f /q "Im- Exploding Particle Logo_Obfuscated.au3"
#AutoIt3Wrapper_Run_After=upx.exe --ultra-brute "%out%"
;~ #AutoIt3Wrapper_Run_After=upx.exe --best "%out%"
#region
Local Const $GDIP_ILMREAD = 0x0001
Local Const $GDIP_PXF32RGB = 0x00022009
Local Const $GDIP_PXF32ARGB = 0x0026200A
Local Const $tagRECT = "long Left;long Top;long Right;long Bottom"
Local Const $tagGDIPBITMAPDATA = "uint Width;uint Height;int Stride;int Format;ptr Scan0;uint_ptr Reserved"
Local Const $tagGDIPRECTF = "float X;float Y;float Width;float Height"
Local Const $tagGDIPSTARTUPINPUT = "uint Version;ptr Callback;bool NoThread;bool NoCodecs"
Local Const $HGDI_ERROR = Ptr(-1)
Local Const $INVALID_HANDLE_VALUE = Ptr(-1)
Local Const $KF_EXTENDED = 0x0100
Local Const $KF_ALTDOWN = 0x2000
Local Const $KF_UP = 0x8000
Local Const $LLKHF_EXTENDED = BitShift($KF_EXTENDED, 8)
Local Const $LLKHF_ALTDOWN = BitShift($KF_ALTDOWN, 8)
Local Const $LLKHF_UP = BitShift($KF_UP, 8)
Local $ghGDIPBrush = 0
Local $ghGDIPDll = 0
Local $ghGDIPPen = 0
Local $giGDIPRef = 0
Local $giGDIPToken = 0
Local Const $tagGDIPPATHDATA = "int Count;" & "ptr Points;" & "ptr Types;"
Local Const $GDIP_PI = 4 * ATan(1)
Local Const $DTT_TEXTCOLOR = 0x00000001
Local Const $DTT_BORDERCOLOR = 0x00000002
Local Const $DTT_SHADOWCOLOR = 0x00000004
Local Const $DTT_SHADOWTYPE = 0x00000008
Local Const $DTT_SHADOWOFFSET = 0x00000010
Local Const $DTT_BORDERSIZE = 0x00000020
Local Const $DTT_FONTPROP = 0x00000040
Local Const $DTT_COLORPROP = 0x00000080
Local Const $DTT_STATEID = 0x00000100
Local Const $DTT_CALCRECT = 0x00000200
Local Const $DTT_APPLYOVERLAY = 0x00000400
Local Const $DTT_GLOWSIZE = 0x00000800
Local Const $DTT_COMPOSITED = 0x00002000
Local Const $DTT_VALIDBITS = BitOR($DTT_TEXTCOLOR, $DTT_BORDERCOLOR, $DTT_SHADOWCOLOR, $DTT_SHADOWTYPE, $DTT_SHADOWOFFSET, $DTT_BORDERSIZE, $DTT_FONTPROP, $DTT_COLORPROP, $DTT_STATEID, $DTT_CALCRECT, $DTT_APPLYOVERLAY, $DTT_GLOWSIZE, $DTT_COMPOSITED)
Local Enum $QualityModeInvalid = -1, $QualityModeDefault = 0, $QualityModeLow = 1, $QualityModeHigh = 2
Local Enum $HatchStyleHorizontal, $HatchStyleVertical, $HatchStyleForwardDiagonal, $HatchStyleBackwardDiagonal, $HatchStyleCross, $HatchStyleDiagonalCross, $HatchStyle05Percent, $HatchStyle10Percent, $HatchStyle20Percent, $HatchStyle25Percent, $HatchStyle30Percent, $HatchStyle40Percent, $HatchStyle50Percent, $HatchStyle60Percent, $HatchStyle70Percent, $HatchStyle75Percent, $HatchStyle80Percent, $HatchStyle90Percent, $HatchStyleLightDownwardDiagonal, $HatchStyleLightUpwardDiagonal, $HatchStyleDarkDownwardDiagonal, $HatchStyleDarkUpwardDiagonal, $HatchStyleWideDownwardDiagonal, $HatchStyleWideUpwardDiagonal, $HatchStyleLightVertical, $HatchStyleLightHorizontal, $HatchStyleNarrowVertical, $HatchStyleNarrowHorizontal, $HatchStyleDarkVertical, $HatchStyleDarkHorizontal, $HatchStyleDashedDownwardDiagonal, $HatchStyleDashedUpwardDiagonal, $HatchStyleDashedHorizontal, $HatchStyleDashedVertical, $HatchStyleSmallConfetti, $HatchStyleLargeConfetti, $HatchStyleZigZag, $HatchStyleWave, $HatchStyleDiagonalBrick, $HatchStyleHorizontalBrick, $HatchStyleWeave, $HatchStylePlaid, $HatchStyleDivot, $HatchStyleDottedGrid, $HatchStyleDottedDiamond, $HatchStyleShingle, $HatchStyleTrellis, $HatchStyleSphere, $HatchStyleSmallGrid, $HatchStyleSmallCheckerBoard, $HatchStyleLargeCheckerBoard, $HatchStyleOutlinedDiamond, $HatchStyleSolidDiamond, $HatchStyleTotal, $HatchStyleLargeGrid = $HatchStyleCross, $HatchStyleMin = $HatchStyleHorizontal, $HatchStyleMax = $HatchStyleTotal - 1
Local Enum $SmoothingModeInvalid = $QualityModeInvalid, $SmoothingModeDefault = $QualityModeDefault, $SmoothingModeHighSpeed = $QualityModeLow, $SmoothingModeHighQuality = $QualityModeHigh, $SmoothingModeNone, $SmoothingModeAntiAlias, $SmoothingModeAntiAlias8x4 = $SmoothingModeAntiAlias, $SmoothingModeAntiAlias8x8
Local Enum $ObjectTypeInvalid, $ObjectTypeBrush, $ObjectTypePen, $ObjectTypePath, $ObjectTypeRegion, $ObjectTypeImage, $ObjectTypeFont, $ObjectTypeStringFormat, $ObjectTypeImageAttributes, $ObjectTypeCustomLineCap, $ObjectTypeGraphics, $ObjectTypeMax = $ObjectTypeGraphics, $ObjectTypeMin = $ObjectTypeBrush
Local $GDIP_STATUS = 0
Local $GDIP_ERROR = 0
Local Const $GUI_EVENT_CLOSE = -3
Local Const $WS_MINIMIZEBOX = 0x00020000
Local Const $WS_SYSMENU = 0x00080000
Local Const $WS_CAPTION = 0x00C00000
Local Const $WS_POPUP = 0x80000000
Local Const $GUI_SS_DEFAULT_GUI = BitOR($WS_MINIMIZEBOX, $WS_CAPTION, $WS_POPUP, $WS_SYSMENU)
#endregion

Opt('GUIOnEventMode', 1)

Local $iWidth = 900;Floor(@DesktopWidth * 0.75)
Local $iHeight = 600;Floor(@DesktopHeight * 0.75)
Local $fps
_GDIPlus_Startup()

Local $GUI_title = "Im- Exploding Particle Logo by UEZ 2010 / "
Local $hGui = GUICreate($GUI_title, $iWidth, $iHeight)
GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")

Local $hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGui)
Local $hBitmap = _GDIPlus_BitmapCreateFromGraphics($iWidth, $iHeight, $hGraphics)
Local $hBuffer = _GDIPlus_ImageGetGraphicsContext($hBitmap)
Local $hBrush = _GDIPlus_BrushCreateSolid(0xE0FFFFFF)
Local $hBrush_Linear = _GDIPlus_LineBrushCreate(0, 0, 0, $iHeight, 0xFF000000, 0x80331144, 0x00)
Local $fSize = 120
$aText = Gen_Pixel_Coordinates($hGraphics, "UEZ;-)", 5, $fSize, 1)
Local $particles = (UBound($aText) - 6) / 8
Local $pixel_size = 1 + Floor($aText[0] / 64)
GUISetState(@SW_SHOW)


Local $r, $speed, $v, $x, $y, $t
Local $w = 512, $h = 384

Local $W2 = $iWidth / 2 - $aText[0]
Local $H2 = $iHeight / 2 - $aText[1]

Local $i = 0, $z = $w / 2
Local $k = $z, $m = $z

Local $scroller_txt = "♪♫♪ Ported to Autoit by UEZ in 09/2010!  Thanks to Guy Frost / DESiRE for the original JavaScript code! ♪♫♪ "
Local $scroller_fsize = 50
Local $scroller_txt_lenght = StringLen($scroller_txt) * $scroller_fsize / 1.8
Local $scroller_font = "Impact"
Local $scroller_speed = 2
Local $scroller_y = $iHeight - 1.6 * $scroller_fsize

Local $b = $iWidth
AdlibRegister("FPS", 1000)

While 1
	If Not (BitAND($i, 0xFF)) Then
		For $e = 2 To UBound($aText) - 1 Step 4
			$r = Random(0, 1) * $w - $z
			$s = Random(0, 1) * $w - $z
			If BitAND($e, 4) Then
				$t = $k
			Else
				$t = $m
			EndIf
			$aText[$e + 1] = $t - $aText[$e] - $r - $s
			$aText[$e + 2] = $r
			$aText[$e + 3] = $s
		Next
		If Not $i Then
			$m = Random(0, 1) * $w
			$k = Random(0, 1) * $h
		EndIf
	EndIf
	_GDIPlus_GraphicsFillRect($hBuffer, 0, 0, $iWidth, $iHeight, $hBrush_Linear)

	_GDIPlus_GraphicsDrawString($hBuffer, $scroller_txt, $b, $scroller_y, $scroller_font, $scroller_fsize)
	$b -= $scroller_speed
	If $b < -$scroller_txt_lenght Then $b = $iWidth + 1

	If $i < $z Then
		$p = 1 - $i / $z
	Else
		$p = ($i - $z) / $z
	EndIf
	$p *= $p
	For $e = 2 To UBound($aText) - 5 Step 8
		$v = $p * $p
		$x = $aText[$e] + $aText[$e + 1] * $p + $aText[$e + 2] * $v + $aText[$e + 3] * $v * $p
		$y = $aText[$e + 4] + $aText[$e + 5] * $p + $aText[$e + 6] * $v + $aText[$e + 7] * $v * $p
		If $e < UBound($aText) / 2 Then
			_GDIPlus_BrushSetSolidColor($hBrush, 0xC0AACC00)
		Else
			_GDIPlus_BrushSetSolidColor($hBrush, 0xC0EEFF22)
		EndIf
		_GDIPlus_GraphicsFillRect($hBuffer, $W2 + $x, $H2 + $y, $pixel_size, $pixel_size, $hBrush)
	Next
	$i += 1
	$i = Mod($i, $w)
	_GDIPlus_GraphicsDrawImageRect($hGraphics, $hBitmap, 0, 0, $iWidth, $iHeight)
	$fps += 1
WEnd


Func Gen_Pixel_Coordinates($hGraphics, $text, $details = 3, $fSize = 40, $fStyle = 0, $fFamily = "Comic Sans MS")
	Local $aCoords
	If $details < 1 Then $details = 3
	If $fStyle < -1 Or $fStyle > 15 Then $fStyle = 0
	Local $x, $y
	Local $iWidth = 2.5 * $fSize, $iHeight = $fSize * 1.05

	Local $hFormat = _GDIPlus_StringFormatCreate()
	Local $hFamily = _GDIPlus_FontFamilyCreate($fFamily)
	Local $hFont = _GDIPlus_FontCreate($hFamily, $fSize, $fStyle, 2)
	Local $tLayout = _GDIPlus_RectFCreate(0, 0, 0, 0)
	Local $aInfo = _GDIPlus_GraphicsMeasureString($hGraphics, $text, $hFont, $tLayout, $hFormat)

	Local $iW = Floor(DllStructGetData($aInfo[0], "Width"))
	Local $iH = Floor(DllStructGetData($aInfo[0], "Height"))
	Local $hBitmap = _GDIPlus_BitmapCreateFromGraphics($iW, $iH, $hGraphics)
	Local $hBuffer = _GDIPlus_ImageGetGraphicsContext($hBitmap)
	_GDIPlus_GraphicsClear($hBuffer, 0xFFFFFFFF)

	If $fStyle > -1 Then
		Local $hBrush = _GDIPlus_BrushCreateSolid(0xFF000000)
		_GDIPlus_GraphicsDrawStringEx($hBuffer, $text, $hFont, $aInfo[0], $hFormat, $hBrush)
		_GDIPlus_BrushDispose($hBrush)
	Else ;generate outlined font
		Local $hPath = _GDIPlus_PathCreate()
		_GDIPlus_PathAddString($hPath, $text, $tLayout, $hFamily, 0, $fSize, $hFormat)
		$aCoords = _GDIPlus_PathGetData($hPath)
		Local $hPen = _GDIPlus_PenCreate(0xFF000000)
		$aCoords = _GDIPlus_PathGetData($hPath)
		_GDIPlus_GraphicsDrawPath($hBuffer, $hPath, $hPen)
		_GDIPlus_PathDispose($hPath)
		_GDIPlus_PenDispose($hPen)
	EndIf
	_GDIPlus_FontDispose($hFont)
	_GDIPlus_FontFamilyDispose($hFamily)
	_GDIPlus_StringFormatDispose($hFormat)

	Local $PixelData, $color
	Local $BitmapData = _GDIPlus_BitmapLockBits($hBitmap, 0, 0, $iW, $iH, $GDIP_ILMREAD, $GDIP_PXF32ARGB)
	Local $Stride = DllStructGetData($BitmapData, "Stride")
	Local $Width = DllStructGetData($BitmapData, "Width")
	Local $Height = DllStructGetData($BitmapData, "Height")
	Local $Scan0 = DllStructGetData($BitmapData, "Scan0")
	Local $aCoords[7]
	Local $z = 2
	For $y = 0 To $iH - 1 Step $details
		For $x = 0 To $iW - 1 Step $details
			$PixelData = DllStructCreate("dword", $Scan0 + ($y * $Stride) + ($x * 4))
			$color = DllStructGetData($PixelData, 1)
			If Hex($color) <> "FFFFFFFF" Then
				$aCoords[$z] = 2 * $x
				$aCoords[$z + 4] = 2 * $y
				$z += 8
				ReDim $aCoords[$z + 5]
			EndIf
		Next
	Next
	ReDim $aCoords[$z - 4]
	$aCoords[0] = $iW
	$aCoords[1] = $iH
;~ 	_ArrayDisplay($aCoords)
	_GDIPlus_BitmapUnlockBits($hBitmap, $BitmapData)
	$PixelData = 0
	_GDIPlus_BitmapDispose($hBitmap)
	_GDIPlus_GraphicsDispose($hBuffer)
	Return $aCoords
EndFunc

Func _Exit()
	AdlibUnRegister("FPS")
	_GDIPlus_BrushDispose($hBrush_Linear)
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_GraphicsDispose($hBuffer)
	_GDIPlus_BitmapDispose($hBitmap)
	_GDIPlus_GraphicsDispose($hGraphics)
	_GDIPlus_Shutdown()
	GUIDelete($hGui)
	Exit
EndFunc

Func FPS()
	WinSetTitle($hGUI, "", $GUI_title & "Particles: "& $particles & " / FPS: " & $fps)
	$fps = 0
EndFunc

;below are all functions and variables from needed UDFs
#region
Func _GDIPlus_BitmapCreateFromGraphics($iWidth, $iHeight, $hGraphics)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipCreateBitmapFromGraphics", "int", $iWidth, "int", $iHeight, "handle", $hGraphics, _
			"ptr*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($aResult[0], $aResult[4])
EndFunc   ;==>_GDIPlus_BitmapCreateFromGraphics
Func _GDIPlus_BitmapDispose($hBitmap)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipDisposeImage", "handle", $hBitmap)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_BitmapDispose
Func _GDIPlus_BitmapLockBits($hBitmap, $iLeft, $iTop, $iWidth, $iHeight, $iFlags = $GDIP_ILMREAD, $iFormat = $GDIP_PXF32RGB)
	Local $tData = DllStructCreate($tagGDIPBITMAPDATA)
	Local $pData = DllStructGetPtr($tData)
	Local $tRect = DllStructCreate($tagRECT)
	Local $pRect = DllStructGetPtr($tRect)
	DllStructSetData($tRect, "Left", $iLeft)
	DllStructSetData($tRect, "Top", $iTop)
	DllStructSetData($tRect, "Right", $iWidth)
	DllStructSetData($tRect, "Bottom", $iHeight)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipBitmapLockBits", "handle", $hBitmap, "ptr", $pRect, "uint", $iFlags, "int", $iFormat, "ptr", $pData)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($aResult[0], $tData)
EndFunc   ;==>_GDIPlus_BitmapLockBits
Func _GDIPlus_BitmapUnlockBits($hBitmap, $tBitmapData)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipBitmapUnlockBits", "handle", $hBitmap, "ptr", DllStructGetPtr($tBitmapData))
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_BitmapUnlockBits
Func _GDIPlus_BrushCreateSolid($iARGB = 0xFF000000)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipCreateSolidFill", "int", $iARGB, "dword*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($aResult[0], $aResult[2])
EndFunc   ;==>_GDIPlus_BrushCreateSolid
Func _GDIPlus_BrushDispose($hBrush)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipDeleteBrush", "handle", $hBrush)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_BrushDispose
Func _GDIPlus_BrushSetSolidColor($hBrush, $iARGB = 0xFF000000)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipSetSolidFillColor", "handle", $hBrush, "dword", $iARGB)
	If @error Then Return SetError(@error, @extended, 0)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_BrushSetSolidColor
Func _GDIPlus_FontCreate($hFamily, $fSize, $iStyle = 0, $iUnit = 3)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipCreateFont", "handle", $hFamily, "float", $fSize, "int", $iStyle, "int", $iUnit, "ptr*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($aResult[0], $aResult[5])
EndFunc   ;==>_GDIPlus_FontCreate
Func _GDIPlus_FontDispose($hFont)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipDeleteFont", "handle", $hFont)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_FontDispose
Func _GDIPlus_FontFamilyCreate($sFamily)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipCreateFontFamilyFromName", "wstr", $sFamily, "ptr", 0, "handle*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($aResult[0], $aResult[3])
EndFunc   ;==>_GDIPlus_FontFamilyCreate
Func _GDIPlus_FontFamilyDispose($hFamily)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipDeleteFontFamily", "handle", $hFamily)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_FontFamilyDispose
Func _GDIPlus_GraphicsClear($hGraphics, $iARGB = 0xFF000000)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipGraphicsClear", "handle", $hGraphics, "dword", $iARGB)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsClear
Func _GDIPlus_GraphicsCreateFromHWND($hWnd)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipCreateFromHWND", "hwnd", $hWnd, "ptr*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($aResult[0], $aResult[2])
EndFunc   ;==>_GDIPlus_GraphicsCreateFromHWND
Func _GDIPlus_GraphicsDispose($hGraphics)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipDeleteGraphics", "handle", $hGraphics)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsDispose
Func _GDIPlus_GraphicsDrawImageRect($hGraphics, $hImage, $iX, $iY, $iW, $iH)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipDrawImageRectI", "handle", $hGraphics, "handle", $hImage, "int", $iX, "int", $iY, _
			"int", $iW, "int", $iH)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsDrawImageRect
Func _GDIPlus_GraphicsDrawString($hGraphics, $sString, $nX, $nY, $sFont = "Arial", $nSize = 10, $iFormat = 0)
	Local $hBrush = _GDIPlus_BrushCreateSolid()
	Local $hFormat = _GDIPlus_StringFormatCreate($iFormat)
	Local $hFamily = _GDIPlus_FontFamilyCreate($sFont)
	Local $hFont = _GDIPlus_FontCreate($hFamily, $nSize)
	Local $tLayout = _GDIPlus_RectFCreate($nX, $nY, 0, 0)
	Local $aInfo = _GDIPlus_GraphicsMeasureString($hGraphics, $sString, $hFont, $tLayout, $hFormat)
	Local $aResult = _GDIPlus_GraphicsDrawStringEx($hGraphics, $sString, $hFont, $aInfo[0], $hFormat, $hBrush)
	Local $iError = @error
	_GDIPlus_FontDispose($hFont)
	_GDIPlus_FontFamilyDispose($hFamily)
	_GDIPlus_StringFormatDispose($hFormat)
	_GDIPlus_BrushDispose($hBrush)
	Return SetError($iError, 0, $aResult)
EndFunc   ;==>_GDIPlus_GraphicsDrawString
Func _GDIPlus_GraphicsDrawStringEx($hGraphics, $sString, $hFont, $tLayout, $hFormat, $hBrush)
	Local $pLayout = DllStructGetPtr($tLayout)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipDrawString", "handle", $hGraphics, "wstr", $sString, "int", -1, "handle", $hFont, _
			"ptr", $pLayout, "handle", $hFormat, "handle", $hBrush)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsDrawStringEx
Func _GDIPlus_GraphicsFillRect($hGraphics, $iX, $iY, $iWidth, $iHeight, $hBrush = 0)
	__GDIPlus_BrushDefCreate($hBrush)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipFillRectangleI", "handle", $hGraphics, "handle", $hBrush, "int", $iX, "int", $iY, _
			"int", $iWidth, "int", $iHeight)
	Local $tmpError = @error, $tmpExtended = @extended
	__GDIPlus_BrushDefDispose()
	If $tmpError Then Return SetError($tmpError, $tmpExtended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsFillRect
Func _GDIPlus_GraphicsMeasureString($hGraphics, $sString, $hFont, $tLayout, $hFormat)
	Local $pLayout = DllStructGetPtr($tLayout)
	Local $tRectF = DllStructCreate($tagGDIPRECTF)
	Local $pRectF = DllStructGetPtr($tRectF)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipMeasureString", "handle", $hGraphics, "wstr", $sString, "int", -1, "handle", $hFont, _
			"ptr", $pLayout, "handle", $hFormat, "ptr", $pRectF, "int*", 0, "int*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Local $aInfo[3]
	$aInfo[0] = $tRectF
	$aInfo[1] = $aResult[8]
	$aInfo[2] = $aResult[9]
	Return SetExtended($aResult[0], $aInfo)
EndFunc   ;==>_GDIPlus_GraphicsMeasureString
Func _GDIPlus_ImageGetGraphicsContext($hImage)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipGetImageGraphicsContext", "handle", $hImage, "ptr*", 0)
	If @error Then Return SetError(@error, @extended, -1)
	Return SetExtended($aResult[0], $aResult[2])
EndFunc   ;==>_GDIPlus_ImageGetGraphicsContext
Func _GDIPlus_PenCreate($iARGB = 0xFF000000, $fWidth = 1, $iUnit = 2)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipCreatePen1", "dword", $iARGB, "float", $fWidth, "int", $iUnit, "ptr*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($aResult[0], $aResult[4])
EndFunc   ;==>_GDIPlus_PenCreate
Func _GDIPlus_PenDispose($hPen)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipDeletePen", "handle", $hPen)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_PenDispose
Func _GDIPlus_RectFCreate($nX = 0, $nY = 0, $nWidth = 0, $nHeight = 0)
	Local $tRectF = DllStructCreate($tagGDIPRECTF)
	DllStructSetData($tRectF, "X", $nX)
	DllStructSetData($tRectF, "Y", $nY)
	DllStructSetData($tRectF, "Width", $nWidth)
	DllStructSetData($tRectF, "Height", $nHeight)
	Return $tRectF
EndFunc   ;==>_GDIPlus_RectFCreate
Func _GDIPlus_Shutdown()
	If $ghGDIPDll = 0 Then Return SetError(-1, -1, False)
	$giGDIPRef -= 1
	If $giGDIPRef = 0 Then
		DllCall($ghGDIPDll, "none", "GdiplusShutdown", "ptr", $giGDIPToken)
		DllClose($ghGDIPDll)
		$ghGDIPDll = 0
	EndIf
	Return True
EndFunc   ;==>_GDIPlus_Shutdown
Func _GDIPlus_Startup()
	$giGDIPRef += 1
	If $giGDIPRef > 1 Then Return True
	$ghGDIPDll = DllOpen("GDIPlus.dll")
	If $ghGDIPDll = -1 Then Return SetError(1, 2, False)
	Local $tInput = DllStructCreate($tagGDIPSTARTUPINPUT)
	Local $pInput = DllStructGetPtr($tInput)
	Local $tToken = DllStructCreate("ulong_ptr Data")
	Local $pToken = DllStructGetPtr($tToken)
	DllStructSetData($tInput, "Version", 1)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdiplusStartup", "ptr", $pToken, "ptr", $pInput, "ptr", 0)
	If @error Then Return SetError(@error, @extended, False)
	$giGDIPToken = DllStructGetData($tToken, "Data")
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_Startup
Func _GDIPlus_StringFormatCreate($iFormat = 0, $iLangID = 0)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipCreateStringFormat", "int", $iFormat, "word", $iLangID, "ptr*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($aResult[0], $aResult[3])
EndFunc   ;==>_GDIPlus_StringFormatCreate
Func _GDIPlus_StringFormatDispose($hFormat)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipDeleteStringFormat", "handle", $hFormat)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_StringFormatDispose
Func __GDIPlus_BrushDefCreate(ByRef $hBrush)
	If $hBrush = 0 Then
		$ghGDIPBrush = _GDIPlus_BrushCreateSolid()
		$hBrush = $ghGDIPBrush
	EndIf
EndFunc   ;==>__GDIPlus_BrushDefCreate
Func __GDIPlus_BrushDefDispose()
	If $ghGDIPBrush <> 0 Then
		_GDIPlus_BrushDispose($ghGDIPBrush)
		$ghGDIPBrush = 0
	EndIf
EndFunc   ;==>__GDIPlus_BrushDefDispose
Func __GDIPlus_PenDefCreate(ByRef $hPen)
	If $hPen = 0 Then
		$ghGDIPPen = _GDIPlus_PenCreate()
		$hPen = $ghGDIPPen
	EndIf
EndFunc   ;==>__GDIPlus_PenDefCreate
Func __GDIPlus_PenDefDispose()
	If $ghGDIPPen <> 0 Then
		_GDIPlus_PenDispose($ghGDIPPen)
		$ghGDIPPen = 0
	EndIf
EndFunc   ;==>__GDIPlus_PenDefDispose
Func _GDIPlus_GraphicsDrawPath($hGraphics, $hPath, $hPen = 0)
	Local $iTmpErr, $iTmpExt, $aResult
	__GDIPlus_PenDefCreate($hPen)
	$aResult = DllCall($ghGDIPDll, "uint", "GdipDrawPath", "hwnd", $hGraphics, "hwnd", $hPen, "hwnd", $hPath)
	$iTmpErr = @error
	$iTmpExt = @extended
	__GDIPlus_PenDefDispose()
	If $iTmpErr Then Return SetError($iTmpErr, $iTmpExt, False)
	$GDIP_STATUS = $aResult[0]
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsDrawPath
Func _GDIPlus_PathAddString($hPath, $sString, $tLayout, $hFamily = 0, $iStyle = 0, $nSize = 8.5, $hFormat = 0)
	Local $pLayout, $aResult
	$pLayout = DllStructGetPtr($tLayout)
	$aResult = DllCall($ghGDIPDll, "uint", "GdipAddPathString", "hwnd", $hPath, "wstr", $sString, "int", -1, "hwnd", $hFamily, "int", $iStyle, "float", $nSize, "ptr", $pLayout, "hwnd", $hFormat)
	If @error Then Return SetError(@error, @extended, False)
	$GDIP_STATUS = $aResult[0]
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_PathAddString
Func _GDIPlus_PathCreate($iFillMode = 0)
	Local $aResult = DllCall($ghGDIPDll, "uint", "GdipCreatePath", "int", $iFillMode, "int*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	$GDIP_STATUS = $aResult[0]
	Return $aResult[2]
EndFunc   ;==>_GDIPlus_PathCreate
Func _GDIPlus_PathDispose($hPath)
	Local $aResult = DllCall($ghGDIPDll, "uint", "GdipDeletePath", "hwnd", $hPath)
	If @error Then Return SetError(@error, @extended, False)
	$GDIP_STATUS = $aResult[0]
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_PathDispose
Func _GDIPlus_PathGetData($hPath)
	Local $iI, $iCount, $pPoints, $tPoints, $pTypes, $tTypes, $pPathData, $tPathData, $aPtTypes[1][1], $aResult
	$iCount = _GDIPlus_PathGetPointCount($hPath)
	If @error Then Return SetError(@error, @extended, 0)
	If $GDIP_STATUS Then
		$GDIP_ERROR = 1
		Return -1
	ElseIf $iCount = 0 Then
		$GDIP_ERROR = 2
		Return -1
	EndIf
	$tPathData = DllStructCreate($tagGDIPPATHDATA)
	$pPathData = DllStructGetPtr($tPathData)
	$tPoints = DllStructCreate("float[" & $iCount * 2 & "]")
	$pPoints = DllStructGetPtr($tPoints)
	$tTypes = DllStructCreate("ubyte[" & $iCount & "]")
	$pTypes = DllStructGetPtr($tTypes)
	DllStructSetData($tPathData, "Count", $iCount)
	DllStructSetData($tPathData, "Points", $pPoints)
	DllStructSetData($tPathData, "Types", $pTypes)
	$aResult = DllCall($ghGDIPDll, "uint", "GdipGetPathData", "hwnd", $hPath, "ptr", $pPathData)
	If @error Then Return SetError(@error, @extended, 0)
	$GDIP_STATUS = $aResult[0]
	If $GDIP_STATUS Then
		$GDIP_ERROR = 3
		Return -1
	EndIf
	ReDim $aPtTypes[$iCount + 1][3]
	$aPtTypes[0][0] = $iCount
	For $iI = 1 To $iCount
		$aPtTypes[$iI][0] = DllStructGetData($tPoints, 1, (($iI - 1) * 2) + 1)
		$aPtTypes[$iI][1] = DllStructGetData($tPoints, 1, (($iI - 1) * 2) + 2)
		$aPtTypes[$iI][2] = DllStructGetData($tTypes, 1, $iI)
	Next
	Return $aPtTypes
EndFunc   ;==>_GDIPlus_PathGetData
Func _GDIPlus_PathGetPointCount($hPath)
	Local $aResult = DllCall($ghGDIPDll, "uint", "GdipGetPointCount", "hwnd", $hPath, "int*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	$GDIP_STATUS = $aResult[0]
	Return $aResult[2]
EndFunc   ;==>_GDIPlus_PathGetPointCount
Func _GDIPlus_LineBrushCreate($nX1, $nY1, $nX2, $nY2, $iARGBClr1, $iARGBClr2, $iWrapMode = 0)
	Local $tPointF1, $pPointF1
	Local $tPointF2, $pPointF2
	Local $aResult
	$tPointF1 = DllStructCreate("float;float")
	$pPointF1 = DllStructGetPtr($tPointF1)
	$tPointF2 = DllStructCreate("float;float")
	$pPointF2 = DllStructGetPtr($tPointF2)
	DllStructSetData($tPointF1, 1, $nX1)
	DllStructSetData($tPointF1, 2, $nY1)
	DllStructSetData($tPointF2, 1, $nX2)
	DllStructSetData($tPointF2, 2, $nY2)
	$aResult = DllCall($ghGDIPDll, "uint", "GdipCreateLineBrush", "ptr", $pPointF1, "ptr", $pPointF2, "uint", $iARGBClr1, "uint", $iARGBClr2, "int", $iWrapMode, "int*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	$GDIP_STATUS = $aResult[0]
	Return $aResult[6]
EndFunc   ;==>_GDIPlus_LineBrushCreate
#endregion