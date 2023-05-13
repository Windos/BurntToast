Describe 'New-BTContentBuilder' {
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

    Context 'full builder lifecycle' {
        BeforeAll {
            $Builder = New-BTContentBuilder
            $Builder | Add-BTText -Text 'First Line of Text', 'Second Line of Text'

            Start-Transcript tmp.log
            try {
                Show-BTNotification -ContentBuilder $Builder -WhatIf
            }
            finally {
                Stop-Transcript
                $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
                Remove-Item tmp.log
            }
        }

        It 'has the expected XML content' {
            $ExpectedLog = 'What if: Performing the operation "Show-BTNotification" on target "submitting: <?xml version="1.0" encoding="utf-8"?><toast><visual><binding template="ToastGeneric"><text>First Line of Text</text><text>Second Line of Text</text></binding></visual></toast>".'
            $Log | Should -Be $ExpectedLog
        }

        It 'does not throw an exception with a data binding' {
            $Builder | Add-BTDataBinding -Key 'Test' -Value 'Example'
            { Show-BTNotification -ContentBuilder $Builder } | Should -Not -Throw
        }
    }
}
