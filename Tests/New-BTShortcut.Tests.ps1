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

Describe 'New-BTShortcut' {
    Context 'with AppId, DisplayName, and IconPath' {
        It 'runs without error with icon' {
            { New-BTShortcut -AppId "Acme.MyApp" -DisplayName "My App PowerShell" -IconPath "C:\Path\To\MyIcon.ico" -WhatIf } | Should -Not -Throw
        }
    }
    Context 'with AppId only' {
        It 'runs without error default shortcut' {
            { New-BTShortcut -AppId "Acme.MyApp" -WhatIf } | Should -Not -Throw
        }
    }
    Context 'with ForceWindowsPowerShell' {
        It 'runs without error forcing Windows PowerShell' {
            { New-BTShortcut -AppId "Acme.MyApp" -ForceWindowsPowerShell -WhatIf } | Should -Not -Throw
        }
    }
    Context 'with ExecutablePath' {
        It 'runs without error with custom executable path' {
            { New-BTShortcut -AppId "Acme.MyApp" -ExecutablePath "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -WhatIf } | Should -Not -Throw
        }
    }
}