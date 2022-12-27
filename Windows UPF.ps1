[xml]$xaml = @"
<Window
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    x:Name="Window" Title="Initial Window" WindowStartupLocation = "CenterScreen"
    Width = "800" Height = "600" ShowInTaskbar = "True">
    <Button x:Name = "Button" Height = "75" Width = "100" Content = 'Push Me' ToolTip = "This is a button" />
</Window>
"@

$reader=(New-Object System.Xml.XmlNodeReader $xaml)
$Window=[Windows.Markup.XamlReader]::Load( $reader )

#Connect to Control
$button = $Window.FindName("Button")

$Window.ShowDialog() | Out-Null