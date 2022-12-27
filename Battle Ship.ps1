#This is free and unencumbered software released into the public domain.
#
#Anyone is free to copy, modify, publish, use, compile, sell, or
#distribute this software, either in source code form or as a compiled
#binary, for any purpose, commercial or non-commercial, and by any
#means.
#
#In jurisdictions that recognize copyright laws, the author or authors
#of this software dedicate any and all copyright interest in the
#software to the public domain. We make this dedication for the benefit
#of the public at large and to the detriment of our heirs and
#successors. We intend this dedication to be an overt act of
#relinquishment in perpetuity of all present and future rights to this
#software under copyright law.

#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
#EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
#MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
#IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
#OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
#ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
#OTHER DEALINGS IN THE SOFTWARE.
#
#For more information, please refer to <https://unlicense.org>
#
#Written by Stephen Kofskie; https://www.kofskie.com

function get-coordinatesyntaxcheck{  
#This function is used to check the syntax of either a user created coordinate or computer created coordinate by making sure the coordinate fits in the range of the grid. 
#The corrdinate is split into its column (A-J) and row (1-10). The function checks three things: the length of the coordinate, the x coordinate, and the y coordinate. 
#If all three checks pass, the function returns a $true statement.
    param(
        [parameter(mandatory=$true)]$coor
    )

    $syntaxfinalcheck = $false
    $lengthcheck = $false
    $xcheck = $false
    $ycheck = $false
    $arrayofletters = @('a','b','c','d','e','f','g','h','i','j')
    $arrayofnumbers = @(1,2,3,4,5,6,7,8,9)
    $xcoorforcheck = $coor[0]
    $ycoorforcheck = [int]::Parse($coor[1])

    #Length check
    if($coor.Length -gt 1 -and $coor.Length -lt 4){
        $lengthcheck = $true
    }
    
    #X and y coordinate check
    if($coor.length -eq 2){
        foreach($i in $arrayofletters){
            if($xcoorforcheck -eq $i){$xcheck = $true}
        }
        foreach($i in $arrayofnumbers){
            if($ycoorforcheck -eq $i){$ycheck = $true}
        }
    }else{
        $middledigitcheck = $coor[1] -eq '1'
        $lastdigitcheck = $coor[2] -eq '0'
        if($lastdigitcheck -eq $true -and $middledigitcheck -eq $true){
            $ycheck = $true
            foreach($i in $arrayofletters){
                if($xcoorforcheck -eq $i){$xcheck = $true}
            }
        }else{
            $xcheck = $false
            $ycheck = $false
        }  
    }

    #final check
    switch($lengthcheck){
        $true{
            switch($xcheck){
                $true{
                    switch($ycheck){
                        $true{$syntaxfinalcheck = $true}
                        $false{$syntaxfinalcheck = $false}
                    }
                }
                $false{$syntaxfinalcheck = $false}
            }
        }
        $false{$syntaxfinalcheck = $false}
    }
    $syntaxfinalcheck
}

function get-blankgrid{  #This function just presents a blank grid on screen. Its used only a couple times in the game. 

    $frame1  = (' ',' ',' ',' ',' ',' ',' ',' ',' ','A',' ',' ',' ','B',' ',' ',' ','C',' ',' ',' ','D',' ',' ',' ','E',' ',' ',' ','F',' ',' ',' ','G',' ',' ',' ','H',' ',' ',' ','I',' ',' ',' ','J',' ')
    $frame2  = (" "," "," "," "," "," "," ","╔"," ","═"," ","╦"," ","═"," ","╦"," ","═"," ","╦"," ","═"," ","╦"," ","═"," ","╦"," ","═"," ","╦"," ","═"," ","╦"," ","═"," ","╦"," ","═"," ","╦"," ","═"," ","╗")
    $dr1     = (" "," "," "," "," "," ","1","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║")
    $frame3  = (" "," "," "," "," "," "," ","╠"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╣")
    $dr2     = (" "," "," "," "," "," ","2","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║")
    $frame4  = (" "," "," "," "," "," "," ","╠"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╣")
    $dr3     = (" "," "," "," "," "," ","3","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║")
    $frame5  = (" "," "," "," "," "," "," ","╠"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╣")
    $dr4     = (" "," "," "," "," "," ","4","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║")
    $frame6  = (" "," "," "," "," "," "," ","╠"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╣")
    $dr5     = (" "," "," "," "," "," ","5","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║")
    $frame7  = (" "," "," "," "," "," "," ","╠"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╣")
    $dr6     = (" "," "," "," "," "," ","6","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║")
    $frame8  = (" "," "," "," "," "," "," ","╠"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╣")
    $dr7     = (" "," "," "," "," "," ","7","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║")
    $frame9  = (" "," "," "," "," "," "," ","╠"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╣")
    $dr8     = (" "," "," "," "," "," ","8","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║")
    $frame10 = (" "," "," "," "," "," "," ","╠"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╣")
    $dr9     = (" "," "," "," "," "," ","9","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║")
    $frame11 = (" "," "," "," "," "," "," ","╠"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╣")
    $dr10    = (" "," "," "," "," ","10","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║"," "," "," ","║")
    $frame12 = (" "," "," "," "," "," "," ","╚"," ","═"," ","╩"," ","═"," ","╩"," ","═"," ","╩"," ","═"," ","╩"," ","═"," ","╩"," ","═"," ","╩"," ","═"," ","╩"," ","═"," ","╩"," ","═"," ","╩"," ","═"," ","╝")

    $frame1 -join "";$frame2 -join "";$dr1 -join "";$frame3 -join "";$dr2 -join "";$frame4 -join "";$dr3 -join "";$frame5 -join "";$dr4 -join "";$frame6 -join "";$dr5 -join "";$frame7 -join "";
    $dr6 -join "";$frame8 -join "";$dr7 -join "";$frame9 -join "";$dr8 -join "";$frame10 -join "";$dr9 -join "";$frame11 -join "";$dr10 -join "";$frame12 -join "";
}

function new-grid{
#This function is used to display the grid, or playing field, for either the player or enemy. This shows ships along with hits and misses. 
#It is also used when the player is initally placing their ships on the grid.
    param(
        [string[]]$coordinates1, #In order to use an array of coordinates, the parameter variables have to be declared strings with brackets within them. (i.e. [string[]])
        [string[]]$coordinates2,
        [string[]]$coordinates3,
        [string[]]$coordinates4,
        [string[]]$coordinates5,
        [string[]]$hits,
        [string[]]$misses
    )

    $ch = "█" #The symbol for a user ship

    $allcoordinates = @() #This array stores all the ship coordinates from either the player or enemy. 

    #Blank Coordinates 
    $a1=" ";$a2=" ";$a3=" ";$a4=" ";$a5=" ";$a6=" ";$a7=" ";$a8=" ";$a9=" ";$a10=" ";
    $b1=" ";$b2=" ";$b3=" ";$b4=" ";$b5=" ";$b6=" ";$b7=" ";$b8=" ";$b9=" ";$b10=" ";
    $c1=" ";$c2=" ";$c3=" ";$c4=" ";$c5=" ";$c6=" ";$c7=" ";$c8=" ";$c9=" ";$c10=" ";
    $d1=" ";$d2=" ";$d3=" ";$d4=" ";$d5=" ";$d6=" ";$d7=" ";$d8=" ";$d9=" ";$d10=" ";
    $e1=" ";$e2=" ";$e3=" ";$e4=" ";$e5=" ";$e6=" ";$e7=" ";$e8=" ";$e9=" ";$e10=" ";
    $f1=" ";$f2=" ";$f3=" ";$f4=" ";$f5=" ";$f6=" ";$f7=" ";$f8=" ";$f9=" ";$f10=" ";
    $g1=" ";$g2=" ";$g3=" ";$g4=" ";$g5=" ";$g6=" ";$g7=" ";$g8=" ";$g9=" ";$g10=" ";
    $h1=" ";$h2=" ";$h3=" ";$h4=" ";$h5=" ";$h6=" ";$h7=" ";$h8=" ";$h9=" ";$h10=" ";
    $i1=" ";$i2=" ";$i3=" ";$i4=" ";$i5=" ";$i6=" ";$i7=" ";$i8=" ";$i9=" ";$i10=" ";
    $j1=" ";$j2=" ";$j3=" ";$j4=" ";$j5=" ";$j6=" ";$j7=" ";$j8=" ";$j9=" ";$j10=" ";

    #adding all ship coordinates to $allcoordinates array.
    foreach($i in $coordinates1){
            $allcoordinates += $i
    }
    if($coordinates2 -ne $null){
        foreach($i in $coordinates2){
            $allcoordinates += $i
        }
    }
    if($coordinates3 -ne $null){
        foreach($i in $coordinates3){
            $allcoordinates += $i
        }
    }
    if($coordinates4 -ne $null){
        foreach($i in $coordinates4){
            $allcoordinates += $i
        }
    }
    if($coordinates5 -ne $null){
        foreach($i in $coordinates5){
            $allcoordinates += $i
        }
    }
    
    #placing everything inside the $allcoordinates array onto the grid
    foreach($coor in $allcoordinates){
        $xcoor = $coor[0]
        if($coor.length -eq 3){
            $ycoor = 10
        }else{
            $ycoor = [int]::Parse($coor[1]) #This is used to turn a portion of a string into an integer.
        }

        switch($xcoor){
            'a'{switch($ycoor){1{$a1 = $ch};2{$a2 = $ch};3{$a3 = $ch};4{$a4 = $ch};5{$a5 = $ch};6{$a6 = $ch};7{$a7 = $ch};8{$a8 = $ch};9{$a9 = $ch};10{$a10 = $ch}}}
            'b'{switch($ycoor){1{$b1 = $ch};2{$b2 = $ch};3{$b3 = $ch};4{$b4 = $ch};5{$b5 = $ch};6{$b6 = $ch};7{$b7 = $ch};8{$b8 = $ch};9{$b9 = $ch};10{$b10 = $ch}}}
            'c'{switch($ycoor){1{$c1 = $ch};2{$c2 = $ch};3{$c3 = $ch};4{$c4 = $ch};5{$c5 = $ch};6{$c6 = $ch};7{$c7 = $ch};8{$c8 = $ch};9{$c9 = $ch};10{$c10 = $ch}}}
            'd'{switch($ycoor){1{$d1 = $ch};2{$d2 = $ch};3{$d3 = $ch};4{$d4 = $ch};5{$d5 = $ch};6{$d6 = $ch};7{$d7 = $ch};8{$d8 = $ch};9{$d9 = $ch};10{$d10 = $ch}}}
            'e'{switch($ycoor){1{$e1 = $ch};2{$e2 = $ch};3{$e3 = $ch};4{$e4 = $ch};5{$e5 = $ch};6{$e6 = $ch};7{$e7 = $ch};8{$e8 = $ch};9{$e9 = $ch};10{$e10 = $ch}}}
            'f'{switch($ycoor){1{$f1 = $ch};2{$f2 = $ch};3{$f3 = $ch};4{$f4 = $ch};5{$f5 = $ch};6{$f6 = $ch};7{$f7 = $ch};8{$f8 = $ch};9{$f9 = $ch};10{$f10 = $ch}}}
            'g'{switch($ycoor){1{$g1 = $ch};2{$g2 = $ch};3{$g3 = $ch};4{$g4 = $ch};5{$g5 = $ch};6{$g6 = $ch};7{$g7 = $ch};8{$g8 = $ch};9{$g9 = $ch};10{$g10 = $ch}}}
            'h'{switch($ycoor){1{$h1 = $ch};2{$h2 = $ch};3{$h3 = $ch};4{$h4 = $ch};5{$h5 = $ch};6{$h6 = $ch};7{$h7 = $ch};8{$h8 = $ch};9{$h9 = $ch};10{$h10 = $ch}}}
            'i'{switch($ycoor){1{$i1 = $ch};2{$i2 = $ch};3{$i3 = $ch};4{$i4 = $ch};5{$i5 = $ch};6{$i6 = $ch};7{$i7 = $ch};8{$i8 = $ch};9{$i9 = $ch};10{$i10 = $ch}}}
            'j'{switch($ycoor){1{$j1 = $ch};2{$j2 = $ch};3{$j3 = $ch};4{$j4 = $ch};5{$j5 = $ch};6{$j6 = $ch};7{$j7 = $ch};8{$j8 = $ch};9{$j9 = $ch};10{$j10 = $ch}}}
        }
    }

    #placing everything inside the hits array onto the grid.
    if($hits -ne $null){
        $ch = 'X' #The symbol used to show that a coordinate was hit by an opponent.
        foreach($coor in $hits){
            $xcoor = $coor[0]
            if($coor.length -eq 3){
                $ycoor = 10
            }else{
                $ycoor = [int]::Parse($coor[1])
            }

            switch($xcoor){
                'a'{switch($ycoor){1{$a1 = $ch};2{$a2 = $ch};3{$a3 = $ch};4{$a4 = $ch};5{$a5 = $ch};6{$a6 = $ch};7{$a7 = $ch};8{$a8 = $ch};9{$a9 = $ch};10{$a10 = $ch}}}
                'b'{switch($ycoor){1{$b1 = $ch};2{$b2 = $ch};3{$b3 = $ch};4{$b4 = $ch};5{$b5 = $ch};6{$b6 = $ch};7{$b7 = $ch};8{$b8 = $ch};9{$b9 = $ch};10{$b10 = $ch}}}
                'c'{switch($ycoor){1{$c1 = $ch};2{$c2 = $ch};3{$c3 = $ch};4{$c4 = $ch};5{$c5 = $ch};6{$c6 = $ch};7{$c7 = $ch};8{$c8 = $ch};9{$c9 = $ch};10{$c10 = $ch}}}
                'd'{switch($ycoor){1{$d1 = $ch};2{$d2 = $ch};3{$d3 = $ch};4{$d4 = $ch};5{$d5 = $ch};6{$d6 = $ch};7{$d7 = $ch};8{$d8 = $ch};9{$d9 = $ch};10{$d10 = $ch}}}
                'e'{switch($ycoor){1{$e1 = $ch};2{$e2 = $ch};3{$e3 = $ch};4{$e4 = $ch};5{$e5 = $ch};6{$e6 = $ch};7{$e7 = $ch};8{$e8 = $ch};9{$e9 = $ch};10{$e10 = $ch}}}
                'f'{switch($ycoor){1{$f1 = $ch};2{$f2 = $ch};3{$f3 = $ch};4{$f4 = $ch};5{$f5 = $ch};6{$f6 = $ch};7{$f7 = $ch};8{$f8 = $ch};9{$f9 = $ch};10{$f10 = $ch}}}
                'g'{switch($ycoor){1{$g1 = $ch};2{$g2 = $ch};3{$g3 = $ch};4{$g4 = $ch};5{$g5 = $ch};6{$g6 = $ch};7{$g7 = $ch};8{$g8 = $ch};9{$g9 = $ch};10{$g10 = $ch}}}
                'h'{switch($ycoor){1{$h1 = $ch};2{$h2 = $ch};3{$h3 = $ch};4{$h4 = $ch};5{$h5 = $ch};6{$h6 = $ch};7{$h7 = $ch};8{$h8 = $ch};9{$h9 = $ch};10{$h10 = $ch}}}
                'i'{switch($ycoor){1{$i1 = $ch};2{$i2 = $ch};3{$i3 = $ch};4{$i4 = $ch};5{$i5 = $ch};6{$i6 = $ch};7{$i7 = $ch};8{$i8 = $ch};9{$i9 = $ch};10{$i10 = $ch}}}
                'j'{switch($ycoor){1{$j1 = $ch};2{$j2 = $ch};3{$j3 = $ch};4{$j4 = $ch};5{$j5 = $ch};6{$j6 = $ch};7{$j7 = $ch};8{$j8 = $ch};9{$j9 = $ch};10{$j10 = $ch}}}
            }
        }
    }

    #placing everything inside the misses array onto the grid. 
    if($misses -ne $null){
        $ch = 'O' #The symbol used to show that a coordinate picked by an opponent found nothing.
        foreach($coor in $misses){
            $xcoor = $coor[0]
            if($coor.length -eq 3){
                $ycoor = 10
            }else{
                $ycoor = [int]::Parse($coor[1])
            }

            switch($xcoor){
                'a'{switch($ycoor){1{$a1 = $ch};2{$a2 = $ch};3{$a3 = $ch};4{$a4 = $ch};5{$a5 = $ch};6{$a6 = $ch};7{$a7 = $ch};8{$a8 = $ch};9{$a9 = $ch};10{$a10 = $ch}}}
                'b'{switch($ycoor){1{$b1 = $ch};2{$b2 = $ch};3{$b3 = $ch};4{$b4 = $ch};5{$b5 = $ch};6{$b6 = $ch};7{$b7 = $ch};8{$b8 = $ch};9{$b9 = $ch};10{$b10 = $ch}}}
                'c'{switch($ycoor){1{$c1 = $ch};2{$c2 = $ch};3{$c3 = $ch};4{$c4 = $ch};5{$c5 = $ch};6{$c6 = $ch};7{$c7 = $ch};8{$c8 = $ch};9{$c9 = $ch};10{$c10 = $ch}}}
                'd'{switch($ycoor){1{$d1 = $ch};2{$d2 = $ch};3{$d3 = $ch};4{$d4 = $ch};5{$d5 = $ch};6{$d6 = $ch};7{$d7 = $ch};8{$d8 = $ch};9{$d9 = $ch};10{$d10 = $ch}}}
                'e'{switch($ycoor){1{$e1 = $ch};2{$e2 = $ch};3{$e3 = $ch};4{$e4 = $ch};5{$e5 = $ch};6{$e6 = $ch};7{$e7 = $ch};8{$e8 = $ch};9{$e9 = $ch};10{$e10 = $ch}}}
                'f'{switch($ycoor){1{$f1 = $ch};2{$f2 = $ch};3{$f3 = $ch};4{$f4 = $ch};5{$f5 = $ch};6{$f6 = $ch};7{$f7 = $ch};8{$f8 = $ch};9{$f9 = $ch};10{$f10 = $ch}}}
                'g'{switch($ycoor){1{$g1 = $ch};2{$g2 = $ch};3{$g3 = $ch};4{$g4 = $ch};5{$g5 = $ch};6{$g6 = $ch};7{$g7 = $ch};8{$g8 = $ch};9{$g9 = $ch};10{$g10 = $ch}}}
                'h'{switch($ycoor){1{$h1 = $ch};2{$h2 = $ch};3{$h3 = $ch};4{$h4 = $ch};5{$h5 = $ch};6{$h6 = $ch};7{$h7 = $ch};8{$h8 = $ch};9{$h9 = $ch};10{$h10 = $ch}}}
                'i'{switch($ycoor){1{$i1 = $ch};2{$i2 = $ch};3{$i3 = $ch};4{$i4 = $ch};5{$i5 = $ch};6{$i6 = $ch};7{$i7 = $ch};8{$i8 = $ch};9{$i9 = $ch};10{$i10 = $ch}}}
                'j'{switch($ycoor){1{$j1 = $ch};2{$j2 = $ch};3{$j3 = $ch};4{$j4 = $ch};5{$j5 = $ch};6{$j6 = $ch};7{$j7 = $ch};8{$j8 = $ch};9{$j9 = $ch};10{$j10 = $ch}}}
            }
        }
    }

    #The grid to be displayed after all array items added.
    $frame1  = (' ',' ',' ',' ',' ',' ',' ',' ',' ','A',' ',' ',' ','B',' ',' ',' ','C',' ',' ',' ','D',' ',' ',' ','E',' ',' ',' ','F',' ',' ',' ','G',' ',' ',' ','H',' ',' ',' ','I',' ',' ',' ','J',' ')
    $frame2  = (" "," "," "," "," "," "," ","╔"," ","═"," ","╦"," ","═"," ","╦"," ","═"," ","╦"," ","═"," ","╦"," ","═"," ","╦"," ","═"," ","╦"," ","═"," ","╦"," ","═"," ","╦"," ","═"," ","╦"," ","═"," ","╗")
    $dr1     = (" "," "," "," "," "," ","1","║"," ","$a1"," ","║"," ","$b1"," ","║"," ","$c1"," ","║"," ","$d1"," ","║"," ","$e1"," ","║"," ","$f1"," ","║"," ","$g1"," ","║"," ","$h1"," ","║"," ","$i1"," ","║"," ","$j1"," ","║")
    $frame3  = (" "," "," "," "," "," "," ","╠"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╣")
    $dr2     = (" "," "," "," "," "," ","2","║"," ","$a2"," ","║"," ","$b2"," ","║"," ","$c2"," ","║"," ","$d2"," ","║"," ","$e2"," ","║"," ","$f2"," ","║"," ","$g2"," ","║"," ","$h2"," ","║"," ","$i2"," ","║"," ","$j2"," ","║")
    $frame4  = (" "," "," "," "," "," "," ","╠"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╣")
    $dr3     = (" "," "," "," "," "," ","3","║"," ","$a3"," ","║"," ","$b3"," ","║"," ","$c3"," ","║"," ","$d3"," ","║"," ","$e3"," ","║"," ","$f3"," ","║"," ","$g3"," ","║"," ","$h3"," ","║"," ","$i3"," ","║"," ","$j3"," ","║")
    $frame5  = (" "," "," "," "," "," "," ","╠"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╣")
    $dr4     = (" "," "," "," "," "," ","4","║"," ","$a4"," ","║"," ","$b4"," ","║"," ","$c4"," ","║"," ","$d4"," ","║"," ","$e4"," ","║"," ","$f4"," ","║"," ","$g4"," ","║"," ","$h4"," ","║"," ","$i4"," ","║"," ","$j4"," ","║")
    $frame6  = (" "," "," "," "," "," "," ","╠"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╣")
    $dr5     = (" "," "," "," "," "," ","5","║"," ","$a5"," ","║"," ","$b5"," ","║"," ","$c5"," ","║"," ","$d5"," ","║"," ","$e5"," ","║"," ","$f5"," ","║"," ","$g5"," ","║"," ","$h5"," ","║"," ","$i5"," ","║"," ","$j5"," ","║")
    $frame7  = (" "," "," "," "," "," "," ","╠"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╣")
    $dr6     = (" "," "," "," "," "," ","6","║"," ","$a6"," ","║"," ","$b6"," ","║"," ","$c6"," ","║"," ","$d6"," ","║"," ","$e6"," ","║"," ","$f6"," ","║"," ","$g6"," ","║"," ","$h6"," ","║"," ","$i6"," ","║"," ","$j6"," ","║")
    $frame8  = (" "," "," "," "," "," "," ","╠"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╣")
    $dr7     = (" "," "," "," "," "," ","7","║"," ","$a7"," ","║"," ","$b7"," ","║"," ","$c7"," ","║"," ","$d7"," ","║"," ","$e7"," ","║"," ","$f7"," ","║"," ","$g7"," ","║"," ","$h7"," ","║"," ","$i7"," ","║"," ","$j7"," ","║")
    $frame9  = (" "," "," "," "," "," "," ","╠"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╣")
    $dr8     = (" "," "," "," "," "," ","8","║"," ","$a8"," ","║"," ","$b8"," ","║"," ","$c8"," ","║"," ","$d8"," ","║"," ","$e8"," ","║"," ","$f8"," ","║"," ","$g8"," ","║"," ","$h8"," ","║"," ","$i8"," ","║"," ","$j8"," ","║")
    $frame10 = (" "," "," "," "," "," "," ","╠"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╣")
    $dr9     = (" "," "," "," "," "," ","9","║"," ","$a9"," ","║"," ","$b9"," ","║"," ","$c9"," ","║"," ","$d9"," ","║"," ","$e9"," ","║"," ","$f9"," ","║"," ","$g9"," ","║"," ","$h9"," ","║"," ","$i9"," ","║"," ","$j9"," ","║")
    $frame11 = (" "," "," "," "," "," "," ","╠"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╬"," ","═"," ","╣")
    $dr10    = (" "," "," "," "," ","10","║"," ","$a10"," ","║"," ","$b10"," ","║"," ","$c10"," ","║"," ","$d10"," ","║"," ","$e10"," ","║"," ","$f10"," ","║"," ","$g10"," ","║"," ","$h10"," ","║"," ","$i10"," ","║"," ","$j10"," ","║")
    $frame12 = (" "," "," "," "," "," "," ","╚"," ","═"," ","╩"," ","═"," ","╩"," ","═"," ","╩"," ","═"," ","╩"," ","═"," ","╩"," ","═"," ","╩"," ","═"," ","╩"," ","═"," ","╩"," ","═"," ","╩"," ","═"," ","╝")

    $frame1 -join "";$frame2 -join "";$dr1 -join "";$frame3 -join "";$dr2 -join "";$frame4 -join "";$dr3 -join "";$frame5 -join "";$dr4 -join "";$frame6 -join "";$dr5 -join "";$frame7 -join "";
    $dr6 -join "";$frame8 -join "";$dr7 -join "";$frame9 -join "";$dr8 -join "";$frame10 -join "";$dr9 -join "";$frame11 -join "";$dr10 -join "";$frame12 -join "";
}

function get-shipcollisioncheck{
#This function is used to check if any of the ships generated by either opponent will collide with one another. Requires at least two arrays. Returns either $true or $false, with
#$false meaning that there is no collision occuring.
    param(
        [parameter(mandatory=$true)][string[]]$ship1,
        [parameter(mandatory=$true)][string[]]$ship2,
        $ship3,
        $ship4,
        $ship5
    )

    $finalcollisioncheck = $true
    $collisions = 0

    #collision check for ship 1 and ship 2.
    foreach($i in $ship2){foreach($x in $ship1){if($x -eq $i){$collisions++}}    }

    #collision check for ship 1, ship 2, ship 3.
    if($ship3 -ne $null){
        foreach($i in $ship3){
            foreach($x in $ship1){
                if($x -eq $i){
                    $collisions++}}}
        foreach($i in $ship3){foreach($x in $ship2){if($x -eq $i){$collisions++}}}
    }

    #collision check for ship 1, ship 2, ship 3, ship 4.
    if($ship4 -ne $null){
        foreach($i in $ship4){foreach($x in $ship1){if($x -eq $i){$collisions++}}}
        foreach($i in $ship4){foreach($x in $ship2){if($x -eq $i){$collisions++}}}
        foreach($i in $ship4){foreach($x in $ship3){if($x -eq $i){$collisions++}}}
    }

    #collision check for ship 1, ship 2, ship 3, ship 4, ship 5.
    if($ship5 -ne $null){
        foreach($i in $ship5){foreach($x in $ship1){if($x -eq $i){$collisions++}}}
        foreach($i in $ship5){foreach($x in $ship2){if($x -eq $i){$collisions++}}}
        foreach($i in $ship5){foreach($x in $ship3){if($x -eq $i){$collisions++}}}
        foreach($i in $ship5){foreach($x in $ship4){if($x -eq $i){$collisions++}}}
    }

    if($collisions -lt 1){$finalcollisioncheck = $false}

    $finalcollisioncheck
}

function get-othercoordinates{
#This function is used to generate the other coordinates for both opponents after a coordinate was selected while selecting a position for a ship.
#This generates coordinates based off of whether a opponent chose to align their ship horizontally or vertically. If the function can't generate 
#cooridnates, it returns $null.
    param(
        [parameter(mandatory=$true)]$centercoordinate, #The coordinate chosen by the opponent to place the center of the ship.
        [parameter(mandatory=$true)]$orientation,      #The orientation that the opponent wants the ship pointed.
        [parameter(mandatory=$true)][int]$shiplength   #The length of the ship to accurately get the correct center.
    )

    $alphaletters = ('a','b','c','d','e','f','g','h','i','j')

    $positionsearchfound = @()   #This stores either the x or y coordinates generated based on orientation and ship length.
    $xcoor = $centercoordinate[0]
    if($centercoordinate.length -eq 3){  #This is used to determine if the y coordinate is '10' or below.
        $ycoor = 10
    }else{
        $ycoor = [int]::Parse($centercoordinate[1])
    }
    $combine = @()               #This array combines the separately generated x and y coordinates depending on ship orientation.
    $finalcheck = $false

    switch($orientation){
        'h'{
            $positionsearch = 0..($alphaletters.count) | ?{$alphaletters[$_] -eq $xcoor} #finds the position of the opponent's x coordinate within the $alphaletters array.

            switch($shiplength){     #Depending on the ship length, this subtracts and adds to the remaining spots needed to make a complete ship.
                5{
                    $positionsearchfound += ($positionsearch - 2)
                    $positionsearchfound += ($positionsearch - 1)
                    $positionsearchfound += ($positionsearch + 1)
                    $positionsearchfound += ($positionsearch + 2)
                }
                4{
                    $positionsearchfound += ($positionsearch - 1)
                    $positionsearchfound += ($positionsearch + 1)
                    $positionsearchfound += ($positionsearch + 2)
                }
                3{
                    $positionsearchfound += ($positionsearch - 1)
                    $positionsearchfound += ($positionsearch + 1)
                }
                2{
                    $positionsearchfound += ($positionsearch - 1)
                }
            }

            #check
            #This checks to make sure the first and last items within the array $positionsearchfound doesn't fall outside the items within the array $alphaletters.
            $arraycount = $positionsearchfound.Count
            $endpoint = ($arraycount - 1)

            if($positionsearchfound[0] -lt 0){
                $finalcheck = $false
            }elseif($positionsearchfound[$endpoint] -gt 9){
                $finalcheck = $false
            }else{$finalcheck = $true}

            foreach($i in $positionsearchfound){     #combines the new x coordinates with the existing y coordinate for the rest of the positions of the ship.
                $combine += ($alphaletters[$i] + $ycoor)
            }
        }
        'v'{
            switch($shiplength){     #Depending on the ship length, this subtracts and adds to the remaining spots needed to make a complete ship.
                5{
                    $positionsearchfound += ($ycoor - 2)
                    $positionsearchfound += ($ycoor - 1)
                    $positionsearchfound += ($ycoor + 1)
                    $positionsearchfound += ($ycoor + 2)
                }
                4{
                    $positionsearchfound += ($ycoor - 1)
                    $positionsearchfound += ($ycoor + 1)
                    $positionsearchfound += ($ycoor + 2)
                }
                3{
                    $positionsearchfound += ($ycoor - 1)
                    $positionsearchfound += ($ycoor + 1)
                }
                2{
                    $positionsearchfound += ($ycoor - 1)
                }
            }
            
            #check
            #This checks to make sure the first and last items within the array $positionsearchfound stays between 1 and 10. 
            $arraycount = $positionsearchfound.Count
            $endpoint = ($arraycount - 1)

            if($positionsearchfound[0] -lt 1){
                $finalcheck = $false
            }elseif($positionsearchfound[$endpoint] -gt 10){
                $finalcheck = $false
            }else{$finalcheck = $true}

            foreach($i in $positionsearchfound){
                $combine += ($xcoor + $i)
            }
        }
    }
    
    #If the checks between either portion of the $orientation switch fails, the outputted array will be $null. Else, the rest of the ship's needed array is outputted.
    if($finalcheck -eq $true){
        $combine
    }else{
        $combine = $null
        $combine
    }
}

function new-enemycoordinate{
#This function generates the intital centerpoint for the enemy's ships. For the 5 and 4 block ships, I had to create an out of bounds area on the grid so it could
#properly generate other parts of the ship when it's centerpoint created here is placed in the get-othercoordinates function.
    param(
        [parameter(mandatory=$true)]$shiplength
    )
    
    $alphaletters = ('a','b','c','d','e','f','g','h','i','j')
    $check = $false
    $outofbounds = @('a1','b1','c1','d1','e1','f1','g1','h1','i1','j1','a2','b2','c2','d2','e2','f2','g2','h2','i2','j2','a3','a4','a5','a6','a7','a8','a9','a10','b3','b4','b5','b6','b7','b8','b9','b10','i3','i4','i5','i6','i7','i8','i9','i10','j3','j4','j5','j6','j7','j8','j9','j10','c9','d9','e9','f9','g9','h9','c10','d10','e10','f10','g10','h10')
    $outofbounds2 = @('a1','b1','c1','d1','e1','f1','g1','h1','i1','i2','i3','i4','i5','i6','i7','i8','i9','j1','a2','j2','a3','a4','a5','a6','a7','a8','a9','a10','b10','i10','j3','j4','j5','j6','j7','j8','j9','j10','c10','d10','e10','f10','g10','h10')
    $outofbounds3 = @('a1','b1','c1','d1','e1','f1','g1','h1','i1','j1','a2','j2','a3','a4','a5','a6','a7','a8','a9','a10','b10','i10','j3','j4','j5','j6','j7','j8','j9','j10','c10','d10','e10','f10','g10','h10')
    
    $failedbank = @()     #This array stores any generated coordinates that do not fit with my boundaries.

    switch($shiplength){
        5{
            do{
                $xcoorrando = get-random -Minimum 0 -Maximum 10
                $ycoorrando = get-random -Minimum 3 -Maximum 9

                $combine = ($alphaletters[$xcoorrando]+$ycoorrando)

                $containsoutofbound = $outofbounds -contains $combine   #Check to see if the generated coordinate is one of my pre-selected out of bounds areas.
                $containsfailed = $failedbank -contains $combine        #Check to see if the generated coordinate was a previously failed attempt at generating one. 


                if($containsoutofbound -eq $true){
                    $failedbank += $combine
                }

                if($containsoutofbound -eq $false -and $containsfailed -eq $false){
                    $check = $true
                }

            }until($check -eq $true)
        }
        4{
            do{
                $xcoorrando = get-random -Minimum 0 -Maximum 10
                $ycoorrando = get-random -Minimum 2 -Maximum 9

                $combine = ($alphaletters[$xcoorrando]+$ycoorrando)

                $containsoutofbound = $outofbounds2 -contains $combine
                $containsfailed = $failedbank -contains $combine


                if($containsoutofbound -eq $true){
                    $failedbank += $combine
                }

                if($containsoutofbound -eq $false -and $containsfailed -eq $false){
                    $check = $true
                }

            }until($check -eq $true)
        }
        3{
            do{
                $xcoorrando = get-random -Minimum 0 -Maximum 10
                $ycoorrando = get-random -Minimum 2 -Maximum 10

                $combine = ($alphaletters[$xcoorrando]+$ycoorrando)

                $containsoutofbound = $outofbounds3 -contains $combine
                $containsfailed = $failedbank -contains $combine


                if($containsoutofbound -eq $true){
                    $failedbank += $combine
                }

                if($containsoutofbound -eq $false -and $containsfailed -eq $false){
                    $check = $true
                }

            }until($check -eq $true)
        }
        2{
            do{
                $xcoorrando = get-random -Minimum 0 -Maximum 10
                $ycoorrando = get-random -Minimum 2 -Maximum 10

                $combine = ($alphaletters[$xcoorrando]+$ycoorrando)

                $containsoutofbound = $outofbounds3 -contains $combine
                $containsfailed = $failedbank -contains $combine


                if($containsoutofbound -eq $true){
                    $failedbank += $combine
                }

                if($containsoutofbound -eq $false -and $containsfailed -eq $false){
                    $check = $true
                }

            }until($check -eq $true)
        }
    }

    $combine
}

function get-enemyorientation{
#This function just randomly generates whether the enemy will place one of their ships horizontally or vertically. 
    $orientationletters = @('h','v')

    $rando = Get-Random -Minimum 0 -Maximum 2
    $orientation = $orientationletters[$rando]
    $orientation
}

function join-coordinates{
#This function just joins all the coordinates from either one of the opponents' fleet of ships into an array. This array is used
#during the game to see if the opponents choice of coordinate to fire upon actually hits something.
    param(
        [parameter(mandatory=$true)][string[]]$ship1,
        [parameter(mandatory=$true)][string[]]$ship2,
        [parameter(mandatory=$true)][string[]]$ship3,
        [parameter(mandatory=$true)][string[]]$ship4,
        [parameter(mandatory=$true)][string[]]$ship5
    )

    $combine = @()

    foreach($i in $ship1){$combine += $i}
    foreach($i in $ship2){$combine += $i}
    foreach($i in $ship3){$combine += $i}
    foreach($i in $ship4){$combine += $i}
    foreach($i in $ship5){$combine += $i}

    $combine
}

function new-enemyfindusership{
#This function generates a coordinate to fire upon the player grid.    
    $alphaletters = ('a','b','c','d','e','f','g','h','i','j')

    $xcoorrando = get-random -Minimum 0 -Maximum 10
    $ycoorrando = get-random -Minimum 1 -Maximum 11
    $combine = ($alphaletters[$xcoorrando]+$ycoorrando)

    $combine
}

#Inital text
$title1 = '                   P O W E R S H E L L              '
$title2 = '        ╔══╗ ╔══╗ ═╦═ ═╦═ ╗   ╔═══ ╔═══ ╗  ╗ ╗ ╔══╗ '
$title3 = '        ╠══╣ ╠══╣  ║   ║  ║   ╠═   ╚══╗ ╠══╣ ║ ╠══╝ '
$title4 = '        ╚══╝ ╚  ╚  ╚   ╚  ╚══ ╚═══ ═══╝ ╚  ╚ ╚ ╚    '
$alphaletters = ('a','b','c','d','e','f','g','h','i','j')
$entrytext1 = "Enter the coordinate to place the center of the 1st boat. This is 5 spaces big. (Ex. E5)"
$entrytext2 = "Enter the coordinate to place the center of the 2nd boat. This is 4 spaces big. (Ex. E5)"
$entrytext3 = "Enter the coordinate to place the center of the 3rd boat. This is 4 spaces big. (Ex. E5)"
$entrytext4 = "Enter the coordinate to place the center of the 4th boat. This is 3 spaces big. (Ex. E5)"
$entrytext5 = "Enter the coordinate to place the center of the 5th boat. This is 2 spaces big. (Ex. E5)"
$confirmcoordinatestext1 = "Do you want to confirm your ships' coordinates? (Y/N)"
$orientationtext = "What orientation do you want to point the boat? [H]orizontal (left to right) or [V]ertical (up and down)? Type 'exit' to quit."

#Menu
do{
    cls
    "`n"
    $title1
    $title2
    $title3
    $title4
    "`n"
    '                          Menu'
    '                     1) Start Game '
    '                     2) How to Play '
    '                     3) Exit '
    "`n"
    $startprompt = Read-Host -Prompt "Enter choice [1],[2],[3]:"
    while('1','2','3' -notcontains $startprompt){
        $startprompt = $startprompt = Read-Host -Prompt "Invalid response. Enter choice [1],[2],[3]:"
    }

    if($startprompt -eq 2){ #How to play menu option
        cls
        "`n"
"   How to play:"
"`n"
"   This game plays like the classic battleship board game. You, the"
"   player, choose the location of 5 ships on your side of the field,"
"   also called the grid. Next, the enemy (computer) chooses the"
"   location of their 5 ships on their grid. From there, the battle"
"   begins. Starting with the player, they choose a spot on the"
"   enemy's grid to attack one of the enemy's boats. The enemy takes"
"   their turn and chooses a spot on the player's grid to attack one"
"   of the player's boats. This goes back and forth until one of the"
"   opponents' fleet of ships are destroyed first."
"   Can you take the challenge?"
"`n"
Pause

cls
"`n"
"   Choosing ship position:"
"`n"
"   -When choosing where to place a ship, the player will be asked"
"   where to place the center of the ship and to point the ship"
"   either it horizontally or vertically. There are 5 ships in"
"   different sizes (5 blocks, 4 blocks, 4 blocks, 3 blocks, 2"
"   blocks). Due to coding, the center varies on the different ships."
"`n"
"   The center of the ships shown horizontally:" 
"	  -Ship 1:  █ █ █ █ █"
"                    ↑-Center"
"      -Ship 2:  █ █ █ █"
"                  ↑-Center"
"      -Ship 3:  █ █ █ █"
"                  ↑-Center"
"      -Ship 4:  █ █ █"
"                  ↑-Center"
"      -Ship 5:  █ █"
"                  ↑-Center"
"`n"
"   The center of the ships shown vertically:"
"   Ship 1        Ship 2       Ship 3     Ship 4       Ship 5"
"`n"
"     █             █            █          █            █"
"     █             █  ←Center→  █          █  ←Center→  █"
"     █   ←Center   █            █          █              "
"     █             █            █"
"     █ "
"`n"
Pause

cls
"`n"
"   The Grid:"
"`n"
"   The grid, or the playing field, is where the battle takes place"
"   Two grids will appear on the screen after the player confirms"
"   their ship positions. The top grid is the enemy's grid and the"
"   bottom grid is the player's grid. An example of a grid below."
"          A   B   C   D   E   F   G   H   I   J "
"        ╔ ═ ╦ ═ ╦ ═ ╦ ═ ╦ ═ ╦ ═ ╦ ═ ╦ ═ ╦ ═ ╦ ═ ╗"
"       1║   ║   ║   ║   ║   ║   ║   ║   ║   ║   ║"
"        ╠ ═ ╬ ═ ╬ ═ ╬ ═ ╬ ═ ╬ ═ ╬ ═ ╬ ═ ╬ ═ ╬ ═ ╣"
"       2║   ║   ║   ║   ║   ║   ║   ║   ║   ║   ║"
"        ╠ ═ ╬ ═ ╬ ═ ╬ ═ ╬ ═ ╬ ═ ╬ ═ ╬ ═ ╬ ═ ╬ ═ ╣"
"       3║   ║   ║   ║   ║   ║   ║   ║   ║   ║   ║"
"        ╠ ═ ╬ ═ ╬ ═ ╬ ═ ╬ ═ ╬ ═ ╬ ═ ╬ ═ ╬ ═ ╬ ═ ╣"
"       4║   ║   ║   ║   ║   ║   ║   ║   ║   ║   ║"
"        ╠ ═ ╬ ═ ╬ ═ ╬ ═ ╬ ═ ╬ ═ ╬ ═ ╬ ═ ╬ ═ ╬ ═ ╣"
"       5║   ║   ║   ║   ║   ║   ║   ║   ║   ║   ║"
"        ╠ ═ ╬ ═ ╬ ═ ╬ ═ ╬ ═ ╬ ═ ╬ ═ ╬ ═ ╬ ═ ╬ ═ ╣"
"       6║   ║   ║   ║   ║   ║   ║   ║   ║   ║   ║"
"        ╠ ═ ╬ ═ ╬ ═ ╬ ═ ╬ ═ ╬ ═ ╬ ═ ╬ ═ ╬ ═ ╬ ═ ╣"
"       7║   ║   ║   ║   ║   ║   ║   ║   ║   ║   ║"
"        ╠ ═ ╬ ═ ╬ ═ ╬ ═ ╬ ═ ╬ ═ ╬ ═ ╬ ═ ╬ ═ ╬ ═ ╣"
"       8║   ║   ║   ║   ║   ║   ║   ║   ║   ║   ║"
"        ╠ ═ ╬ ═ ╬ ═ ╬ ═ ╬ ═ ╬ ═ ╬ ═ ╬ ═ ╬ ═ ╬ ═ ╣"
"       9║   ║   ║   ║   ║   ║   ║   ║   ║   ║   ║"
"        ╠ ═ ╬ ═ ╬ ═ ╬ ═ ╬ ═ ╬ ═ ╬ ═ ╬ ═ ╬ ═ ╬ ═ ╣"
"      10║   ║   ║   ║   ║   ║   ║   ║   ║   ║   ║"
"        ╚ ═ ╩ ═ ╩ ═ ╩ ═ ╩ ═ ╩ ═ ╩ ═ ╩ ═ ╩ ═ ╩ ═ ╝"
"   The enemy's grid will appear blank and will only show the"
"   positions the player chose to fire upon. The players grid will"
"   show their ships positions, as well as the places where the"
"   enemy fired upon them. Between the two grids, a message will"
"   appear when the player or enemy hits or misses a boat on either"
"   opponents grid."
"`n"
"   The symbols shown on the grid at any given time:"
"        - █ = Player ship."
"        - X = Portion of ship hit."
"        - O = Area fired upon where no ships are located."
"`n"
"   Hopefully these tips will help you have a successful game and"
"   have a fun time as well!"
"`n"
pause

    }
}until($startprompt -eq 1 -or $startprompt -eq 3)


switch($startprompt){
    1{
        #User ships creation
        do{

            #ship1
            do{     #As for all user ships, this loops until the player both has a coordinate with the correct syntax, and all other
                    #generated coordinates fit on the grid.
                
                #display
                cls
                "`n"
                get-blankgrid
                "`n"

                $pass = $false
                $usership1 = @()   #5blocks

                do{     #asking user where to place centerpoint
                    $usercoor = read-host -Prompt $entrytext1
                    $syntaxfunction = get-coordinatesyntaxcheck -coor $usercoor
                }until($syntaxfunction -eq $true)

                $usership1 += $usercoor

                #display
                cls
                "`n"
                new-grid -coordinates1 $usership1 
                "`n"
    
                #Asking user if they want to place the ship orientation and testing that it can fit on the grid
                $orientation = read-host -prompt $orientationtext
                while('h','v','exit' -notcontains $orientation){
                    $orientation = read-host -prompt ("Invalid Response. " + $directiontext)
                }
                $othercoordinates = get-othercoordinates -centercoordinate $usercoor -orientation $orientation -shiplength 5
                if($othercoordinates -ne $null){
                    $pass = $true
                }
            }until($pass -eq $true)

             foreach($i in $othercoordinates){
                $usership1 += $i
             }
 

            #ship2
            #For ships 2 -5, a collision check is performed before each ship's loop stops.
            do{
                $pass = $false
                $orientationpass = $false
                $usership2 = @()   #4blocks
                
                #display
                cls
                "`n"
                new-grid -coordinates1 $usership1 
                "`n"

                do{
                    $usercoor = read-host -Prompt $entrytext2
                    $syntaxfunction = get-coordinatesyntaxcheck -coor $usercoor
                }until($syntaxfunction -eq $true)

                $usership2 += $usercoor

                #display
                cls
                "`n"
                new-grid -coordinates1 $usership1 -coordinates2 $usership2 
                "`n"

                $orientation = read-host -prompt $orientationtext
                while('h','v','exit' -notcontains $orientation){
                    $orientation = read-host -prompt ("Invalid Response. " + $orientationtext)
                }

                $othercoordinates = get-othercoordinates -centercoordinate $usercoor -orientation $orientation -shiplength 4
                if($othercoordinates -ne $null){
                    $orientationpass = $true
                }

                foreach($i in $othercoordinates){
                    $usership2 += $i
                }

                $collisioncheck = get-shipcollisioncheck -ship1 $usership1 -ship2 $usership2
                if($collisioncheck -eq $false -and $orientationpass -eq $true){
                    $pass = $true
                }
    
            }until($pass -eq $true)


            #ship3
            do{
                $pass = $false
                $orientationpass = $false
                $usership3 = @()   #4blocks
                
                #display
                cls
                "`n"
                new-grid -coordinates1 $usership1 -coordinates2 $usership2
                "`n"
    
                do{
                    $usercoor = read-host -Prompt $entrytext3
                    $syntaxfunction = get-coordinatesyntaxcheck -coor $usercoor
                }until($syntaxfunction -eq $true)

                $usership3 += $usercoor

                #display
                cls
                "`n"
                new-grid -coordinates1 $usership1 -coordinates2 $usership2 -coordinates3 $usership3 
                "`n" 
        
                $orientation = read-host -prompt $orientationtext
                while('h','v','exit' -notcontains $orientation){
                    $orientation = read-host -prompt ("Invalid Response. " + $orientationtext)
                }

                $othercoordinates = get-othercoordinates -centercoordinate $usercoor -orientation $orientation -shiplength 4
                if($othercoordinates -ne $null){
                    $orientationpass = $true
                }

                foreach($i in $othercoordinates){
                    $usership3 += $i
                }
    
                $collisioncheck = get-shipcollisioncheck -ship1 $usership1 -ship2 $usership2 -ship3 $usership3
                if($collisioncheck -eq $false -and $orientationpass -eq $true){
                    $pass = $true
                }
    
            }until($pass -eq $true)


            #ship 4
            do{
                $pass = $false
                $orientationpass = $false
                $usership4 = @()   #3blocks
                
                #display
                cls
                "`n"
                new-grid -coordinates1 $usership1 -coordinates2 $usership2 -coordinates3 $usership3
                "`n"
    
                do{
                    $usercoor = read-host -Prompt $entrytext4
                    $syntaxfunction = get-coordinatesyntaxcheck -coor $usercoor
                }until($syntaxfunction -eq $true)

                $usership4 += $usercoor

                #display
                cls
                "`n"
                new-grid -coordinates1 $usership1 -coordinates2 $usership2 -coordinates3 $usership3 -coordinates4 $usership4
                "`n" 
        
                $orientation = read-host -prompt $orientationtext
                while('h','v','exit' -notcontains $orientation){
                    $orientation = read-host -prompt ("Invalid Response. " + $orientationtext)
                }

                $othercoordinates = get-othercoordinates -centercoordinate $usercoor -orientation $orientation -shiplength 3
                if($othercoordinates -ne $null){
                    $orientationpass = $true
                }

                foreach($i in $othercoordinates){
                    $usership4 += $i
                }
    
                $collisioncheck = get-shipcollisioncheck -ship1 $usership1 -ship2 $usership2 -ship3 $usership3 -ship4 $usership4
                if($collisioncheck -eq $false -and $orientationpass -eq $true){
                    $pass = $true
                }
    
            }until($pass -eq $true)


            #ship 5
            do{
                $pass = $false
                $orientationpass = $false
                $usership5 = @()   #2blocks
                
                #display
                cls
                "`n"
                new-grid -coordinates1 $usership1 -coordinates2 $usership2 -coordinates3 $usership3 -coordinates4 $usership4
                "`n"
    
                do{
                    $usercoor = read-host -Prompt $entrytext5
                    $syntaxfunction = get-coordinatesyntaxcheck -coor $usercoor
                }until($syntaxfunction -eq $true)

                $usership5 += $usercoor

                #display
                cls
                "`n"
                new-grid -coordinates1 $usership1 -coordinates2 $usership2 -coordinates3 $usership3 -coordinates4 $usership4 -coordinates5 $usership5
                "`n" 
        
                $orientation = read-host -prompt $orientationtext
                while('h','v','exit' -notcontains $orientation){
                    $orientation = read-host -prompt ("Invalid Response. " + $orientationtext)
                }

                $othercoordinates = get-othercoordinates -centercoordinate $usercoor -orientation $orientation -shiplength 2
                if($othercoordinates -ne $null){
                    $orientationpass = $true
                }

                foreach($i in $othercoordinates){
                    $usership5 += $i
                }
    
                $collisioncheck = get-shipcollisioncheck -ship1 $usership1 -ship2 $usership2 -ship3 $usership3 -ship4 $usership4 -ship5 $usership5
                if($collisioncheck -eq $false -and $orientationpass -eq $true){
                    $pass = $true
                }
    
        }until($pass -eq $true)

        #display
        cls
        "`n"
        new-grid -coordinates1 $usership1 -coordinates2 $usership2 -coordinates3 $usership3 -coordinates4 $usership4 -coordinates5 $usership5
        "`n"

        $confirmcoordinates = Read-Host -Prompt $confirmcoordinatestext1     #Confirmation that the player is set with their ship coordinates. Else, they get to redo them.
        while('y','n' -notcontains $confirmcoordinates){
            $confirmcoordinates = Read-Host -Prompt "Invalid response. $confirmcoordinatestext1"
        }

        }until($confirmcoordinates -eq 'y')


        #Enemy ship generation
        #during the loop, each ship generates it's centerpoint, ship orientation, and the other corresponding coordinates for their respective ship.
        do{
            $enemyship1 = @()
            $enemyship2 = @()
            $enemyship3 = @()
            $enemyship4 = @()
            $enemyship5 = @()

            #Ship1
            $enemycentercoor1 = new-enemycoordinate -shiplength 5
            $enemyorientation1 = get-enemyorientation
            $othercoors1 = get-othercoordinates -centercoordinate $enemycentercoor1 -orientation $enemyorientation1 -shiplength 5

            $enemyship1 += $enemycentercoor1
            foreach($i in $othercoors1){
                $enemyship1 += $i
            }

            #Ship2
            $enemycentercoor2 = new-enemycoordinate -shiplength 4
            $enemyorientation2 = get-enemyorientation
            $othercoors2 = get-othercoordinates -centercoordinate $enemycentercoor2 -orientation $enemyorientation2 -shiplength 4

            $enemyship2 += $enemycentercoor2
            foreach($i in $othercoors2){
                $enemyship2 += $i
            }

            #Ship3
            $enemycentercoor3 = new-enemycoordinate -shiplength 4
            $enemyorientation3 = get-enemyorientation
            $othercoors3 = get-othercoordinates -centercoordinate $enemycentercoor3 -orientation $enemyorientation3 -shiplength 4

            $enemyship3 += $enemycentercoor3
            foreach($i in $othercoors3){
                $enemyship3 += $i
            }

            #Ship4
            $enemycentercoor4 = new-enemycoordinate -shiplength 3
            $enemyorientation4 = get-enemyorientation
            $othercoors4 = get-othercoordinates -centercoordinate $enemycentercoor4 -orientation $enemyorientation4 -shiplength 3

            $enemyship4 += $enemycentercoor4
            foreach($i in $othercoors4){
                $enemyship4 += $i
            }

            #Ship5
            $enemycentercoor5 = new-enemycoordinate -shiplength 2
            $enemyorientation5 = get-enemyorientation
            $othercoors5 = get-othercoordinates -centercoordinate $enemycentercoor5 -orientation $enemyorientation5 -shiplength 2

            $enemyship5 += $enemycentercoor5
            foreach($i in $othercoors5){
                $enemyship5 += $i
            }

            $enemyshipcollisioncheck = get-shipcollisioncheck -ship1 $enemyship1 -ship2 $enemyship2 -ship3 $enemyship3 -ship4 $enemyship4 -ship5 $enemyship5
        }until($enemyshipcollisioncheck -eq $false)

        #Game start screen display
        cls
        "                    Enemy Grid↓"
        get-blankgrid
        "`n"
        "                   READY TO BATTLE!"
        "`n"
        new-grid -coordinates1 $usership1 -coordinates2 $usership2 -coordinates3 $usership3 -coordinates4 $usership4 -coordinates5 $usership5
        "                    Player Grid↑"
        "`n"


        $allusercoorpoints = join-coordinates -ship1 $usership1 -ship2 $usership2 -ship3 $usership3 -ship4 $usership4 -ship5 $usership5
        $allenemycoorpoints = join-coordinates -ship1 $enemyship1 -ship2 $enemyship2 -ship3 $enemyship3 -ship4 $enemyship4 -ship5 $enemyship5
        $userfoundcoors = @()     #this array stores all the enemy ships' coordinates that the player found.
        $usermissedcoors = @()    #this array stores all the missed coordinates that the player fired at the enemy.
        $enemyfoundcoors = @()    #this array stores all the player ships' coordinates that the enemy found.
        $enemymissedcoors = @()   #this array stores all the missed coordinates that the enemy fired at the player.

        $gameuserfoundcount = 0
        $gameenemyfoundcount = 0
        #These two arrays keep track of how many hits each opponent scored. The first to reach 18 wins.

        $focustarget = $null         #This saves the coordinate that the enemy successfully finds and uses that to target other surrounding parts of the player's boat. Resets to null when enemy fails to find other surrounding coordinates in all directions.
        $focustargetdirection = 0    #This is used change the direction of where to generate a new coordinate to fire upon. 0=Left, 1=Up, 2=Right, 3=Down. Number increases when enemy misses at one of the surrounding targets of the $focustarget. Resets to zero when the variable goes over three.
        $focustargetmovecount = 0    #This is used to make the enemy move where to fire upon the player's field should the enemy successfully find a player's coordinate. Increases by one if the enemy finds one of the player's coordinates based on $focustarget. Resets when a surrounding coordinate from $focustarget misses. 


        do{

            #Player
            do{
                $userfindenemyship = read-host -Prompt "Enter a coordinate to fire upon enemy ship. (Ex: E5)"
                $syntaxfunction = get-coordinatesyntaxcheck -coor $userfindenemyship
                $useruniquecheck1 = $userfoundcoors -contains $userfindenemyship   #Checks that the user's coordinate wasn't already entered
                $useruniquecheck2 = $usermissedcoors -contains $userfindenemyship  #Checks that the user's coordinate wasn't already entered
            }until($syntaxfunction -eq $true -and $useruniquecheck1 -eq $false -and $useruniquecheck2 -eq $false)

            if($allenemycoorpoints -contains $userfindenemyship){  #If the player scores a hit on the enemy
                $userfoundcoors += $userfindenemyship
                $gameuserfoundcount++
    
                #display
                cls
                "                     Enemy Grid↓"
                new-grid -hits $userfoundcoors -misses $usermissedcoors
                "`n"
                "           HIT: Enemy ship hit at $userfindenemyship"
                "`n"
                new-grid -coordinates1 $usership1 -coordinates2 $usership2 -coordinates3 $usership3 -coordinates4 $usership4 -coordinates5 $usership5 -hits $enemyfoundcoors -misses $enemymissedcoors
                "                     Player Grid↑"
                "`n"
                start-sleep -Seconds 3
    
            }else{     #If the player misses the enemy
                $usermissedcoors += $userfindenemyship

                #display
                cls
                "                     Enemy Grid↓"
                new-grid -hits $userfoundcoors -misses $usermissedcoors
                "`n"
                "         MISS: Player fired at $userfindenemyship but no hit"
                "`n"
                new-grid -coordinates1 $usership1 -coordinates2 $usership2 -coordinates3 $usership3 -coordinates4 $usership4 -coordinates5 $usership5 -hits $enemyfoundcoors -misses $enemymissedcoors
                "                     Player Grid↑"
                "`n"
                start-sleep -Seconds 3
            }

            #Enemy's turn
            do{
                if($focustarget -ne $null -and $focustargetdirection -lt 4){  #If the enemy successfully hit the player

                    $targetpointxcoor = $focustarget[0]
                    if($focustarget.length -eq 3){
                        [int]$targetpointycoor = 10
                    }else{
                        $targetpointycoor = [int]::Parse($focustarget[1])  
                    }
        
                    switch($focustargetdirection){
                        0{ #Left
                            $positionsearch = 0..($alphaletters.count) | ?{$alphaletters[$_] -eq $targetpointxcoor}
                            if($positionsearch -eq 0){     #If in the search for the x coordinate (A-J) within $alphaletters array equals A itself, the enemy can't go below that and moves to the next direction. 
                                $enemyfindusership = 'k9'
                            }else{                         #If the x coordinate doesn't intially equal A, a new x coordinate is generated
                                $negativecheck = ($positionsearch - $focustargetmovecount)  
                                #Had a problem where the next generated target moving to the left from A1..A10 would go to j1..j10 instead of moving to the 'up' loop. This fixes it.  
                                if($negativecheck -lt 0){
                                    $enemyfindusership = 'k9'
                                }else{
                                    $enemyfindusership = ($alphaletters[($positionsearch - $focustargetmovecount)] + $targetpointycoor)
                                }
                                
                            }
                        }
                        1{ #up
                            if($targetpointycoor -eq 1){   #If in the search for the y coordinate (1-10) equals 1, the enemy can't go below that and moves to the next direction. 
                                $enemyfindusership = 'k9'
                            }else{                         #If the y coordinate doesn't intially equal 1, a new y coordinate is generated
                                $enemyfindusership = ($targetpointxcoor + ($targetpointycoor - $focustargetmovecount))
                            }
                        }
                        2{ #right
                            $positionsearch = 0..($alphaletters.count) | ?{$alphaletters[$_] -eq $targetpointxcoor}
                            if($positionsearch -eq 9){     #If in the search for the x coordinate (A-J) within $alphaletters array equals J itself, the enemy can't go above that and moves to the next direction.
                                $enemyfindusership = 'k9'
                            }else{                         #If the x coordinate doesn't intially equal J, a new x coordinate is generated
                                $enemyfindusership = ($alphaletters[($positionsearch + $focustargetmovecount)] + $targetpointycoor)
                            }
                        }
                        3{ #down
                            if($targetpointycoor -eq 10){  #If in the search for the y coordinate (1-10) equals 10, the enemy can't go above that goes back to a random coordinate.
                                $enemyfindusership = 'k9'
                            }else{                         #If the y coordinate doesn't intially equal 10, a new y coordinate is generated
                                $enemyfindusership = ($targetpointxcoor + ($targetpointycoor + $focustargetmovecount))
                            }
                        }
                    }

                    #Check to make sure the new coordinate syntax is correct, and hasn't been suggested before
                    $syntaxcheck = get-coordinatesyntaxcheck -coor $enemyfindusership
                    $uniquecheck1 = $enemyfoundcoors -contains $enemyfindusership
                    $uniquecheck2 = $enemymissedcoors -contains $enemyfindusership

                    if($syntaxcheck -eq $false){
                        $focustargetmovecount = 1
                        $focustargetdirection++
                    }elseif($syntaxcheck -eq $true){
                        if($uniquecheck1 -eq $true -or $uniquecheck2 -eq $true){
                            $focustargetmovecount = 1
                            $focustargetdirection++
                        }
                    }
                }else{ #randomly generating a coordinate
                    $enemyfindusership = new-enemyfindusership

                    #Check to make sure the new coordinate syntax is correct, and hasn't been suggested before
                    $syntaxcheck = get-coordinatesyntaxcheck -coor $enemyfindusership
                    $uniquecheck1 = $enemyfoundcoors -contains $enemyfindusership
                    $uniquecheck2 = $enemymissedcoors -contains $enemyfindusership
                }
            }until($syntaxcheck -eq $true -and $uniquecheck1 -eq $false -and $uniquecheck2 -eq $false)


    
            if($allusercoorpoints -contains $enemyfindusership){   #If the enemy find the player ship
                if($focustarget -eq $null){
                    $focustarget = $enemyfindusership
                }
                $focustargetmovecount += 1         #focus is moved to the next nearby coordinate
                $enemyfoundcoors += $enemyfindusership
                $gameenemyfoundcount++

                #display
                cls
                "                     Enemy Grid↓"
                new-grid -hits $userfoundcoors -misses $usermissedcoors
                "`n"
                "           HIT: Player ship hit at $enemyfindusership"
                "`n"
                new-grid -coordinates1 $usership1 -coordinates2 $usership2 -coordinates3 $usership3 -coordinates4 $usership4 -coordinates5 $usership5 -hits $enemyfoundcoors -misses $enemymissedcoors
                "                     Player Grid↑"
                "`n"
                start-sleep -Seconds 2
            }else{       #If the enemy misses the player ship
                $enemymissedcoors += $enemyfindusership
    
                if($focustarget -eq $null){
                    $focustargetmovecount = 0
                    $focustargetdirection = 0
                }else{
                    $focustargetmovecount = 1   #movement is relegated back to one spot
                    $focustargetdirection++     #direction is changed for the focus target if $focustarget isn't $null
                }
    
                #display
                cls
                "                 Enemy Grid↓"
                new-grid -hits $userfoundcoors -misses $usermissedcoors
                "`n"
                "         MISS: Enemy fired at $enemyfindusership but no hit"
                "`n"
                new-grid -coordinates1 $usership1 -coordinates2 $usership2 -coordinates3 $usership3 -coordinates4 $usership4 -coordinates5 $usership5 -hits $enemyfoundcoors -misses $enemymissedcoors
                "                 Player Grid↑"
                "`n"
                start-sleep -Seconds 2
            }


            if($focustargetdirection -ge 4){  #if the enemy can't find any hits from $focustarget in all directions
                $focustarget = $null
                $focustargetdirection = 0
                $focustargetmovecount = 0
            }
        }until($gameuserfoundcount -eq 18 -or $gameenemyfoundcount -eq 18)


        #game over screens
        if($gameuserfoundcount -eq 18){
            cls
            "`n"
            "You win."
            "`n"
            "You put in the time, and a couple keystrokes to get the job done."
            "Here's a star: ☼"
            "`n"
            "oh wait...that's the sun. Well, either way you earned it."
            Pause
            Return
        }elseif($gameenemyfoundcount -eq 18){
            cls
            "`n"
            "You lose."
            "`n"
            "You put up a good fight but it just wasn't enough. Keep at it though."
            "`n"
            Pause
            Return
        }       
       
        
    }
    3{Return} #Exit game
}
