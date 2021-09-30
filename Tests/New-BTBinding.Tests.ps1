. (Join-Path -Path $PSScriptRoot -ChildPath '_envPrep.ps1')

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
            $Log | Should -Be $Expected
        }
    }
}
