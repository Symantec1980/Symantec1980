;Coded by UEZ 2010 Beta Build 2010-10-21
#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/sf /sv /om /cs=0 /cn=0
#AutoIt3Wrapper_Run_After=del /f /q "Pixel Text Effect_Obfuscated.au3"
#AutoIt3Wrapper_Run_After=upx.exe --ultra-brute "%out%"

#region include functions and variables - main script starts at line 512 ;-)
Func _ArrayReverse(ByRef $avArray, $iStart = 0, $iEnd = 0)
	If Not IsArray($avArray) Then Return SetError(1, 0, 0)
	If UBound($avArray, 0) <> 1 Then Return SetError(3, 0, 0)
	Local $vTmp, $iUBound = UBound($avArray) - 1
	If $iEnd < 1 Or $iEnd > $iUBound Then $iEnd = $iUBound
	If $iStart < 0 Then $iStart = 0
	If $iStart > $iEnd Then Return SetError(2, 0, 0)
	For $i = $iStart To Int(($iStart + $iEnd - 1) / 2)
		$vTmp = $avArray[$i]
		$avArray[$i] = $avArray[$iEnd]
		$avArray[$iEnd] = $vTmp
		$iEnd -= 1
	Next
	Return 1
EndFunc   ;==>_ArrayReverse
Func _ArraySort(ByRef $avArray, $iDescending = 0, $iStart = 0, $iEnd = 0, $iSubItem = 0)
	If Not IsArray($avArray) Then Return SetError(1, 0, 0)
	Local $iUBound = UBound($avArray) - 1
	If $iEnd < 1 Or $iEnd > $iUBound Then $iEnd = $iUBound
	If $iStart < 0 Then $iStart = 0
	If $iStart > $iEnd Then Return SetError(2, 0, 0)
	Switch UBound($avArray, 0)
		Case 1
			__ArrayQuickSort1D($avArray, $iStart, $iEnd)
			If $iDescending Then _ArrayReverse($avArray, $iStart, $iEnd)
		Case 2
			Local $iSubMax = UBound($avArray, 2) - 1
			If $iSubItem > $iSubMax Then Return SetError(3, 0, 0)
			If $iDescending Then
				$iDescending = -1
			Else
				$iDescending = 1
			EndIf
			__ArrayQuickSort2D($avArray, $iDescending, $iStart, $iEnd, $iSubItem, $iSubMax)
		Case Else
			Return SetError(4, 0, 0)
	EndSwitch
	Return 1
EndFunc   ;==>_ArraySort
Func __ArrayQuickSort1D(ByRef $avArray, ByRef $iStart, ByRef $iEnd)
	If $iEnd <= $iStart Then Return
	Local $vTmp
	If ($iEnd - $iStart) < 15 Then
		Local $vCur
		For $i = $iStart + 1 To $iEnd
			$vTmp = $avArray[$i]
			If IsNumber($vTmp) Then
				For $j = $i - 1 To $iStart Step -1
					$vCur = $avArray[$j]
					If ($vTmp >= $vCur And IsNumber($vCur)) Or (Not IsNumber($vCur) And StringCompare($vTmp, $vCur) >= 0) Then ExitLoop
					$avArray[$j + 1] = $vCur
				Next
			Else
				For $j = $i - 1 To $iStart Step -1
					If (StringCompare($vTmp, $avArray[$j]) >= 0) Then ExitLoop
					$avArray[$j + 1] = $avArray[$j]
				Next
			EndIf
			$avArray[$j + 1] = $vTmp
		Next
		Return
	EndIf
	Local $L = $iStart, $R = $iEnd, $vPivot = $avArray[Int(($iStart + $iEnd) / 2)], $fNum = IsNumber($vPivot)
	Do
		If $fNum Then
			While ($avArray[$L] < $vPivot And IsNumber($avArray[$L])) Or (Not IsNumber($avArray[$L]) And StringCompare($avArray[$L], $vPivot) < 0)
				$L += 1
			WEnd
			While ($avArray[$R] > $vPivot And IsNumber($avArray[$R])) Or (Not IsNumber($avArray[$R]) And StringCompare($avArray[$R], $vPivot) > 0)
				$R -= 1
			WEnd
		Else
			While (StringCompare($avArray[$L], $vPivot) < 0)
				$L += 1
			WEnd
			While (StringCompare($avArray[$R], $vPivot) > 0)
				$R -= 1
			WEnd
		EndIf
		If $L <= $R Then
			$vTmp = $avArray[$L]
			$avArray[$L] = $avArray[$R]
			$avArray[$R] = $vTmp
			$L += 1
			$R -= 1
		EndIf
	Until $L > $R
	__ArrayQuickSort1D($avArray, $iStart, $R)
	__ArrayQuickSort1D($avArray, $L, $iEnd)
EndFunc   ;==>__ArrayQuickSort1D
Func __ArrayQuickSort2D(ByRef $avArray, ByRef $iStep, ByRef $iStart, ByRef $iEnd, ByRef $iSubItem, ByRef $iSubMax)
	If $iEnd <= $iStart Then Return
	Local $vTmp, $L = $iStart, $R = $iEnd, $vPivot = $avArray[Int(($iStart + $iEnd) / 2)][$iSubItem], $fNum = IsNumber($vPivot)
	Do
		If $fNum Then
			While ($iStep * ($avArray[$L][$iSubItem] - $vPivot) < 0 And IsNumber($avArray[$L][$iSubItem])) Or (Not IsNumber($avArray[$L][$iSubItem]) And $iStep * StringCompare($avArray[$L][$iSubItem], $vPivot) < 0)
				$L += 1
			WEnd
			While ($iStep * ($avArray[$R][$iSubItem] - $vPivot) > 0 And IsNumber($avArray[$R][$iSubItem])) Or (Not IsNumber($avArray[$R][$iSubItem]) And $iStep * StringCompare($avArray[$R][$iSubItem], $vPivot) > 0)
				$R -= 1
			WEnd
		Else
			While ($iStep * StringCompare($avArray[$L][$iSubItem], $vPivot) < 0)
				$L += 1
			WEnd
			While ($iStep * StringCompare($avArray[$R][$iSubItem], $vPivot) > 0)
				$R -= 1
			WEnd
		EndIf
		If $L <= $R Then
			For $i = 0 To $iSubMax
				$vTmp = $avArray[$L][$i]
				$avArray[$L][$i] = $avArray[$R][$i]
				$avArray[$R][$i] = $vTmp
			Next
			$L += 1
			$R -= 1
		EndIf
	Until $L > $R
	__ArrayQuickSort2D($avArray, $iStep, $iStart, $R, $iSubItem, $iSubMax)
	__ArrayQuickSort2D($avArray, $iStep, $L, $iEnd, $iSubItem, $iSubMax)
EndFunc   ;==>__ArrayQuickSort2D
Func _ColorSetRGB($aColor, $curExt = @extended)
	If UBound($aColor) <> 3 Then Return SetError(1, 0, -1)
	Local $nColor = 0, $iColor
	For $i = 0 To 2
		$nColor = BitShift($nColor, -8)
		$iColor = $aColor[$i]
		If $iColor < 0 Or $iColor > 255 Then Return SetError(2, 0, -1)
		$nColor += $iColor
	Next
	Return SetExtended($curExt, $nColor)
EndFunc   ;==>_ColorSetRGB
Global Const $GDIP_ILMREAD = 0x0001
Global Const $GDIP_PXF32RGB = 0x00022009
Global Const $GDIP_PXF32ARGB = 0x0026200A
Global Const $tagRECT = "long Left;long Top;long Right;long Bottom"
Global Const $tagGDIPBITMAPDATA = "uint Width;uint Height;int Stride;int Format;ptr Scan0;uint_ptr Reserved"
Global Const $tagGDIPRECTF = "float X;float Y;float Width;float Height"
Global Const $tagGDIPSTARTUPINPUT = "uint Version;ptr Callback;bool NoThread;bool NoCodecs"
Global Const $HGDI_ERROR = Ptr(-1)
Global Const $INVALID_HANDLE_VALUE = Ptr(-1)
Global Const $KF_EXTENDED = 0x0100
Global Const $KF_ALTDOWN = 0x2000
Global Const $KF_UP = 0x8000
Global Const $LLKHF_EXTENDED = BitShift($KF_EXTENDED, 8)
Global Const $LLKHF_ALTDOWN = BitShift($KF_ALTDOWN, 8)
Global Const $LLKHF_UP = BitShift($KF_UP, 8)
Global $ghGDIPBrush = 0
Global $ghGDIPDll = 0
Global $ghGDIPPen = 0
Global $giGDIPRef = 0
Global $giGDIPToken = 0
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
Func _GDIPlus_ImageDispose($hImage)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipDisposeImage", "handle", $hImage)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_ImageDispose
Func _GDIPlus_ImageGetGraphicsContext($hImage)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipGetImageGraphicsContext", "handle", $hImage, "ptr*", 0)
	If @error Then Return SetError(@error, @extended, -1)
	Return SetExtended($aResult[0], $aResult[2])
EndFunc   ;==>_GDIPlus_ImageGetGraphicsContext
Func _GDIPlus_ImageGetHeight($hImage)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipGetImageHeight", "handle", $hImage, "uint*", 0)
	If @error Then Return SetError(@error, @extended, -1)
	Return SetExtended($aResult[0], $aResult[2])
EndFunc   ;==>_GDIPlus_ImageGetHeight
Func _GDIPlus_ImageGetWidth($hImage)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipGetImageWidth", "handle", $hImage, "uint*", -1)
	If @error Then Return SetError(@error, @extended, -1)
	Return SetExtended($aResult[0], $aResult[2])
EndFunc   ;==>_GDIPlus_ImageGetWidth
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
Global Const $tagGDIPPATHDATA = "int Count;" & "ptr Points;" & "ptr Types;"
Global Const $GDIP_PI = 4 * ATan(1)
Global Const $DTT_TEXTCOLOR = 0x00000001
Global Const $DTT_BORDERCOLOR = 0x00000002
Global Const $DTT_SHADOWCOLOR = 0x00000004
Global Const $DTT_SHADOWTYPE = 0x00000008
Global Const $DTT_SHADOWOFFSET = 0x00000010
Global Const $DTT_BORDERSIZE = 0x00000020
Global Const $DTT_FONTPROP = 0x00000040
Global Const $DTT_COLORPROP = 0x00000080
Global Const $DTT_STATEID = 0x00000100
Global Const $DTT_CALCRECT = 0x00000200
Global Const $DTT_APPLYOVERLAY = 0x00000400
Global Const $DTT_GLOWSIZE = 0x00000800
Global Const $DTT_COMPOSITED = 0x00002000
Global Const $DTT_VALIDBITS = BitOR($DTT_TEXTCOLOR, $DTT_BORDERCOLOR, $DTT_SHADOWCOLOR, $DTT_SHADOWTYPE, $DTT_SHADOWOFFSET, $DTT_BORDERSIZE, $DTT_FONTPROP, $DTT_COLORPROP, $DTT_STATEID, $DTT_CALCRECT, $DTT_APPLYOVERLAY, $DTT_GLOWSIZE, $DTT_COMPOSITED)
Global Enum $QualityModeInvalid = -1, $QualityModeDefault = 0, $QualityModeLow = 1, $QualityModeHigh = 2
Global Enum $HatchStyleHorizontal, $HatchStyleVertical, $HatchStyleForwardDiagonal, $HatchStyleBackwardDiagonal, $HatchStyleCross, $HatchStyleDiagonalCross, $HatchStyle05Percent, $HatchStyle10Percent, $HatchStyle20Percent, $HatchStyle25Percent, $HatchStyle30Percent, $HatchStyle40Percent, $HatchStyle50Percent, $HatchStyle60Percent, $HatchStyle70Percent, $HatchStyle75Percent, $HatchStyle80Percent, $HatchStyle90Percent, $HatchStyleLightDownwardDiagonal, $HatchStyleLightUpwardDiagonal, $HatchStyleDarkDownwardDiagonal, $HatchStyleDarkUpwardDiagonal, $HatchStyleWideDownwardDiagonal, $HatchStyleWideUpwardDiagonal, $HatchStyleLightVertical, $HatchStyleLightHorizontal, $HatchStyleNarrowVertical, $HatchStyleNarrowHorizontal, $HatchStyleDarkVertical, $HatchStyleDarkHorizontal, $HatchStyleDashedDownwardDiagonal, $HatchStyleDashedUpwardDiagonal, $HatchStyleDashedHorizontal, $HatchStyleDashedVertical, $HatchStyleSmallConfetti, $HatchStyleLargeConfetti, $HatchStyleZigZag, $HatchStyleWave, $HatchStyleDiagonalBrick, $HatchStyleHorizontalBrick, $HatchStyleWeave, $HatchStylePlaid, $HatchStyleDivot, $HatchStyleDottedGrid, $HatchStyleDottedDiamond, $HatchStyleShingle, $HatchStyleTrellis, $HatchStyleSphere, $HatchStyleSmallGrid, $HatchStyleSmallCheckerBoard, $HatchStyleLargeCheckerBoard, $HatchStyleOutlinedDiamond, $HatchStyleSolidDiamond, $HatchStyleTotal, $HatchStyleLargeGrid = $HatchStyleCross, $HatchStyleMin = $HatchStyleHorizontal, $HatchStyleMax = $HatchStyleTotal - 1
Global Enum $SmoothingModeInvalid = $QualityModeInvalid, $SmoothingModeDefault = $QualityModeDefault, $SmoothingModeHighSpeed = $QualityModeLow, $SmoothingModeHighQuality = $QualityModeHigh, $SmoothingModeNone, $SmoothingModeAntiAlias, $SmoothingModeAntiAlias8x4 = $SmoothingModeAntiAlias, $SmoothingModeAntiAlias8x8
Global Enum $ObjectTypeInvalid, $ObjectTypeBrush, $ObjectTypePen, $ObjectTypePath, $ObjectTypeRegion, $ObjectTypeImage, $ObjectTypeFont, $ObjectTypeStringFormat, $ObjectTypeImageAttributes, $ObjectTypeCustomLineCap, $ObjectTypeGraphics, $ObjectTypeMax = $ObjectTypeGraphics, $ObjectTypeMin = $ObjectTypeBrush
Global $GDIP_STATUS = 0
Global $GDIP_ERROR = 0
Func _GDIPlus_BitmapCreateFromStream($pStream)
	Local $aResult = DllCall($ghGDIPDll, "uint", "GdipCreateBitmapFromStream", "ptr", $pStream, "int*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	$GDIP_STATUS = $aResult[0]
	Return $aResult[2]
EndFunc   ;==>_GDIPlus_BitmapCreateFromStream
Func _GDIPlus_BitmapGetPixel($hBitmap, $iX, $iY)
	Local $aResult = DllCall($ghGDIPDll, "uint", "GdipBitmapGetPixel", "hwnd", $hBitmap, "int", $iX, "int", $iY, "uint*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	$GDIP_STATUS = $aResult[0]
	Return $aResult[4]
EndFunc   ;==>_GDIPlus_BitmapGetPixel
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
Func _WinAPI_CreateStreamOnHGlobal($hGlobal = 0, $fDeleteOnRelease = True)
	Local $aResult = DllCall("ole32.dll", "int", "CreateStreamOnHGlobal", "hwnd", $hGlobal, "int", $fDeleteOnRelease, "ptr*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetError($aResult[0], 0, $aResult[3])
EndFunc   ;==>_WinAPI_CreateStreamOnHGlobal
Global Const $GUI_EVENT_CLOSE = -3
Global Const $GMEM_MOVEABLE = 0x0002
Func _MemGlobalAlloc($iBytes, $iFlags = 0)
	Local $aResult = DllCall("kernel32.dll", "handle", "GlobalAlloc", "uint", $iFlags, "ulong_ptr", $iBytes)
	If @error Then Return SetError(@error, @extended, 0)
	Return $aResult[0]
EndFunc   ;==>_MemGlobalAlloc
Func _MemGlobalLock($hMem)
	Local $aResult = DllCall("kernel32.dll", "ptr", "GlobalLock", "handle", $hMem)
	If @error Then Return SetError(@error, @extended, 0)
	Return $aResult[0]
EndFunc   ;==>_MemGlobalLock
Func _MemGlobalUnlock($hMem)
	Local $aResult = DllCall("kernel32.dll", "bool", "GlobalUnlock", "handle", $hMem)
	If @error Then Return SetError(@error, @extended, 0)
	Return $aResult[0]
EndFunc   ;==>_MemGlobalUnlock
Global Const $WS_MINIMIZEBOX = 0x00020000
Global Const $WS_SYSMENU = 0x00080000
Global Const $WS_CAPTION = 0x00C00000
Global Const $WS_POPUP = 0x80000000
Global Const $WS_EX_TOOLWINDOW = 0x00000080
Global Const $WS_EX_TOPMOST = 0x00000008
Global Const $GUI_SS_DEFAULT_GUI = BitOR($WS_MINIMIZEBOX, $WS_CAPTION, $WS_POPUP, $WS_SYSMENU)
#endregion

Opt('GUIOnEventMode', 1)
ProcessSetPriority(@AutoItPID, 4)
Local $iWidth = 1000
Local $iHeight = 600
Local $W2 = $iWidth / 2
Local $H2 = $iHeight / 2
Local $fps
_GDIPlus_Startup()
Local $GUI_title = "GDI+ Pixel Text Effect Beta by UEZ 2010 (short demo style ✌ d-|•b ✌)"
Local $hGui = GUICreate($GUI_title, $iWidth, $iHeight, -1, -1, Default, BitOR($WS_EX_TOPMOST, $WS_EX_TOOLWINDOW))
WinSetTrans($hGui, "", 255)
Local $hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGui)
Local $hBitmap = _GDIPlus_BitmapCreateFromGraphics($iWidth, $iHeight, $hGraphics)
Local $hBuffer = _GDIPlus_ImageGetGraphicsContext($hBitmap)
Local $hBrush = _GDIPlus_BrushCreateSolid(0xFFFFFFFF)
Local $hMem_Image = Load_BMP_From_Mem(Mem_Image())
Local $hMem_Image_x = _GDIPlus_ImageGetWidth($hMem_Image)
Local $hMem_Image_y = _GDIPlus_ImageGetHeight($hMem_Image)
Local $hMem_Image_Bmp = _GDIPlus_BitmapCreateFromGraphics($hMem_Image_x, $hMem_Image_y, $hGraphics)
Local $hContext = _GDIPlus_ImageGetGraphicsContext($hMem_Image_Bmp)
_GDIPlus_GraphicsDrawImageRect($hContext, $hMem_Image, 0, 0, $iWidth, $iHeight)
GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")
Local $playsound = 0
If FileExists(@ScriptDir & "\fmod.dll") And FileExists(@ScriptDir & "\Images.xm") Then $playsound = 1
Local $fmod_dll
If $playsound Then
	Local $F_dll = DllOpen("fmod.dll")
	DllCall($F_dll, "long", "_FSOUND_SetBufferSize@4", _
			"long", 200)
	DllCall($F_dll, "long", "_FSOUND_Init@12", _
			"long", 44100, _
			"long", 32, _
			"long", 0x0001)
	Local $F_RetValue = DllCall($F_dll, "long", "_FMUSIC_LoadSong@4", _
			"str", "Images.xm")
	Local $mod = $F_RetValue[0]
	DllCall($F_dll, "long", "_FMUSIC_SetMasterVolume@8", _
			"long", $mod, _
			"long", 100)
	DllCall($F_dll, "long", "_FMUSIC_SetLooping@8", _
			"long", $mod, _
			"long", 1)
	DllCall($F_dll, "long", "_FMUSIC_PlaySong@4", _
			"long", $mod)
EndIf
Local $speed = 7, $morph_steps = 75
Local $aCoord
Local $p = 0, $q = 7
ProgressOn("Pixel Calculation", "Please be patient... :-)", "0 %", -1, -1)
Local $fSize_aT1 = 40
Local $aText1 = Gen_Pixel_Coordinates($hGraphics, "Pixel Text Effect", 3, $fSize_aT1)
$p += 1
ProgressSet(Round(100 * $p / $q), Round(100 * $p / $q) & " percent")
Local $aText2 = Gen_Pixel_Coordinates($hGraphics, "A new GDI+ Demo", 3, 45, 0, 1, 0, 1, 1, 2, "Comic Sans MS")
$p += 1
ProgressSet(Round(100 * $p / $q), Round(100 * $p / $q) & " percent")
Local $aText3 = Gen_Pixel_Coordinates($hGraphics, "Coded by", 1, 24, -1, 3, 0xFFFFFFFF, 1, 15, Random(2, 8, 1))
$p += 1
ProgressSet(Round(100 * $p / $q), Round(100 * $p / $q) & " percent")
Local $aText4 = Gen_Pixel_Coordinates($hGraphics, "UEZ", 3, 70, 1, 2, 0, 1, 20, 1, "Arial Black")
$p += 1
ProgressSet(Round(100 * $p / $q), Round(100 * $p / $q) & " percent")
Local $fSize_aT5 = 60
Local $aText5 = Gen_Pixel_Coordinates($hGraphics, "Your reached the", 4, $fSize_aT5, 0, 4)
$p += 1
ProgressSet(Round(100 * $p / $q), Round(100 * $p / $q) & " percent")
Local $aText6 = Gen_Pixel_Coordinates($hGraphics, "End", 2, 72, 0, 4, 0xFFFFFFFF, 1, 7, 1, "Times New Roman")
$p += 1
ProgressSet(Round(100 * $p / $q), Round(100 * $p / $q) & " percent")
Local $fSize_aT7 = 72
Local $aText7 = Gen_Pixel_Coordinates($hGraphics, "✌ d-|•b ✌", 3, $fSize_aT7)
$p += 1
ProgressSet(Round(100 * $p / $q), Round(100 * $p / $q) & " percent")
If $playsound Then
	Do
		Sleep(50)
	Until GetOrder($mod) > 1
Else
	Sleep(1500)
EndIf
ProgressOff()
GUISetState(@SW_SHOW)
GUISetCursor(16, 1)
WinSetTitle($hGui, "", $GUI_title & " / #Pixels: " & UBound($aText1) - 1)
Text_Implosion($aText1, 0, 8, $fSize_aT1 * 1.75)
Sleep(2000)
Text_Zoom_Out2($aText1, 1.125, 8, 0, 0xA0000000)
Sleep(1000)
WinSetTitle($hGui, "", $GUI_title & " / #Pixels: " & UBound($aText2) - 1)
Text_Zoom_In($aText2, 0.1, 4)
Sleep(2000)
Text_Explosion($aCoord, 1, 4, 0xA0000000)
Sleep(1000)
WinSetTitle($hGui, "", $GUI_title & " / #Pixels: " & UBound($aText3) - 1)
Text_Zoom_In($aText3, 0.25)
Sleep(1500)
Text_Explosion2($aCoord, 0.25)
Sleep(1000)
WinSetTitle($hGui, "", $GUI_title & " / #Pixels: " & UBound($aText4) - 1)
Text_Zoom_In($aText4, 0.05, 3)
Sleep(3000)
Text_Explosion($aCoord, 1, 2, 0xB0000000)
Sleep(1000)
WinSetTitle($hGui, "", $GUI_title & " / #Pixels: " & UBound($aText5) - 1)
Text_Implosion($aText5, 1, 4, $fSize_aT5 * 1.75)
Sleep(2000)
WinSetTitle($hGui, "", $GUI_title & " / #Pixels: " & UBound($aText5) - 1 & " -> " & UBound($aText6) - 1)
Morph($aText5, $aText6, 4, 1)
Sleep(1500)
WinSetTitle($hGui, "", $GUI_title & " / #Pixels: " & UBound($aText6) - 1)
Text_Zoom_Out1($aText6, 0.25, 4)
Sleep(1000)
WinSetTitle($hGui, "", $GUI_title & " / #Pixels: " & UBound($aText7) - 1)
Text_Zoom_In($aText7, 0.25, 4)
Sleep(4000)
_Exit()
Func Text_Zoom_In($aDisplay, $s = 0.1, $bs = 2, $clear = 0xFF000000)
	Local $hBrushClear = _GDIPlus_BrushCreateSolid($clear)
	_GDIPlus_GraphicsFillRect($hBuffer, 0, 0, $iWidth, $iHeight, $hBrushClear)
	Local $size = 0, $x, $y
	$aCoord = $aDisplay
	While $size <= $iWidth / $aDisplay[0][0]
		_GDIPlus_GraphicsFillRect($hBuffer, 0, 0, $iWidth, $iHeight, $hBrushClear)
		For $i = 1 To UBound($aDisplay) - 1
			$x = $W2 - $aDisplay[0][0] * $size / 2 + $aDisplay[$i][0] * $size
			$y = $H2 - $aDisplay[0][1] * $size / 2 + $aDisplay[$i][1] * $size
			$aCoord[$i][0] = $x
			$aCoord[$i][1] = $y
			$aCoord[$i][2] = $aDisplay[$i][2]
			$aCoord[$i][3] = $aDisplay[$i][3]
			$aCoord[$i][4] = $aDisplay[$i][4]
			$aCoord[$i][5] = $aDisplay[$i][5]
			_GDIPlus_BrushSetSolidColor($hBrush, $aDisplay[$i][4])
			_GDIPlus_GraphicsFillRect($hBuffer, $x, $y, $bs, $bs, $hBrush)
		Next
		_GDIPlus_GraphicsDrawImageRect($hGraphics, $hBitmap, 0, 0, $iWidth, $iHeight)
		$size += $s
	WEnd
	_GDIPlus_BrushDispose($hBrushClear)
	Return $size - $s / 8
EndFunc   ;==>Text_Zoom_In
Func Text_Zoom_Out1($aDisplay, $s = 0.1, $bs = 2, $clear = 0xFF000000)
	Local $hBrushClear = _GDIPlus_BrushCreateSolid($clear)
	_GDIPlus_GraphicsFillRect($hBuffer, 0, 0, $iWidth, $iHeight, $hBrushClear)
	Local $size = $iWidth / $aDisplay[0][0], $x, $y
	$aCoord = $aDisplay
	While 1
		_GDIPlus_GraphicsFillRect($hBuffer, 0, 0, $iWidth, $iHeight, $hBrushClear)
		For $i = 1 To UBound($aDisplay) - 1
			$x = $W2 - $aDisplay[0][0] * $size / 2 + $aDisplay[$i][0] * $size
			$y = $H2 - $aDisplay[0][1] * $size / 2 + $aDisplay[$i][1] * $size
			$aCoord[$i][0] = $x
			$aCoord[$i][1] = $y
			$aCoord[$i][2] = $aDisplay[$i][2]
			$aCoord[$i][3] = $aDisplay[$i][3]
			$aCoord[$i][4] = $aDisplay[$i][4]
			$aCoord[$i][5] = $aDisplay[$i][5]
			_GDIPlus_BrushSetSolidColor($hBrush, $aDisplay[$i][4])
			_GDIPlus_GraphicsFillRect($hBuffer, $x, $y, $bs, $bs, $hBrush)
		Next
		_GDIPlus_GraphicsDrawImageRect($hGraphics, $hBitmap, 0, 0, $iWidth, $iHeight)
		$size -= $s
		If $size <= 0 Then
			_GDIPlus_GraphicsFillRect($hBuffer, 0, 0, $iWidth, $iHeight, $hBrushClear)
			_GDIPlus_GraphicsDrawImageRect($hGraphics, $hBitmap, 0, 0, $iWidth, $iHeight)
			ExitLoop
		EndIf
	WEnd
	_GDIPlus_BrushDispose($hBrushClear)
EndFunc   ;==>Text_Zoom_Out1
Func Text_Zoom_Out2($aDisplay, $s = 1.15, $bs = 2, $size = 0, $clear = 0xFF000000)
	Local $hBrushClear = _GDIPlus_BrushCreateSolid($clear)
	_GDIPlus_GraphicsFillRect($hBuffer, 0, 0, $iWidth, $iHeight, $hBrushClear)
	Local $x, $y
	If Not $size Then $size = $iWidth / $aDisplay[0][0]
	Local $max_zoom = ($iWidth - $aDisplay[0][0]) / 3
	$aCoord = $aDisplay
	While 1
		_GDIPlus_GraphicsFillRect($hBuffer, 0, 0, $iWidth, $iHeight, $hBrushClear)
		For $i = 1 To UBound($aDisplay) - 1
			$x = $W2 - $aDisplay[0][0] * $size / 2 + $aDisplay[$i][0] * $size
			$y = $H2 - $aDisplay[0][1] * $size / 2 + $aDisplay[$i][1] * $size
			$aCoord[$i][0] = $x
			$aCoord[$i][1] = $y
			$aCoord[$i][2] = $aDisplay[$i][2]
			$aCoord[$i][3] = $aDisplay[$i][3]
			$aCoord[$i][4] = $aDisplay[$i][4]
			$aCoord[$i][5] = $aDisplay[$i][5]
			_GDIPlus_BrushSetSolidColor($hBrush, $aDisplay[$i][4])
			_GDIPlus_GraphicsFillRect($hBuffer, $x, $y, $bs * $size / 4, $bs * $size / 4, $hBrush)
		Next
		_GDIPlus_GraphicsDrawImageRect($hGraphics, $hBitmap, 0, 0, $iWidth, $iHeight)
		$size *= $s
		If $size > $max_zoom Then
			_GDIPlus_GraphicsFillRect($hBuffer, 0, 0, $iWidth, $iHeight, $hBrushClear)
			_GDIPlus_GraphicsDrawImageRect($hGraphics, $hBitmap, 0, 0, $iWidth, $iHeight)
			ExitLoop
		EndIf
	WEnd
	_GDIPlus_BrushDispose($hBrushClear)
EndFunc   ;==>Text_Zoom_Out2
Func Text_Explosion($aCoord, $color = 0, $bs = 2, $clear = 0xFF000000)
	Local $hBrushClear = _GDIPlus_BrushCreateSolid($clear)
	_GDIPlus_GraphicsFillRect($hBuffer, 0, 0, $iWidth, $iHeight, $hBrushClear)
	Local $pixels = UBound($aCoord)
	Local $i, $t, $c = 0
	While 1
		For $i = 1 To UBound($aCoord) - 1
			If Not $aCoord[$i][5] Then
				$aCoord[$i][0] += $aCoord[$i][2]
				$aCoord[$i][1] += $aCoord[$i][3]
				If ($aCoord[$i][0] > -$speed And $aCoord[$i][0] < $iWidth + $speed) And ($aCoord[$i][1] > -$speed And $aCoord[$i][1] < $iHeight + $speed) Then
					If $color Then _GDIPlus_BrushSetSolidColor($hBrush, $aCoord[$i][4])
					_GDIPlus_GraphicsFillRect($hBuffer, $aCoord[$i][0], $aCoord[$i][1], $bs, $bs, $hBrush)
				Else
					$aCoord[$i][5] = 1
				EndIf
			EndIf
			$c += $aCoord[$i][5]
		Next
		_GDIPlus_GraphicsDrawImageRect($hGraphics, $hBitmap, 0, 0, $iWidth, $iHeight)
		_GDIPlus_GraphicsFillRect($hBuffer, 0, 0, $iWidth, $iHeight, $hBrushClear)
		If $c > $pixels - 2 Then
			ExitLoop
		Else
			$c = 0
		EndIf
	WEnd
	_GDIPlus_BrushDispose($hBrushClear)
EndFunc   ;==>Text_Explosion
Func Text_Explosion2($aCoord, $color = 0, $bs = 2, $clear = 0xFF000000, $timer = 25)
	Local $hBrushClear = _GDIPlus_BrushCreateSolid($clear)
	_GDIPlus_GraphicsFillRect($hBuffer, 0, 0, $iWidth, $iHeight, $hBrushClear)
	Local $pixels = UBound($aCoord)
	Local $i, $j = 0, $t, $c = 0
	_ArraySort($aCoord, Random(0, 1, 1), 0, 0, 0)
	$t = TimerInit()
	While 1
		For $i = 1 To UBound($aCoord) - 1
			If Not $aCoord[$i][6] Then
				$aCoord[$i][0] += $aCoord[$i][2]
				$aCoord[$i][1] += $aCoord[$i][3]
			EndIf
			If ($aCoord[$i][0] > -$speed And $aCoord[$i][0] < $iWidth + $speed) And ($aCoord[$i][1] > -$speed And $aCoord[$i][1] < $iHeight + $speed) Then
				If $color Then _GDIPlus_BrushSetSolidColor($hBrush, $aCoord[$i][4])
				_GDIPlus_GraphicsFillRect($hBuffer, $aCoord[$i][0], $aCoord[$i][1], $bs, $bs, $hBrush)
			Else
				$aCoord[$i][5] = 1
			EndIf
			$c += $aCoord[$i][5]
			If TimerDiff($t) > $timer And $j < UBound($aCoord) Then
				$aCoord[$j][6] = 0
				$j += 1
				$t = TimerInit()
			EndIf
		Next
		_GDIPlus_GraphicsDrawImageRect($hGraphics, $hBitmap, 0, 0, $iWidth, $iHeight)
		_GDIPlus_GraphicsFillRect($hBuffer, 0, 0, $iWidth, $iHeight, $hBrushClear)
		If $c > $pixels - 3 Then
			ExitLoop
		Else
			$c = 0
		EndIf
	WEnd
	_GDIPlus_BrushDispose($hBrushClear)
EndFunc   ;==>Text_Explosion2
Func Text_Implosion($aCoord, $color = 0, $bs = 2, $implode_factor = 30, $clear = 0xFF000000)
	Local $scale = $iWidth / $aCoord[0][0]
	Local $hBrushClear = _GDIPlus_BrushCreateSolid($clear)
	_GDIPlus_GraphicsFillRect($hBuffer, 0, 0, $iWidth, $iHeight, $hBrushClear)
	Local $pixels = UBound($aCoord)
	Local $i, $t
	While $t < $implode_factor
		For $i = 1 To UBound($aCoord) - 1
			$aCoord[$i][7] -= $aCoord[$i][2]
			$aCoord[$i][8] -= $aCoord[$i][3]
			If $color Then _GDIPlus_BrushSetSolidColor($hBrush, $aCoord[$i][4])
			$x = $W2 - $aCoord[0][0] * $scale / 2 + $aCoord[$i][7] * $scale
			$y = $H2 - $aCoord[0][1] * $scale / 2 + $aCoord[$i][8] * $scale
			_GDIPlus_GraphicsFillRect($hBuffer, $x, $y, $bs, $bs, $hBrush)
		Next
		_GDIPlus_GraphicsDrawImageRect($hGraphics, $hBitmap, 0, 0, $iWidth, $iHeight)
		_GDIPlus_GraphicsFillRect($hBuffer, 0, 0, $iWidth, $iHeight, $hBrushClear)
		$t += 1
	WEnd
	_GDIPlus_BrushDispose($hBrushClear)
EndFunc   ;==>Text_Implosion
Func Morph($aDisplayA, $aDisplayB, $bs = 2, $color = 0, $clear = 0xFF000000, $shuffle = 1)
	Local $aMorphA[1][11], $aMorphB[1][11]
	Local $diff = UBound($aDisplayA) - UBound($aDisplayB)
	Switch $diff
		Case $diff > 0
			ReDim $aMorphA[UBound($aDisplayA)][11]
			ReDim $aMorphB[UBound($aDisplayA)][11]
		Case $diff < 0
			ReDim $aMorphA[UBound($aDisplayB)][11]
			ReDim $aMorphB[UBound($aDisplayB)][11]
		Case $diff = 0
			ReDim $aMorphA[UBound($aDisplayA)][11]
			ReDim $aMorphB[UBound($aDisplayB)][11]
	EndSwitch
	Local $c_aDisplayB = $aDisplayB
	If $shuffle Then Shuffel_Array($c_aDisplayB)
	Calculate_Morph($aMorphA, $aMorphB, $aDisplayA, $c_aDisplayB, $diff)
	Local $hBrushClear = _GDIPlus_BrushCreateSolid($clear)
	_GDIPlus_GraphicsFillRect($hBuffer, 0, 0, $iWidth, $iHeight, $hBrushClear)
	Local $pixels = UBound($aMorphA)
	Local $i, $f, $c = 0, $test, $mBrush[3]
	While $c < $morph_steps
		For $i = 1 To UBound($aMorphA) - 1
			$aMorphA[$i][0] += $aMorphA[$i][2]
			$aMorphA[$i][1] += $aMorphA[$i][3]
			If $color Then
				$mBrush[0] = "0x" & StringMid(Hex($aMorphA[$i][6]), 3, 2)
				$mBrush[1] = "0x" & StringMid(Hex($aMorphA[$i][6]), 5, 2)
				$mBrush[2] = "0x" & StringMid(Hex($aMorphA[$i][6]), 7, 2)
				$mBrush[0] += $aMorphA[$i][8]
				$mBrush[1] += $aMorphA[$i][9]
				$mBrush[2] += $aMorphA[$i][10]
				$f = "0xFF" & Hex(Max(0, $mBrush[0]), 2) & Hex(Max(0, $mBrush[1]), 2) & Hex(Max(0, $mBrush[2]), 2)
				_GDIPlus_BrushSetSolidColor($hBrush, $f)
				$aMorphA[$i][6] = $f
			Else
				_GDIPlus_BrushSetSolidColor($hBrush, $aMorphA[$i][6])
			EndIf
			_GDIPlus_GraphicsFillRect($hBuffer, $aMorphA[$i][0], $aMorphA[$i][1], $bs, $bs, $hBrush)
		Next
		_GDIPlus_GraphicsDrawImageRect($hGraphics, $hBitmap, 0, 0, $iWidth, $iHeight)
		_GDIPlus_GraphicsFillRect($hBuffer, 0, 0, $iWidth, $iHeight, $hBrushClear)
		$c += 1
	WEnd
	_GDIPlus_BrushDispose($hBrushClear)
EndFunc   ;==>Morph
Func Gen_Pixel_Coordinates($hGraphics, $text, $details = 3, $fSize = 40, $fStyle = 0, $color = 0, $pixelC = 0xFFFFFFFF, $random = 1, $speed = 7, $mode = 1, $fFamily = "Arial")
	Local $aCoords, $pcolor, $e = 2.71828182845904523536
	If $details < 1 Then $details = 3
	If $fStyle < -1 Or $fStyle > 15 Then $fStyle = 0
	Local $x, $y, $bcolor[3], $RedM = 1, $BlueM = 1.25, $GreenM = 1.50, $index = Random(0, 100)
	Local $iWidth = 2.5 * $fSize, $iHeight = $fSize * 1.05, $implode_factor = $fSize * 1.75
	Local $hFormat = _GDIPlus_StringFormatCreate()
	Local $hFamily = _GDIPlus_FontFamilyCreate($fFamily)
	Local $hFont = _GDIPlus_FontCreate($hFamily, $fSize, $fStyle, 2)
	Local $tLayout = _GDIPlus_RectFCreate(2, 0, 0, 0)
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
	Else
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
	Local $PixelData
	Local $BitmapData = _GDIPlus_BitmapLockBits($hBitmap, 0, 0, $iW, $iH, $GDIP_ILMREAD, $GDIP_PXF32ARGB)
	Local $Stride = DllStructGetData($BitmapData, "Stride")
	Local $Scan0 = DllStructGetData($BitmapData, "Scan0")
	Local $aCoords[2][9]
	$aCoords[0][0] = $iW
	$aCoords[0][1] = $iH
	If $color = 2 Then _GDIPlus_GraphicsDrawImageRect($hContext, $hMem_Image, 0, 0, $iW, $iH)
	Local $z = 1
	For $y = 0 To $iH - 1 Step $details
		For $x = 0 To $iW - 1 Step $details
			$PixelData = DllStructCreate("dword", $Scan0 + ($y * $Stride) + ($x * 4))
			$pcolor = DllStructGetData($PixelData, 1)
			If Hex($pcolor) <> "FFFFFFFF" Then
				ReDim $aCoords[$z + 1][9]
				$aCoords[$z][0] = $x
				$aCoords[$z][1] = $y
				If $random And $speed Then
					Switch $mode
						Case 1
							$aCoords[$z][2] = _Random(-$speed, $speed, -1.5, 1.5)
							$aCoords[$z][3] = _Random(-$speed, $speed, -1.5, 1.5)
						Case 3
							$aCoords[$z][2] = 8 + Cos($x * $y)
							$aCoords[$z][3] = Sin($x / 16) * 8
						Case 4
							$aCoords[$z][2] = -$x * Sin($x ^ (1 / $y)) / 4
							$aCoords[$z][3] = Cos($x * $y) * 5.25
						Case 5
							$aCoords[$z][2] = 0
							$aCoords[$z][3] = 2 + ATan($x / 0x40) * 0x10
						Case 6
							$aCoords[$z][2] = -Sqrt($y)
							$aCoords[$z][3] = Sqrt($x) * - 1.5
						Case 7
							$aCoords[$z][2] = Max($speed, ($y * $z) / $y * Cos($x * 4096))
							$aCoords[$z][3] = Max($speed, Sin($y / $x) * 6)
						Case 8
							$aCoords[$z][2] = 8 + Cos($x * $z) * 5.25
							$aCoords[$z][3] = 11 + $x * Sin($x ^ (1 / ($z / $x))) / Random(8, 128, 1)
						Case 9
							$aCoords[$z][2] = Cos(Sqrt($e * $x) / 4) * 6
							$aCoords[$z][3] = Sin(-Sqrt($e * $x) / 4) * 4
						Case 2
							$aCoords[$z][2] = Cos(Sqrt($e * $x) / 4) * 6
							$aCoords[$z][3] = Sin(-Sqrt($e * $x) / 4) * 4
					EndSwitch
				EndIf
				Switch $color
					Case 0
						$aCoords[$z][4] = 0xF0FFFFFF
					Case 1
						$aCoords[$z][4] = Random(0xFF111111, 0xFFFFFFFF, 1)
					Case 2
						$aCoords[$z][4] = "0x" & Hex(_GDIPlus_BitmapGetPixel($hMem_Image_Bmp, $x, $y))
					Case 3
						$aCoords[$z][4] = $pixelC
					Case 4
						$bcolor[0] = 0xFF * ((Sin($index * $RedM) + 1) / 2)
						$bcolor[1] = 0xFF * ((Sin($index * $GreenM) + 1) / 2)
						$bcolor[2] = 0xFF * ((Cos($index * $BlueM) + 1) / 2)
						$aCoords[$z][4] = "0xD0" & Hex(_ColorSetRGB($bcolor), 6)
						$index += 0.005
				EndSwitch
				$aCoords[$z][6] = 1
				$aCoords[$z][7] = $aCoords[$z][0] + ($aCoords[$z][2] * $implode_factor)
				$aCoords[$z][8] = $aCoords[$z][1] + ($aCoords[$z][3] * $implode_factor)
				$z += 1
			EndIf
		Next
	Next
	_GDIPlus_BitmapUnlockBits($hBitmap, $BitmapData)
	$PixelData = 0
	_GDIPlus_BitmapDispose($hBitmap)
	_GDIPlus_GraphicsDispose($hBuffer)
	Return $aCoords
EndFunc   ;==>Gen_Pixel_Coordinates
Func Calculate_Morph(ByRef $aM1, ByRef $aM2, $aD1, $aD2, $diff)
	Local $i, $R
	Local $scaleA = $iWidth / $aD1[0][0]
	Local $scaleB = $iWidth / $aD2[0][0]
	For $i = 1 To UBound($aM1) - Abs($diff) - 1
		$x = $W2 - $aD1[0][0] * $scaleA / 2 + $aD1[$i][0] * $scaleA
		$y = $H2 - $aD1[0][1] * $scaleA / 2 + $aD1[$i][1] * $scaleA
		$aM1[$i][0] = $x
		$aM1[$i][1] = $y
		$x = $W2 - $aD2[0][0] * $scaleB / 2 + $aD2[$i][0] * $scaleB
		$y = $H2 - $aD2[0][1] * $scaleB / 2 + $aD2[$i][1] * $scaleB
		$aM1[$i][4] = $x
		$aM1[$i][5] = $y
		$aM1[$i][2] = ($aM1[$i][4] - $aM1[$i][0]) / $morph_steps
		$aM1[$i][3] = ($aM1[$i][5] - $aM1[$i][1]) / $morph_steps
		$aM1[$i][6] = $aD1[$i][4]
		$aM1[$i][7] = $aD2[$i][4]
		Delta_Color($aM1, $i)
	Next
	If $diff < 0 Then
		For $i = UBound($aM1) - Abs($diff) - 1 To UBound($aM1) - 1
			$R = Random(1, UBound($aD1) - Abs($diff) - 3, 1)
			$x = $W2 - $aD1[0][0] * $scaleA / 2 + $aD1[$R][0] * $scaleA
			$y = $H2 - $aD1[0][1] * $scaleA / 2 + $aD1[$R][1] * $scaleA
			$aM1[$i][0] = $x
			$aM1[$i][1] = $y
			$x = $W2 - $aD2[0][0] * $scaleB / 2 + $aD2[$i][0] * $scaleB
			$y = $H2 - $aD2[0][1] * $scaleB / 2 + $aD2[$i][1] * $scaleB
			$aM1[$i][4] = $x
			$aM1[$i][5] = $y
			$aM1[$i][2] = ($aM1[$i][4] - $aM1[$i][0]) / $morph_steps
			$aM1[$i][3] = ($aM1[$i][5] - $aM1[$i][1]) / $morph_steps
			$aM1[$i][6] = $aD1[$R][4]
			$aM1[$i][7] = $aD2[$i][4]
			Delta_Color($aM1, $i)
		Next
	ElseIf $diff > 0 Then
		For $i = UBound($aM1) - Abs($diff) - 1 To UBound($aM1) - 1
			$R = Random(1, UBound($aD2) - Abs($diff) - 3, 1)
			$x = $W2 - $aD1[0][0] * $scaleA / 2 + $aD1[$i][0] * $scaleA
			$y = $H2 - $aD1[0][1] * $scaleA / 2 + $aD1[$i][1] * $scaleA
			$aM1[$i][0] = $x
			$aM1[$i][1] = $y
			$x = $W2 - $aD2[0][0] * $scaleB / 2 + $aD2[$R][0] * $scaleB
			$y = $H2 - $aD2[0][1] * $scaleB / 2 + $aD2[$R][1] * $scaleB
			$aM1[$i][4] = $x
			$aM1[$i][5] = $y
			$aM1[$i][2] = ($aM1[$i][4] - $aM1[$i][0]) / $morph_steps
			$aM1[$i][3] = ($aM1[$i][5] - $aM1[$i][1]) / $morph_steps
			$aM1[$i][6] = $aD1[$i][4]
			$aM1[$i][7] = $aD2[$R][4]
			Delta_Color($aM1, $i)
		Next
	EndIf
EndFunc   ;==>Calculate_Morph
Func Delta_Color(ByRef $aC1, $i)
	Local $mBrushA[3], $mBrushB[3]
	$mBrushA[0] = "0x" & StringMid(Hex($aC1[$i][6]), 3, 2)
	$mBrushA[1] = "0x" & StringMid(Hex($aC1[$i][6]), 5, 2)
	$mBrushA[2] = "0x" & StringMid(Hex($aC1[$i][6]), 7, 2)
	$mBrushB[0] = "0x" & StringMid(Hex($aC1[$i][7]), 3, 2)
	$mBrushB[1] = "0x" & StringMid(Hex($aC1[$i][7]), 5, 2)
	$mBrushB[2] = "0x" & StringMid(Hex($aC1[$i][7]), 7, 2)
	$aC1[$i][8] = ($mBrushB[0] - $mBrushA[0]) / $morph_steps
	$aC1[$i][9] = ($mBrushB[1] - $mBrushA[1]) / $morph_steps
	$aC1[$i][10] = ($mBrushB[2] - $mBrushA[2]) / $morph_steps
EndFunc   ;==>Delta_Color
Func Shuffel_Array(ByRef $array)
	Local $temp[1][9], $x, $y, $random
	Local $elements = UBound($array) - 1
	For $x = 1 To $elements
		For $y = 0 To 8
			$temp[0][$y] = $array[$x][$y]
		Next
		While 1
			$random = Random($x - 1, $elements, 1)
			If $random > 0 Then ExitLoop
		WEnd
		For $y = 0 To 8
			$array[$x][$y] = $array[$random][$y]
		Next
		For $y = 0 To 8
			$array[$random][$y] = $temp[0][$y]
		Next
	Next
EndFunc   ;==>Shuffel_Array
Func Max($a, $b)
	If $a > $b Then Return $a
	Return $b
EndFunc   ;==>Max
Func _Random($min, $max, $emin, $emax, $int = 0)
	Local $r1 = Random($min, $emin, $int)
	Local $r2 = Random($emax, $max, $int)
	If Random(0, 1, 1) Then
		Return $r1
	Else
		Return $r2
	EndIf
EndFunc   ;==>_Random
Func GetOrder($F_SongHandle)
	Local $F_Getorder = DllCall($F_dll, "long", "_FMUSIC_GetOrder@4", _
			"long", $F_SongHandle)
	Return $F_Getorder[0]
EndFunc   ;==>GetOrder
Func _Exit()
	Local $i, $steps
	_GDIPlus_GraphicsDispose($hContext)
	_GDIPlus_BitmapDispose($hMem_Image_Bmp)
	_GDIPlus_ImageDispose($hMem_Image)
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_GraphicsDispose($hBuffer)
	_GDIPlus_BitmapDispose($hBitmap)
	_GDIPlus_GraphicsDispose($hGraphics)
	_GDIPlus_Shutdown()
	If @OSBuild < 6000 Then
		$steps = -1
	Else
		$steps = -0.05
	EndIf
	For $i = 255 To 0 Step $steps
		WinSetTrans($hGui, "", $i)
		If $playsound Then
			DllCall($F_dll, "long", "_FMUSIC_SetMasterVolume@8", _
					"long", $mod, _
					"long", $i * 0.390625)
		EndIf
	Next
	GUIDelete($hGui)
	If $playsound Then
		DllCall($F_dll, "long", "_FMUSIC_StopSong@4", _
				"long", $mod)
		DllCall($F_dll, "long", "_FSOUND_Close@0")
		DllClose($F_dll)
	EndIf
	Exit
EndFunc   ;==>_Exit
Func Load_BMP_From_Mem($pic)
	Local $memBitmap, $len, $tMem, $hImage, $hData, $pData
	$memBitmap = Binary($pic)
	$len = BinaryLen($memBitmap)
	$hData = _MemGlobalAlloc($len, $GMEM_MOVEABLE)
	$pData = _MemGlobalLock($hData)
	$tMem = DllStructCreate("byte[" & $len & "]", $pData)
	DllStructSetData($tMem, 1, $memBitmap)
	_MemGlobalUnlock($hData)
	$hStream = _WinAPI_CreateStreamOnHGlobal($pData)
	$hBitmapFromStream = _GDIPlus_BitmapCreateFromStream($hStream)
	$tMem = ""
	Return $hBitmapFromStream
EndFunc   ;==>Load_BMP_From_Mem
Func Mem_Image($save = 0)
	Local $DllBinary = '0xFFD8FFE000104A46494600010101004800480000FFDB0043000302020302020303030304030304050805050404050A070706080C0A0C0C0B0A0B0B0D0E12100D0E110E0B0B1016101113141515150C'
	$DllBinary &= '0F171816141812141514FFDB00430103040405040509050509140D0B0D1414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414FF'
	$DllBinary &= 'C2001108007800D403012200021101031101FFC4001C0000000701010000000000000000000000000102030405060708FFC4001A010002030101000000000000000000000001020003040506FFDA000C'
	$DllBinary &= '03010002100310000001E44A52F81D26D4B12254144105182D9B9600D59F70EB562F0AE87D1936AE2276A0C8C1F2FF0046244F1A53FB0382A1E704B4D4E49589104E09190E8757D64AADC198912A2390'
	$DllBinary &= '9CB0F47D89CFFB8C82B8182048045000048088A415361108E73C73D0FC55073D25A69B0800A4800C259815BA8054899F0BB532F51BB6C6AADD0D998A4957C935AA0AC65D7BF92952689BAA970C968D32'
	$DllBinary &= '2614C6193CE586F42F08CEF04CC517201891F534B05C3474EA9B3BDEC54F9CE9EC6AB0BCCFBF87BF52F98A175B9FD8B9BD46C1ABCF6E2BBAC939A953D20E874D94B22DAF8B18111CEDA88AD5F0CEFDCA'
	$DllBinary &= '6B3CDC1A726920048168935B6FFA8E6B2BE3BD3E8F1B61634E8851A5C7EDF26BCAE86EC54378CC8D95EF6D69F4BD1C19EADDE4333269D3D84185B55662CA6EEDEADB826E0F6F89239C564B8783590210'
	$DllBinary &= 'BF794B63875E9F3C8CFF0033A7ACAFCECEDD80E63EBDD89C9EF6F77E57F4D5623DF5ED2684996E32E0312B2FA1119CCB742CB594E3EDAA340046C7EF32D657CD69ABDDC3AE4002BB27BB1D745925B971'
	$DllBinary &= '29B16923D14DCE9FA4D3EDCFCF3A3696EEC1516960B0F0DC92911C65E890BCC326C22D6DFB0C9534D7164532782BAE7F6D1CEF373A9CB598AC096748581C9DCF18020BF02CAFD0000E965B8740AED94B'
	$DllBinary &= '015DA820295B6008E240755C101EBC9E8807AF88E20074C42400D000047FFFC40029100002020202010402020203000000000002030104000511120610131420212207301523314142FFDA0008010100'
	$DllBinary &= '010502E338CE3E9C7D4564C9D1F803EE0AFC0B5218AF0BD42C19E31AE24AFC2352A8F22F0DB4836E9EFA03EDC6719C6719C7DE96B6CEC59A9FE3CFD69EB2A6BFD79FA6CB47576D9E45A8AFAF9FBC7DD6'
	$DllBinary &= '04D3D178131B35EBAAA2BEB13E9CFA5AD5D3B85B4F06A0ECD9E90B5ECFEBA1ACB3B3778FF89D6D247D39CE7E9CF185333920D9CD8A7612BDCAF62533FD5468BB63674FA9569E8F3F4E7D24BAE772C8C9'
	$DllBinary &= '2C9900CF901392F1C9389CB0532AF23A82B67F4FF1ED588212ED9CE739CC67E71D7549C6ED57D67623DE3650BC5DD26605A964FB60DC8504631A2ACEEB2C640CC6D682AC2ED23E3BFEFA7F1FB3B89D76'
	$DllBinary &= 'B17ABA6BB22A4B376A5C9EF92A09F37A119BBFE4636116DEF6CF1575C47ACF94CC917D7C4BED12A919AB12761C51118F533828B08C55A5B8B6DAE272ECB66DFDFC7FC526D89DCAD483E70BB1DB12E768'
	$DllBinary &= 'F371352D398A06C2A34465B43C67FC433C7B587B5D9D95F567B3FAD7FF005C9DA35E236B19072D11B6C56433BC5AAC0F9179C67916BFE49CCF33E9CFA78AE946DB2EECBB4DBE2EAEBF8F48378256457C'
	$DllBinary &= '8AA059F0862235EAB5957C5F58BCAD5D5098A6023695EE4C506C6077233710E0ADE6529B0C11F955257B307C5A565BBC50DBC102EF54AA5CC278D2A8DBDCCA1BDB1B646625B190C599B5691C1B34A30E'
	$DllBinary &= '572414DF6228D368C7E5782C29878C1E07B4190B830BDAD671C5D5125E6D5C304C8B9F66CC2F6D5EC1C917AEA7F16ED5BED84DFC8DB15C3F76339F25ACC5D8FD2B3A04FE53257A8145C513C9A35D22B8'
	$DllBinary &= '5CFE072540C12AAA2C2A66889B16206DEF15D876A067FB581EC513BB12AE57CC2CCFA71954BACB1B8C74997C236CAEA02F153D71F5E0728C8E6B656733AAEB092B55F2A6C05F8B1C828F49FDB08FACBD'
	$DllBinary &= '62D8B7595722759F11B59111162BF617941A0D8DAAC1B007EA33D663F6C8881F5D4EB5BB6B9E435175D94B5CDE357AB985A0279504707500852B95E4C76C99E260E71C1EE4187E2CA25A095FBE9620E9'
	$DllBinary &= '3AD5981CDF41FB3B2E1F250632369D11CE7389E097E911CCE8B583A5D6BE97C9B35E842935D502B48444F4E267F0227139385C1E0F69CEFD67FEDC106B5B0A32E571BB561C5B5ADB5D89D575D3351C36'
	$DllBinary &= '73DEE3D23E9A0A7F3F6B71BD06AA6151338312311F89E79CFF00CF5900537BE3624640FB0B7FE13C1009F5B572C7F8DB31742A33C82E9E93CCB717637E8F72559ED83E0D5D4BFFC40024110001030402'
	$DllBinary &= '02020300000000000000000100021103041021122031411314223033FFDA0008010301013F01EB388C4FE89EF3D8F4E4A54E0A61F5D002E30151B427655CD2F8DE56D7E45428E8D3BC8DE950B56D112E'
	$DllBinary &= 'F2AA31AFDAAF4793A7D2FAAD27CA7DA7013CB2720EF36FFD5A4AB8B9DA37750E827D5705CB9207251C4C26911869832AA19387BA501D4AF28A985CF2F30303A1457B519FFFC400251100010402020103'
	$DllBinary &= '050000000000000000010002031104101221203041510513223132FFDA0008010201013F01F10D28342A0A822DF400B4057939A3C9A2CEE952A55B7B6BBF091ED8DBC9CB2BEA07F4D581399206724085'
	$DllBinary &= 'C9A15ABF09075B2685953E44996E35FCA8DD243F802A0C8E2CAF7432DDECDB51E4F335C7636458E91D64F71382C7C6F8430E21D9ED47034F6836956C21AAB4F69BD3858A510A04698CE23D00A97DB1F1'
	$DllBinary &= 'B8C5BBBD9DB50F0B2BFFC4003E10000103010503080706060300000000000100020311122131415104226110132032526271912330334281D1E114537282A1B105244373C1F0404463FFDA0008010100'
	$DllBinary &= '063F02F5746B4B8E810976E71D963CA31D73F242AC924FC4F45BF66B75CDCE355CDB766642DCF9B68A9F8ABB67B4757B89465D96164B1690B687CAA517C9B14F1B066E8C8FF85636685D33BBAADFF109'
	$DllBinary &= '68EFBB84FEE51FB36CF1C35C4B463D3FE65AE900C1B6A89CD60D92170F75BB4BA47F953D78631A5CE75C00CD366FE2279B8FEE0758F8E88450C6D8A31835A29EAAD4FB2C52BBB4F602517C264D95DDC1'
	$DllBinary &= '6DBE49C19B443B5347DDBB7878B71F5822D9E32F3AE4136477A7DAFEF4E5E1EAEE5F544437FF006E4B2E5FCD46E900C39F651DF039F9FAB641036D3DC99B3C62F1D67768FA8C95EB82AB881E2AEBD60B'
	$DllBinary &= '309C316AB6C6474ED35B60FC461E5EAB6B948BC06D0F9A3D13591A29C57B460F12A8257B8F7705BD4693AE2AAE361BDEC56EB458D71557342B96F0BB92E25A51A35A1D2764EEC9F54E656B4D7D455839'
	$DllBinary &= 'B841BE5761F0D5185A6D54D5CED51E192BEB5C382B4F959F951B4FB34CE89D16C16BFB9920DFB6199CDBC30E48738F79783421CE42C9FB331D9935253847380FF7A4CD6E5800E4E179F8AA16991DA5F4'
	$DllBinary &= '5BD1B18CFD550B5563791C0AB5D70ACFB3953CC346CC7167B92FD78A732516769676B177D7F7E9B769DB6B1C18B63CDFF44D8ED36268170C912CDA059E053C037F6C2361EFB2156A56A9F04E4465FD57'
	$DllBinary &= '9C11DAF6C9D8C89A2EE2A6DA79A3CC5BA8A842C0AE8AC88CF89C4ADE6823C95B6DEDD2A8020B7E0BD13CD7885E91B45561BF441DEC661E48C2FEBE8E4EDA62043DB74919C42AF47ED7B40F411F55A7DF'
	$DllBinary &= '3F258A2DAE54F156B62DACB40C627A2C237B8AABCAA5C10A5927F54DE78160ED055748E2E1A513236523A0C1ADAA6995E7C095501EFEEB4555A7B694F742B9C3E0A8D06FD5A102C940FC2550CE1C75CD'
	$DllBinary &= '56F72E6E66963B8A02D6EFBAE461DA2AD95BBBCE373191F9792760D39818788E1D063062E3451C11DCD6B68A8AA4DDA2176F64E1715BCEB5C6AACB2F3A36F281964647E2EFF4FE8B726D983B8827E4AA'
	$DllBinary &= '65807E1AFCD5613338E458DB2D1E3AADF9BC7243D09957B2B1F042A4846AEF8855C41F782AECE6CB97A473BC975839737330B1D914E68F483F7FAA2DFF00B11DCD3A8D16F7585C7A01DD9154792AE700'
	$DllBinary &= '1523DF3C16F389E0151CF753B22E0BD89929905516C49C0609933EF93BF7A74778ADD565C41589B7DE57AC95080A8636F92F426ED15F11FCA8B266189FDE6AA168A6AD5BB2DAE051A6ECADC5BDA086D7'
	$DllBinary &= '0DC1D7DDAAE7DA2CB8F5DBFE7A0E5C55197F15579F3BD6AA9914D34A05BC383916497917DBD4275877354EA91A2ACACB7FFA477AB258E6FE2571A8E5E2B8E8AA0D9764518A76D99060516BD976AB7779'
	$DllBinary &= 'BA6610ED36F054F04D76BF3462937AC958F409575DCAD822FCCED0210417868A57541E3DD5CE6792A52E57854A72D150E2AA3157754DC468856F7B7028091A986B79C78A8DF831D71EE94E961BB6880F'
	$DllBinary &= 'D7F64278BD9BB2CD8B8EA161CAFD69CB45ACF20B4F3FE1134A9CD1BB14074885476233E4A8EA9478223F5088CF169D0ADAF61B5CCED4D169BE3550996AC8E78EC3E9D68DE0FCEBFAA918C1E8C9AB4B70'
	$DllBinary &= 'A154372BC74A18E9568369DE0AE435C5594EAA1C841BD5CACB9542055791CDAE215AFE867DD51071F453DCD7655511FE8BE968774DC9AE1BBB5C3D76D7DA33B5E23FDCD50D5CDE2AA00AAA557FFFC400'
	$DllBinary &= '271001000201030304020301000000000000010011213141516171911081A1B1D1E120C1F0F1FFDA0008010100013F213D022A540F454AF4A805C741B5899AE41E6BFDBA4CCB8DD73E2A6A325AA765ED'
	$DllBinary &= 'ED1B3A610CBB85897A3D3BD8485E497783DE8FB4CE5A13C79257F0A951F44F5012BD6A54E67E03077743DE02548884C1C21F5E61B70AD18FBBD185997E977B4303206047B9989083EF442BDE24AFE350'
	$DllBinary &= '4254A81E9713C353DAB89B960B7CA3E99ED364D090FE2E3D06A7444B67FD60E032DCF72FF63C31810E683BC61F32BF884095EB51D9B41E4F2EDBF860505190C749DBBEBF51FE0894E634FA31235081E7'
	$DllBinary &= '6C29B4F68B8515AFD80CA760DA63D9F85BB4D4E2A57A54A810D654A9518ABF0718B5F885AA8BDFDD5FF6951A7ADC78915DEA01B2BD88265474A8ACB8C1C7283503AA01CE9D26E15C130FC918F98A6A9F'
	$DllBinary &= 'B13C915DA5DD3D857DEBA64952A54AFE35317ED6EB9FD4D03481B5F69DA84A0FCC6DB81D49D542B237C4B74EB458BA2FA88A79FCCECB0753DB58CD02E817E220B81EE4D2A3CAD466EAF426CCF2A956CA'
	$DllBinary &= 'F7C4408ACD8439B01D26E9B1D78BDEF4841A0B65277F4AF421084AEEA42F8727FB11D1E56297F8E9D58D4BC6996203028E1C9EB2CBC65A5741AAC6EC1DDFE9B4712D92CD53C43D19647DD716126C1A78'
	$DllBinary &= 'E91391D3FC83701A296A2F9DC203629C979D4B297921FBA5909697FA441F0196C8B9F131A0DDA3F112DAA2EB6604E2DB7C9C70D5104549F41FF7DDABE8C183E96822B465CBC7C9E90014D9940E91BABF'
	$DllBinary &= '6A41BE4052521BCDD9616FCF88E52BCAE668457101FAD32ADC5C441E5EEBF67A136F08613BFB1A43BDE1D87507F714540BB73AF7829E096D0E65691C93F6C7530F0F599D8E183EAE274C39D4815A3C0C'
	$DllBinary &= 'AB868D7543C0574C23EFFDC5B548BCC17EF467A993034CC9B5D65CB840C717DB031D5E8F97DE5D0612F47793354E25D806B71D237B9C2DEC960A31835D79FA82254E6F1D609009DF47795EE4409E3C75'
	$DllBinary &= 'D6006D9C22FC76C75811E284FDC31395BF79F12FC2D51F697281C7203ED588E63F12CEFB43EAD587F72549BD5A6A5682D0E232807958596710E0D77D4AE93033DB9B2FBC395CDAD650C5DEBDF6353BC6'
	$DllBinary &= '5C09A55C1EF30445497F680AC03CA3E34385D3EFF9826B4966A4A21CE1F922F441A577067A233FEFF84EEC14CE0231DF4D96095C35819AF89800539D49AF1CF4D46177FDE6AC1EC799A1A6EE9DE5D053'
	$DllBinary &= '6429F8859E1C532E56F86650CE13585A22180FF2A2D6E2518799FD70C267576FD62CB8108CEF0EFA7F713A911BCAC43CB3217C2F32EADE4130AD8FF4C726A8E8E34DCCCA3D6AE41D554C55280C6E70F3'
	$DllBinary &= 'FEC4C1C5B59EA12FE375AEE3A343CD4C797663048751215509C4294DE78AAC572BBF6802E74D1F99794AE1FE6155A1EECBEDB2B6F98EB1F9B39ECDC3F7E608168EE7877FBEF1F4238B591AB1AB046B7B'
	$DllBinary &= '3617E21887DD69D7BD6126BB69073E426B2EFB20FC8F1D652AB6B4D4DD3FD91884B99E7E5B3C91A72983EE18F2FF00D74EB6C57ACA33210D2540470E61A6B84CEDD40971774F781B75C907503A38879E'
	$DllBinary &= 'B14ACC2985EB5FA83F9616869D3DB7E92AF2C163ACC6947D099C828C68422803A1E8B044D729A6F2C3FD1B9D6EC60882D8D66C76BE8E60B38055710D48624DED02A3FEC3D44A658E265683E60696789A'
	$DllBinary &= 'A5E6080C0D47853BCED2F03433836AFEB3ECF10252E89CBA3D9D19BEB9AE68A1D46C42BC846BC9C7535F0CB8F958653855D6125A506E837BCD25C4205AE08D4686E1F114E5072E38216532E2058A8B70'
	$DllBinary &= '46E2459082478E620D4E1E22D83CC99AAF72055CB1BAE1977E1D69B416E1AA4DC97368E0EA5A24DD7DC3140DF6B0F307F103A8FCF029CD455A5B9C1B474D35D2B98E2CE860B1C9DEBD67ADA5E082151A'
	$DllBinary &= 'B63AED009CEA3CB3481B470D515FDA50C2ED84E95325654D256429398FF345AFBE4E194E3A7233177897A646A76C5C067A9D3EEF1ACA2DB5FDDD0F79B2C703AAF0DF82106590BB21D86CE1B8A77ED384'
	$DllBinary &= '1543A21701C833FFDA000C03010002000300000010836F7B99C0352ECB90830382BB1948879FBEEADBFD58B5F30C2B06892057AB06189FF3BAE3A01DD5AE00B2768D0C294C9BDFFC0F0AFD15565E875A'
	$DllBinary &= '577BDDF16DEC72519FC64006FB0F271F7FD780FC2FBEF81741FFC400221100030100030002010500000000000000000111211031412091F0516171A1B1FFDA0008010301013F10835F069E0EBEC824D4'
	$DllBinary &= '2DC7C51948420E33E1786264E733978B0938B3B1A782566BA1B18430B9F701011F6BFC332FD1BF034EB309693623D150F052865288D9276C5FDC4655D75B19419AAFB3C4AFE7BFECB0C9F9F9E11128B9'
	$DllBinary &= '83C2885A174B874BC077EB46E051488692BDF68D9B46C8C4EF25770D1D2B1E44B86293C2134FBE288896896127283C614D8BA0AFD5F2C6B453A08EC4668CE2626D52FD88D3D8447FFFC4002411010101'
	$DllBinary &= '00020103040301000000000000010011213141105161208191F0A1B1C1E1FFDA0008010201013F1062DF5577C40EEF8258CCB192C8B0B6DB67A3D7E9CDEEC1A167D3C54667165CA1F997E80209946E7D'
	$DllBinary &= '152611C7407DBFD6741CE7FCB073224DE7C7CC2E49443231B2BA24B206E821A29EC865F8FC09F71FECE4B29F4FC433507B9C9FC6D881EFEFEF391A4C63E6CF69BDC5D9B2089E4CFCF170609CE75F82E9'
	$DllBinary &= '871E308CF12074BC7130BA41E2E0C20252D85979B60391827D1ED936EA5F421F16626C72E7C96DE1FBF79F41226733E8EA7AB904396CDE187A8EB63DEBFFC40026100100020202020202020301000000'
	$DllBinary &= '00000100112131415161817191A1B1C1F010D1F1E1FFDA0008010100013F108184381344041FFD80260468B53646FC47BDE0AB16800CAC030B45A3C051F91EC21E3688AFCB17A2A3C69BFA3A0129E297'
	$DllBinary &= 'CDC0EE2F444257D230256A6AF5C5849E312CA47E45521ECB2F8866229ADDA8542BE624037510A8DFC471FF000B94E4A807E2142A60615950278C1FCC5C5A5E05ABB5AF60B9AF9E054DA416EB068ADAF0'
	$DllBinary &= '5C2C036000764C6AF76ED62D18C04419B9694347332CC52B3B8AC4C3B59712607C08EB78B2D3C4A639037E804DF4CEFF00C0D18970205CAC711CE26E0B31368D6649747F818AEA575A00655788072E33'
	$DllBinary &= '61C0EA1AB134B328022A84F2A8E7B76CFB97C45F171CC5B2E3A82945BE621B4957B7C4DC147CCC284A28CEA85992185172F2DD1E80EA56365EE8EB3BA01CB1FF0002A6895D4B0FF1DB19FF00C9BF3FE3'
	$DllBinary &= '4808FAC55CC3AC617C270C02952D0A94AF4A52D95B90690DF11BEE5D55C06E0ED02F7570E441AD5C70609E56F82501A3C751678CE0FBA810CBD2A57E3F30487AC51C684DEEC7A4DC5414F684313D05E5'
	$DllBinary &= '83456A3A788C567118BCA4208D25B119500C34004878013EA34BE172F85EDE68038038814EDD1CB35BCB143E3CC0060C46BA75EDC11BFA563BCAE97F8B8A7809B37E5BFE2302BF043707E652CEA9D3FE'
	$DllBinary &= 'F8253F525D01AE2F331CEF253F1922FF0077950566AE5F157702AAEDEB2E7786C0C5AA311825C267CCB216D41F706E6D0AFA446B057F0FB817658D27254224ACA1E6BC4B377655ACB330A576A545F250'
	$DllBinary &= '28158B3DE068B7A96D5A20BC754865E2EB52DE9A8B79928904DD005A37EAAEAF6D7E2588DE4F422D7E9F11DA915552F1C7BCFC4420F225A1F550C255C8D43455715B1EE5CD2F197EF5048152E579C5C5'
	$DllBinary &= '9FB80E4F074F02C8A64669452FAB0EFF007868BA2A98F48915C414C598AC952C06147903207060C5B6801EA09C05D6853B25F631AFA56950602833590F532983C80669451958F5635582D06ABA5E4DC4'
	$DllBinary &= 'FEE9779E9F93FF0011743430EC197795C57119411AA5F61E5CD669D9994C562B2D212B4ACDE43E2DCF43E35580A5F79DE365BC415661E3319D5B5D18A974F04ED61CC0F385F10F257220DF0084DE73FB'
	$DllBinary &= '9DC902A9F62A1A02F753E982A1C4731F0D34C5B0E7A3E0158FC5752D4CECD8DC0FD89EA39FDF161AA56B29A085E206B429AA5CB628673AE46F1B798CDE2DCB209DC31B7C8D644DB7158325294BF70E10'
	$DllBinary &= 'B4030506A3963AB13D9836CABDBD37AD2BC965E85326237728ABB7B776DF3FB582CA56E98DB9FF00C892B0B4357FCC7305B13999281C9575755D0A811976CE96E8D5CABE29A955491C8574BA2F27261D'
	$DllBinary &= '8AFA814466840033CAAFC56EA790EC1D8B5DD73C661A183A233432DAD6CFC6A58472E871FB7C7EE058DE50699C1BF900891E15827E11F942073BA599EB64BFB9DEFC52FA510F4AEC53B86A076F5BC61A'
	$DllBinary &= 'BC00BAE474B0EC002E4C985F41B013BC125DBDFCC7CE51D9F98951AE040A1BE0F21DF29AA0C80948B428E2E2491A1159DD84AF12F3202D2B680CFC38659971571C2C16E7E3501241CA5509492C4C69C7'
	$DllBinary &= '35B369DDFF00113BFD69880CAD2D3CD301656C5BA25B8E01A457B19CBA6516EDF148AEC4AE2D28B367A23759C9C5E1014BC5517A371504F04F8B4B01D0D4B4594605E32A17EBF11AC6A271E40B4EB3BC'
	$DllBinary &= 'F10104E0A27B5E5BDB707649117EF30FFB12978535DDF59FAF52AC7A825DD5F315013B1E97FE434008458FB8E72E175AFDBAF12CD09FF662A59BD014D7586AF73C3A7561A055B6E394C7E2093969D0AA'
	$DllBinary &= 'B7C1B652A3C0C5E32BE5557CAC6C24D2DCB0F2C06BDA2E30E087A06CF163DC3968840AF25F9DBEC8F1FC968DED0151E0C4D2C38846DB140EBD350FBAA0E35A4F4FA40D642F050BE00F7DC05063F008A8'
	$DllBinary &= '814E86B5C372952DB32B6294A7C4BD7E848F4637EAAA32406D65B6F29FA894D6F2145F368FFD9946CACE93E16FEAA6A85565C1F63E236C90FE50E7EE35C929A15F80BFC4287222D67A4A7EE3810D19E8'
	$DllBinary &= '9DC7ECCBA66705E8E2F7A778AEA3B3206FE394E8EAD892A9B529A385E5BE738F46489B98CFE26BEEDDFD34BEA614AA556F72C268E6787C4C3F71B45C40C7CAB15F170E40C0A0F85DBF8894562BB65342'
	$DllBinary &= '56ED33FDB690EE1D1434D8AD2D11C62A894F6DD3B20EFC5DD271470B6E68C81429592CCB4D19DDB2F22B63D6F2C37CF9D372F6C1956C395C65970C7E573EC610D823B5199DF8808F98BF012CCC77FA99'
	$DllBinary &= '8C25356E22A1863D577ABDEB38D42A13925BAC0B9AD84A82EEC0E1BD99F518806F584DE1EE1426C63867B016D6EAFCC615430AABEE5FB5C03C00051D4BAC84341E045B8ADEDFB9411983613F71C8CD72'
	$DllBinary &= '4BA6EA730F8683CC20CE8B51FDF328D440C381F5166350A03087EE5BDDD0B02ADD735421F273285C85D9A8413B0327C1DC0A0F20F589AED4EC464E87166D68392F264E139412DEA69C17BBBBA450A29C'
	$DllBinary &= 'B09C9D2022F4C18F0F8998C75AA6FE47EBFEC057AF6D4A6616AD95CE1AEA03124653435CC0B039464F5D88FD29ED387775AE6BCC056948B77B58FA6C43F9841DD8A476577F1FB85BFD0036E1DDAFE613'
	$DllBinary &= '985D010C19E560DD8344A5273291787C894E30C680A70CC392921DDC51F5605E42FE71FCC33D3804B2A0CA65AAA31FFA8E584A8D36C667F957E8977793660B93DE71282C0B6B54A287869C7899C87B5B'
	$DllBinary &= 'A604F2693E2191E2EC4FEF571E8116BAD3FDB8E9B9BEC80A8AE1314725D4B94347C2015F86CD70FF00A6384C2BF20FAD7EA2C3FB4D01D0DEB8AF32A3EEAAA8A63B8186DCAE06CF2EA2DF852E7AE80BC4'
	$DllBinary &= '2F3980F1A6054AE0DB1D9BF962EA6B9ADB6AEBE6807560602C6240E4C4BCF502BC3B453FC40F4528BC33FC4294532E74C0EDE2050703284C1E0FDDB00CC2BF49FF00A3EA1F2EA038038F8D10D300B71B'
	$DllBinary &= 'B160E976735DC0DADC577DFEA5525957BFEFF4809C08E5E89F21B0267251325AB8FEFEC8E7500094E1A78ECE3F29620405B55CBFDFF5176D6333F24094E687385DD7DC4525D3E8BCD7C7EF6C30231DC9'
	$DllBinary &= '33B1FC29A61EC5AA02503CAE1E729965534934811CB6C169A171670CA1B8B6C54A2B20B466F5C069FF0052D929DA3FC086E2B8C8658A9B980C57E0CADFCEA33CA681ADB03D02FA94548DADAEDFBC7A96'
	$DllBinary &= '37402FCF35FAFB8E70E001AF8F895F6C53287384A586CB050734DDDEEF9FB8045675E44DE0F7550D1388AF1FCD387D3CC5AE8940F2E7F0FEFB943C1691A7933D567D8FC1A88AAB21ABC3F7300B528AF8'
	$DllBinary &= '351EFC60BCE87C956684BDAD9DF4BC366CB06B25D17782EC4F934D405578A18BDD56D0468A5E06AF52F650F7558B10725B2A185972653B6C2A08AF16BCD975C63E3128C2734CD7C771578B549EFA9FFF'
	$DllBinary &= 'D9'
	If $save Then
		$hFile = FileOpen(@ScriptDir & "\PTE_Eagle.jpg", 18)
		FileWrite($hFile, $DllBinary)
		FileClose($hFile)
	EndIf
	Return $DllBinary
EndFunc   ;==>Mem_Image