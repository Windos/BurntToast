. (Join-Path -Path $PSScriptRoot -ChildPath '_envPrep.ps1')

Describe 'Get-BTHistory' {
    if ($PlatformAvailable) {
        Context 'valid AppId, one previous toast' {
            Mock Test-Path { $true } -ModuleName BurntToast -Verifiable -ParameterFilter {
                $Path -eq 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\{1AC14E77-02E7-4E5D-B744-2EB1AE5198B7}\WindowsPowerShell\v1.0\powershell.exe'
            }

            It 'should not throw' {
                { Get-BTHistory } | Should -Not -Throw
            }

            It 'tested the correct path' {
                Assert-VerifiableMock
            }
        }
    }

    Context 'invalid AppId' {
        Mock Test-Path { $false } -ModuleName BurntToast  -Verifiable -ParameterFilter {
            $Path -eq 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\Script Checker'
        }

        It 'should throw' {
            { Get-BTHistory -AppId 'Script Checker' } | Should -Throw "The AppId Script Checker is not present in the registry, please run New-BTAppId to avoid inconsistent Toast behaviour."
        }

        It 'tested the correct path' {
            Assert-VerifiableMock
        }
    }
}
