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

Describe 'Submit-BTNotification Throttle' {
    BeforeEach {
        $lockDir = Join-Path $env:TEMP 'BurntToast-Throttle'
        if (Test-Path $lockDir) { Remove-Item $lockDir -Recurse -Force }
    }

    AfterAll {
        $lockDir = Join-Path $env:TEMP 'BurntToast-Throttle'
        if (Test-Path $lockDir) { Remove-Item $lockDir -Recurse -Force }
    }

    Context 'CooldownSeconds parameter exists' {
        It 'accepts -CooldownSeconds without error' {
            $mockContent = [Activator]::CreateInstance([Microsoft.Toolkit.Uwp.Notifications.ToastContent])
            { Submit-BTNotification -Content $mockContent -UniqueIdentifier 'throttle-test' -CooldownSeconds 10 -WhatIf } | Should -Not -Throw
        }
    }

    Context 'first notification always fires' {
        It 'shows the toast on first call even with cooldown set' {
            Start-Transcript tmp-throttle.log
            try {
                $mockContent = [Activator]::CreateInstance([Microsoft.Toolkit.Uwp.Notifications.ToastContent])
                Submit-BTNotification -Content $mockContent -UniqueIdentifier 'first-call' -CooldownSeconds 30 -WhatIf
            } finally {
                Stop-Transcript
                $Log = (Get-Content tmp-throttle.log).Where({ $_ -match 'What if:' })
                Remove-Item tmp-throttle.log
            }
            $Log | Should -Not -BeNullOrEmpty
        }
    }

    Context 'second notification within cooldown is suppressed' {
        It 'does not show toast when called again within cooldown window' {
            $mockContent = [Activator]::CreateInstance([Microsoft.Toolkit.Uwp.Notifications.ToastContent])

            # First call — should fire
            Submit-BTNotification -Content $mockContent -UniqueIdentifier 'spam-test' -CooldownSeconds 60 -WhatIf

            # Second call within cooldown — should be suppressed
            Start-Transcript tmp-throttle2.log
            try {
                Submit-BTNotification -Content $mockContent -UniqueIdentifier 'spam-test' -CooldownSeconds 60 -WhatIf
            } finally {
                Stop-Transcript
                $Log = (Get-Content tmp-throttle2.log).Where({ $_ -match 'What if:' })
                Remove-Item tmp-throttle2.log
            }
            $Log | Should -BeNullOrEmpty
        }
    }

    Context 'different identifiers are independent' {
        It 'allows notifications with different UniqueIdentifiers regardless of cooldown' {
            $mockContent = [Activator]::CreateInstance([Microsoft.Toolkit.Uwp.Notifications.ToastContent])

            Submit-BTNotification -Content $mockContent -UniqueIdentifier 'id-A' -CooldownSeconds 60 -WhatIf

            Start-Transcript tmp-throttle3.log
            try {
                Submit-BTNotification -Content $mockContent -UniqueIdentifier 'id-B' -CooldownSeconds 60 -WhatIf
            } finally {
                Stop-Transcript
                $Log = (Get-Content tmp-throttle3.log).Where({ $_ -match 'What if:' })
                Remove-Item tmp-throttle3.log
            }
            $Log | Should -Not -BeNullOrEmpty
        }
    }

    Context 'no cooldown means no throttling' {
        It 'fires every time when CooldownSeconds is not specified' {
            $mockContent = [Activator]::CreateInstance([Microsoft.Toolkit.Uwp.Notifications.ToastContent])

            Submit-BTNotification -Content $mockContent -UniqueIdentifier 'no-cd' -WhatIf

            Start-Transcript tmp-throttle4.log
            try {
                Submit-BTNotification -Content $mockContent -UniqueIdentifier 'no-cd' -WhatIf
            } finally {
                Stop-Transcript
                $Log = (Get-Content tmp-throttle4.log).Where({ $_ -match 'What if:' })
                Remove-Item tmp-throttle4.log
            }
            $Log | Should -Not -BeNullOrEmpty
        }
    }

    Context 'cooldown requires UniqueIdentifier' {
        It 'writes a warning when CooldownSeconds used without UniqueIdentifier' {
            $mockContent = [Activator]::CreateInstance([Microsoft.Toolkit.Uwp.Notifications.ToastContent])
            $output = Submit-BTNotification -Content $mockContent -CooldownSeconds 10 -WhatIf 3>&1
            $warnings = $output | Where-Object { $_ -is [System.Management.Automation.WarningRecord] }
            $warnings.Message | Should -Match 'UniqueIdentifier'
        }
    }
}

Describe 'New-BurntToastNotification Throttle Passthrough' {
    BeforeEach {
        $lockDir = Join-Path $env:TEMP 'BurntToast-Throttle'
        if (Test-Path $lockDir) { Remove-Item $lockDir -Recurse -Force }
    }

    It 'accepts -CooldownSeconds parameter' {
        { New-BurntToastNotification -Text 'Throttle Test' -UniqueIdentifier 'passthrough' -CooldownSeconds 10 -WhatIf } | Should -Not -Throw
    }

    It 'suppresses second call within cooldown' {
        New-BurntToastNotification -Text 'First' -UniqueIdentifier 'pt-spam' -CooldownSeconds 60 -WhatIf

        Start-Transcript tmp-throttle-pt.log
        try {
            New-BurntToastNotification -Text 'Second' -UniqueIdentifier 'pt-spam' -CooldownSeconds 60 -WhatIf
        } finally {
            Stop-Transcript
            $Log = (Get-Content tmp-throttle-pt.log).Where({ $_ -match 'What if:' })
            Remove-Item tmp-throttle-pt.log
        }
        $Log | Should -BeNullOrEmpty
    }
}
