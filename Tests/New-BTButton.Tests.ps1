. (Join-Path -Path $PSScriptRoot -ChildPath '_envPrep.ps1')

Describe 'New-BTButton' {
    Context 'system defined dismiss button' {
        Start-Transcript tmp.log
        try {
            New-BTButton -Dismiss -WhatIf
        }
        finally {
            Stop-Transcript
            $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
            Remove-Item tmp.log
        }
        It 'has consitent WhatIf response' {
            $Expected = 'What if: Performing the operation "New-BTButton" on target "returning: [ToastButtonDismiss]:CustomContent=:ImageUri=".'
            $Log | Should -Be $Expected
        }
    }
    Context 'system defined snooze button' {
        Start-Transcript tmp.log
        try {
            New-BTButton -Snooze -WhatIf
        }
        finally {
            Stop-Transcript
            $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
            Remove-Item tmp.log
        }
        It 'has consitent WhatIf response' {
            $Expected = 'What if: Performing the operation "New-BTButton" on target "returning: [ToastButtonSnooze]:CustomContent=:ImageUri=:SelectionBoxId=".'
            $Log | Should -Be $Expected
        }
    }
    Context 'custom button with text' {
        Start-Transcript tmp.log
        try {
            New-BTButton -Content 'Blog' -Arguments 'https://king.geek.nz' -WhatIf
        }
        finally {
            Stop-Transcript
            $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
            Remove-Item tmp.log
        }
        It 'has consitent WhatIf response' {
            $Expected = 'What if: Performing the operation "New-BTButton" on target "returning: [ToastButton]:Content=Blog:Arguments=https://king.geek.nz:ActivationType=Protocol:ImageUri=:TextBoxId=".'
            $Log | Should -Be $Expected
        }
    }
    Context 'custom button with image' {
        Start-Transcript tmp.log
        try {
            $Picture = "$PSScriptRoot\..\Media\BurntToast.png"
            New-BTButton -Content 'View Picture' -Arguments $Picture -ImageUri $Picture -WhatIf
        }
        finally {
            Stop-Transcript
            $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
            Remove-Item tmp.log
        }
        It 'has consitent WhatIf response' {
            $Expected = "What if: Performing the operation ""New-BTButton"" on target ""returning: [ToastButton]:Content=View Picture:Arguments=$PSScriptRoot\..\Media\BurntToast.png:ActivationType=Protocol:ImageUri=$PSScriptRoot\..\Media\BurntToast.png:TextBoxId=""."
            $Log | Should -Be $Expected
        }
    }
}
