
$OSVersion = [System.Environment]::OSVersion.Version

if ($OSVersion.Major -ge 10 -and $null -eq $env:BurntToastPesterNotWindows10) {
    if ($OSVersion.Build -ge 15063 -and $null -eq $env:BurntToastPesterNotAnniversaryUpdate) {
        $Paths = if ($IsWindows) {
            "$PSScriptRoot\lib\Microsoft.Toolkit.Uwp.Notifications\net5.0-windows10.0.17763\*.dll",
            "$PSScriptRoot\lib\Microsoft.Windows.SDK.NET\*.dll"
        } else {
            "$PSScriptRoot\lib\Microsoft.Toolkit.Uwp.Notifications\net461\*.dll"
        }

        $Library = @( Get-ChildItem -Path $Paths -Recurse -ErrorAction SilentlyContinue )

        # Add one class from each expected DLL here:
        $LibraryMap = @{
            'Microsoft.Toolkit.Uwp.Notifications.dll' = 'Microsoft.Toolkit.Uwp.Notifications.ToastContent'
            'Microsoft.Windows.SDK.NET.dll' = 'Windows.UI.Notifications.ToastNotification'
            'WinRT.Runtime.dll' = 'WinRT.WindowsRuntimeTypeAttribute'
        }

        $Script:Config = Get-Content -Path $PSScriptRoot\config.json -ErrorAction SilentlyContinue | ConvertFrom-Json
        $Script:DefaultImage = if ($Script:Config.AppLogo -match '^[.\\]') {
            "$PSScriptRoot$($Script:Config.AppLogo)"
        } else {
            $Script:Config.AppLogo
        }

        foreach ($Type in $Library) {
            try {
                if (-not ($LibraryMap[$Type.Name]  -as [type])) {
                    Add-Type -Path $Type.FullName -ErrorAction Stop
                }
            } catch {
                Write-Error -Message "Failed to load library $($Type.FullName): $_"
            }
        }

        Export-ModuleMember -Alias 'Toast'
        Export-ModuleMember -Function $PublicFunctions

        if (-not $IsWindows) {
            $null = [Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime]
        }
    } else {
        throw 'This version of BurntToast will only work on Windows 10 Creators Update (15063) and above or equivalent Windows Server version. ' +
              'If you would like to use BurntToast on earlier builds, please downgrade to a version of the module below 1.0'
    }
} else {
    throw 'This version of BurntToast will only work on Windows 10 or equivalent Windows Server version. ' +
          'If you would like to use BurntToast on Windows 8, please use version 0.4 of the module'
}
