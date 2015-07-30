$Path = (Get-Item $PSScriptRoot).Parent.FullName

$Files = @(
    "$Path\BurntToast.png",
    "$Path\BurntToast.psd1",
    "$Path\loader.psm1",
    "$Path\New-BurntToastNotification.ps1",
    "$Path\Test-PSDifferentUser.ps1",
    "$Path\ValidationScripts.ps1"
)

Compress-Archive -Path $Files -Destination "$PSScriptRoot\BurntToast.zip"