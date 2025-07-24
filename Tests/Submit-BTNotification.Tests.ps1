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
    Context 'event handler deduplication/registration' {
        It 'registers a unique action event without error' {
            $mockContent = [Activator]::CreateInstance([Microsoft.Toolkit.Uwp.Notifications.ToastContent])
            $action = { Write-Host "Activated!" }
            { Submit-BTNotification -Content $mockContent -ActivatedAction $action -WhatIf } | Should -Not -Throw
        }
        It 'warns and does not throw on duplicate action registration' {
            $mockContent = [Activator]::CreateInstance([Microsoft.Toolkit.Uwp.Notifications.ToastContent])
            $action = { Write-Host "Activated!" }

            $transcriptPath = "$env:TEMP\BTTranscript-$PID.txt"
            Start-Transcript -Path $transcriptPath -Force | Out-Null
            try {
                $null = Submit-BTNotification -Content $mockContent -ActivatedAction $action -WhatIf 2>&1
            } finally {
                Stop-Transcript | Out-Null
            }

            $transcript = Get-Content $transcriptPath -Raw
            $transcript | Should -Match "Duplicate or conflicting OnActivated ScriptBlock event detected"
            Remove-Item $transcriptPath -Force
        }
        It 'allows distinct handler actions without deduplication warning' {
            $mockContent = [Activator]::CreateInstance([Microsoft.Toolkit.Uwp.Notifications.ToastContent])
            $a1 = { Write-Host "A" }
            $a2 = { Write-Host "B" }
            $null = Submit-BTNotification -Content $mockContent -ActivatedAction $a1 -WhatIf 2>&1
            $output = Submit-BTNotification -Content $mockContent -ActivatedAction $a2 -WhatIf 2>&1
            $output | Should -Not -Contain "Duplicate or conflicting OnActivated ScriptBlock event detected"
        }
    }
}