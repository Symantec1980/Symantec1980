;coded by UEZ 2009-01-17 -=> this recursion code is very slow with AutoIt !!! :-(
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/sf /sv /om /cs=0 /cn=0
#AutoIt3Wrapper_UseUpx=n
;~ #AutoIt3Wrapper_Run_After=upx.exe --best "%out%"
#AutoIt3Wrapper_Run_After=upx.exe --ultra-brute "%out%"
#AutoIt3Wrapper_Run_After=del "L-System Fractals_Obfuscated.au3"

#include <Array.au3>
#include <GDIPlus.au3>
#Include <Misc.au3>

Opt('MustDeclareVars', 1)
Opt("GUIOnEventMode", 1)

Global $dll = DllOpen("user32.dll")
Global Const $Pi = 4 * ATan(1)
Global Const $Pi_Div_180 = $Pi / 180
Global Const $width = 800
Global Const $height = 600
Global $hGUI, $hWnd, $hGraphic, $Bitmap, $Pen
Global $angle = 0, $x1, $y1, $x2, $y2, $random
Global $length, $depth, $dir, $degree, $dist_rel
Global $font_size, $String_Format, $Font_Family, $Font, $Text_Layout, $Brush, $text

$hGUI = GUICreate("GDI+: L-System Fractals by UEZ 2009 (press F9 to save current image)", $width, $height)
GUISetState(@SW_SHOW)

GUISetOnEvent(-3, "_Exit")

_GDIPlus_Startup ()
$hGraphic = _GDIPlus_GraphicsCreateFromHWND ($hGUI)
$Pen = _GDIPlus_PenCreate(0, 1)
_GDIPlus_GraphicsSetSmoothingMode($hGraphic, 4) ; AntiAlias

$font_size = 7
$String_Format = _GDIPlus_StringFormatCreate ()
$Font_Family = _GDIPlus_FontFamilyCreate ("Arial")
$Font = _GDIPlus_FontCreate ($Font_Family, $font_size, 2)
$Brush = _GDIPlus_BrushCreateSolid (0xDF000000) ;text color

_GDIPlus_GraphicsClear($hGraphic, 0xFFFFFFFF)

$random = Random(1, 11, 1)

AdlibRegister("Save_PIC", 50)

While 1
    Switch $random
        Case 1 ;Dragon Curve
            $x1 = $width / 4.2
            $y1 = $height / 2.8
            $length = 500
            $depth = Random(6, 18, 1)
            $dir = 1
			$angle = 0
            $text = "Dragon Curve, Recursion Depth = " & $depth
            Draw_Text()
            Dragon($length, $depth, $dir)
        Case 2 ;Levy-C Curve
            $x1 = $width / 3.65
            $y1 = $height / 2.875
            $length = 475
            $depth = Random(6, 18, 1)
            $dir = 1
			$angle = 0
            $text = "Levy-C Curve, Recursion Depth = " & $depth
            Draw_Text()
            Levy_C($length, $depth, $dir)
        Case 3 ;Koch Curve
            $x1 = $width / 5.3
            $y1 = $height / 1.35
			$x2 = ""
			$y2 = ""
            $length = 500
            $depth = Random(2, 8, 1)
            $dir = 1
			$angle = 0
            $text = "Koch Curve, Recursion Depth = " & $depth
            Draw_Text()
            Koch($length, $depth, $dir)	;F
			Turn(-$dir * 2 * $degree) 	;--
            Koch($length, $depth, $dir)	;F
			Turn(-$dir * 2 * $degree) 	;--
			Koch($length, $depth, $dir)	;F
        Case 4 ;Peano Curve
            $x1 = $width / 8
            $y1 = $height / 2
            $length = 600
            $depth = Random(2, 5, 1)
            $dir = 1
			$angle = 0
            $text = "Peano Curve, Recursion Depth = " & $depth
            Draw_Text()
            Peano($length, $depth, $dir)
        Case 5 ;Triangle
            $x1 = $width / 10.8
            $y1 = $height / 1.03
            $length = 1300
            $depth = Random(2, 10, 1)
            $dir = 1
			$angle = 0
            $text = "Triangle, Recursion Depth = " & $depth
            Draw_Text()
            Triangle($length, $depth, $dir)
        Case 6 ;Arrowhead Curve
            $x1 = $width / 10.80
            $y1 = $height / 1.05
            $length = 650
            $depth = Random(3, 9, 1)
            $dir = 1
			$angle = 0
            $text = "Arrowhead Curve, Recursion Depth = " & $depth
            Draw_Text()
            Arrowhead_R($length, $depth, $dir) ;R
        Case 7 ;Penta Plexity
            $x1 = $width / 3.55
            $y1 = $height / 15
            $length = 350
            $depth = Random(1, 6, 1)
            $dir = 1
			$angle = 0
            $text = "Penta Plexity, Recursion Depth = " & $depth
            Draw_Text()
			;F++F++F++F++F
            Penta_Plexity($length, $depth, $dir)	;F
			Turn($dir * 2 * $degree) 				;++
            Penta_Plexity($length, $depth, $dir)	;F
			Turn($dir * 2 * $degree) 				;++
			Penta_Plexity($length, $depth, $dir)	;F
			Turn($dir * 2 * $degree) 				;++
			Penta_Plexity($length, $depth, $dir)	;F
			Turn($dir * 2 * $degree) 				;++
            Penta_Plexity($length, $depth, $dir)	;F
		Case 8 ;Sierpinski Carpet
            $x1 = $width / 8
            $y1 = $height / 2
            $length = 600
            $depth = Random(2, 6, 1)
            $dir = 1
			$angle = 0
            $text = "Sierpinski Carpet, Recursion Depth = " & $depth
            Draw_Text()
            Sierpinski_Carpet($length, $depth, $dir) ;F
		Case 9 ;Gosper Curve
			$depth = Random(4, 6, 1)
            $x1 = $width / 1.45
            $y1 = $height / 7 - $depth
            $length = 480
            $dir = 1
			$angle = 0
            $text = "Gosper Curve, Recursion Depth = " & $depth
            Draw_Text()
            Gosper_R($length, $depth, $dir) ;R
		Case 10 ;Sierpinski Triangle
            $x1 = $width / 10.666
            $y1 = $height / 1.05
            $length = 325
            $depth = Random(2, 9, 1)
            $dir = 1
			$angle = 0
            $text = "Sierpinski Triangle, Recursion Depth = " & $depth
            Draw_Text()
			;FXF--FF--FF
            Sierpinski_F($length, $depth, $dir) ;F
			Sierpinski_X($length, $depth, $dir) ;X
			Sierpinski_F($length, $depth, $dir) ;F
			Turn(-$dir * 2 * $degree) 			;--
			Sierpinski_F($length, $depth, $dir) ;F
			Sierpinski_F($length, $depth, $dir) ;F
			Turn(-$dir * 2 * $degree) 			;--
			Sierpinski_F($length, $depth, $dir) ;F
			Sierpinski_F($length, $depth, $dir) ;F
		Case 11 ;Pythagoras Tree
            $x1 = $width / 2
            $y1 = $height / 1.1
            $length = 110
            $depth = Random(5, 15, 1)
            $dir = 1
			$angle = 5
            $text = "Pythagoras Tree, Recursion Depth = " & $depth
            Draw_Text()
			Pythagoras($length, $depth, $dir)
	EndSwitch
	$random += 1
	If $random = 12 Then $random = 1
    Sleep(4000)
    _GDIPlus_GraphicsClear($hGraphic, 0xFFFFFFFF)
Wend

Func Pythagoras($length, $split, $dir)

    If _IsPressed("20", $dll) Then ;hold pressed spacebar to abort current drawing
        $split = 0
        $dir = 0
        $length = 0
    EndIf
    If $split = 0 Then
		Pythagoras_Square($length)
    Else
        $dist_rel = Sqrt(3) / 2
        $degree = 30
		Pythagoras_Square($length)
        Forward_Only($length)
        Turn(-$dir * 1 * $degree)
		Pythagoras($length * $dist_rel, $split - 1, 1)
		Turn($dir * 3 * $degree)
		Forward_Only($length * $dist_rel)
		Pythagoras($length / 2, $split - 1, 1)
		Forward_Only(-$length * $dist_rel)
		Turn(-$dir * 2 * $degree)
		Forward_Only(-$length)
	EndIf
    ;Sleep(0)
EndFunc

Func Pythagoras_Square($length)
	Local $i
	For $i = 1 To 4
		Draw_and_Forward($length)
		Turn($dir * 90)
	Next
EndFunc

Func Sierpinski_X($length, $split, $dir)
	;FXF--FF--FF
	;X -> --FXF++FXF++FXF--
	;F -> FF

    If _IsPressed("20", $dll) Then ;hold pressed spacebar to abort current drawing
        $split = 0
        $dir = 0
        $length = 0
    EndIf
    If $split = 0 Then
;~         Draw_and_Forward($length)
    Else
        $dist_rel = 2
        $degree = 60
        Turn(-$dir * 2 * $degree) ;--
        Sierpinski_F($length / $dist_rel, $split - 1, 1) ;F
		Sierpinski_X($length / $dist_rel, $split - 1, 1) ;X
		Sierpinski_F($length / $dist_rel, $split - 1, 1) ;F
        Turn($dir * 2 * $degree) ;++
        Sierpinski_F($length / $dist_rel, $split - 1, 1) ;F
		Sierpinski_X($length / $dist_rel, $split - 1, 1) ;X
		Sierpinski_F($length / $dist_rel, $split - 1, 1) ;F
        Turn($dir * 2 * $degree) ;++
		Sierpinski_F($length / $dist_rel, $split - 1, 1) ;F
		Sierpinski_X($length / $dist_rel, $split - 1, 1) ;X
		Sierpinski_F($length / $dist_rel, $split - 1, 1) ;F
        Turn(-$dir * 2 * $degree) ;--
	EndIf
    ;Sleep(0)
EndFunc

Func Sierpinski_F($length, $split, $dir)
	;FXF--FF--FF
	;X -> --FXF++FXF++FXF--
	;F -> FF

    If _IsPressed("20", $dll) Then ;hold pressed spacebar to abort current drawing
        $split = 0
        $dir = 0
        $length = 0
    EndIf
    If $split = 0 Then
        Draw_and_Forward($length)
    Else
        $dist_rel = 2
        $degree = 60
        Sierpinski_F($length / $dist_rel, $split - 1, 1) ;F
        Sierpinski_F($length / $dist_rel, $split - 1, 1) ;F
    EndIf
    ;Sleep(0)
EndFunc

Func Gosper_R($length, $split, $dir)
	;F -> R or F -> L
	;R -> R+L++L-R--RR-L+
	;L -> -R+LL++L+R--R-L

    If _IsPressed("20", $dll) Then ;hold pressed spacebar to abort current drawing
        $split = 0
        $dir = 0
        $length = 0
    EndIf
    If $split = 0 Then
        Draw_and_Forward($length)
    Else
        $dist_rel = Sqrt(7)
        $degree = 60
        Gosper_R($length / $dist_rel, $split - 1, 1) 	;R
        Turn($dir * 1 * $degree) 						;+
		Gosper_L($length / $dist_rel, $split - 1, 1) 	;L
		Turn($dir * 2 * $degree) 						;++
		Gosper_L($length / $dist_rel, $split - 1, 1) 	;L
		Turn(-$dir * 1 * $degree) 						;-
		Gosper_R($length / $dist_rel, $split - 1, 1) 	;R
		Turn(-$dir * 2 * $degree) 						;--
		Gosper_R($length / $dist_rel, $split - 1, 1) 	;R
		Gosper_R($length / $dist_rel, $split - 1, 1) 	;R
		Turn(-$dir * 1 * $degree) 						;-
		Gosper_L($length / $dist_rel, $split - 1, 1) 	;L
		Turn($dir * 1 * $degree) 						;+
    EndIf
    ;Sleep(0)
EndFunc

Func Gosper_L($length, $split, $dir)
	;F -> R or F -> L
	;R -> R+L++L-R--RR-L+
	;L -> -R+LL++L+R--R-L

    If _IsPressed("20", $dll) Then ;hold pressed spacebar to abort current drawing
        $split = 0
        $dir = 0
        $length = 0
    EndIf
    If $split = 0 Then
        Draw_and_Forward($length)
    Else
        $dist_rel = Sqrt(7)
        $degree = 60
		Turn(-$dir * 1 * $degree) 						;-
        Gosper_R($length / $dist_rel, $split - 1, 1) 	;R
        Turn($dir * 1 * $degree) 						;+
		Gosper_L($length / $dist_rel, $split - 1, 1) 	;L
		Gosper_L($length / $dist_rel, $split - 1, 1) 	;L
		Turn($dir * 2 * $degree) 						;++
		Gosper_L($length / $dist_rel, $split - 1, 1) 	;L
		Turn($dir * 1 * $degree) 						;+
		Gosper_R($length / $dist_rel, $split - 1, 1) 	;R
		Turn(-$dir * 2 * $degree) 						;--
		Gosper_R($length / $dist_rel, $split - 1, 1) 	;R
		Turn(-$dir * 1 * $degree) 						;-
		Gosper_L($length / $dist_rel, $split - 1, 1) 	;L
    EndIf
    ;Sleep(0)
EndFunc

Func Sierpinski_Carpet($length, $split, $dir)
	;F
	;F -> F+F-F-FF-F-F-fF
	;f -> fff

    If _IsPressed("20", $dll) Then ;hold pressed spacebar to abort current drawing
        $split = 0
        $dir = 0
        $length = 0
    EndIf
    If $split = 0 Then
        Draw_and_Forward($length)
    Else
        $dist_rel = 3
        $degree = 90
        Sierpinski_Carpet($length / $dist_rel, $split - 1, 1) 	;F
        Turn($dir * 1 * $degree) 								;+
		Sierpinski_Carpet($length / $dist_rel, $split - 1, 1) 	;F
		Turn(-$dir * 1 * $degree) 								;-
		Sierpinski_Carpet($length / $dist_rel, $split - 1, 1) 	;F
		Turn(-$dir * 1 * $degree) 								;-
		Sierpinski_Carpet($length / $dist_rel, $split - 1, 1) 	;F
		Sierpinski_Carpet($length / $dist_rel, $split - 1, 1) 	;F
		Turn(-$dir * 1 * $degree) 								;-
		Sierpinski_Carpet($length / $dist_rel, $split - 1, 1) 	;F
		Turn(-$dir * 1 * $degree) 								;-
		Sierpinski_Carpet($length / $dist_rel, $split - 1, 1) 	;F
		Turn(-$dir * 1 * $degree) 								;-
		Sierpinski_Carpet_Forward_Only($length / $dist_rel, $split - 1, 1) 	;f
		Sierpinski_Carpet($length / $dist_rel, $split - 1, 1) 	;F
    EndIf
    ;Sleep(0)
EndFunc

Func Sierpinski_Carpet_Forward_Only($length, $split, $dir) ;f
	;F
	;F -> F+F-F-FF-F-F-fF
	;f -> fff
	Forward_Only($length / $dist_rel) ;f
	Forward_Only($length / $dist_rel) ;f
	Forward_Only($length / $dist_rel) ;f
    ;Sleep(0)
EndFunc

Func Penta_Plexity($length, $split, $dir)
	;F++F++F++F++F
	;F -> F++F++F|F-F++F

    If _IsPressed("20", $dll) Then ;hold pressed spacebar to abort current drawing
        $split = 0
        $dir = 0
        $length = 0
    EndIf
    If $split = 0 Then
        Draw_and_Forward($length)
    Else
        $dist_rel = ((Sqrt(5) + 1) / 2)^2
        $degree = 36
        Penta_Plexity($length / $dist_rel, $split - 1, 1)	;F
        Turn($dir * 2 * $degree) 							;++
        Penta_Plexity($length / $dist_rel, $split - 1, 1)	;F
        Turn($dir * 2 * $degree) 							;++
		Penta_Plexity($length / $dist_rel, $split - 1, 1)	;F
		Turn($dir * 5 * $degree) 							;180°
		Penta_Plexity($length / $dist_rel, $split - 1, 1)	;F
		Turn(-$dir * 1 * $degree) 							;-
		Penta_Plexity($length / $dist_rel, $split - 1, 1)	;F
		Turn($dir * 2 * $degree) 							;++
		Penta_Plexity($length / $dist_rel, $split - 1, 1)	;F
	EndIf
    ;Sleep(0)
EndFunc

Func Arrowhead_R($length, $split, $dir)
	;F -> R oder F -> L
	;R -> -L+R+L-
	;L -> +R-L-R+

    If _IsPressed("20", $dll) Then ;hold pressed spacebar to abort current drawing
        $split = 0
        $dir = 0
        $length = 0
    EndIf
    If $split = 0 Then
        Draw_and_Forward($length)
    Else
        $dist_rel = 2
        $degree = 60
        Turn(-$dir * 1 * $degree) 						;-
        Arrowhead_L($length / $dist_rel, $split - 1, 1) ;L
        Turn($dir * 1 * $degree) 						;+
        Arrowhead_R($length / $dist_rel, $split - 1, 1) ;R
        Turn($dir * 1 * $degree) 						;+
		Arrowhead_L($length / $dist_rel, $split - 1, 1) ;L
        Turn(-$dir * 1 * $degree) 						;--
	EndIf
    ;Sleep(0)
EndFunc

Func Arrowhead_L($length, $split, $dir)
	;F -> R oder F -> L
	;R -> -L+R+L-
	;L -> +R-L-R+

    If _IsPressed("20", $dll) Then ;hold pressed spacebar to abort current drawing
        $split = 0
        $dir = 0
        $length = 0
    EndIf
    If $split = 0 Then
        Draw_and_Forward($length)
    Else
        $dist_rel = 2
        $degree = 60
        Turn($dir * 1 * $degree) 						;+
        Arrowhead_R($length / $dist_rel, $split - 1, 1) ;R
        Turn(-$dir * 1 * $degree) 						;-
        Arrowhead_L($length / $dist_rel, $split - 1, 1) ;L
        Turn(-$dir * 1 * $degree) 						;-
        Arrowhead_R($length / $dist_rel, $split - 1, 1) ;R
        Turn($dir * 1 * $degree) 						;+
    EndIf
    ;Sleep(0)
EndFunc

Func Triangle($length, $split, $dir)
    ;F--F--F
    ;F -> F--F--F--ff
    ;ff -> ff

    If _IsPressed("20", $dll) Then ;hold pressed spacebar to abort current drawing
        $split = 0
        $dir = 0
        $length = 0
    EndIf
    If $split = 0 Then
        Draw_and_Forward($length)
    Else
        $dist_rel = 2
        $degree = 60
        Triangle($length / $dist_rel, $split - 1, 1) ;F
        Turn(-$dir * 2 * $degree) ;--
        Triangle($length / $dist_rel, $split - 1, 1) ;F
        Turn(-$dir * 2 * $degree) ;--
        Triangle($length / $dist_rel, $split - 1, 1) ;F
        Turn(-$dir * 2 * $degree) ;--
        Forward_Only($length / $dist_rel) ;f
        Forward_Only($length / $dist_rel) ;f
    EndIf
    ;Sleep(0)
EndFunc

Func Dragon($length, $split, $dir)
    ;F -> R
    ;R -> +R--L+
    ;L -> -R++L-

    If _IsPressed("20", $dll) Then ;hold pressed spacebar to abort current drawing
        $split = 0
        $dir = 0
        $length = 0
    EndIf
    If $split = 0 Then
        Draw_and_Forward($length)
    Else
        $degree = 45
        $dist_rel = Sqrt(2)
        Turn($dir * $degree) ;+
        Dragon($length / $dist_rel, $split - 1, 1) ;R
        Turn(-$dir * 2 * $degree) ;--
        Dragon($length / $dist_rel, $split - 1, -1) ;L
        Turn($dir * $degree) ;+
    EndIf
    ;Sleep(0)
EndFunc

Func Levy_C($length, $split, $dir)
    ;F
    ;F -> +F--F+

    If _IsPressed("20", $dll) Then ;hold pressed spacebar to abort current drawing
        $split = 0
        $dir = 0
        $length = 0
    EndIf
    If $split = 0 Then
        Draw_and_Forward($length)
    Else
        $degree = 45
        $dist_rel = 1.45
        Turn($dir * $degree) ;+
        Levy_C($length / $dist_rel, $split - 1, 1) ;F
        Turn(-$dir * 2 * $degree) ;--
        Levy_C($length / $dist_rel, $split - 1, 1) ;F
        Turn($dir * $degree) ;+
    EndIf
    ;Sleep(0)
EndFunc

Func Koch($length, $split, $dir)
    ;F--F--F
    ;F -> F+F--F+F

    If _IsPressed("20", $dll) Then ;hold pressed spacebar to abort current drawing
        $split = 0
        $dir = 0
        $length = 0
    EndIf
    If $split = 0 Then
        Draw_and_Forward($length)
    Else
        $dist_rel = 3
        $degree = 60
        Koch($length / $dist_rel, $split - 1, 1) ;F
        Turn($dir * $degree) 					 ;+
        Koch($length / $dist_rel, $split - 1, 1) ;F
        Turn(-$dir * 2 * $degree) 				 ;--
        Koch($length / $dist_rel, $split - 1, 1) ;F
        Turn($dir * $degree) 					 ;+
        Koch($length / $dist_rel, $split - 1, 1) ;F
    EndIf
    ;Sleep(0)
EndFunc

Func Peano($length, $split, $dir)
    ;F
    ;F -> F-F+F+F+F-F-F-F+F

    If _IsPressed("20", $dll) Then ;hold pressed spacebar to abort current drawing
        $split = 0
        $dir = 0
        $length = 0
    EndIf
    If $split = 0 Then
        Draw_and_Forward($length)
    Else
        $dist_rel = 3
        $degree = 90
        Peano($length / $dist_rel, $split - 1, 1) ;F
        Turn(-$dir * $degree) ;-
        Peano($length / $dist_rel, $split - 1, 1) ;F
        Turn($dir * $degree) ;+
        Peano($length / $dist_rel, $split - 1, 1) ;F
        Turn($dir * $degree) ;+
        Peano($length / $dist_rel, $split - 1, 1) ;F
        Turn($dir * $degree) ;+
        Peano($length / $dist_rel, $split - 1, 1) ;F
        Turn(-$dir * $degree) ;-
        Peano($length / $dist_rel, $split - 1, 1) ;F
        Turn(-$dir * $degree) ;-
        Peano($length / $dist_rel, $split - 1, 1) ;F
        Turn(-$dir * $degree) ;-
        Peano($length / $dist_rel, $split - 1, 1) ;F
        Turn($dir * $degree) ;+
        Peano($length / $dist_rel, $split - 1, 1) ;F
    EndIf
    ;Sleep(0)
EndFunc

Func Turn ($degrees)
    $angle = $angle + ($degrees * $Pi_Div_180)
EndFunc

Func Draw_and_Forward($length)
    $x2 = $x1 + Cos($angle) * $length
    $y2 = $y1 + Sin($angle) * $length
;~     Local $red = 0 ;((Cos(1 * $x1 / 2^6) + 1) / 2) * 256
;~     Local $green = 0;((Cos(1.25 * $y2 / 2^6) + 1) / 2) * 256
;~     Local $blue = 0;((Cos(1.5 * $x2 / 2^6) + 1) / 2) * 256
;~     _GDIPlus_PenSetColor($Pen, "0xEF" & Hex($red, 2) & Hex($green, 2) & Hex($blue, 2)) ;Set the pen color
    _GDIPlus_PenSetColor($Pen, "0x60000000") ;Set the pen color
    _GDIPlus_GraphicsDrawLine($hGraphic, $x1, $y1, $x2, $y2, $Pen)
    $x1 = $x2
    $y1 = $y2
EndFunc

Func Forward_Only($length)
    $x2 = $x1 + Cos($angle) * $length
    $y2 = $y1 + Sin($angle) * $length
    $x1 = $x2
    $y1 = $y2
EndFunc

Func Draw_Text()
	Local $Text_Layout2
	Local $text_info = "UEZ 2009 ;-)"
    $Text_Layout = _GDIPlus_RectFCreate (0, $height - 1.75 * $font_size, 0, 0)
	$Text_Layout2 = _GDIPlus_RectFCreate ($width - StringLen($text_info) * $font_size * 0.67, $height - 1.75 * $font_size, 0, 0)
    _GDIPlus_GraphicsDrawStringEx ($hGraphic, $text, $Font, $Text_Layout, $String_Format, $Brush)
	_GDIPlus_GraphicsDrawStringEx ($hGraphic, $text_info, $Font, $Text_Layout2, $String_Format, $Brush)
EndFunc

Func Save_PIC()
	If _IsPressed("78", $dll) Then
		_GDIPlus_Save_to_Image(@ScriptDir & "\L-SF-Screenshot_" & @YEAR & @MON & @MDAY & "_" & @HOUR & @MIN & @SEC, $hGUI)
		If @error Then MsgBox(16, "ERROR", "Image was not saved!", 10)
	EndIf
EndFunc

; #FUNCTION# =============================================================================
; Name...........: _GDIPlus_Save_to_Image
; Description ...: INTERNAL FUNCTION - save drawn image to file
; Syntax.........: _GraphGDIPlus_Reference_Pixel($file, $hWnd)
; Parameters ....: $file - filename
;                  $hWnd - handle to GUI
; Autor .........: ptrex, ProgAndy, UEZ
; =========================================================================================
Func _GDIPlus_Save_to_Image($file, $hWnd,  $CLSID = "PNG")
    Local $hDC, $memBmp, $memDC, $hImage, $w, $h, $size, $sCLSID
    If $file <> "" Or $hWnd <> "" Then
        $size = WinGetClientSize($hWnd)
        $w = $size[0]
        $h = $size[1]
        $hDC = _WinAPI_GetDC($hWnd)
        $memDC = _WinAPI_CreateCompatibleDC($hDC)
        $memBmp = _WinAPI_CreateCompatibleBitmap($hDC, $w, $h)
        _WinAPI_SelectObject ($memDC, $memBmp)
        _WinAPI_BitBlt($memDC, 0, 0, $w, $h, $hDC, 0, 0, 0x00CC0020) ;  0x00CC0020 = $SRCCOPY
        $hImage = _GDIPlus_BitmapCreateFromHBITMAP ($memBmp)
		$sCLSID = _GDIPlus_EncodersGetCLSID ($CLSID)
;~         _GDIPlus_ImageSaveToFile($hImage, $file)
		_GDIPlus_ImageSaveToFileEx ($hImage, $file & "." & StringLower($CLSID), $sCLSID)
        If @error Then
            Return SetError(1, 0, 0)
        Else
            Return SetError(0, 0, 0)
        EndIf
        _GDIPlus_ImageDispose ($hImage)
        _WinAPI_ReleaseDC($hWnd, $hDC)
        _WinAPI_DeleteDC($memDC)
        _WinAPI_DeleteObject ($memBmp)
    Else
        Return SetError(1, 0, 0)
    EndIf
EndFunc

Func _Exit()
	AdlibUnRegister("Save_PIC")
    ; Clean up resources
    _GDIPlus_PenDispose($Pen)
    _GDIPlus_GraphicsDispose ($hGraphic)
    _GDIPlus_FontDispose ($Font)
    _GDIPlus_FontFamilyDispose ($Font_Family)
    _GDIPlus_StringFormatDispose ($String_Format)
    _GDIPlus_BrushDispose($Brush)
    _GDIPlus_Shutdown ()
    DllClose($dll)
    Exit
EndFunc
