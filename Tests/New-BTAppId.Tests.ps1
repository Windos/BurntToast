. (Join-Path -Path $PSScriptRoot -ChildPath '_envPrep.ps1')

Describe 'New-BTAppId' {
    Mock New-Item {} -ModuleName BurntToast
    Mock New-ItemProperty {} -ModuleName BurntToast

    Context 'executing when AppId already exists' {
        Mock Test-Path { $true } -ModuleName BurntToast -Verifiable -ParameterFilter {
            $Path -eq 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\{1AC14E77-02E7-4E5D-B744-2EB1AE5198B7}\WindowsPowerShell\v1.0\powershell.exe'
        }

        New-BTAppId

        It 'tested the correct path' {
            Assert-VerifiableMock
        }
        It 'should not have called cmdlet: New-Item' {
            Assert-MockCalled New-Item -Time 0 -Exactly -Scope Context -ModuleName BurntToast
        }
        It 'should not have called cmdlet: New-Item' {
            Assert-MockCalled New-ItemProperty -Time 0 -Exactly -Scope Context -ModuleName BurntToast
        }
    }

    Context 'executing when AppId is unique' {
        Mock Test-Path { $false } -ModuleName BurntToast  -Verifiable -ParameterFilter {
            $Path -eq 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\Script Checker'
        }

        New-BTAppId -AppId 'Script Checker'

        It 'tested the correct path' {
            Assert-VerifiableMock
        }
        It 'should have called cmdlet: New-Item' {
            Assert-MockCalled New-Item -Time 1 -Exactly -Scope Context -ModuleName BurntToast
        }
        It 'should have called cmdlet: New-Item' {
            Assert-MockCalled New-ItemProperty -Time 1 -Exactly -Scope Context -ModuleName BurntToast
        }
    }
}
