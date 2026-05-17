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

Describe 'Throttle: Advanced Edge Cases' {
    BeforeEach {
        # Fresh throttle state for every test — no leakage between tests.
        $lockDir = Join-Path $env:TEMP 'BurntToast-Throttle'
        if (Test-Path $lockDir) { Remove-Item $lockDir -Recurse -Force }
    }

    AfterAll {
        $lockDir = Join-Path $env:TEMP 'BurntToast-Throttle'
        if (Test-Path $lockDir) { Remove-Item $lockDir -Recurse -Force }
    }

    Context 'rapid-fire stress test' {
        It 'only fires once when called 20 times in a tight loop with 60s cooldown' {
            $mockContent = [Activator]::CreateInstance([Microsoft.Toolkit.Uwp.Notifications.ToastContent])
            $firedCount = 0

            for ($i = 0; $i -lt 20; $i++) {
                Start-Transcript "tmp-stress-$i.log" -Force
                try {
                    Submit-BTNotification -Content $mockContent -UniqueIdentifier 'stress-test' -CooldownSeconds 60 -WhatIf
                } finally {
                    Stop-Transcript
                    $log = (Get-Content "tmp-stress-$i.log").Where({ $_ -match 'What if:.*submitting:' })
                    Remove-Item "tmp-stress-$i.log"
                    if ($log) { $firedCount++ }
                }
            }

            $firedCount | Should -Be 1
        }
    }

    Context 'cooldown expiry' {
        It 'fires again after cooldown expires (simulated by backdating lock file)' {
            $mockContent = [Activator]::CreateInstance([Microsoft.Toolkit.Uwp.Notifications.ToastContent])

            # First call — fires normally.
            Submit-BTNotification -Content $mockContent -UniqueIdentifier 'expiry-test' -CooldownSeconds 5 -WhatIf

            # Backdate the lock file to simulate cooldown expiry.
            $lockFile = Join-Path $env:TEMP 'BurntToast-Throttle\expiry-test.lock'
            [System.IO.File]::SetLastWriteTime($lockFile, [datetime]::Now.AddSeconds(-10))

            # Second call — should fire because cooldown expired.
            Start-Transcript tmp-expiry.log -Force
            try {
                Submit-BTNotification -Content $mockContent -UniqueIdentifier 'expiry-test' -CooldownSeconds 5 -WhatIf
            } finally {
                Stop-Transcript
                $Log = (Get-Content tmp-expiry.log).Where({ $_ -match 'What if:.*submitting:' })
                Remove-Item tmp-expiry.log
            }
            $Log | Should -Not -BeNullOrEmpty
        }
    }

    Context 'zero cooldown behaves like no cooldown' {
        It 'fires every time when CooldownSeconds is 0' {
            $mockContent = [Activator]::CreateInstance([Microsoft.Toolkit.Uwp.Notifications.ToastContent])
            $firedCount = 0

            for ($i = 0; $i -lt 5; $i++) {
                Start-Transcript "tmp-zero-$i.log" -Force
                try {
                    Submit-BTNotification -Content $mockContent -UniqueIdentifier 'zero-cd' -CooldownSeconds 0 -WhatIf
                } finally {
                    Stop-Transcript
                    $log = (Get-Content "tmp-zero-$i.log").Where({ $_ -match 'What if:.*submitting:' })
                    Remove-Item "tmp-zero-$i.log"
                    if ($log) { $firedCount++ }
                }
            }

            $firedCount | Should -Be 5
        }
    }

    Context 'negative cooldown is treated as no throttle' {
        It 'fires every time when CooldownSeconds is negative' {
            $mockContent = [Activator]::CreateInstance([Microsoft.Toolkit.Uwp.Notifications.ToastContent])

            Submit-BTNotification -Content $mockContent -UniqueIdentifier 'neg-cd' -CooldownSeconds -5 -WhatIf

            Start-Transcript tmp-neg.log -Force
            try {
                Submit-BTNotification -Content $mockContent -UniqueIdentifier 'neg-cd' -CooldownSeconds -5 -WhatIf
            } finally {
                Stop-Transcript
                $Log = (Get-Content tmp-neg.log).Where({ $_ -match 'What if:.*submitting:' })
                Remove-Item tmp-neg.log
            }
            $Log | Should -Not -BeNullOrEmpty
        }
    }

    Context 'special characters in UniqueIdentifier' {
        It 'handles identifiers with spaces and dashes' {
            $mockContent = [Activator]::CreateInstance([Microsoft.Toolkit.Uwp.Notifications.ToastContent])
            { Submit-BTNotification -Content $mockContent -UniqueIdentifier 'my toast-id 2' -CooldownSeconds 10 -WhatIf } | Should -Not -Throw
        }
    }

    Context 'lock file integrity' {
        It 'creates lock file in correct directory with correct name' {
            $mockContent = [Activator]::CreateInstance([Microsoft.Toolkit.Uwp.Notifications.ToastContent])
            Submit-BTNotification -Content $mockContent -UniqueIdentifier 'lockcheck' -CooldownSeconds 30 -WhatIf

            $lockFile = Join-Path $env:TEMP 'BurntToast-Throttle\lockcheck.lock'
            Test-Path $lockFile | Should -BeTrue
        }

        It 'lock file contains a valid ISO 8601 timestamp' {
            $mockContent = [Activator]::CreateInstance([Microsoft.Toolkit.Uwp.Notifications.ToastContent])
            Submit-BTNotification -Content $mockContent -UniqueIdentifier 'timestamp-check' -CooldownSeconds 30 -WhatIf

            $lockFile = Join-Path $env:TEMP 'BurntToast-Throttle\timestamp-check.lock'
            $content = [System.IO.File]::ReadAllText($lockFile)
            { [datetime]::Parse($content) } | Should -Not -Throw
        }
    }

    Context 'concurrent identifier isolation' {
        It 'throttling one identifier does not affect another with different cooldowns' {
            $mockContent = [Activator]::CreateInstance([Microsoft.Toolkit.Uwp.Notifications.ToastContent])

            # Fire A with 60s cooldown — locks it.
            Submit-BTNotification -Content $mockContent -UniqueIdentifier 'iso-A' -CooldownSeconds 60 -WhatIf
            # Fire B with 60s cooldown — independent lock.
            Submit-BTNotification -Content $mockContent -UniqueIdentifier 'iso-B' -CooldownSeconds 60 -WhatIf

            # A should be suppressed, B should be suppressed, C should fire.
            Start-Transcript tmp-iso.log -Force
            try {
                Submit-BTNotification -Content $mockContent -UniqueIdentifier 'iso-A' -CooldownSeconds 60 -WhatIf
                Submit-BTNotification -Content $mockContent -UniqueIdentifier 'iso-B' -CooldownSeconds 60 -WhatIf
                Submit-BTNotification -Content $mockContent -UniqueIdentifier 'iso-C' -CooldownSeconds 60 -WhatIf
            } finally {
                Stop-Transcript
                $Log = (Get-Content tmp-iso.log).Where({ $_ -match 'What if:.*submitting:' })
                Remove-Item tmp-iso.log
            }

            # Only iso-C should have fired.
            $Log.Count | Should -Be 1
            $Log[0] | Should -Match 'iso-C'
        }
    }
}

Describe 'AutoAppLogo: Advanced Edge Cases' {
    Context 'AppLogoMap with nonexistent icon path' {
        It 'falls back gracefully when mapped icon file does not exist' {
            # Map current process to a file that does not exist.
            $currentProc = (Get-Process -Id $PID).ProcessName
            $result = InModuleScope 'BurntToast' -Parameters @{ procName = $currentProc } {
                param($procName)
                Get-BTCallerAppIcon -AppLogoMap @{ $procName = 'C:\nonexistent\fake.ico' }
            }
            # Should NOT return the fake path — should fall through to extraction.
            $result | Should -Not -Be 'C:\nonexistent\fake.ico'
        }
    }

    Context 'icon cache reuse' {
        It 'returns the same cached path on repeated calls' {
            $first = InModuleScope 'BurntToast' { Get-BTCallerAppIcon }
            $second = InModuleScope 'BurntToast' { Get-BTCallerAppIcon }
            $first | Should -Be $second
        }

        It 'cached icon file is a valid PNG' {
            $iconPath = InModuleScope 'BurntToast' { Get-BTCallerAppIcon }
            if ($iconPath -and (Test-Path $iconPath)) {
                # PNG magic bytes: 137 80 78 71 (0x89 0x50 0x4E 0x47)
                $bytes = [System.IO.File]::ReadAllBytes($iconPath)
                $bytes[0] | Should -Be 0x89
                $bytes[1] | Should -Be 0x50
                $bytes[2] | Should -Be 0x4E
                $bytes[3] | Should -Be 0x47
            }
        }
    }

    Context 'empty AppLogoMap' {
        It 'ignores empty hashtable and proceeds with auto-detection' {
            $result = InModuleScope 'BurntToast' { Get-BTCallerAppIcon -AppLogoMap @{} }
            $result | Should -Not -BeNullOrEmpty
        }
    }

    Context 'multiple AppLogoMap entries' {
        It 'only matches the correct process name' {
            $ModuleRoot = (Get-Item (Get-Module 'BurntToast').Path).Directory.FullName
            $targetIcon = Join-Path $ModuleRoot 'Images\BurntToast.png'
            $currentProc = (Get-Process -Id $PID).ProcessName

            $map = @{
                'chrome'       = 'C:\icons\chrome.ico'
                'firefox'      = 'C:\icons\firefox.ico'
                $currentProc   = $targetIcon
                'nonexistent'  = 'C:\icons\nope.ico'
            }
            $result = InModuleScope 'BurntToast' -Parameters @{ map = $map } {
                param($map)
                Get-BTCallerAppIcon -AppLogoMap $map
            }
            $result | Should -Be $targetIcon
        }
    }

    Context 'AutoAppLogo produces valid toast XML' {
        It 'generates well-formed XML with detected icon path' {
            Start-Transcript tmp-xml.log -Force
            try {
                New-BurntToastNotification -Text 'XML Validation' -AutoAppLogo -WhatIf
            } finally {
                Stop-Transcript
                $Log = (Get-Content tmp-xml.log).Where({ $_ -match 'What if:' })
                Remove-Item tmp-xml.log
            }

            # Extract the XML from the WhatIf output and validate it parses.
            $xmlMatch = [regex]::Match($Log, '<\?xml.*</toast>')
            $xmlMatch.Success | Should -BeTrue

            $xml = [xml]$xmlMatch.Value
            $xml | Should -Not -BeNullOrEmpty

            # The image source should not be the default BurntToast.png.
            $imgSrc = $xml.toast.visual.binding.image.src
            $imgSrc | Should -Not -Match 'BurntToast\.png'
        }
    }

    Context 'combined throttle + AutoAppLogo' {
        BeforeEach {
            $lockDir = Join-Path $env:TEMP 'BurntToast-Throttle'
            if (Test-Path $lockDir) { Remove-Item $lockDir -Recurse -Force }
        }

        It 'throttles AND uses auto logo when both are set' {
            # First call — fires with auto logo.
            Start-Transcript tmp-combo1.log -Force
            try {
                New-BurntToastNotification -Text 'Combo' -AutoAppLogo -UniqueIdentifier 'combo' -CooldownSeconds 60 -WhatIf
            } finally {
                Stop-Transcript
                $Log1 = (Get-Content tmp-combo1.log).Where({ $_ -match 'What if:' })
                Remove-Item tmp-combo1.log
            }
            $Log1 | Should -Not -BeNullOrEmpty
            $Log1 | Should -Not -Match 'BurntToast\.png'

            # Second call — should be throttled (no output).
            Start-Transcript tmp-combo2.log -Force
            try {
                New-BurntToastNotification -Text 'Combo Again' -AutoAppLogo -UniqueIdentifier 'combo' -CooldownSeconds 60 -WhatIf
            } finally {
                Stop-Transcript
                $Log2 = (Get-Content tmp-combo2.log).Where({ $_ -match 'What if:' })
                Remove-Item tmp-combo2.log
            }
            $Log2 | Should -BeNullOrEmpty
        }
    }
}
