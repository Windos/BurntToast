
$WinMajorVersion = (Get-CimInstance -ClassName Win32_OperatingSystem -Property Version).Version.Split('.')[0]

if ($WinMajorVersion -ge 10) {
    $Library = @( Get-ChildItem -Path $PSScriptRoot\lib\Microsoft.Toolkit.Uwp.Notifications\*.dll -Recurse -ErrorAction SilentlyContinue )

    if ($IsWindows) {
        $Library += @( Get-ChildItem -Path $PSScriptRoot\lib\Microsoft.Windows.SDK.NET\*.dll -Recurse -ErrorAction SilentlyContinue )
    }

    # Add one class from each expected DLL here:
    $LibraryMap = @{
        'Microsoft.Toolkit.Uwp.Notifications.dll' = 'Microsoft.Toolkit.Uwp.Notifications.ToastContent'
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

    $Script:ActionsSupported = 'System.Management.Automation.SemanticVersion' -as [type] -and
        $PSVersionTable.PSVersion -ge [System.Management.Automation.SemanticVersion] '7.1.0-preview.4'

    $Script:UnsupportedEvents = 'Toast events are only supported on PowerShell 7.1.0 and above. ' +
        'Your notification will still be displayed, but the actions will be ignored.'

    Export-ModuleMember -Alias 'Toast'
    Export-ModuleMember -Function $PublicFunctions

    # Register default AppId
    New-BTAppId

    if (-not $IsWindows) {
        $null = [Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime]
    }
} else {
    throw 'This version of BurntToast will only work on Windows 10. If you would like to use BurntToast on Windows 8, please use version 0.4'
}
