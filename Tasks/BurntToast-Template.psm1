$WinMajorVersion = (Get-CimInstance -ClassName Win32_OperatingSystem -Property Version).Version.Split('.')[0]

if ($WinMajorVersion -ge 10) {
    [int] $WinBuild = (Get-CimInstance -ClassName Win32_OperatingSystem -Property BuildNumber).BuildNumber

    if ($WinBuild -ge 15063) {
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

        Export-ModuleMember -Alias 'Builder'
        Export-ModuleMember -Function $PublicFunctions
    } else {
        throw 'This version of BurntToast will only work on Windows 10 Creators Update (15063) and above. ' +
              'If you would like to use BurntToast on earlier Windows 10 builds, please downgrade to a version of the module below 1.0'
    }
} else {
    throw 'This version of BurntToast will only work on Windows 10. ' +
          'If you would like to use BurntToast on Windows 8, please use version 0.4'
}
