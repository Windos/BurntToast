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
}
