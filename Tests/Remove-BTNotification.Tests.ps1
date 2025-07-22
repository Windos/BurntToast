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

Describe 'Remove-BTNotification' {
    Context 'all notifications (no parameter)' {
        It 'runs without error for clearing all' {
            { Remove-BTNotification -WhatIf } | Should -Not -Throw
        }
    }

    Context 'remove by tag' {
        It 'runs without error for tag' {
            { Remove-BTNotification -Tag 'Toast001' -WhatIf } | Should -Not -Throw
        }
    }

    Context 'remove by group' {
        It 'runs without error for group' {
            { Remove-BTNotification -Group 'Updates' -WhatIf } | Should -Not -Throw
        }
    }

    Context 'remove by unique identifier' {
        It 'runs without error for unique identifier' {
            { Remove-BTNotification -UniqueIdentifier 'Toast001' -WhatIf } | Should -Not -Throw
        }
    }
}