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

Describe 'New-BTAction' {
    Context 'running without arguments' {
        BeforeAll {
            Start-Transcript tmp.log
            try {
                New-BTAction -WhatIf
            }
            finally {
                Stop-Transcript
                $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
                Remove-Item tmp.log
            }
        }

        It 'has consitent WhatIf response' {
            $Expected = 'What if: Performing the operation "New-BTAction" on target "returning: [ToastActionsCustom] with 0 Inputs, 0 Buttons, and 0 ContextMenuItems".'
            $Log | Should -Be $Expected
        }
    }

    Context 'snooze and dismiss modal' {
        BeforeAll {
            Start-Transcript tmp.log
            try {
                New-BTAction -SnoozeAndDismiss -WhatIf
            }
            finally {
                Stop-Transcript
                $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
                Remove-Item tmp.log
            }
        }

        It 'has consitent WhatIf response' {
            $Expected = 'What if: Performing the operation "New-BTAction" on target "returning: [ToastActionsSnoozeAndDismiss] with 0 Inputs, 0 Buttons, and 0 ContextMenuItems".'
            $Log | Should -Be $Expected
        }
    }

    Context 'single clickable button' {
        BeforeAll {
            Start-Transcript tmp.log
            try {
                New-BTAction -Buttons (New-BTButton -Content 'Google' -Arguments 'https://google.com') -WhatIf
            }
            finally {
                Stop-Transcript
                $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
                Remove-Item tmp.log
            }
        }

        It 'has consitent WhatIf response' {
            $Expected = 'What if: Performing the operation "New-BTAction" on target "returning: [ToastActionsCustom] with 0 Inputs, 1 Buttons, and 0 ContextMenuItems".'
            $Log | Should -Be $Expected
        }
    }

    Context 'mixed content: button & context menu' {
        BeforeAll {
            $Button = New-BTButton -Content 'Google' -Arguments 'https://google.com'
            $ContextMenuItem = New-BTContextMenuItem -Content 'Bing' -Arguments 'https://bing.com'

            Start-Transcript tmp.log
            try {
                New-BTAction -Buttons $Button -ContextMenuItems $ContextMenuItem -WhatIf
            }
            finally {
                Stop-Transcript
                $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
                Remove-Item tmp.log
            }
        }

        It 'has consitent WhatIf response' {
            $Expected = 'What if: Performing the operation "New-BTAction" on target "returning: [ToastActionsCustom] with 0 Inputs, 1 Buttons, and 1 ContextMenuItems".'
            $Log | Should -Be $Expected
        }
    }

    Context 'including too many buttons and or context menu items' {
        BeforeAll {
            $Button = New-BTButton -Content 'Google' -Arguments 'https://google.com'
            $ContextMenuItem = New-BTContextMenuItem -Content 'Bing' -Arguments 'https://bing.com'
        }

        it 'throws when providing too poolable items' {
            { $Button = New-BTButton -Content 'Google' -Arguments 'https://google.com'; $ContextMenuItem = New-BTContextMenuItem -Content 'Bing' -Arguments 'https://bing.com'; New-BTAction -Buttons $Button, $Button, $Button, $Button, $Button -ContextMenuItems $ContextMenuItem } | Should -Throw 'You have included too many buttons and context menu items. The maximum combined number of these elements is five.'
        }
    }

    Context 'input objects' {
        BeforeAll {
            Start-Transcript tmp.log
            try {
                $Input1 = New-BTInput -Id Reply001 -Title 'Type a reply:'
                New-BTAction -Inputs $Input1 -WhatIf
            }
            finally {
                Stop-Transcript
                $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
                Remove-Item tmp.log
            }
        }

        It 'has consitent WhatIf response' {
            $Expected = 'What if: Performing the operation "New-BTAction" on target "returning: [ToastActionsCustom] with 1 Inputs, 0 Buttons, and 0 ContextMenuItems".'
            $Log | Should -Be $Expected
        }
    }
}
