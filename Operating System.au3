Dim $version = @AutoItVersion 
Dim $computername = @ComputerName 
Dim $OS = @OSVersion 
Dim $text = ""

Switch $OS
	
Case "WIN_2008"
	$OS = "Windows Server 2008"
	
Case "WIN-VISTA"
	$OS= "Windows Vista"
	
Case "WIN_XP"
	$OS = "Windows XP"
	
Case "WIN_2000"
	$OS = "Windows 2000"
	
Case "WIN_NT4"
	$OS = "Windows NT 4.0"
	
Case "Win_ME"
	$OS = "Windows ME"
	
Case "WIN_98"
	$OS = "Windows 98"
	
Case "WIN_98"
	$OS = "Windows 98"
	
Case "WIN_95"
	$OS = "Windows 95"
	
Case "WIN_10"
	$OS = "Windows 10"
	
Case Else
	$OS = "Unknown"
	
EndSwitch

$text =  "AutoIt Version =" & $version & @CRLF
$text = "Computer Name =" & $computername &@CRLF
$text = "Operating System = " & $OS

MsgBox (0, "Computer Information", $text)