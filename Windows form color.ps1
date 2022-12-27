Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

[System.Windows.Forms.Application]::EnableVisualStyles()

$form = New-Object System.Windows.Forms.Form
$form.Text = 'Changing Colors..'
$form.MinimumSize = [System.Drawing.Size]::new(400, 300)
$form.ClientSize =[System.Drawing.Size]::new(300, 200)
$form.StartPosition = "CenterScreen"
$form.TopMost = $true
$form.SuspendLayout()

$btnOK = New-Object System.Windows.Forms.Button
$btnOK.Anchor = 'Top','Left'
$btnOK.Size = [System.Drawing.Size]::new(120, 31)
$btnOK.Location = [System.Drawing.Point]::new($form.Width / 2 - $btnOK.Width -8, 150)
$btnOK.Text = 'OK'
$btnOK.UseVisualStyleBackColor = $true
$btnOK.DialogResult = [System.Windows.Forms.DialogResult]::OK

$btnCancel = New-Object System.Windows.Forms.Button
$btnCancel.Anchor = 'Top','Left'
$btnCancel.Size = $btnOK.Size
$btnCancel.Location = [System.Drawing.Point]::new(($form.Width / 2) + 8, 150)
$btnCancel.Text = 'Cancel'
$btnCancel.UseVisualStyleBackColor = $true
$btnCancel.DialogResult = [System.Windows.Forms.DialogResult]::Cancel

$form.Controls.Add($btnOK)
$form.Controls.Add($btnCancel)
$form.AcceptButton = $btnOK
$form.CancelButton = $btnCancel

$timer = New-Object System.Windows.Forms.Timer
$timer.Interval = 1000   # for demo 1 second
$timer.Enabled = $false  # disabled at first
$timer.Tag = -1          # store the starting color index. Initialize to -1
$timer.Add_Tick({
    $colors = 'LightBlue', 'LightGreen', 'LightPink', 'Yellow', 'Orange', 'Brown', 'Magenta', 'White', 'Gray'
    # prevent the same color index to repeat
    $index = Get-Random -Maximum $colors.Count
    if ($index -eq $this.Tag) { $index = ($index + 1) % $colors.Count }
    $this.Tag = $index
    $form.BackColor = $colors[$index]
})

$form.ResumeLayout()
$form.PerformLayout()

$form.Add_Shown({$timer.Enabled = $true; $timer.Start()})
[void]$form.ShowDialog()

# clean up the Timer and Form objects
$timer.Dispose()
$form.Dispose()