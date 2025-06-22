BeforeAll {
    if (Get-Module -Name 'BurntToast') {
        Remove-Module -Name 'BurntToast'
    }

    if ($ENV:BURNTTOAST_MODULE_ROOT) {
        Import-Module $ENV:BURNTTOAST_MODULE_ROOT -Force
    } else {
        Import-Module "$PSScriptRoot/../src/BurntToast.psd1" -Force
    }

    $Text1 = New-BTText -Content 'This is a test'
    $Binding1 = New-BTBinding -Children $Text1
}

Describe 'New-BTVisual' {
    Context 'accept binding, create visual' {
        BeforeAll {
            Start-Transcript tmp.log
            try {
                New-BTVisual -BindingGeneric $Binding1 -WhatIf
            }
            finally {
                Stop-Transcript
                $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
                Remove-Item tmp.log
            }
        }

        It 'has consitent WhatIf response' {
            $Expected = 'What if: Performing the operation "New-BTVisual" on target "returning: [ToastVisual]:BindingGeneric=1:BaseUri=:Language=".'
            $Log | Should -Be $Expected
        }
    }
}
