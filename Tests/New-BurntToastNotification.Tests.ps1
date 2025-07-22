BeforeAll {
    if (Get-Module -Name 'BurntToast') {
        Remove-Module -Name 'BurntToast'
    }

    if ($ENV:BURNTTOAST_MODULE_ROOT) {
        Import-Module $ENV:BURNTTOAST_MODULE_ROOT -Force
    } else {
        Import-Module "$PSScriptRoot/../src/BurntToast.psd1" -Force
    }

    $ModuleRoot = (Get-Item (Get-Module 'BurntToast').Path).Directory.FullName
    $ImagePath = Resolve-Path -Path (Join-Path $ModuleRoot 'Images\BurntToast.png')
}

Describe 'New-BurntToastNotification' {
    It 'has registered alias' {
        $Aliases = Get-Alias -Name 'Toast' -ErrorAction SilentlyContinue
        $Aliases.Count | Should -BeGreaterThan 0
    }

    Context 'running without arguments (default toast)' {
        BeforeAll {
            Start-Transcript tmp.log
            try {
                New-BurntToastNotification -WhatIf
            }
            finally {
                Stop-Transcript
                $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
                Remove-Item tmp.log
            }
        }

        It 'has consitent WhatIf response' {
            $Expected = "What if: Performing the operation ""New-BurntToastNotification"" on target ""submitting: <?xml version=""1.0"" encoding=""utf-8""?><toast><visual><binding template=""ToastGeneric""><text>{Default Notification}</text><image src=""$ImagePath"" placement=""appLogoOverride"" hint-crop=""circle"" /></binding></visual></toast>""."
            $Log | Should -Be $Expected
        }
    }

    Context 'custom text' {
        BeforeAll {
            Start-Transcript tmp.log
            try {
                New-BurntToastNotification -Text 'Example Script', 'The example script has run successfully.' -WhatIf
            }
            finally {
                Stop-Transcript
                $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
                Remove-Item tmp.log
            }
        }

        It 'has consitent WhatIf response' {
            $Expected = "What if: Performing the operation ""New-BurntToastNotification"" on target ""submitting: <?xml version=""1.0"" encoding=""utf-8""?><toast><visual><binding template=""ToastGeneric""><text>{Example Script}</text><text>{The example script has run successfully.}</text><image src=""$ImagePath"" placement=""appLogoOverride"" hint-crop=""circle"" /></binding></visual></toast>""."
            $Log | Should -Be $Expected
        }
    }

    Context 'system supplied sound option' {
        BeforeAll {
            Start-Transcript tmp.log
            try {
                New-BurntToastNotification -Text 'WAKE UP!' -Sound 'Alarm2' -WhatIf
            }
            finally {
                Stop-Transcript
                $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
                Remove-Item tmp.log
            }
        }

        It 'has consitent WhatIf response' {
            $Expected = "What if: Performing the operation ""New-BurntToastNotification"" on target ""submitting: <?xml version=""1.0"" encoding=""utf-8""?><toast duration=""long""><visual><binding template=""ToastGeneric""><text>{WAKE UP!}</text><image src=""$ImagePath"" placement=""appLogoOverride"" hint-crop=""circle"" /></binding></visual><audio src=""ms-winsoundevent:Notification.Looping.Alarm2"" loop=""true"" /></toast>""."
            $Log | Should -Be $Expected
        }
    }

    Context 'include a button' {
        BeforeAll {
            Start-Transcript tmp.log
            try {
                $BlogButton = New-BTButton -Content 'Open Blog' -Arguments 'https://king.geek.nz'
                New-BurntToastNotification -Text 'New Blog Post!' -Button $BlogButton -WhatIf
            }
            finally {
                Stop-Transcript
                $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
                Remove-Item tmp.log
            }
        }

        It 'has consitent WhatIf response' {
            $Expected = "What if: Performing the operation ""New-BurntToastNotification"" on target ""submitting: <?xml version=""1.0"" encoding=""utf-8""?><toast><visual><binding template=""ToastGeneric""><text>{New Blog Post!}</text><image src=""$ImagePath"" placement=""appLogoOverride"" hint-crop=""circle"" /></binding></visual><actions><action content=""Open Blog"" arguments=""https://king.geek.nz"" activationType=""protocol"" /></actions></toast>""."
            $Log | Should -Be $Expected
        }
    }

    Context 'include a header' {
        BeforeAll {
            Start-Transcript tmp.log
            try {
                $ToastHeader = New-BTHeader -Id '001' -Title 'SO Questions'
                New-BurntToastNotification -Text 'New SO Question', 'Details...' -Header $ToastHeader  -WhatIf
            }
            finally {
                Stop-Transcript
                $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
                Remove-Item tmp.log
            }
        }

        It 'has consitent WhatIf response' {
            $Expected = "What if: Performing the operation ""New-BurntToastNotification"" on target ""submitting: <?xml version=""1.0"" encoding=""utf-8""?><toast><visual><binding template=""ToastGeneric""><text>{New SO Question}</text><text>{Details...}</text><image src=""$ImagePath"" placement=""appLogoOverride"" hint-crop=""circle"" /></binding></visual><header id=""001"" title=""SO Questions"" arguments="""" activationType=""protocol"" /></toast>""."
            $Log | Should -Be $Expected
        }
    }

    Context 'include a progress bar' {
        BeforeAll {
            Start-Transcript tmp.log
            try {
                $Progress = New-BTProgressBar -Status 'Copying' -Value 0.2
                New-BurntToastNotification -Text 'File copy running' -ProgressBar $Progress -WhatIf
            }
            finally {
                Stop-Transcript
                $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
                Remove-Item tmp.log
            }
        }

        It 'has consitent WhatIf response' {
            $Expected = "What if: Performing the operation ""New-BurntToastNotification"" on target ""submitting: <?xml version=""1.0"" encoding=""utf-8""?><toast><visual><binding template=""ToastGeneric""><text>{File copy running}</text><progress value=""{0.2}"" status=""{Copying}"" /><image src=""$ImagePath"" placement=""appLogoOverride"" hint-crop=""circle"" /></binding></visual></toast>""."
            $Log | Should -Be $Expected
        }
    }

    Context 'attribution text' {
        BeforeAll {
            Start-Transcript tmp.log
            try {
                $Text1 = New-BTText -Content 'Default Notification'

                $Attrib = 'via Pester'

                $Binding1 = New-BTBinding -Children $Text1 -Attribution $Attrib
                $Visual1 = New-BTVisual -BindingGeneric $Binding1
                $Content1 = New-BTContent -Visual $Visual1

                Submit-BTNotification -Content $Content1 -WhatIf
            }
            finally {
                Stop-Transcript
                $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
                Remove-Item tmp.log
            }
        }

        It 'has consitent WhatIf response' {
            $Expected = 'What if: Performing the operation "Submit-BTNotification" on target "submitting: [ToastNotification] with Id , Sequence Number  and XML: <?xml version="1.0" encoding="utf-8"?><toast><visual><binding template="ToastGeneric"><text>{Default Notification}</text><text placement="attribution">via Pester</text></binding></visual></toast>".'
            $Log | Should -Be $Expected
        }
    }
}

Context 'include attribution string' {
    BeforeAll {
        Start-Transcript tmp.log
        try {
            New-BurntToastNotification -Text 'Notification with Attribution' -Attribution 'Via Pester' -WhatIf
        }
        finally {
            Stop-Transcript
            $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
            Remove-Item tmp.log
        }
    }

    It 'includes attribution text in WhatIf response' {
        $Expected = "What if: Performing the operation ""New-BurntToastNotification"" on target ""submitting: <?xml version=""1.0"" encoding=""utf-8""?><toast><visual><binding template=""ToastGeneric""><text>{Notification with Attribution}</text><text placement=""attribution"">Via Pester</text><image src=""$ImagePath"" placement=""appLogoOverride"" hint-crop=""circle"" /></binding></visual></toast>""."
        $Log | Should -Be $Expected
    }
}
