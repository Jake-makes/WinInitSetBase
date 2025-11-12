Write-Host "Running as Administrator.."

function Test-IsAdmin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    return $currentUser.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

if (-not (Test-IsAdmin)) {
    # Relaunch the script with elevation
    $psi = New-Object System.Diagnostics.ProcessStartInfo
    $psi.FileName = 'powershell.exe'
    $psi.Arguments = "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`""
    $psi.Verb = 'runas'               # <-- triggers UAC prompt
    $psi.UseShellExecute = $true

    try {
        [System.Diagnostics.Process]::Start($psi) | Out-Null
    } catch {
        Write-Error "Elevation was cancelled or failed."
    }
    exit   # stop the non‑elevated instance
}

Write-Host 'Setting services to disabled..'

Set-Service -Name AssignedAccessManagerSvc -StartupType Disabled
Set-Service -Name BDESVC -StartupType Disabled
Set-Service -Name DiagTrack -StartupType Disabled
Set-Service -Name diagsvc -StartupType Disabled
Set-Service -Name DPS -StartupType Disabled
Set-Service -Name WdiServiceHost -StartupType Disabled
Set-Service -Name WdiSystemHost -StartupType Disabled
Set-Service -Name lfsvc -StartupType Disabled
Set-Service -Name MapsBroker -StartupType Disabled
Set-Service -Name Netlogon -StartupType Disabled
Set-Service -Name defragsvc -StartupType Disabled
Set-Service -Name WpcMonSvc -StartupType Disabled
Set-Service -Name PhoneSvc -StartupType Disabled
Set-Service -Name Spooler -StartupType Manual
Set-Service -Name wisvc -StartupType Disabled
Set-Service -Name WerSvc -StartupType Disabled
Set-Service -Name refsdedupsvc -StartupType Disabled
Set-Service -Name SysMain -StartupType Disabled
Set-Service -Name seclogon -StartupType Disabled
Set-Service -Name RemoteRegistry -StartupType Disabled
Set-Service -Name WinRM -StartupType Disabled
Set-Service -Name CscService -StartupType Disabled
Set-Service -Name PcaSvc -StartupType Disabled
Set-Service -Name SEMgrSvc -StartupType Disabled
Set-Service -Name RetailDemo -StartupType Disabled
Set-Service -Name RmSvc -StartupType Disabled

Write-Host 'Removing apps..'

Get-AppxPackage *solitairecollection* -AllUsers | Remove-AppxPackage
Get-AppxPackage Microsoft.YourPhone -AllUsers | Remove-AppxPackage
Get-AppxPackage *WebExperience* | Remove-AppxPackage
Get-AppxPackage *Copilot* | Remove-AppxPackage

Write-Host 'Removing Windows features..'

DISM /Online /Disable-Feature /FeatureName:"WindowsMediaPlayerLegacy"
Disable-WindowsOptionalFeature -FeatureName "WindowsMediaPlayer" -Online
DISM /Online /Disable-Feature /FeatureName:"WorkFolders-Client"
DISM /Online /Disable-Feature /FeatureName:"SearchEngine-Client-Package"

Write-Host 'Removing bloat via registry..'

New-Item -Path “HKCU:\Software\Policies\Microsoft\Windows\Explorer” -Force | Out-Null
Set-ItemProperty -Path “HKCU:\Software\Policies\Microsoft\Windows\Explorer” -Name “DisableSearchBoxSuggestions” -Value 1
New-Item -Path “HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search” -Force | Out-Null
Set-ItemProperty -Path “HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search” -Name “ConnectedSearchUseWeb” -Value 0
Set-ItemProperty -Path “HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search” -Name “ConnectedSearchUseWebOverMeteredConnections” -Value 0