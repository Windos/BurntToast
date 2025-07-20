# New-BTShortcut

## SYNOPSIS

Creates a Windows shortcut for launching PowerShell or a compatible host with a custom AppUserModelID, enabling full toast notification branding (name & icon).

## DESCRIPTION

To ensure toast notifications show your custom app name and icon (registered by `New-BTAppId`), PowerShell (or a custom host) must be launched from a shortcut with the `AppUserModelID` property set.
This function automates creation of such a shortcut, optionally with a custom icon and host executable.

## PARAMETERS

| Name                 | Type     | Description                                                                                                     |
|----------------------|----------|-----------------------------------------------------------------------------------------------------------------|
| `AppId`              | String (Mandatory) | The AppUserModelID to set on the shortcut (should match the value registered with `New-BTAppId`).             |
| `ShortcutPath`       | String   | Path where the shortcut (.lnk) will be created. Defaults to Desktop.                                            |
| `DisplayName`        | String   | Friendly display name/description for the shortcut (optional).                                                  |
| `IconPath`           | String   | Path to the icon image to use for the shortcut (should match icon registered for AppId; optional).              |
| `ForceWindowsPowerShell` | Switch | Forces the shortcut to use Windows PowerShell (powershell.exe), even if PowerShell 7+ (pwsh.exe) is available. Cannot be used with ExecutablePath. |
| `ExecutablePath`     | String   | The absolute path to a custom executable (pwsh.exe, powershell.exe, or another PowerShell host). Cannot be used with ForceWindowsPowerShell. |

## INPUTS

None. You cannot pipe input to this function.

## OUTPUTS

System.IO.FileInfo (Returns the path to the created shortcut file).

## EXAMPLES

### Example 1

```powershell
New-BTShortcut -AppId "Acme.MyApp" -DisplayName "My App PowerShell" -IconPath "C:\Path\To\MyIcon.ico"
```

Creates a PowerShell shortcut with custom AppId and icon on the Desktop. Prefers pwsh.exe if available.

### Example 2

```powershell
New-BTShortcut -AppId "Acme.MyApp"
```

Creates a default shortcut with AppUserModelID, desktop location, and default icon. Prefers pwsh.exe if available.

### Example 3

```powershell
New-BTShortcut -AppId "Acme.MyApp" -ForceWindowsPowerShell
```

Forces the shortcut to always launch Windows PowerShell (powershell.exe).

### Example 4

```powershell
New-BTShortcut -AppId "Acme.MyApp" -ExecutablePath "C:\CustomHost\CustomHost.exe"
```

Uses the specified executable as the shortcut target.

## NOTES

After creating the shortcut, launch PowerShell exclusively via this shortcut to guarantee Windows uses your custom name and icon for actionable toast notifications.
This works for pwsh.exe (PowerShell 7+), powershell.exe (Windows PowerShell), or any compatible host.

## LINKS

- [New-BTAppId](#)
