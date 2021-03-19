Describe 'BurntToast Module' {
    Context 'meta validation' {
        It 'doesn''t throw' {
            if (Get-Module -Name 'BurntToast') {
                Remove-Module -Name 'BurntToast'
            }

            {Import-Module "$PSScriptRoot/../src/BurntToast.psd1" -Force} | Should -Not -Throw
        }

        It 'should import functions' {
            (Get-Module BurntToast).ExportedFunctions.Count | Should -Be 3
        }

        It 'should import aliases' {
            (Get-Module BurntToast).ExportedAliases.Count | Should -Be 1
        }
    }
}
