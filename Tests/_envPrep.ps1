if (Get-Module -Name 'BurntToast') {
    Remove-Module -Name 'BurntToast' -Force
}

try {
    [Windows.UI.Notifications.ToastNotificationManager]::History.Clear('{1AC14E77-02E7-4E5D-B744-2EB1AE5198B7}\WindowsPowerShell\v1.0\powershell.exe')
    $PlatformAvailable = $true
} catch {
    $PlatformAvailable = $false
}

if ($ENV:BURNTTOAST_MODULE_ROOT) {
    Import-Module $ENV:BURNTTOAST_MODULE_ROOT -Force
} else {
    Import-Module "$PSScriptRoot/../BurntToast/BurntToast.psd1" -Force
}

