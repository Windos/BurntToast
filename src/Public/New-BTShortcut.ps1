function New-BTShortcut {
<#
    .SYNOPSIS
    Creates a Windows shortcut for launching PowerShell or a compatible host with a custom AppUserModelID, enabling full toast notification branding (name & icon).

    .DESCRIPTION
    To ensure toast notifications show your custom app name and icon (registered by New-BTAppId), PowerShell (or a custom host) must be launched from a shortcut
    with the AppUserModelID property set. This function automates creation of such a shortcut, optionally with a custom icon and host executable.

    .PARAMETER AppId
    The AppUserModelID to set on the shortcut (should match the value registered with New-BTAppId).

    .PARAMETER ShortcutPath
    Path where the shortcut (.lnk) will be created. Defaults to Desktop.

    .PARAMETER DisplayName
    Friendly display name/description for the shortcut (optional).

    .PARAMETER IconPath
    Path to the icon image to use for the shortcut (should match icon registered for AppId; optional).

    .PARAMETER ForceWindowsPowerShell
    Forces the shortcut to use Windows PowerShell (powershell.exe), even if PowerShell 7+ (pwsh.exe) is available. Cannot be used with ExecutablePath.

    .PARAMETER ExecutablePath
    The absolute path to a custom executable (pwsh.exe, powershell.exe, or another PowerShell host). Cannot be used with ForceWindowsPowerShell.

    .INPUTS
    None. You cannot pipe input to this function.

    .OUTPUTS
    System.IO.FileInfo (Returns the path to the created shortcut file).

    .EXAMPLE
    New-BTShortcut -AppId "Acme.MyApp" -DisplayName "My App PowerShell" -IconPath "C:\Path\To\MyIcon.ico"
    Creates a PowerShell shortcut with custom AppId and icon on the Desktop. Prefers pwsh.exe if available.

    .EXAMPLE
    New-BTShortcut -AppId "Acme.MyApp"
    Creates a default shortcut with AppUserModelID, desktop location, and default icon. Prefers pwsh.exe if available.

    .EXAMPLE
    New-BTShortcut -AppId "Acme.MyApp" -ForceWindowsPowerShell
    Forces the shortcut to always launch Windows PowerShell (powershell.exe).

    .EXAMPLE
    New-BTShortcut -AppId "Acme.MyApp" -ExecutablePath "C:\CustomHost\CustomHost.exe"
    Uses the specified executable as the shortcut target.

    .NOTES
    After creating the shortcut, launch PowerShell exclusively via this shortcut to guarantee Windows uses your custom name and icon
    for actionable toast notifications. This works for pwsh.exe (PowerShell 7+), powershell.exe (Windows PowerShell), or any compatible host.
#>
    [CmdletBinding(SupportsShouldProcess = $true)]
    param(
        [Parameter(Mandatory=$true)]
        [string]$AppId,

        [string]$ShortcutPath = [System.IO.Path]::Combine([Environment]::GetFolderPath("Desktop"), "PowerShell - $DisplayName.lnk"),

        [string]$DisplayName = "PowerShell ($AppId)",

        [string]$IconPath,

        [Parameter(ParameterSetName = "ForceWindowsPowerShell", Mandatory = $true)]
        [switch]$ForceWindowsPowerShell,

        [Parameter(ParameterSetName = "ExecutablePath", Mandatory = $true)]
        [string]$ExecutablePath
    )

    if ($PSCmdlet.ShouldProcess($ShortcutPath, "Create PowerShell shortcut")) {
        # Use WScript.Shell to create the shortcut
        $WScriptShell = New-Object -ComObject WScript.Shell
        $Shortcut = $WScriptShell.CreateShortcut($ShortcutPath)

        if ($PSCmdlet.ParameterSetName -eq 'ExecutablePath') {
            $Shortcut.TargetPath = $ExecutablePath
            $Shortcut.Arguments = "-NoExit"
        } elseif ($PSCmdlet.ParameterSetName -eq 'ForceWindowsPowerShell') {
            $Shortcut.TargetPath = (Get-Command powershell.exe).Source
            $Shortcut.Arguments = "-NoExit"
        } else {
            # Default behavior: pwsh.exe if found, else powershell.exe
            $pwsh = Get-Command pwsh.exe -ErrorAction SilentlyContinue
            if ($pwsh) {
                $Shortcut.TargetPath = $pwsh.Source
                $Shortcut.Arguments = "-NoExit"
            } else {
                $Shortcut.TargetPath = (Get-Command powershell.exe).Source
                $Shortcut.Arguments = "-NoExit"
            }
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
}