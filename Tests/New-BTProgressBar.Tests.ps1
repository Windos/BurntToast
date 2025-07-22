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

Describe 'New-BTProgressBar' {
    Context 'fixed value and status' {
        BeforeAll {
            Start-Transcript tmp.log
            try {
                New-BTProgressBar -Status 'Copying files' -Value 0.2 -WhatIf
            }
            finally {
                Stop-Transcript
                $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
                Remove-Item tmp.log
            }
        }

        It 'has consitent WhatIf response' {
            $Expected = 'What if: Performing the operation "New-BTProgressBar" on target "returning: [AdaptiveProgressBar]:Status=Copying files:Title=:Value=0.2:ValueStringOverride=".'
            $Log | Should -Be $Expected
        }
    }

    Context 'indeterminate progress' {
        BeforeAll {
            Start-Transcript tmp.log
            try {
                New-BTProgressBar -Status 'Copying files' -Indeterminate -WhatIf
            }
            finally {
                Stop-Transcript
                $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
                Remove-Item tmp.log
            }
        }

        It 'has consitent WhatIf response' {
            $Expected = 'What if: Performing the operation "New-BTProgressBar" on target "returning: [AdaptiveProgressBar]:Status=Copying files:Title=:Value=indeterminate:ValueStringOverride=".'
            $Log | Should -Be $Expected
        }
    }

    Context 'custom value display override' {
        BeforeAll {
            Start-Transcript tmp.log
            try {
                New-BTProgressBar -Status 'Copying files' -Value 0.2 -ValueDisplay '4/20 files complete' -WhatIf
            }
            finally {
                Stop-Transcript
                $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
                Remove-Item tmp.log
            }
        }

        It 'has consitent WhatIf response' {
            $Expected = 'What if: Performing the operation "New-BTProgressBar" on target "returning: [AdaptiveProgressBar]:Status=Copying files:Title=:Value=0.2:ValueStringOverride=4/20 files complete".'
            $Log | Should -Be $Expected
        }
    }

    Context 'with title' {
        BeforeAll {
            Start-Transcript tmp.log
            try {
                New-BTProgressBar -Title 'File Copy' -Status 'Copying files' -Value 0.2 -WhatIf
            }
            finally {
                Stop-Transcript
                $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
                Remove-Item tmp.log
            }
        }

        It 'has consitent WhatIf response' {
            $Expected = 'What if: Performing the operation "New-BTProgressBar" on target "returning: [AdaptiveProgressBar]:Status=Copying files:Title=File Copy:Value=0.2:ValueStringOverride=".'
            $Log | Should -Be $Expected
        }
    }
}
