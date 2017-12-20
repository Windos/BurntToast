$ModuleName = 'BurntToast'

$UserModulePath = 'C:\Users\Windos\Documents\WindowsPowerShell\Modules'

$Installed = Get-Module -Name $ModuleName -ListAvailable

if ($Installed) {
    Remove-Item $Installed.ModuleBase -Recurse -Force
}

Copy-Item -Path $PSScriptRoot\$ModuleName -Container -Recurse -Destination $UserModulePath -Force
