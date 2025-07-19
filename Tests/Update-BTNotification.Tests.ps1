BeforeAll {
    if (Get-Module -Name 'BurntToast') {
        Remove-Module -Name 'BurntToast'
    }
    if ($ENV:BURNTTOAST_MODULE_ROOT) {
        Import-Module $ENV:BURNTTOAST_MODULE_ROOT -Force
    } else {
        Import-Module "$PSScriptRoot/../src/BurntToast.psd1" -Force
    }
}

Describe 'Update-BTNotification' {
    Context 'update with unique identifier and data binding' {
        It 'runs without error for update' {
            $data = @{ Key = 'Value' }
            { Update-BTNotification -UniqueIdentifier 'ID001' -DataBinding $data -WhatIf } | Should -Not -Throw
        }
    }
}