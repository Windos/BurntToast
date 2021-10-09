. (Join-Path -Path $PSScriptRoot -ChildPath '_envPrep.ps1')

Describe 'BurntToast Module' {
    Context 'meta validation' {
        It 'should import functions' {
            (Get-Module BurntToast).ExportedFunctions.Count | Should -Be 25
        }

        It 'should import aliases' {
            (Get-Module BurntToast).ExportedAliases.Count | Should -Be 1
        }
    }
}
