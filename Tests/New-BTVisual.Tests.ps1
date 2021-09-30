. (Join-Path -Path $PSScriptRoot -ChildPath '_envPrep.ps1')

Describe 'New-BTVisual' {
    $Text1 = New-BTText -Content 'This is a test'
    $Binding1 = New-BTBinding -Children $Text1

    Context 'accept binding, create visual' {
        Start-Transcript tmp.log
        try {
            New-BTVisual -BindingGeneric $Binding1 -WhatIf
        }
        finally {
            Stop-Transcript
            $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
            Remove-Item tmp.log
        }
        It 'has consitent WhatIf response' {
            $Expected = 'What if: Performing the operation "New-BTVisual" on target "returning: [ToastVisual]:BindingGeneric=1:BaseUri=:Language=".'
            $Log | Should -Be $Expected
        }
    }
}
