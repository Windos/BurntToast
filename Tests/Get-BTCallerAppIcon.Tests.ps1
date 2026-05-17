BeforeAll {
    if (Get-Module -Name 'BurntToast') {
        Remove-Module -Name 'BurntToast'
    }

    if ($ENV:BURNTTOAST_MODULE_ROOT) {
        Import-Module $ENV:BURNTTOAST_MODULE_ROOT -Force
    } else {
        Import-Module "$PSScriptRoot/../src/BurntToast.psd1" -Force
    }

    # Clean icon cache before tests so we get fresh extraction results.
    $iconCacheDir = Join-Path $env:TEMP 'BurntToast-IconCache'
    if (Test-Path $iconCacheDir) { Remove-Item $iconCacheDir -Recurse -Force }
}

Describe 'Get-BTCallerAppIcon' {
    # Private function — must use InModuleScope to access it from tests.
    Context 'function exists' {
        It 'is defined as a private function in the module' {
            InModuleScope 'BurntToast' {
                $cmd = Get-Command -Name 'Get-BTCallerAppIcon' -ErrorAction SilentlyContinue
                $cmd | Should -Not -BeNullOrEmpty
            }
        }
    }

    Context 'returns an icon path' {
        It 'returns a string path when called' {
            $result = InModuleScope 'BurntToast' { Get-BTCallerAppIcon }
            $result | Should -BeOfType [string]
        }

        It 'returns a path to a file that exists' {
            $result = InModuleScope 'BurntToast' { Get-BTCallerAppIcon }
            if ($result) {
                Test-Path $result | Should -BeTrue
            }
        }
    }

    Context 'override map' {
        It 'uses override icon when process name matches AppLogoMap key' {
            $ModuleRoot = (Get-Item (Get-Module 'BurntToast').Path).Directory.FullName
            $fallbackIcon = Join-Path $ModuleRoot 'Images\BurntToast.png'

            # Map the current PowerShell process name so the override triggers.
            $currentProc = (Get-Process -Id $PID).ProcessName
            $result = InModuleScope 'BurntToast' -Parameters @{ procName = $currentProc; iconPath = $fallbackIcon } {
                param($procName, $iconPath)
                Get-BTCallerAppIcon -AppLogoMap @{ $procName = $iconPath }
            }
            $result | Should -Be $fallbackIcon
        }

        It 'ignores override map when process name does not match' {
            $result = InModuleScope 'BurntToast' {
                Get-BTCallerAppIcon -AppLogoMap @{ 'nonexistent-process-xyz' = 'C:\fake\icon.ico' }
            }
            $result | Should -Not -Be 'C:\fake\icon.ico'
        }
    }

    Context 'icon caching' {
        It 'caches extracted icons in temp directory' {
            $result = InModuleScope 'BurntToast' { Get-BTCallerAppIcon }
            if ($result) {
                $result | Should -Match ([regex]::Escape($env:TEMP))
            }
        }
    }
}

Describe 'New-BurntToastNotification AutoAppLogo' {
    Context 'AutoAppLogo switch exists' {
        It 'accepts -AutoAppLogo without error' {
            { New-BurntToastNotification -Text 'Auto Logo Test' -AutoAppLogo -WhatIf } | Should -Not -Throw
        }
    }

    Context 'AutoAppLogo overrides default logo' {
        It 'uses detected app icon instead of default BurntToast logo' {
            Start-Transcript tmp-autologo.log
            try {
                New-BurntToastNotification -Text 'Auto Logo' -AutoAppLogo -WhatIf
            } finally {
                Stop-Transcript
                $Log = (Get-Content tmp-autologo.log).Where({ $_ -match 'What if:' })
                Remove-Item tmp-autologo.log
            }
            $ModuleRoot = (Get-Item (Get-Module 'BurntToast').Path).Directory.FullName
            $defaultLogo = Join-Path $ModuleRoot 'Images\BurntToast.png'
            $Log | Should -Not -Match ([regex]::Escape($defaultLogo))
        }
    }

    Context 'AutoAppLogo with AppLogoMap' {
        It 'accepts -AppLogoMap hashtable parameter' {
            $map = @{ 'pwsh' = 'C:\test\icon.ico'; 'powershell' = 'C:\test\icon.ico' }
            { New-BurntToastNotification -Text 'Map Test' -AutoAppLogo -AppLogoMap $map -WhatIf } | Should -Not -Throw
        }
    }

    Context 'AutoAppLogo and AppLogo are mutually exclusive' {
        It 'throws when both -AutoAppLogo and -AppLogo are specified' {
            { New-BurntToastNotification -Text 'Conflict' -AutoAppLogo -AppLogo 'C:\test.ico' -WhatIf } | Should -Throw
        }
    }
}
