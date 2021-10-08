. (Join-Path -Path $PSScriptRoot -ChildPath '_envPrep.ps1')

Describe 'New-BTContent' {
    $ModuleRoot = (Get-Item (Get-Module 'BurntToast').Path).Directory.FullName
    $ImagePath = Resolve-Path -Path (Join-Path $ModuleRoot 'Images\BurntToast.png')

    $Text1 = New-BTText -Content 'This is a test'
    $Text2 = New-BTText -Content 'This more testing'
    $Image2 = New-BTImage -Source $ImagePath -AppLogoOverride -Crop Circle
    $Binding1 = New-BTBinding -Children $Text1, $Text2 -AppLogoOverride $Image2
    $Visual1 = New-BTVisual -BindingGeneric $Binding1

    Context 'loaded with children' {
        Start-Transcript tmp.log
        try {
            New-BTContent -Visual $Visual1 -WhatIf
        }
        finally {
            Stop-Transcript
            $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
            Remove-Item tmp.log
        }
        It 'has consitent WhatIf response' {
            $Expected = "What if: Performing the operation ""New-BTContent"" on target ""returning: [ToastContent] with XML: <?xml version=""1.0"" encoding=""utf-8""?><toast><visual><binding template=""ToastGeneric""><text>{This is a test}</text><text>{This more testing}</text><image src=""$ImagePath"" placement=""appLogoOverride"" hint-crop=""circle"" /></binding></visual></toast>""."
            $Log | Should -Be $Expected
        }
    }
    Context 'built in activation' {
        Start-Transcript tmp.log
        try {
            New-BTContent -Visual $Visual1 -ActivationType Protocol -Launch 'https://google.com' -WhatIf
        }
        finally {
            Stop-Transcript
            $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
            Remove-Item tmp.log
        }
        It 'has consitent WhatIf response' {
            $Expected = "What if: Performing the operation ""New-BTContent"" on target ""returning: [ToastContent] with XML: <?xml version=""1.0"" encoding=""utf-8""?><toast activationType=""protocol"" launch=""https://google.com""><visual><binding template=""ToastGeneric""><text>{This is a test}</text><text>{This more testing}</text><image src=""$ImagePath"" placement=""appLogoOverride"" hint-crop=""circle"" /></binding></visual></toast>""."
            $Log | Should -Be $Expected
        }
    }
}
