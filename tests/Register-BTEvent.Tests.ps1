Describe 'Register-BTEvent' {
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

    Context 'When called with default parameters' {
        It 'should not pass through the event registration object' {
            $EventRegistration = Register-BTEvent -Action { Write-Host 'Test' }

            $EventRegistration | Should -BeNullOrEmpty
        }
    }
    
    Context 'When called with custom parameters' {
        It 'should register an event with a unique source identifier' {
            $EventRegistration = Register-BTEvent -Action { Write-Host 'Test' } -PassThru

            $EventRegistration | Should -Not -BeNullOrEmpty
            $EventRegistration.Name | Should -Match 'BurntToast_\w{8}-\w{4}-\w{4}-\w{4}-\w{12}'
            $EventRegistration.Command | Should -Match 'Write-Host ''Test'''
        }

        It 'should register an event with the specified source identifier' {
            $EventRegistration = Register-BTEvent -Action { Write-Host 'Test' } -SourceIdentifier 'Pester' -PassThru

            $EventRegistration | Should -Not -BeNullOrEmpty
            $EventRegistration.Name | Should -Match 'Pester'
        }
    }
}