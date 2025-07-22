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

Describe 'New-BTHeader' {
    Context 'loaded with standard arguments' {
        BeforeAll {
            Start-Transcript tmp.log
            try {
                New-BTHeader -Id 'primary header' -Title 'First Category' -WhatIf
            }
            finally {
                Stop-Transcript
                $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
                Remove-Item tmp.log
            }
        }

        It 'has consitent WhatIf response' {
            $Expected = 'What if: Performing the operation "New-BTHeader" on target "returning: [ToastHeader]:Id=primary header:Title=First Category:Arguments=:ActivationType=Protocol".'
            $Log | Should -Be $Expected
        }
    }

    Context 'loaded without Id' {
        BeforeAll {
            Start-Transcript tmp.log
            try {
                New-BTHeader -Title 'First Category' -WhatIf
            }
            finally {
                Stop-Transcript
                $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
                Remove-Item tmp.log
            }
        }

        It 'generates an Id' {
            $Expected = 'Id=[a-zA-Z\d]+:Title'
            $Log | Should -Match $Expected
        }
    }

    Context 'clickable header text' {
        BeforeAll {
            Start-Transcript tmp.log
            try {
                New-BTHeader -Id '001' -Title 'Stack Overflow Questions' -Arguments 'http://stackoverflow.com/' -WhatIf
            }
            finally {
                Stop-Transcript
                $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
                Remove-Item tmp.log
            }
        }

        It 'has consitent WhatIf response' {
            $Expected = 'What if: Performing the operation "New-BTHeader" on target "returning: [ToastHeader]:Id=001:Title=Stack Overflow Questions:Arguments=http://stackoverflow.com/:ActivationType=Protocol".'
            $Log | Should -Be $Expected
        }
    }
}
