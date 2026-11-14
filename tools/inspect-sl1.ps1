# Non-destructive Windows PnP inventory for Rane SL1 (VID_13E5 / PID_0001)
# This script reads Plug-and-Play properties only. It does not change driver bindings.
$ErrorActionPreference = "Continue"
$needle = 'VID_13E5&PID_0001'
$devices = Get-PnpDevice -PresentOnly | Where-Object { $_.InstanceId -match $needle }

$lines = @()
$lines += "RANE SL1 - Windows PnP inventory"
$lines += "Date: $(Get-Date -Format o)"
$lines += "Computer: $env:COMPUTERNAME"
$lines += "OS: $((Get-CimInstance Win32_OperatingSystem).Caption) / $((Get-CimInstance Win32_OperatingSystem).Version)"
$lines += ""

if (-not $devices) {
    $lines += "No present device matched $needle."
    $lines += "Check the cable, USB port and device power."
} else {
    foreach ($dev in $devices) {
        $lines += "========================================"
        $lines += "FriendlyName: $($dev.FriendlyName)"
        $lines += "Class:        $($dev.Class)"
        $lines += "Status:       $($dev.Status)"
        $lines += "InstanceId:   $($dev.InstanceId)"
        $lines += ""
        $props = Get-PnpDeviceProperty -InstanceId $dev.InstanceId -ErrorAction SilentlyContinue
        foreach ($key in @(
            'DEVPKEY_Device_HardwareIds',
            'DEVPKEY_Device_CompatibleIds',
            'DEVPKEY_Device_DriverProvider',
            'DEVPKEY_Device_DriverVersion',
            'DEVPKEY_Device_Service',
            'DEVPKEY_Device_Manufacturer'
        )) {
            $p = $props | Where-Object { $_.KeyName -eq $key }
            if ($p) {
                $lines += "$key :"
                $lines += ($p.Data | Out-String).TrimEnd()
            }
        }
        $lines += ""
    }
}

$out = Join-Path (Get-Location) 'sl1-usb-report.txt'
$lines | Set-Content -Encoding UTF8 $out
$lines
Write-Host "`nReport saved to: $out"
