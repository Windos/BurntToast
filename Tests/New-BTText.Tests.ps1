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

Describe 'New-BTText' {
    Context 'blank line' {
        BeforeAll {
            Start-Transcript tmp.log
            try {
                New-BTText -WhatIf
            }
            finally {
                Stop-Transcript
                $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
                Remove-Item tmp.log
            }
        }

        It 'has consitent WhatIf response' {
            $Expected = 'What if: Performing the operation "New-BTText" on target "returning: [AdaptiveText]:Text=:HintMaxLines=:HintMinLines=:HintWrap=:HintAlign=Default:HintStyle=Default:Language=".'
            $Log | Should -Be $Expected
        }
    }

    Context 'with content' {
        BeforeAll {
            Start-Transcript tmp.log
            try {
                New-BTText -Content 'This is a line with text!' -WhatIf
            }
            finally {
                Stop-Transcript
                $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
                Remove-Item tmp.log
            }
        }

        It 'has consitent WhatIf response' {
            $Expected = 'What if: Performing the operation "New-BTText" on target "returning: [AdaptiveText]:Text=This is a line with text!:HintMaxLines=:HintMinLines=:HintWrap=:HintAlign=Default:HintStyle=Default:Language=".'
            $Log | Should -Be $Expected
        }
    }
}
