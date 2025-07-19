function New-BTShortcut {
<#
    .SYNOPSIS
    Creates a Windows shortcut for launching PowerShell with a custom AppUserModelID, enabling full toast notification branding (name & icon).

    .DESCRIPTION
    To ensure toast notifications show your custom app name and icon (registered by New-BTAppId), PowerShell must be launched from a shortcut
    with the AppUserModelID property set. This function automates creation of such a shortcut, optionally with a custom icon.

    .PARAMETER AppId
    The AppUserModelID to set on the shortcut (should match the value registered with New-BTAppId).

    .PARAMETER ShortcutPath
    Path where the shortcut (.lnk) will be created. Defaults to Desktop.

    .PARAMETER DisplayName
    Friendly display name/description for the shortcut (optional).

    .PARAMETER IconPath
    Path to the icon image to use for the shortcut (should match icon registered for AppId; optional).

    .INPUTS
    None. You cannot pipe input to this function.

    .OUTPUTS
    System.IO.FileInfo (Returns the path to the created shortcut file).

    .EXAMPLE
    New-BTShortcut -AppId "Acme.MyApp" -DisplayName "My App PowerShell" -IconPath "C:\Path\To\MyIcon.ico"
    Creates a PowerShell shortcut with custom AppId and icon on the Desktop.

    .EXAMPLE
    New-BTShortcut -AppId "Acme.MyApp"
    Creates a default shortcut with AppUserModelID, desktop location, and default icon.

    .NOTES
    After creating the shortcut, launch PowerShell exclusively via this shortcut to guarantee Windows uses your custom name and icon
    for actionable toast notifications. This works for pwsh.exe (PowerShell Core/7+) and powershell.exe (Windows PowerShell).
#>
    [CmdletBinding(SupportsShouldProcess = $true)]
    param(
        [Parameter(Mandatory=$true)]
        [string]$AppId,

        [string]$ShortcutPath = [System.IO.Path]::Combine([Environment]::GetFolderPath("Desktop"), "PowerShell - $DisplayName.lnk"),

        [string]$DisplayName = "PowerShell ($AppId)",

        [string]$IconPath
    )

    # Use WScript.Shell to create the shortcut
    $WScriptShell = New-Object -ComObject WScript.Shell
    $Shortcut = $WScriptShell.CreateShortcut($ShortcutPath)
    # Use pwsh.exe if available, else default to Windows PowerShell
    $pwsh = Get-Command pwsh.exe -ErrorAction SilentlyContinue
    if ($pwsh) {
        $Shortcut.TargetPath = $pwsh.Source
        $Shortcut.Arguments = "-NoExit"
    } else {
        $Shortcut.TargetPath = (Get-Command powershell.exe).Source
        $Shortcut.Arguments = "-NoExit"
    }
    $Shortcut.Description = $DisplayName
    if ($IconPath) {
        $Shortcut.IconLocation = $IconPath
    }

    # Save shortcut file
    $Shortcut.Save()

    # Now set AppUserModelID directly via property store (COM/Windows API)
    try {
        $shell = New-Object -ComObject Shell.Application
        $folder = Split-Path $ShortcutPath
        $file = Split-Path $ShortcutPath -Leaf
        $folderItem = $shell.Namespace($folder).ParseName($file)
        $props = $folderItem.ExtendedProperty("System.AppUserModel.ID")
        if (-not $props -or $props -ne $AppId) {
            # Fallback to PowerShell Community: use Set-ItemProperty as known working on Windows 10+
            Set-ItemProperty -Path $ShortcutPath -Name 'System.AppUserModel.ID' -Value $AppId -ErrorAction SilentlyContinue
        }
    } catch {
        Write-Warning "Unable to set AppUserModelID property on shortcut. Try setting it manually if required."
    }
}