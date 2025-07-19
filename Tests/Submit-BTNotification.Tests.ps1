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

Describe 'Submit-BTNotification' {
    Context 'content and unique identifier' {
        It 'runs without error for submitting with identifier' {
            $mockContent = [Activator]::CreateInstance([Microsoft.Toolkit.Uwp.Notifications.ToastContent])
            { Submit-BTNotification -Content $mockContent -UniqueIdentifier 'Toast001' -WhatIf } | Should -Not -Throw
        }
    }
}