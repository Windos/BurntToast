Describe 'BurntToast Module' {
    Context 'meta validation' {
        It 'doesn''t throw' {
            if (Get-Module -Name 'BurntToast') {
                Remove-Module -Name 'BurntToast'
            }

            if ($ENV:BURNTTOAST_MODULE_ROOT) {
                {Import-Module $ENV:BURNTTOAST_MODULE_ROOT -Force} | Should -Not -Throw
            } else {
                {Import-Module "$PSScriptRoot/../src/BurntToast.psd1" -Force} | Should -Not -Throw
            }
        }

        It 'should import functions' {
            (Get-Module BurntToast).ExportedFunctions.Count | Should -Be 6
        }

        It 'should import aliases' {
            (Get-Module BurntToast).ExportedAliases.Count | Should -Be 1
        }
    }
}
