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

Describe 'New-BTAudio' {
    Context 'built in audio source' {
        BeforeAll {
            Start-Transcript tmp.log
            try {
                New-BTAudio -Source ms-winsoundevent:Notification.SMS -WhatIf
            }
            finally {
                Stop-Transcript
                $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
                Remove-Item tmp.log
            }
        }

        It 'has consitent WhatIf response' {
            $Expected = 'What if: Performing the operation "New-BTAudio" on target "returning: [ToastAudio]:Src=ms-winsoundevent:Notification.SMS:Loop=False:Silent=False".'
            $Log | Should -Be $Expected
        }
    }

    Context 'Silent switch' {
        BeforeAll {
            Start-Transcript tmp.log
            try {
                New-BTAudio -Silent -WhatIf
            }
            finally {
                Stop-Transcript
                $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
                Remove-Item tmp.log
            }
        }

        It 'has consitent WhatIf response' {
            $Expected = 'What if: Performing the operation "New-BTAudio" on target "returning: [ToastAudio]:Src=:Loop=False:Silent=True".'
            $Log | Should -Be $Expected
        }
    }
}
