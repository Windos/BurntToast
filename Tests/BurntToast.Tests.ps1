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

Describe 'BurntToast Module' {
    Context 'meta validation' {
        It 'should import functions' {
            (Get-Module BurntToast).ExportedFunctions.Count | Should -Be 20
        }

        It 'should import aliases' {
            (Get-Module BurntToast).ExportedAliases.Count | Should -Be 1
        }
    }

    Context 'Importing on Unsupported Operating Systems' {
        It 'throws when importing on operating systems older than Windows 10' {
            $env:BurntToastPesterNotWindows10 = $true

            if (Get-Module -Name 'BurntToast') {
                Remove-Module -Name 'BurntToast'
            }

            if ($ENV:BURNTTOAST_MODULE_ROOT) {
                {Import-Module $ENV:BURNTTOAST_MODULE_ROOT -Force} | Should -Throw -ExpectedMessage 'This version of BurntToast will only work on Windows 10*'
            } else {
                {Import-Module "$PSScriptRoot/../src/BurntToast.psd1" -Force} | Should -Throw -ExpectedMessage 'This version of BurntToast will only work on Windows 10*'
            }
        }

        It 'throws when importing on Windows 10 builds older than the Anniversary Update' {
            $env:BurntToastPesterNotAnniversaryUpdate = $true

            if (Get-Module -Name 'BurntToast') {
                Remove-Module -Name 'BurntToast'
            }

            if ($ENV:BURNTTOAST_MODULE_ROOT) {
                {Import-Module $ENV:BURNTTOAST_MODULE_ROOT -Force} | Should -Throw -ExpectedMessage 'This version of BurntToast will only work on Windows 10 Creators Update (15063) and above*'
            } else {
                {Import-Module "$PSScriptRoot/../src/BurntToast.psd1" -Force} | Should -Throw -ExpectedMessage 'This version of BurntToast will only work on Windows 10 Creators Update (15063) and above*'
            }
        }

        AfterEach {
            $env:BurntToastPesterNotWindows10 = $null
            $env:BurntToastPesterNotAnniversaryUpdate = $null
        }
    }
}
