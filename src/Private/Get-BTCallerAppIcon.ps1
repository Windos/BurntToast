function Get-BTCallerAppIcon {
    <#
        .SYNOPSIS
        Detects the calling application (terminal, IDE, etc.) and extracts its icon.

        .DESCRIPTION
        Walks up the process tree from the current PowerShell session to find the first
        ancestor with a visible window — that's typically the terminal or IDE that launched
        the script. Extracts the app's icon from its executable and caches it in
        %TEMP%\BurntToast-IconCache so repeated calls don't re-extract.

        Supports an optional override map so specific process names can use custom icons
        (e.g., mapping 'node' to a Claude logo when BurntToast is called from Claude Code).

        .PARAMETER AppLogoMap
        Hashtable mapping process names (without .exe) to icon file paths.
        If the detected parent process matches a key, that icon is used instead of extracting.

        .OUTPUTS
        System.String — path to the icon file, or $null if detection fails.
    #>

    param (
        [hashtable] $AppLogoMap
    )

    $cacheDir = Join-Path $env:TEMP 'BurntToast-IconCache'

    # Walk up the process tree to find the first ancestor with a visible window.
    # That's usually the terminal, IDE, or app shell that the user is looking at.
    try {
        $proc = Get-Process -Id $PID -ErrorAction Stop

        while ($proc) {
            # Check for override map match first — before we even care about the window handle.
            if ($AppLogoMap -and $AppLogoMap.ContainsKey($proc.ProcessName)) {
                $overridePath = $AppLogoMap[$proc.ProcessName]
                if (Test-Path $overridePath) { return $overridePath }
            }

            # Found a windowed process — this is our target.
            if ($proc.MainWindowHandle -ne [IntPtr]::Zero) { break }

            # Move up to parent process.
            $parentId = (Get-CimInstance Win32_Process -Filter "ProcessId=$($proc.Id)" -ErrorAction Stop).ParentProcessId
            if (-not $parentId -or $parentId -eq 0) { return $null }
            $proc = Get-Process -Id $parentId -ErrorAction SilentlyContinue
        }

        if (-not $proc -or $proc.MainWindowHandle -eq [IntPtr]::Zero) { return $null }

        # Check override map for the windowed ancestor too.
        if ($AppLogoMap -and $AppLogoMap.ContainsKey($proc.ProcessName)) {
            $overridePath = $AppLogoMap[$proc.ProcessName]
            if (Test-Path $overridePath) { return $overridePath }
        }

        # Extract the icon from the process's executable and cache it as a .png.
        # We cache by process name so different apps get their own icon file.
        if (-not [System.IO.Directory]::Exists($cacheDir)) {
            [System.IO.Directory]::CreateDirectory($cacheDir) | Out-Null
        }

        $cachedIcon = Join-Path $cacheDir "$($proc.ProcessName).png"

        if ([System.IO.File]::Exists($cachedIcon)) { return $cachedIcon }

        # Use System.Drawing to extract the icon from the .exe and save as PNG.
        $exePath = $proc.Path
        if (-not $exePath) { return $null }

        Add-Type -AssemblyName System.Drawing -ErrorAction SilentlyContinue
        $icon = [System.Drawing.Icon]::ExtractAssociatedIcon($exePath)
        if ($icon) {
            $bitmap = $icon.ToBitmap()
            $bitmap.Save($cachedIcon, [System.Drawing.Imaging.ImageFormat]::Png)
            $bitmap.Dispose()
            $icon.Dispose()
            return $cachedIcon
        }
    } catch {
        # If anything goes wrong during detection, return $null and let the caller
        # fall back to the default BurntToast logo. No crash, no noise.
        return $null
    }

    return $null
}
