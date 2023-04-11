Add-Type -AssemblyName System.Windows.Forms
$enable = $true
$centerX = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Width / 2
$centerY = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Height / 2
$radius = 100
$angle = 0
$step = 5
$duration = 60 * 1000  # 1 minute in milliseconds

while($enable){
    $endTime = (Get-Date).AddMilliseconds($duration)
    while ((Get-Date) -le $endTime) {
        $angle += $step
        if ($angle -gt 360){
            $angle -= 360
        }
        $x = $centerX + [math]::Round($radius * [math]::Cos($angle * [math]::PI / 180))
        $y = $centerY + [math]::Round($radius * [math]::Sin($angle * [math]::PI / 180))
        [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($x, $y)
        [System.Windows.Forms.Application]::DoEvents()
        Start-Sleep -Milliseconds 50
        if ([System.Console]::KeyAvailable -and [System.Console]::ReadKey($true).Key -eq 'P'){
            $enable = !$enable
            break
        }
    }

    # Pause for 1 minute
    $endTime = (Get-Date).AddMilliseconds($duration)
    while ((Get-Date) -le $endTime) {
        [System.Windows.Forms.Application]::DoEvents()
        Start-Sleep -Milliseconds 50
        if ([System.Console]::KeyAvailable -and [System.Console]::ReadKey($true).Key -eq 'P'){
            $enable = !$enable
            break
        }
    }
}
