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

Describe 'New-BTContextMenuItem' {
    Context 'loaded with standard arguments' {
        BeforeAll {
            Start-Transcript tmp.log
            try {
                New-BTContextMenuItem -Content 'Google' -Arguments 'https://google.com' -ActivationType Protocol -WhatIf
            }
            finally {
                Stop-Transcript
                $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
                Remove-Item tmp.log
            }
        }

        It 'has consitent WhatIf response' {
            $Expected = 'What if: Performing the operation "New-BTContextMenuItem" on target "returning: [ToastContextMenuItem]:Content=Google:Arguments=https://google.com:ActivationType=Protocol".'
            $Log | Should -Be $Expected
        }
    }
}
