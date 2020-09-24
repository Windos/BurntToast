. (Join-Path -Path $PSScriptRoot -ChildPath '_envPrep.ps1')

Describe 'New-BTContextMenuItem' {
    Context 'loaded with standard arguments' {
        Start-Transcript tmp.log
        try {
            New-BTContextMenuItem -Content 'Google' -Arguments 'https://google.com' -ActivationType Protocol -WhatIf
        }
        finally {
            Stop-Transcript
            $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
            Remove-Item tmp.log
        }
        It 'has consitent WhatIf response' {
            $Expected = 'What if: Performing the operation "New-BTContextMenuItem" on target "returning: [ToastContextMenuItem]:Content=Google:Arguments=https://google.com:ActivationType=Protocol".'
            $Log | Should -Be $Expected
        }
    }
}
