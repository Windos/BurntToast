. (Join-Path -Path $PSScriptRoot -ChildPath '_envPrep.ps1')

Describe 'New-BTSelectionBoxItem' {
    Context 'loaded with standard arguments' {
        Start-Transcript tmp.log
        try {
            New-BTSelectionBoxItem -Id 'Item1' -Content 'First option in the list' -WhatIf
        }
        finally {
            Stop-Transcript
            $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
            Remove-Item tmp.log
        }
        It 'has consitent WhatIf response' {
            $Expected = 'What if: Performing the operation "New-BTSelectionBoxItem" on target "returning: [ToastSelectionBoxItem]:Id=Item1:Content=First option in the list".'
            $Log | Should -Be $Expected
        }
    }
}
