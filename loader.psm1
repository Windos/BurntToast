. $PSScriptRoot\New-BurntToastNotification.ps1
. $PSScriptRoot\Test-PSDifferentUser.ps1
. $PSScriptRoot\ValidationScripts.ps1

New-Alias -Name Toast -Value New-BurntToastNotification
Export-ModuleMember -Alias Toats -Function New-BurntToastNotification
