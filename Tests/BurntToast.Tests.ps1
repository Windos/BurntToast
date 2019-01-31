Import-Module "$PSScriptRoot/../BurntToast/BurntToast.psd1" -Force

Describe 'Set-BTFunctionLevel' {
    Mock Out-File {}
    Mock Write-Warning {}
    
    Context 'running without arguments (New-BurntToastNotification)' {
        It 'runs without errors' {
            { New-BurntToastNotification } | Should Not Throw
        }
        
        It 'does not return anything' {            New-BurntToastNotification | Should BeNullOrEmpty         }
    }
}
