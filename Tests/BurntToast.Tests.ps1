Import-Module "$PSScriptRoot/../BurntToast/BurntToast.psd1" -Force

Describe 'New-BTAppId' {
    Context 'running without arguments' {
        Start-Transcript tmp.log
        try {
            New-BTAppId -DryFire -WhatIf
        }
        finally {
            Stop-Transcript
            $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
            Remove-Item tmp.log
        }
        It 'has consitent WhatIf response' {
            $Expected = 'What if: Performing the operation "New-BTAppId" on target "creating: ''HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\{1AC14E77-02E7-4E5D-B744-2EB1AE5198B7}\WindowsPowerShell\v1.0\powershell.exe'' with property ''ShowInActionCenter'' set to ''1'' (DWORD)".'
            $Log -join [System.Environment]::NewLine | should Be $Expected
        }
    }
    Context 'running with custom AppId' {
        Start-Transcript tmp.log
        try {
            New-BTAppId -AppId 'Script Checker' -DryFire -WhatIf
        }
        finally {
            Stop-Transcript
            $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
            Remove-Item tmp.log
        }
        It 'has consitent WhatIf response' {
            $Expected = 'What if: Performing the operation "New-BTAppId" on target "creating: ''HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\Script Checker'' with property ''ShowInActionCenter'' set to ''1'' (DWORD)".'
            $Log -join [System.Environment]::NewLine | should Be $Expected
        }
    }
}

Describe 'New-BTAudio' {
    Context 'built in audio source' {
        Start-Transcript tmp.log
        try {
            New-BTAudio -Source ms-winsoundevent:Notification.SMS -WhatIf
        }
        finally {
            Stop-Transcript
            $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
            Remove-Item tmp.log
        }
        It 'has consitent WhatIf response' {
            $Expected = 'What if: Performing the operation "New-BTAudio" on target "returning: [ToastAudio]:Src=ms-winsoundevent:Notification.SMS:Loop=False:Silent=False".'
            $Log -join [System.Environment]::NewLine | should Be $Expected
        }
    }
    Context 'custom audio source' {
        Start-Transcript tmp.log
        try {
            New-BTAudio -Path 'C:\Windows\media\tada.wav' -WhatIf
        }
        finally {
            Stop-Transcript
            $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
            Remove-Item tmp.log
        }
        It 'has consitent WhatIf response' {
            $Expected = 'What if: Performing the operation "New-BTAudio" on target "returning: [ToastAudio]:Src=file:///C:/Windows/media/tada.wav:Loop=False:Silent=False".'
            $Log -join [System.Environment]::NewLine | should Be $Expected
        }
    }
    Context 'Silent switch' {
        Start-Transcript tmp.log
        try {
            New-BTAudio -Silent -WhatIf
        }
        finally {
            Stop-Transcript
            $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
            Remove-Item tmp.log
        }
        It 'has consitent WhatIf response' {
            $Expected = 'What if: Performing the operation "New-BTAudio" on target "returning: [ToastAudio]:Src=:Loop=False:Silent=True".'
            $Log -join [System.Environment]::NewLine | should Be $Expected
        }
    }
}

Describe 'New-BTButton' {
    Context 'system defined dismiss button' {
        Start-Transcript tmp.log
        try {
            New-BTButton -Dismiss -WhatIf
        }
        finally {
            Stop-Transcript
            $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
            Remove-Item tmp.log
        }
        It 'has consitent WhatIf response' {
            $Expected = 'What if: Performing the operation "New-BTButton" on target "returning: [ToastButtonDismiss]:CustomContent=:ImageUri=".'
            $Log -join [System.Environment]::NewLine | should Be $Expected
        }
    }
    Context 'system defined snooze button' {
        Start-Transcript tmp.log
        try {
            New-BTButton -Snooze -WhatIf
        }
        finally {
            Stop-Transcript
            $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
            Remove-Item tmp.log
        }
        It 'has consitent WhatIf response' {
            $Expected = 'What if: Performing the operation "New-BTButton" on target "returning: [ToastButtonSnooze]:CustomContent=:ImageUri=:SelectionBoxId=".'
            $Log -join [System.Environment]::NewLine | should Be $Expected
        }
    }
    Context 'custom button with text' {
        Start-Transcript tmp.log
        try {
            New-BTButton -Content 'Blog' -Arguments 'https://king.geek.nz' -WhatIf
        }
        finally {
            Stop-Transcript
            $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
            Remove-Item tmp.log
        }
        It 'has consitent WhatIf response' {
            $Expected = 'What if: Performing the operation "New-BTButton" on target "returning: [ToastButton]:Content=Blog:Arguments=https://king.geek.nz:ActivationType=Protocol:ImageUri=:TextBoxId=".'
            $Log -join [System.Environment]::NewLine | should Be $Expected
        }
    }
    Context 'custom button with image' {
        Start-Transcript tmp.log
        try {
            $Picture = "$PSScriptRoot\..\Media\BurntToast.png"
            New-BTButton -Content 'View Picture' -Arguments $Picture -ImageUri $Picture -WhatIf
        }
        finally {
            Stop-Transcript
            $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
            Remove-Item tmp.log
        }
        It 'has consitent WhatIf response' {
            $Expected = "What if: Performing the operation ""New-BTButton"" on target ""returning: [ToastButton]:Content=View Picture:Arguments=$PSScriptRoot\..\Media\BurntToast.png:ActivationType=Protocol:ImageUri=$PSScriptRoot\..\Media\BurntToast.png:TextBoxId=""."
            $Log -join [System.Environment]::NewLine | should Be $Expected
        }
    }
}

Describe 'New-BTContextMenuItem' {
    Context 'loaded with standard arguments' {
        Start-Transcript tmp.log
        try {
            New-BTContextMenuItem -Content 'Google' -Arguments 'https://google.com' -ActivationType Protocol -WhatIf
        }
        finally {
            Stop-Transcript
            $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
            Remove-Item tmp.log
        }
        It 'has consitent WhatIf response' {
            $Expected = 'What if: Performing the operation "New-BTContextMenuItem" on target "returning: [ToastContextMenuItem]:Content=Google:Arguments=https://google.com:ActivationType=Protocol".'
            $Log -join [System.Environment]::NewLine | should Be $Expected
        }
    }
}

Describe 'New-BTHeader' {
    Context 'loaded with standard arguments' {
        Start-Transcript tmp.log
        try {
            New-BTHeader -Id 'primary header' -Title 'First Category' -WhatIf
        }
        finally {
            Stop-Transcript
            $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
            Remove-Item tmp.log
        }
        It 'has consitent WhatIf response' {
            $Expected = 'What if: Performing the operation "New-BTHeader" on target "returning: [ToastHeader]:Id=primary header:Title=First Category:Arguments=:ActivationType=Protocol".'
            $Log -join [System.Environment]::NewLine | should Be $Expected
        }
    }
    Context 'clickable header text' {
        Start-Transcript tmp.log
        try {
            New-BTHeader -Id '001' -Title 'Stack Overflow Questions' -Arguments 'http://stackoverflow.com/' -WhatIf
        }
        finally {
            Stop-Transcript
            $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
            Remove-Item tmp.log
        }
        It 'has consitent WhatIf response' {
            $Expected = 'What if: Performing the operation "New-BTHeader" on target "returning: [ToastHeader]:Id=001:Title=Stack Overflow Questions:Arguments=http://stackoverflow.com/:ActivationType=Protocol".'
            $Log -join [System.Environment]::NewLine | should Be $Expected
        }
    }
}

Describe 'New-BTImage' {
    Context 'standard image' {
        Start-Transcript tmp.log
        try {
            New-BTImage -Source $PSScriptRoot\..\Media\BurntToast.png -WhatIf
        }
        finally {
            Stop-Transcript
            $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
            Remove-Item tmp.log
        }
        It 'has consitent WhatIf response' {
            $Expected = "What if: Performing the operation ""New-BTImage"" on target ""returning: [AdaptiveImage]:Source=$PSScriptRoot\..\Media\BurntToast.png:AlternateText=:HintCrop=Default:HintRemoveMargin=False:HintAlign=Default:AddImageQuery=""."
            $Log -join [System.Environment]::NewLine | should Be $Expected
        }
    }
    Context 'application logo override' {
        Start-Transcript tmp.log
        try {
            New-BTImage -Source $PSScriptRoot\..\Media\BurntToast.png -AppLogoOverride -Crop Circle -WhatIf
        }
        finally {
            Stop-Transcript
            $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
            Remove-Item tmp.log
        }
        It 'has consitent WhatIf response' {
            $Expected = "What if: Performing the operation ""New-BTImage"" on target ""returning: [ToastGenericAppLogo]:Source=$PSScriptRoot\..\Media\BurntToast.png:AlternateText=:HintCrop=Circle:AddImageQuery=""."
            $Log -join [System.Environment]::NewLine | should Be $Expected
        }
    }
    Context 'hero image' {
        Start-Transcript tmp.log
        try {
            New-BTImage -Source $PSScriptRoot\..\Media\BurntToast.png -HeroImage -WhatIf
        }
        finally {
            Stop-Transcript
            $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
            Remove-Item tmp.log
        }
        It 'has consitent WhatIf response' {
            $Expected = "What if: Performing the operation ""New-BTImage"" on target ""returning: [ToastGenericHeroImage]:Source=$PSScriptRoot\..\Media\BurntToast.png:AlternateText=:AddImageQuery=""."
            $Log -join [System.Environment]::NewLine | should Be $Expected
        }
    }
}

Describe 'New-BTProgressBar' {
    Context 'fixed value and status' {
        Start-Transcript tmp.log
        try {
            New-BTProgressBar -Status 'Copying files' -Value 0.2 -WhatIf
        }
        finally {
            Stop-Transcript
            $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
            Remove-Item tmp.log
        }
        It 'has consitent WhatIf response' {
            $Expected = 'What if: Performing the operation "New-BTProgressBar" on target "returning: [AdaptiveProgressBar]:Status=Copying files:Title=:Value=0.2:ValueStringOverride=".'
            $Log -join [System.Environment]::NewLine | should Be $Expected
        }
    }
    Context 'indeterminate progress' {
        Start-Transcript tmp.log
        try {
            New-BTProgressBar -Status 'Copying files' -Indeterminate -WhatIf
        }
        finally {
            Stop-Transcript
            $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
            Remove-Item tmp.log
        }
        It 'has consitent WhatIf response' {
            $Expected = 'What if: Performing the operation "New-BTProgressBar" on target "returning: [AdaptiveProgressBar]:Status=Copying files:Title=:Value=indeterminate:ValueStringOverride=".'
            $Log -join [System.Environment]::NewLine | should Be $Expected
        }
    }
    Context 'custom value display override' {
        Start-Transcript tmp.log
        try {
            New-BTProgressBar -Status 'Copying files' -Value 0.2 -ValueDisplay '4/20 files complete' -WhatIf
        }
        finally {
            Stop-Transcript
            $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
            Remove-Item tmp.log
        }
        It 'has consitent WhatIf response' {
            $Expected = 'What if: Performing the operation "New-BTProgressBar" on target "returning: [AdaptiveProgressBar]:Status=Copying files:Title=:Value=0.2:ValueStringOverride=4/20 files complete".'
            $Log -join [System.Environment]::NewLine | should Be $Expected
        }
    }
    Context 'with title' {
        Start-Transcript tmp.log
        try {
            New-BTProgressBar -Title 'File Copy' -Status 'Copying files' -Value 0.2 -WhatIf
        }
        finally {
            Stop-Transcript
            $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
            Remove-Item tmp.log
        }
        It 'has consitent WhatIf response' {
            $Expected = 'What if: Performing the operation "New-BTProgressBar" on target "returning: [AdaptiveProgressBar]:Status=Copying files:Title=File Copy:Value=0.2:ValueStringOverride=".'
            $Log -join [System.Environment]::NewLine | should Be $Expected
        }
    }
}

Describe 'New-BTSelectionBoxItem' {
    Context 'loaded with standard arguments' {
        Start-Transcript tmp.log
        try {
            New-BTSelectionBoxItem -Id 'Item1' -Content 'First option in the list' -WhatIf
        }
        finally {
            Stop-Transcript
            $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
            Remove-Item tmp.log
        }
        It 'has consitent WhatIf response' {
            $Expected = 'What if: Performing the operation "New-BTSelectionBoxItem" on target "returning: [ToastSelectionBoxItem]:Id=Item1:Content=First option in the list".'
            $Log -join [System.Environment]::NewLine | should Be $Expected
        }
    }
}

Describe 'New-BTText' {
    Context 'blank line' {
        Start-Transcript tmp.log
        try {
            New-BTText -WhatIf
        }
        finally {
            Stop-Transcript
            $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
            Remove-Item tmp.log
        }
        It 'has consitent WhatIf response' {
            $Expected = 'What if: Performing the operation "New-BTText" on target "returning: [AdaptiveText]:Text=:HintMaxLines=:HintMinLines=:HintWrap=:HintAlign=Default:HintStyle=Default:Language=".'
            $Log -join [System.Environment]::NewLine | should Be $Expected
        }
    }
    Context 'with content' {
        Start-Transcript tmp.log
        try {
            New-BTText -Content 'This is a line with text!' -WhatIf
        }
        finally {
            Stop-Transcript
            $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
            Remove-Item tmp.log
        }
        It 'has consitent WhatIf response' {
            $Expected = 'New-BTText" on target "returning: [AdaptiveText]:Text=This is a line with text!:HintMaxLines=:HintMinLines=:HintWrap=:HintAlign=Default:HintStyle=Default:Language=".'
            $Log -join [System.Environment]::NewLine | should Be $Expected
        }
    }
}



Describe 'New-BTAction' {
    Context 'running without arguments' {
        Start-Transcript tmp.log
        try {
            New-BTAction -WhatIf
        }
        finally {
            Stop-Transcript
            $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
            Remove-Item tmp.log
        }
        It 'has consitent WhatIf response' {
            $Expected = 'What if: Performing the operation "New-BTAction" on target "returning: [ToastActionsCustom] with 0 Inputs, 0 Buttons, and 0 ContextMenuItems".'
            $Log -join [System.Environment]::NewLine | should Be $Expected
        }
    }
    Context 'snooze and dismiss modal' {
        Start-Transcript tmp.log
        try {
            New-BTAction -SnoozeAndDismiss -WhatIf
        }
        finally {
            Stop-Transcript
            $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
            Remove-Item tmp.log
        }
        It 'has consitent WhatIf response' {
            $Expected = 'What if: Performing the operation "New-BTAction" on target "returning: [ToastActionsSnoozeAndDismiss] with 0 Inputs, 0 Buttons, and 0 ContextMenuItems".'
            $Log -join [System.Environment]::NewLine | should Be $Expected
        }
    }
    Context 'single clickable button' {
        Start-Transcript tmp.log
        try {
            New-BTAction -Buttons (New-BTButton -Content 'Google' -Arguments 'https://google.com') -WhatIf
        }
        finally {
            Stop-Transcript
            $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
            Remove-Item tmp.log
        }
        It 'has consitent WhatIf response' {
            $Expected = 'What if: Performing the operation "New-BTAction" on target "returning: [ToastActionsCustom] with 0 Inputs, 1 Buttons, and 0 ContextMenuItems".'
            $Log -join [System.Environment]::NewLine | should Be $Expected
        }
    }
    Context 'mixed content: button & context menu' {
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
        It 'has consitent WhatIf response' {
            $Expected = 'What if: Performing the operation "New-BTAction" on target "returning: [ToastActionsCustom] with 0 Inputs, 1 Buttons, and 1 ContextMenuItems".'
            $Log -join [System.Environment]::NewLine | should Be $Expected
        }
    }
}

Describe 'New-BTBinding' {
    Context 'loaded with children' {
        $Text1 = New-BTText -Content 'This is a test'
        $Text2 = New-BTText
        $Text3 = New-BTText -Content 'This more testing'
        $Progress = New-BTProgressBar -Title 'Things are happening' -Status 'Working on it' -Value 0.01
        $Image1 = New-BTImage -Source $PSScriptRoot\..\Media\BurntToast.png
        $Image2 = New-BTImage -Source $PSScriptRoot\..\Media\BurntToast.png -AppLogoOverride -Crop Circle
        $Image3 = New-BTImage -Source $PSScriptRoot\..\Media\BurntToast.png -HeroImage

        Start-Transcript tmp.log
        try {
            New-BTBinding -Children $Text1, $Text2, $Text3, $Image1, $Progress -AppLogoOverride $Image2 -HeroImage $Image3 -WhatIf
        }
        finally {
            Stop-Transcript
            $Log = (Get-Content tmp.log).Where({ $_ -match "What if: " })
            Remove-Item tmp.log
        }
        It 'has consitent WhatIf response' {
            $Expected = "What if: Performing the operation ""New-BTBinding"" on target ""returning: [ToastBindingGeneric]:Children=5:AddImageQuery=0:AppLogoOverride=1:Attribution=0:BaseUri=0:HeroImage=1:Language=0""."
            $Log -join [System.Environment]::NewLine | should Be $Expected
        }
    }
}




Describe 'New-BTContent' {
    $Text1 = New-BTText -Content 'This is a test'
    $Text2 = New-BTText -Content 'This more testing'
    $Image2 = New-BTImage -Source $PSScriptRoot\..\Media\BurntToast.png -AppLogoOverride -Crop Circle
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
            $Expected = "What if: Performing the operation ""New-BTContent"" on target ""returning: [ToastContent] with XML: <?xml version=""1.0"" encoding=""utf-8""?><toast><visual><binding template=""ToastGeneric""><text>{This is a test}</text><text>{This more testing}</text><image src=""$PSScriptRoot\..\Media\BurntToast.png"" placement=""appLogoOverride"" hint-crop=""circle"" /></binding></visual></toast>""."
            $Log -join [System.Environment]::NewLine | should Be $Expected
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
            $Expected = "What if: Performing the operation ""New-BTContent"" on target ""returning: [ToastContent] with XML: <?xml version=""1.0"" encoding=""utf-8""?><toast activationType=""protocol"" launch=""https://google.com""><visual><binding template=""ToastGeneric""><text>{This is a test}</text><text>{This more testing}</text><image src=""$PSScriptRoot\..\Media\BurntToast.png"" placement=""appLogoOverride"" hint-crop=""circle"" /></binding></visual></toast>""."
            $Log -join [System.Environment]::NewLine | should Be $Expected
        }
    }
}


# Describe 'New-BurntToastNotification' {
#     Context 'running without arguments' {
#         It 'runs without errors' {
#             { New-BurntToastNotification } | should Not Throw
#         }
#
#         It 'does not return anything' {
#             New-BurntToastNotification | should BeNullOrEmpty
#         }
#     }
#     Context 'running with arguments (Image)' {
#         It 'runs without errors' {
#             { New-BurntToastNotification -AppLogo 'https://raw.githubusercontent.com/Windos/BurntToast/master/Media/BurntToast-Logo.png' } | should Not Throw
#         }
#
#         It 'does not return anything' {
#             New-BurntToastNotification -AppLogo 'https://raw.githubusercontent.com/Windos/BurntToast/master/Media/BurntToast-Logo.png' | should BeNullOrEmpty
#         }
#     }
# }
