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

Describe 'New-BTInput' {
    Context 'text entry box' {
        BeforeAll {
            Start-Transcript tmp.log
            try {
                New-BTInput -Id Reply001 -Title 'Type a reply:' -WhatIf
            }
            finally {
                Stop-Transcript
                $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
                Remove-Item tmp.log
            }
        }

        It 'has consitent WhatIf response' {
            $Expected = 'What if: Performing the operation "New-BTInput" on target "returning: [ToastTextBox]:Id=Reply001:Title=Type a reply::PlaceholderContent=:DefaultInput=".'
            $Log | Should -Be $Expected
        }
    }

    Context 'selection box with five options' {
        BeforeAll {
            $Select1 = New-BTSelectionBoxItem -Id 'Item1' -Content 'First option in the list'
            $Select2 = New-BTSelectionBoxItem -Id 'Item2' -Content 'Second option in the list'
            $Select3 = New-BTSelectionBoxItem -Id 'Item3' -Content 'Third option in the list'
            $Select4 = New-BTSelectionBoxItem -Id 'Item4' -Content 'Fourth option in the list'
            $Select5 = New-BTSelectionBoxItem -Id 'Item5' -Content 'Fifth option in the list'
            Start-Transcript tmp.log
            try {
                New-BTInput -Id 'Selection001' -DefaultSelectionBoxItemId 'Item5' -Items $Select1, $Select2, $Select3, $Select4, $Select5 -WhatIf
            }
            finally {
                Stop-Transcript
                $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
                Remove-Item tmp.log
            }
        }

        It 'has consitent WhatIf response' {
            $Expected = 'What if: Performing the operation "New-BTInput" on target "returning: [ToastSelectionBox]:Id=Selection001:Title=:DefaultSelectionBoxItemId=Item5:DefaultInput=5".'
            $Log | Should -Be $Expected
        }
    }
}
