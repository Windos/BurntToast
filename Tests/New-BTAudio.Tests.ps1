. (Join-Path -Path $PSScriptRoot -ChildPath '_envPrep.ps1')

Describe 'New-BTAudio' {
    Context 'built in audio source' {
        Start-Transcript tmp.log
        try {
            New-BTAudio -Source ms-winsoundevent:Notification.SMS -WhatIf
        }
        finally {
            Stop-Transcript
            $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
            Remove-Item tmp.log
        }
        It 'has consitent WhatIf response' {
            $Expected = 'What if: Performing the operation "New-BTAudio" on target "returning: [ToastAudio]:Src=ms-winsoundevent:Notification.SMS:Loop=False:Silent=False".'
            $Log | Should -Be $Expected
        }
    }
    Context 'custom audio source' {
        Start-Transcript tmp.log
        try {
            New-BTAudio -Path 'C:\Windows\media\tada.wav' -WhatIf
        }
        finally {
            Stop-Transcript
            $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
            Remove-Item tmp.log
        }
        It 'has consitent WhatIf response' {
            $Expected = 'What if: Performing the operation "New-BTAudio" on target "returning: [ToastAudio]:Src=file:///C:/Windows/media/tada.wav:Loop=False:Silent=False".'
            $Log | Should -Be $Expected
        }
    }
    Context 'Silent switch' {
        Start-Transcript tmp.log
        try {
            New-BTAudio -Silent -WhatIf
        }
        finally {
            Stop-Transcript
            $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
            Remove-Item tmp.log
        }
        It 'has consitent WhatIf response' {
            $Expected = 'What if: Performing the operation "New-BTAudio" on target "returning: [ToastAudio]:Src=:Loop=False:Silent=True".'
            $Log | Should -Be $Expected
        }
    }
    Context 'input validation' {
        It 'throws if audio file doesn''t exist' {
            { New-BTAudio -Path 'C:\Fake\phantom.wav' } | Should -Throw "The file 'C:\Fake\phantom.wav' doesn't exist in the specified location. Please provide a valid path and try again."
        }
        It 'throws if the extension is not supported' {
            { New-BTAudio -Path 'C:\Fake\phantom.mov' } | Should -Throw "The file extension '.mov' is not supported. Please provide a valid path and try again."
        }
    }
}
